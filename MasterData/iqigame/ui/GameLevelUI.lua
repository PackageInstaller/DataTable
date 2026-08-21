-- chunkname: @IQIGame\\UI\\GameLevelUI.lua

local GameLevelUI = Base:Extend("GameLevelUI", "IQIGame.Onigao.UI.GameLevelUI", {
	items = {},
	LinePosList = {},
	NeedLinelevelItems = {},
	AllLineObj = {}
})
local GameLevelItem = require("IQIGame.UI.Chapter.ResourceChapter.GameLevelInfo.GameLevelItem")
local LevelInfoPanelView = require("IQIGame.UI.Chapter.ResourceChapter.GameLevelInfo.LevelInfoPanel")

function GameLevelUI:OnInit()
	LuaCodeInterface.BindOutlet(self.View, self)

	self.commonReturnBtn = CommonReturnBtn.New(self.Com_ReturnBtn, self)
	self.DrawLineComponent = self.DrawLineParent:GetComponent("UIDrawLine")
	self.TweenLevelGrid = self.LevelGrid:GetComponent("TweenPosition")
	self.LevelContent = self.LevelGrid:GetComponent("ScrollAreaList")

	function self.LevelContent.onRenderCell(cell)
		self:OnRenderItem(cell)
	end

	function self.LevelContent.onRenderEnd()
		self:OpenCurDataInfoPanel()
	end

	function self.DelegateLevelInfo(data)
		self:LevelItemClick(data)
	end

	self.TweenLevelInfoView = LevelInfoPanelView.New(self.LevelInfoPanel, function()
		self:TweenLevelInfoClose()
	end, self.UIController)
	self.moneyCell = CurrencyCell.New(self.CurrencyContainer)
end

function GameLevelUI:GetPreloadAssetPaths()
	return nil
end

function GameLevelUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GameLevelUI:IsManualShowOnOpen(userData)
	return false
end

function GameLevelUI:GetBGM(userData)
	return nil
end

function GameLevelUI:OnOpen(chapterPass)
	self.ChapterData = chapterPass

	self.TweenLevelInfoView:Hide()

	self.LevelItems = {}

	for k, v in pairs(chapterPass) do
		table.insert(self.LevelItems, v)
	end

	table.sort(self.LevelItems, function(a, b)
		return a.cid < b.cid
	end)
	self:OnRefreshLevelItems()
	self.moneyCell:RefreshItem(Constant.TopMoneyType.GameLevelUI)
end

function GameLevelUI:OnClose(userData)
	self.NeedLinelevelItems = {}
	self.LinePosList = {}
end

function GameLevelUI:OnAddListeners()
	EventDispatcher.AddEventListener(EventID.LevelInfoEvent, self.DelegateLevelInfo)
end

function GameLevelUI:OnRemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.LevelInfoEvent, self.DelegateLevelInfo)
end

function GameLevelUI:OnPause()
	return
end

function GameLevelUI:OnResume()
	return
end

function GameLevelUI:OnCover()
	return
end

function GameLevelUI:OnReveal()
	return
end

function GameLevelUI:OnRefocus(userData)
	return
end

function GameLevelUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function GameLevelUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GameLevelUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function GameLevelUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GameLevelUI:OnDestroy()
	self.commonReturnBtn:Dispose()
	self.moneyCell:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)
end

function GameLevelUI:OnRefreshLevelItems()
	self.NeedLinelevelItems = {}
	self.LinePosList = {}
	self.LevelContent.startIndex = ResourceChapterModule.GetNewUnLockPass(self.ChapterData) - 1

	self.LevelContent:Refresh(#self.LevelItems)
end

function GameLevelUI:OnRenderItem(cell)
	local itemdata = self.LevelItems[cell.index + 1]
	local tempItem = self.items[cell.gameObject]

	if tempItem == nil then
		tempItem = GameLevelItem.New(cell.gameObject)
		self.items[cell.gameObject] = tempItem
	end

	local islast = cell.index + 1 == #self.LevelItems

	tempItem:SetData(cell.index + 1, itemdata, islast)
	cell.gameObject.transform.parent:SetSiblingIndex(cell.index)
end

function GameLevelUI:OpenCurDataInfoPanel()
	self:LevelItemClick(self.LevelItems[self.LevelContent.startIndex + 1])
end

function GameLevelUI:LevelItemClick(data)
	self.TweenLevelInfoView:SetData(data)
	self.TweenLevelInfoView:Show()
end

function GameLevelUI:TweenLevelInfoClose()
	return
end

function GameLevelUI:PanelTween(v)
	if v == false then
		self.TweenLevelGrid:PlayReverse()
	else
		self.TweenLevelGrid:PlayForward()
	end
end

function GameLevelUI:LoadImg(path, ImgCom)
	AssetUtil.LoadImage(self, path, ImgCom)
end

return GameLevelUI
