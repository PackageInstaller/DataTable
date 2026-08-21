-- chunkname: @IQIGame\\UI\\SummerActivityStageUI.lua

local SummerActivityStageUI = {}

SummerActivityStageUI = Base:Extend("SummerActivityStageUI", "IQIGame.Onigao.UI.SummerActivityStageUI", SummerActivityStageUI)

local detailPanelClass = require("IQIGame/UI/SummerActivity/SummerActivityStageUI_detailPanel")
local stagePanelClass = require("IQIGame/UI/SummerActivity/SummerActivityStageUI_stagePanel")
local tabItemClass = require("IQIGame/UI/SummerActivity/SummerActivityStageUI_tabItem")
local MultipleFightPopupView = require("IQIGame/UI/SummerActivity/SummerActivityStageUI_MultipleFightPop")

function SummerActivityStageUI:OnInit()
	self:InitMembers()
	self:InitComponent()
	self:InitDelegate()
end

function SummerActivityStageUI:InitMembers()
	self.tabDataArray = {}
	self.tabCellList = {}
end

function SummerActivityStageUI:InitComponent()
	self.detailPanel = detailPanelClass.New(self.stageDetailPanel, self)

	self.detailPanel:Hide()

	self.stageTabScroll = self.stageTabScroll:GetComponent("OptimizedScrollRect")

	self.stageTabScroll:NormalInit(function(OptimizedParams, OptimizedViewsHolder)
		self:UpdateTabScroll(OptimizedParams, OptimizedViewsHolder)
	end)

	self.buttonReturn = CommonReturnBtn.New(self.Com_ReturnBtn, self)
	self.moneyCell = CurrencyCell.New(self.currencyRoot)
	self.multipleFightPopupView = MultipleFightPopupView.New(self.MultipleFightPopupRoot)

	self.multipleFightPopupView:Hide()
end

function SummerActivityStageUI:InitDelegate()
	function self.showStageDetailEvent(worldMapItemId)
		self:ShowStageDetailPanel(worldMapItemId)
	end

	function self.delegateOnClickButtonTask()
		self:OnClickButtonTask()
	end

	function self.delegateOnClickButtonShop()
		self:OnClickButtonShop()
	end

	function self.delegateOnClickTipsBtn()
		self:OnClickTipsBtn()
	end
end

function SummerActivityStageUI:OnAddListeners()
	self.buttonTask:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonTask)
	self.buttonShop:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonShop)
	self.TipsBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickTipsBtn)
	EventDispatcher.AddEventListener(EventID.SummerActivityStageUI_ShowStageDetailPanel, self.showStageDetailEvent)
end

function SummerActivityStageUI:OnRemoveListeners()
	self.buttonTask:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonTask)
	self.buttonShop:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonShop)
	self.TipsBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickTipsBtn)
	EventDispatcher.RemoveEventListener(EventID.SummerActivityStageUI_ShowStageDetailPanel, self.showStageDetailEvent)
end

function SummerActivityStageUI:OnClickTipsBtn()
	UIModule.Open(Constant.UIControllerName.SummerActivityTipsUI, Constant.UILayer.UI)
end

function SummerActivityStageUI:OnClickButtonShop()
	UIModule.Open(Constant.UIControllerName.ActivityShopUI, Constant.UILayer.UI, {
		activityPod = self.activityPOD
	})
end

function SummerActivityStageUI:OnClickButtonTask()
	UIModule.Open(Constant.UIControllerName.SummerActivityTaskUI, Constant.UILayer.UI)
end

function SummerActivityStageUI:UpdateTabScroll(OptimizedParams, OptimizedViewsHolder)
	local viewGameObject = OptimizedViewsHolder.root.gameObject
	local instanceID = OptimizedViewsHolder.instanceID
	local index = OptimizedViewsHolder.ItemIndex
	local data = self.tabDataArray[index + 1]

	if not self.tabCellList[instanceID] then
		self.tabCellList[instanceID] = tabItemClass.New(viewGameObject, self)
	end

	self.tabCellList[instanceID]:Refresh(data, index + 1)
end

function SummerActivityStageUI:OnOpen(userData)
	self.activityPOD = userData.activityPod
	self.chapterType = Constant.ChapterPassType.TYPE_SummerActivity

	self.multipleFightPopupView:Hide()
	self.detailPanel:Hide()
	self:Refresh()

	if userData.selectChapterId then
		self:SelectTabWithStage(SummerActivityModule.GetStageIs(userData.selectChapterId) - 1)
	else
		self:SelectTabWithStage(0)
	end
end

function SummerActivityStageUI:OnClose(userData)
	self.multipleFightPopupView:Hide()
end

function SummerActivityStageUI:GetPreloadAssetPaths()
	return nil
end

function SummerActivityStageUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function SummerActivityStageUI:IsManualShowOnOpen(userData)
	return false
end

function SummerActivityStageUI:GetBGM(userData)
	return nil
end

function SummerActivityStageUI:OnPause()
	return
end

function SummerActivityStageUI:OnResume()
	return
end

function SummerActivityStageUI:OnCover()
	return
end

function SummerActivityStageUI:OnReveal()
	return
end

function SummerActivityStageUI:OnRefocus(userData)
	return
end

function SummerActivityStageUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function SummerActivityStageUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function SummerActivityStageUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function SummerActivityStageUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function SummerActivityStageUI:Refresh()
	self.tabDataArray = SummerActivityModule.GetStageCfgArray(Constant.ChapterPassType.TYPE_SummerActivity)

	self.stageTabScroll:RefreshByItemCount(#self.tabDataArray)
	self.moneyCell:RefreshItem(Constant.TopMoneyType.SummerActivityStage)
end

function SummerActivityStageUI:RefreshDungeon()
	local cfgGeneralDup = CfgUtil.GetCfgGeneralDupChapterDataWithID(self.currentSelectedTabId)

	if not cfgGeneralDup then
		return
	end

	if self.currentStagePanel then
		self.currentStagePanel:OnDestroy()

		self.currentStagePanel = nil
	end

	local path = cfgGeneralDup.Chaptercomponents

	if LuaUtility.StrIsNullOrEmpty(path) then
		logError(string.format("【夏日活动】关卡 id = %s没有配置关卡预制体 “Chaptercomponents” ", cfgGeneralDup.Id))

		return
	end

	AssetUtil.LoadAsset(self, path, self._OnDungeonPrefabLoadSuccess)
end

function SummerActivityStageUI:_OnDungeonPrefabLoadSuccess(assetName, asset, duration, userData)
	local o = GameObject.Instantiate(asset, self.stageRoot.transform)

	self.currentStagePanel = stagePanelClass.New(o, self)

	self.currentStagePanel:Refresh()
end

function SummerActivityStageUI:OnTabSelected(tabItem)
	if self.currentSelectedTabItem then
		self.currentSelectedTabItem:UnSelected()

		self.currentSelectedTabItem = nil
	end

	self.currentSelectedTabItem = tabItem

	self.currentSelectedTabItem:Selected()

	self.currentSelectedTabId = self.currentSelectedTabItem.data.Id

	self:RefreshDungeon()
end

function SummerActivityStageUI:SelectTabWithStage(stage)
	local viewsHolder = self.stageTabScroll:GetItemViewsHolder(stage)

	if viewsHolder then
		local instanceID = viewsHolder.instanceID

		self.tabCellList[instanceID]:OnClickButtonClick()
	end
end

function SummerActivityStageUI:ShowStageDetailPanel(worldMapItemId)
	self.detailPanel:Show()
	self.detailPanel:Refresh(worldMapItemId, self.chapterType)
end

function SummerActivityStageUI:OnDestroy()
	if self.currentStagePanel then
		self.currentStagePanel:OnDestroy()

		self.currentStagePanel = nil
	end

	for _, v in pairs(self.tabCellList) do
		v:OnDestroy()
	end

	self.detailPanel:OnDestroy()

	self.tabCellList = {}

	self.buttonReturn:Dispose()
	self.moneyCell:Dispose()
	self.multipleFightPopupView:Dispose()
	AssetUtil.UnloadAsset(self)
end

return SummerActivityStageUI
