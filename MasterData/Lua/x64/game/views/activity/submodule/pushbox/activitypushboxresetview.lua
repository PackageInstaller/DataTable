local ActivityPushBoxResetView = class("ActivityPushBoxResetView", ReduxView)

function ActivityPushBoxResetView:UIName()
	return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionUI_2_10AnniversaryUI/BoxGameResetPopUI"
end

function ActivityPushBoxResetView:UIParent()
	return manager.ui.uiPop.transform
end

function ActivityPushBoxResetView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityPushBoxResetView:InitUI()
	self:BindCfgUI()
end

function ActivityPushBoxResetView:AddUIListeners()
	self:AddBtnListener(self.okBtn_, nil, function()
		self:Back()
		manager.notify:Invoke(PUSH_BOX_RESET)
	end)
	self:AddBtnListener(self.cancelBtn_, nil, function()
		self:Back()
	end)
end

function ActivityPushBoxResetView:OnEnter()
	return
end

function ActivityPushBoxResetView:OnExit()
	return
end

function ActivityPushBoxResetView:Dispose()
	self:RemoveAllListeners()
	self.super.Dispose(self)
end

return ActivityPushBoxResetView
