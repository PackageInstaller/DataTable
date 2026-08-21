-- chunkname: @IQIGame\\UI\\ArchivesUI.lua

local ArchivesUI = {}

ArchivesUI = Base:Extend("ArchivesUI", "IQIGame.Onigao.UI.ArchivesUI", ArchivesUI)

local ArchivesMainPanelClass = require("IQIGame.UI.Archives.ArchivesMainPanel")
local ArchivesAchievementPanelClass = require("IQIGame.UI.Archives.ArchivesAchievementPanel")
local DisplayDetaillPanelClass = require("IQIGame.UI.Archives.DisplayDetaillPanel")
local ArchivesStoryReviewPanelClass = require("IQIGame.UI.Archives.ArchivesStoryReviewPanel")
local panelType = {
	StoryReviewPanel = 2,
	MainPanel = 0,
	AchievementPanel = 1
}

function ArchivesUI:OnInit()
	self:InitMembers()
	self:InitComponent()
	self:InitDelegate()
end

function ArchivesUI:InitMembers()
	return
end

function ArchivesUI:InitComponent()
	self.commonReturnBtn = CommonReturnBtn.New(self.Com_ReturnButton, self)

	self.commonReturnBtn:RegisterReturnEvent(function()
		self:OnClickReturnBtn()
	end)

	self.MainPanel = ArchivesMainPanelClass.New(self.MainPanel, self)

	self.MainPanel:Close()

	self.AchievementPanel = ArchivesAchievementPanelClass.New(self.AchievementPanel, self)

	self.AchievementPanel:Close()

	self.DisplayDetaillPanel = DisplayDetaillPanelClass.New(self.displayDetaillPanel, self)

	self.DisplayDetaillPanel:Hide()

	self.storyReviewPanel = ArchivesStoryReviewPanelClass.New(self.PlotPanel, self)

	self.storyReviewPanel:Close()
end

function ArchivesUI:InitDelegate()
	function self.displayDetailPanelDelegate(cid)
		self:displayDetaillPanelPop(cid)
	end
end

function ArchivesUI:OnAddListeners()
	RedDotModule.Subscribe(Constant.E_RedDotPath.Archives_Achievement, self.buttonAchievement.transform:Find("RedDot").gameObject)
	EventDispatcher.AddEventListener(EventID.AchievementPop, self.displayDetailPanelDelegate)
end

function ArchivesUI:OnRemoveListeners()
	RedDotModule.Unsubscribe(Constant.E_RedDotPath.Archives_Achievement, self.buttonAchievement.transform:Find("RedDot").gameObject)
	EventDispatcher.RemoveEventListener(EventID.AchievementPop, self.displayDetailPanelDelegate)
end

function ArchivesUI:OnOpen(userData)
	self.MainPanel:Open()
	self.storyReviewPanel:Close()
end

function ArchivesUI:OnClose(userData)
	self.AchievementPanel:Close()
	self.MainPanel:Close()
end

function ArchivesUI:OnDestroy()
	self.AchievementPanel:OnDestroy()
	self.MainPanel:OnDestroy()
	self.commonReturnBtn:Dispose()
end

function ArchivesUI:GetPreloadAssetPaths()
	return nil
end

function ArchivesUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ArchivesUI:IsManualShowOnOpen(userData)
	return false
end

function ArchivesUI:GetBGM(userData)
	return nil
end

function ArchivesUI:OnPause()
	return
end

function ArchivesUI:OnResume()
	return
end

function ArchivesUI:OnCover()
	return
end

function ArchivesUI:OnReveal()
	return
end

function ArchivesUI:OnRefocus(userData)
	return
end

function ArchivesUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function ArchivesUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ArchivesUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ArchivesUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ArchivesUI:OnAchievementBtnClick()
	self.AchievementPanel:Open()
	self.MainPanel:Close()
end

function ArchivesUI:OnStoryReviewButtonClick()
	self.storyReviewPanel:Open()
	self.MainPanel:Close()
end

function ArchivesUI:displayDetaillPanelPop(cid)
	self.DisplayDetaillPanel:Show()
	self.DisplayDetaillPanel:Refresh(cid)
end

function ArchivesUI:OnClickReturnBtn()
	if self.onCloseButtonClick then
		self:onCloseButtonClick()
	end
end

function ArchivesUI:RegisterCloseEvent(func)
	self.onCloseButtonClick = func
end

return ArchivesUI
