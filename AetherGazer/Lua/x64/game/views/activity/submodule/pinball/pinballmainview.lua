local var_0_0 = class("PinBallMainView", ActivityMainBasePanel)

function var_0_0.GetUIName(arg_1_0)
	return "Widget/Version/BaichaoUI_3_9/BaichaoUI_3_9_PinballUI/BaichaoUI_3_9_PinballCheckMainUI"
end

function var_0_0.Init(arg_2_0)
	var_0_0.super.Init(arg_2_0)

	if arg_2_0.controllers_ then
		arg_2_0.lockController = arg_2_0.controllers_:GetController("statelock01")
	end
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:BindHelpBtn("PINBALL_GAMEPLAY_DESC")
	arg_3_0:AddBtnListenerScale(arg_3_0.goBtn_, nil, function()
		JumpTools.OpenPageByJump("/pinballStage")
	end)
end

function var_0_0.OnEnter(arg_5_0)
	var_0_0.super.OnEnter(arg_5_0)
	manager.redPoint:bindUIandKey(arg_5_0.goBtn_.transform, PinballTools.RedPointKey(PinballData.activityID))
end

function var_0_0.OnExit(arg_6_0)
	manager.redPoint:unbindUIandKey(arg_6_0.goBtn_.transform, PinballTools.RedPointKey(PinballData.activityID))
	var_0_0.super.OnExit(arg_6_0)
end

function var_0_0.HideRedPoint(arg_7_0)
	return
end

function var_0_0.isHasLeftTimeDes(arg_8_0)
	return true
end

function var_0_0.UpdateBar(arg_9_0)
	local var_9_0 = PinballTools.ActivityCoin()

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.RefreshAcvanceStatus(arg_10_0, arg_10_1)
	arg_10_0.lockController:SetSelectedState(arg_10_1 and "normal01" or "lock01")
end

return var_0_0
