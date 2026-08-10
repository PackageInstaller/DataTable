local var_0_0 = class("ChallengeRogueTeamStartAnimatorView", BaseView)

function var_0_0.Ctor(arg_1_0)
	arg_1_0.gameObject_ = Object.Instantiate(Asset.Load(arg_1_0:UIName()), arg_1_0:UIParent())
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.UIName(arg_2_0)
	return "Widget/System/Activity_Roulike/item/RoulikeSwitchUI"
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiStory.transform
end

function var_0_0.Init(arg_4_0)
	arg_4_0:BindCfgUI()
	ChallengeRogueTeamData:UISetNeedPlayStartAnimator(false)
	arg_4_0:AddTimer()
end

function var_0_0.Dispose(arg_5_0)
	Object.Destroy(arg_5_0.gameObject_)

	arg_5_0.transform_ = nil
	arg_5_0.gameObject_ = nil
end

function var_0_0.AddListeners(arg_6_0)
	return
end

function var_0_0.AddTimer(arg_7_0)
	arg_7_0:StopTimer()

	local var_7_0 = true

	arg_7_0.timer_ = FrameTimer.New(function()
		local var_8_0 = arg_7_0.animator_:GetCurrentAnimatorStateInfo(0)

		if var_8_0.normalizedTime > 0.1 and var_7_0 then
			JumpTools.GoToSystem("/challengeRogueTeamPathMain")

			var_7_0 = false
		end

		if var_8_0.normalizedTime < 1 then
			return
		end

		arg_7_0:StopTimer()
		arg_7_0:Dispose()
	end, 1, -1)

	arg_7_0.timer_:Start()
end

function var_0_0.StopTimer(arg_9_0)
	if arg_9_0.timer_ then
		arg_9_0.timer_:Stop()

		arg_9_0.timer_ = nil
	end
end

return var_0_0
