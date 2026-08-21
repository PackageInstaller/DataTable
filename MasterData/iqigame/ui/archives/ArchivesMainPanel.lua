-- chunkname: @IQIGame\\UI\\Archives\\ArchivesMainPanel.lua

local ArchivesMainPanel = class(nil, BaseChildrenPanel)
local AchievementDisplayEditItemClass = require("IQIGame.UI.Achievement.AchievementDisplayEditItem")

function ArchivesMainPanel.New(go, mainView)
	local o = Clone(ArchivesMainPanel)

	o:Initialize(go, mainView)

	return o
end

function ArchivesMainPanel:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitMembers()
	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function ArchivesMainPanel:InitMembers()
	return
end

function ArchivesMainPanel:InitComponent()
	self.buttonEditDisplay = self.buttonEditDisplay:GetComponent("Button")
	self.achievementBtn = self.achievementBtn:GetComponent("Button")
end

function ArchivesMainPanel:InitDelegate()
	function self.buttonEditDisplayDelegate()
		self:OnButtonEditDisplayClick()
	end

	function self.achievementBtnDelegate()
		self:OnAchievementBtnClick()
	end

	function self.refreshAchievementShowDelegate()
		self:refreshAchievementShow()
	end

	function self.delegateOnClickPlotBtn()
		self:OnClickPlotBtn()
	end
end

function ArchivesMainPanel:AddListener()
	self.buttonEditDisplay.onClick:AddListener(self.buttonEditDisplayDelegate)
	self.achievementBtn.onClick:AddListener(self.achievementBtnDelegate)
	self.plotBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickPlotBtn)
	EventDispatcher.AddEventListener(EventID.AchievementShow, self.refreshAchievementShowDelegate)
end

function ArchivesMainPanel:RemoveListener()
	self.buttonEditDisplay.onClick:RemoveListener(self.buttonEditDisplayDelegate)
	self.achievementBtn.onClick:RemoveListener(self.achievementBtnDelegate)
	self.plotBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickPlotBtn)
	EventDispatcher.RemoveEventListener(EventID.AchievementShow, self.refreshAchievementShowDelegate)
end

function ArchivesMainPanel:OnOpen()
	self:RefreshDisplayContainer()
	self.mainView:RegisterCloseEvent(function()
		UIModule.CloseAllUIFrom({
			Constant.UIControllerName.MainUI
		})
	end)

	local sum, finishNum = AchievementModule.GetAchievementFinishCount()

	LuaUtility.SetText(self.achieveProcess, Mathf.Ceil(finishNum * 100 / sum) .. "%")
end

function ArchivesMainPanel:OnClose()
	return
end

function ArchivesMainPanel:RefreshDisplayContainer()
	for i = LuaUtility.GetChildCount(self.DisplayContainer.transform), 1, -1 do
		UnityEngine.Object.Destroy(LuaUtility.GetChild(self.DisplayContainer.transform, i - 1).gameObject)
	end

	local displayList = AchievementModule.GetAchievementDisplayList()

	for i = 1, #displayList do
		local ItemEditorObject = GameObject.Instantiate(self.displayImagePrefab, self.DisplayContainer.transform)
		local editItem = AchievementDisplayEditItemClass.New(ItemEditorObject, self)

		editItem:SetAnchorPosition(displayList[i].x, displayList[i].y)

		local data = CfgUtil.GetItemCfgDataWithID(displayList[i].cid)

		LuaUtility.LoadImage(self, UIGlobalApi.GetIconPath(data.BigIcon), editItem.gameObject:GetComponent("Image"), function()
			LuaUtility.SetImageNativeSizeWithGameObject(editItem.gameObject)
		end)
	end
end

function ArchivesMainPanel:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
end

function ArchivesMainPanel:OnButtonEditDisplayClick()
	UIModule.Open(Constant.UIControllerName.AchievementDisplayUI, Constant.UILayer.UI)
end

function ArchivesMainPanel:OnAchievementBtnClick()
	self.mainView:OnAchievementBtnClick()
end

function ArchivesMainPanel:OnClickPlotBtn()
	self.mainView:OnStoryReviewButtonClick()
end

function ArchivesMainPanel:refreshAchievementShow()
	self:RefreshDisplayContainer()
end

return ArchivesMainPanel
