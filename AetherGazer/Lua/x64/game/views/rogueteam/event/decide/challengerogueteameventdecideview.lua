local var_0_0 = class("ChallengeRogueTeamEventDecideView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Roulike/RogueDeterminePopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	return
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0:AddTimer()
end

function var_0_0.OnExit(arg_5_0)
	arg_5_0:StopTimer()
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

function var_0_0.AddListeners(arg_7_0)
	return
end

function var_0_0.AddTimer(arg_8_0)
	arg_8_0:StopTimer()

	local var_8_0 = GameSetting.rogue_Team_event_decide_effect.value[1]

	arg_8_0.timer_ = Timer.New(function()
		arg_8_0:DoNextStep()
	end, var_8_0 / 1000, 1)

	arg_8_0.timer_:Start()
end

function var_0_0.StopTimer(arg_10_0)
	if arg_10_0.timer_ then
		arg_10_0.timer_:Stop()

		arg_10_0.timer_ = nil
	end
end

function var_0_0.DoNextStep(arg_11_0)
	arg_11_0:StopTimer()

	local var_11_0 = arg_11_0.params_.stageID

	if var_11_0 ~= 0 then
		ChallengeRogueTeamAction.GotoRogueTeamEventReserve(var_11_0, true)
	else
		arg_11_0:Back()
	end
end

return var_0_0
