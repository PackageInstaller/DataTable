local var_0_0 = class("AutoChessActionBaseRenderer")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.status = AutoChessConst.ACTION_RENDERER_STATUS.IDLE
	arg_1_0.actionData = nil
end

function var_0_0.Init(arg_2_0, arg_2_1)
	arg_2_0.actionData = arg_2_1
end

function var_0_0.Play(arg_3_0)
	arg_3_0.status = AutoChessConst.ACTION_RENDERER_STATUS.RUNNING

	arg_3_0:OnPlay()
end

function var_0_0.Pause(arg_4_0)
	if arg_4_0:IsRunning() then
		arg_4_0.status = AutoChessConst.ACTION_RENDERER_STATUS.PAUSED

		arg_4_0:OnPause()
	end
end

function var_0_0.Resume(arg_5_0)
	if arg_5_0:IsPaused() then
		arg_5_0.status = AutoChessConst.ACTION_RENDERER_STATUS.RUNNING

		arg_5_0:OnResume()
	end
end

function var_0_0.Finish(arg_6_0)
	arg_6_0.status = AutoChessConst.ACTION_RENDERER_STATUS.FINISHED

	arg_6_0:OnFinish()
end

function var_0_0.Reset(arg_7_0)
	arg_7_0.status = AutoChessConst.ACTION_RENDERER_STATUS.IDLE

	arg_7_0:OnReset()

	arg_7_0.actionData = nil
end

function var_0_0.IsFinish(arg_8_0)
	return arg_8_0.status == AutoChessConst.ACTION_RENDERER_STATUS.FINISHED
end

function var_0_0.IsRunning(arg_9_0)
	return arg_9_0.status == AutoChessConst.ACTION_RENDERER_STATUS.RUNNING
end

function var_0_0.IsPaused(arg_10_0)
	return arg_10_0.status == AutoChessConst.ACTION_RENDERER_STATUS.PAUSED
end

function var_0_0.SetSpeed(arg_11_0, arg_11_1)
	return
end

function var_0_0.OnPlay(arg_12_0)
	return
end

function var_0_0.Update(arg_13_0)
	return
end

function var_0_0.OnPause(arg_14_0)
	return
end

function var_0_0.OnResume(arg_15_0)
	return
end

function var_0_0.OnFinish(arg_16_0)
	return
end

function var_0_0.OnReset(arg_17_0)
	return
end

return var_0_0
