local ActivityPushBoxQuitView = class("ActivityPushBoxQuitView", ReduxView)

function ActivityPushBoxQuitView:UIName()
	return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionUI_2_10AnniversaryUI/BoxGamePausePopUI"
end

function ActivityPushBoxQuitView:UIParent()
	return manager.ui.uiPop.transform
end

function ActivityPushBoxQuitView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityPushBoxQuitView:InitUI()
	self:BindCfgUI()
end

function ActivityPushBoxQuitView:AddUIListeners()
	self:AddBtnListener(self.okBtn_, nil, function()
		PushBoxTool:SendSdk(self.params_.activityID, self.params_.id, 3)

		if self.params_.way == "back" then
			JumpTools.OpenPageByJump("/activityPushBoxMaterial", {
				activityID = self.params_.activityID
			})
		elseif self.params_.way == "home" then
			JumpTools.OpenPageByJump("/home")
		end
	end)
	self:AddBtnListener(self.cancelBtn_, nil, function()
		self:Back()
	end)
end

function ActivityPushBoxQuitView:OnEnter()
	return
end

function ActivityPushBoxQuitView:OnExit()
	return
end

function ActivityPushBoxQuitView:Dispose()
	self:RemoveAllListeners()
	self.super.Dispose(self)
end

return ActivityPushBoxQuitView
