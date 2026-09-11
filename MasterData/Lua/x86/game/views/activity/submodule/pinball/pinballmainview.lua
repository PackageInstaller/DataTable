local PinBallMainView = class("PinBallMainView", ActivityMainBasePanel)

function PinBallMainView:GetUIName()
	return "Widget/Version/BaichaoUI_3_9/BaichaoUI_3_9_PinballUI/BaichaoUI_3_9_PinballCheckMainUI"
end

function PinBallMainView:Init()
	PinBallMainView.super.Init(self)

	if self.controllers_ then
		self.lockController = self.controllers_:GetController("statelock01")
	end
end

function PinBallMainView:AddListeners()
	self:BindHelpBtn("PINBALL_GAMEPLAY_DESC")
	self:AddBtnListenerScale(self.goBtn_, nil, function()
		JumpTools.OpenPageByJump("/pinballStage")
	end)
end

function PinBallMainView:OnEnter()
	PinBallMainView.super.OnEnter(self)
	manager.redPoint:bindUIandKey(self.goBtn_.transform, PinballTools.RedPointKey(PinballData.activityID))
end

function PinBallMainView:OnExit()
	manager.redPoint:unbindUIandKey(self.goBtn_.transform, PinballTools.RedPointKey(PinballData.activityID))
	PinBallMainView.super.OnExit(self)
end

function PinBallMainView:HideRedPoint()
	return
end

function PinBallMainView:isHasLeftTimeDes()
	return true
end

function PinBallMainView:UpdateBar()
	local var_9_0 = PinballTools.ActivityCoin()

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function PinBallMainView:RefreshAcvanceStatus(arg_10_1)
	self.lockController:SetSelectedState(arg_10_1 and "normal01" or "lock01")
end

return PinBallMainView
