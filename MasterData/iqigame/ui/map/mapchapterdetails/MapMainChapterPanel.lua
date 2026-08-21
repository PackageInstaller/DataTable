-- chunkname: @IQIGame\\UI\\Map\\MapChapterDetails\\MapMainChapterPanel.lua

local m = {
	isPlayingAnim = false,
	ItemList = {},
	ConditionItems = {}
}
local mainLineConditionItemCell = require("IQIGame.UI.Map.ItemCell.MainLineConditionItemCell")
local commonCondition = require("IQIGame.UI.Common.Condition.CommonCondition")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnCloseBtnClick()
		self:OnCloseBtnClick()
	end

	function self.DelegateOnEnterGameBtnClick()
		self:OnEnterGameBtnClick()
	end

	function self.DelegateOnStartStageLevel(plotStageDupPOD)
		self:OnStartStageLevel(plotStageDupPOD)
	end

	function self.DelegateOnUnlockFunctionUpdateEvent()
		self:OnRefreshUnlockBtn()
	end

	function self.DelegateOnClickRewardDetalisBtn()
		self:OnClickRewardDetailsBtn()
	end

	function self.DelegateOnGmBtnClick()
		self:OnGmBtnClick()
	end

	function self.OnButtonRestartClickDelegate()
		self:OnButtonRestartClick()
	end

	self.wrapContent = self.ItemScroll:GetComponent("ScrollAreaList")

	function self.wrapContent.onRenderCell(cell)
		self:OnRenderItem(cell)
	end

	self.enterCommonCondition = commonCondition.New(self.ConditionParent)

	self:InitStaticText()
end

function m:InitStaticText()
	UGUIUtil.SetText(self.levelTipsTitle, ChapterStageMapUIApi:GetLevelTipsTitle())
	UGUIUtil.SetText(self.levelTipsNumText, ChapterStageMapUIApi:GetHeroTipsTitle())
	UGUIUtil.SetText(self.LvTitle, ChapterStageMapUIApi:GetLvText())
end

function m:AddListeners()
	self.CloseButton:GetComponent("Button").onClick:AddListener(self.DelegateOnCloseBtnClick)
	self.StartButton:GetComponent("Button").onClick:AddListener(self.DelegateOnEnterGameBtnClick)
	self.rewardDetailsBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickRewardDetalisBtn)
	self.GmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnGmBtnClick)
	self.ButtonRestart:GetComponent("Button").onClick:AddListener(self.OnButtonRestartClickDelegate)
	EventDispatcher.AddEventListener(EventID.StartStageLevel, self.DelegateOnStartStageLevel)
	EventDispatcher.AddEventListener(EventID.UnlockFunction, self.DelegateOnUnlockFunctionUpdateEvent)
end

function m:RemoveListeners()
	self.CloseButton:GetComponent("Button").onClick:RemoveListener(self.DelegateOnCloseBtnClick)
	self.StartButton:GetComponent("Button").onClick:RemoveListener(self.DelegateOnEnterGameBtnClick)
	self.rewardDetailsBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickRewardDetalisBtn)
	self.GmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnGmBtnClick)
	self.ButtonRestart:GetComponent("Button").onClick:RemoveListener(self.OnButtonRestartClickDelegate)
	EventDispatcher.RemoveEventListener(EventID.UnlockFunction, self.DelegateOnUnlockFunctionUpdateEvent)
	EventDispatcher.RemoveEventListener(EventID.StartStageLevel, self.DelegateOnStartStageLevel)
end

function m:SetData(markCid, userData)
	self.StageCfg = CfgWorldMapItemTable[markCid]
	self.StageCid = self.StageCfg.Id

	if userData then
		self.enterFunction = userData.enterFunction
		self.gmFunction = userData.gmFunction
	end

	self:RefreshChapterInfo()
	self:Show()
end

function m:RefreshChapterInfo()
	UGUIUtil.SetText(self.StageNameText, self.StageCfg.Name)
	UGUIUtil.SetText(self.StageDescriptionText, self.StageCfg.Desc)
	UGUIUtil.SetText(self.levelTipsNumText, self.StageCfg.RecommendLevel)
	UGUIUtil.SetText(self.stageTypeText, ChapterStageMapUIApi:GetStageTypeText(self.StageCfg.IsFight))

	local stageCost = self.StageCfg.PassCost[2] or 0
	local enterCost = self.StageCfg.EnterCost[2] or 0

	self.NeedPower = stageCost + enterCost

	UGUIUtil.SetText(self.CostText, tostring(-self.NeedPower))

	local itemID = self.StageCfg.PassCost[1] or self.StageCfg.EnterCost[1]

	if itemID then
		LuaUtility.SetGameObjectShow(self.Consume, true)
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[itemID].SmallIcon), self.CostIconImage:GetComponent(typeof(UnityEngine.UI.Image)))
	else
		LuaUtility.SetGameObjectShow(self.Consume, false)
	end

	AssetUtil.LoadImage(self, ChapterStageMapUIApi:GetStageDetailsTypeImage(self.StageCfg.IsFight), self.stageTypeImg:GetComponent(typeof(UnityEngine.UI.Image)))
	AssetUtil.LoadImage(self, ChapterStageMapUIApi:GetMarkImagePath(self.StageCfg.IconPath), self.stageSignImg:GetComponent("Image"))

	self.ItemDatas = {}

	local dropItems = StoryChapterModule.GetDropItems(self.StageCid)

	for _, dropItem in pairs(dropItems) do
		local dropLib = CfgDropLibTable[dropItem.dropID]

		for index, itemID in pairs(dropLib.GiftItemIds) do
			table.insert(self.ItemDatas, {
				num = dropLib.GiftItemCount[index],
				tag = dropItem.tag,
				itemID = itemID
			})
		end
	end

	self.wrapContent:Refresh(#self.ItemDatas)
	self:UpdateEnterCondition()
end

function m:OnEnterGameBtnClick()
	if self.enterFunction then
		self.enterFunction()

		return
	end

	if WarehouseModule.GetPlayerStrengthNum() < self.NeedPower then
		NoticeModule.ShowNotice(20006)

		return
	end

	if not self.enterCommonCondition:GetAllConditionsIsUnlock() then
		NoticeModule.ShowNotice(19001)

		return
	end

	self:Hide()
	StoryChapterModule.EnterDup(self.StageCid)
	GameChapterModule.SetupCurChapterType(self.StageCfg.Type)

	GameChapterModule.CurSelectChapterCfg = nil
end

function m:OnStartStageLevel(plotStageDupPOD)
	return
end

function m:OnRenderItem(cell)
	local rawItemData = self.ItemDatas[cell.index + 1]
	local instanceId = cell.gameObject:GetInstanceID()
	local itemCell = self.ItemList[instanceId]

	if itemCell == nil then
		itemCell = ItemCell.New(cell.gameObject)
		self.ItemList[instanceId] = itemCell
	end

	local itemData
	local tag = 0

	if rawItemData ~= nil then
		if rawItemData.itemID ~= Constant.ItemCid.NORMAL_MONEY then
			rawItemData.num = 0
		end

		itemData = ItemData.CreateByCIDAndNumber(rawItemData.itemID, rawItemData.num)
		tag = rawItemData.tag

		itemCell:SetItem(itemData)
		itemCell:SetTag(tag)

		if rawItemData.itemID == Constant.ItemCid.NORMAL_MONEY then
			itemCell:SetNum(rawItemData.num)
		end
	end
end

function m:UpdateEnterCondition()
	self.enterCommonCondition:SetData(self.StageCfg.EnterConditionId)
end

function m:OnCloseBtnClick()
	if self.isPlayingAnim then
		return
	end

	self.isPlayingAnim = true

	CoroutineUtility.StartCoroutine(function()
		UIUtil.PlayOrRewindDefaultAnim(self.View, true)
		CoroutineUtility.Yield(CustomWaitForSeconds(LuaUtility.GetAnimationLengthWithName(self.View, "MainChapterPanel")))
		self:Hide()
	end)
end

function m:Show()
	self.isPlayingAnim = false

	self:AddListeners()
	self:OnRefreshUnlockBtn()
	LuaUtility.SetGameObjectShow(self.View, true)
	UIUtil.PlayOrRewindDefaultAnim(self.View, false)
end

function m:OnRefreshUnlockBtn()
	local funcList = {}

	funcList[Constant.UnlockType.FUNC_GM_TOOL] = self.GmBtn

	UnlockFunctionModule.FuncSwitchHandler(funcList)
end

function m:OnClickRewardDetailsBtn()
	UIModule.Open(Constant.UIControllerName.RewardDetailUI, Constant.UILayer.UI, {
		itemDatas = self.ItemDatas
	})
end

function m:OnGmBtnClick()
	if not IQIGame.Onigao.Game.Device.isMobile then
		local CChatPOD = {}

		CChatPOD.channel = 3
		CChatPOD.type = 1
		CChatPOD.target = ""
		CChatPOD.content = "/cmd finishDup 1 " .. self.StageCid

		net_centerChat.sendChat(CChatPOD)
	end

	self:Hide()
end

function m:OnButtonRestartClick()
	if self.enterFunction then
		self.enterFunction()
		StoryModule.SetStoryRestartWhenNext()

		return
	end

	NoticeModule.ShowNotice(70007, function()
		if WarehouseModule.GetPlayerStrengthNum() < self.NeedPower then
			NoticeModule.ShowNotice(20006)

			return
		end

		if not self.enterCommonCondition:GetAllConditionsIsUnlock() then
			NoticeModule.ShowNotice(19001)

			return
		end

		self:Hide()
		StoryChapterModule.EnterDup(self.StageCid)
		StoryModule.SetStoryRestartWhenNext()
	end)
end

function m:Hide()
	self:RemoveListeners()
	LuaUtility.SetGameObjectShow(self.View, false)
	EventDispatcher.Dispatch(EventID.CloseChapterDetailEvent)
end

function m:Dispose()
	for k, v in pairs(self.ItemList) do
		v:Dispose()
	end

	for k, v in pairs(self.ConditionItems) do
		v:Dispose()
	end

	self.enterCommonCondition:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
