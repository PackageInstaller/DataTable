local var_0_0 = class("ChallengeRogueTeamMapSwitchEffectView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_Roulike/item/BackGroundCutScenesUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()
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

	local var_8_0 = false

	arg_8_0.timer_ = FrameTimer.New(function()
		local var_9_0 = arg_8_0.animator_:GetCurrentAnimatorStateInfo(0)

		if var_9_0.normalizedTime >= 0.7 and var_8_0 == false then
			var_8_0 = true

			ChallengeRogueTeamAction.RequestNextMapData(function(arg_10_0)
				if not isSuccess(arg_10_0.result) then
					var_8_0 = false
				end
			end)
		end

		if var_9_0.normalizedTime >= 1 then
			arg_8_0:StopTimer()
			ChallengeRogueTeamData:RemoveServerTriggerQueue()
			arg_8_0:Back()
			ChallengeRogueTeamAction.RemovePopWindowCnt()
			manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_UPDATE_WINDOW)
		end
	end, 1, -1)

	arg_8_0.timer_:Start()
end

function var_0_0.StopTimer(arg_11_0)
	if arg_11_0.timer_ then
		arg_11_0.timer_:Stop()

		arg_11_0.timer_ = nil
	end
end

return var_0_0
