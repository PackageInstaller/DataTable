local var_0_0 = class("StageArchiveMomoTalkPlayer")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.updateCallback_ = arg_1_1
	arg_1_0.updatePeriod_ = arg_1_2
	arg_1_0.cdNum_ = 0
end

function var_0_0.Play(arg_2_0)
	arg_2_0.isPlaying_ = true
	arg_2_0.curUpdateIndex_ = 0

	arg_2_0:StartCountDown()
	arg_2_0:OnUpdate()
end

function var_0_0.Stop(arg_3_0)
	arg_3_0.isPlaying_ = false

	arg_3_0:StopCountDown()
end

function var_0_0.Skip(arg_4_0)
	if not arg_4_0.isPlaying_ then
		return
	end

	arg_4_0.cdNum_ = arg_4_0.updatePeriod_

	arg_4_0:OnUpdate()
end

function var_0_0.StartCountDown(arg_5_0)
	arg_5_0:StopCountDown()

	arg_5_0.cdNum_ = arg_5_0.updatePeriod_

	if not arg_5_0.countDownTimer_ then
		arg_5_0.countDownTimer_ = FuncTimerManager.inst:CreateFuncFrameTimer(handler(arg_5_0, arg_5_0.OnCountDown), -1, true)
	end
end

function var_0_0.StopCountDown(arg_6_0)
	if arg_6_0.countDownTimer_ then
		FuncTimerManager.inst:RemoveFuncTimer(arg_6_0.countDownTimer_)

		arg_6_0.countDownTimer_ = nil
	end
end

function var_0_0.OnCountDown(arg_7_0)
	arg_7_0.cdNum_ = arg_7_0.cdNum_ - Time.deltaTime

	if arg_7_0.cdNum_ <= 0 then
		arg_7_0.cdNum_ = arg_7_0.updatePeriod_

		arg_7_0:OnUpdate()
	end
end

function var_0_0.OnUpdate(arg_8_0)
	arg_8_0.curUpdateIndex_ = arg_8_0.curUpdateIndex_ + 1

	if arg_8_0.updateCallback_ then
		arg_8_0.updateCallback_(arg_8_0.curUpdateIndex_)
	end
end

return var_0_0
