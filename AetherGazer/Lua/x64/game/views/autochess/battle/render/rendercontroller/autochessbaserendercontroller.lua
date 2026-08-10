local var_0_0 = class("AutoChessBaseRenderController")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.speed = 1
	arg_1_0.finishCallback = nil
	arg_1_0.status = AutoChessConst.ACTION_RENDER_CONTROLLER_STATUS.IDLE

	arg_1_0:OnCtor()
end

function var_0_0.Init(arg_2_0, arg_2_1)
	arg_2_0.speed = arg_2_1
end

function var_0_0.RegistFinishCallback(arg_3_0, arg_3_1)
	arg_3_0.finishCallback = arg_3_1
end

function var_0_0.SetSpeed(arg_4_0, arg_4_1)
	arg_4_0.speed = arg_4_1

	arg_4_0:OnSpeedChange()
end

function var_0_0.Play(arg_5_0)
	arg_5_0.status = AutoChessConst.ACTION_RENDER_CONTROLLER_STATUS.RUNNING

	AutoChessBattleRenderer.GetInstance():RegistPlayingRenderController(arg_5_0)
	arg_5_0:OnPlay()
end

function var_0_0.Pause(arg_6_0)
	if arg_6_0:IsRunning() then
		arg_6_0.status = AutoChessConst.ACTION_RENDER_CONTROLLER_STATUS.PAUSED

		arg_6_0:OnPause()
	end
end

function var_0_0.Resume(arg_7_0)
	if arg_7_0:IsPaused() then
		arg_7_0.status = AutoChessConst.ACTION_RENDER_CONTROLLER_STATUS.RUNNING

		arg_7_0:OnResume()
	end
end

function var_0_0.Finish(arg_8_0)
	arg_8_0.status = AutoChessConst.ACTION_RENDER_CONTROLLER_STATUS.FINISHED

	arg_8_0:OnFinish()

	if arg_8_0.finishCallback then
		arg_8_0.finishCallback()
	end
end

function var_0_0.IsFinish(arg_9_0)
	return arg_9_0.status == AutoChessConst.ACTION_RENDER_CONTROLLER_STATUS.FINISHED
end

function var_0_0.IsRunning(arg_10_0)
	return arg_10_0.status == AutoChessConst.ACTION_RENDER_CONTROLLER_STATUS.RUNNING
end

function var_0_0.IsPaused(arg_11_0)
	return arg_11_0.status == AutoChessConst.ACTION_RENDER_CONTROLLER_STATUS.PAUSED
end

function var_0_0.Reset(arg_12_0)
	arg_12_0.status = AutoChessConst.ACTION_RENDER_CONTROLLER_STATUS.IDLE
	arg_12_0.speed = 1
	arg_12_0.finishCallback = nil
end

function var_0_0.OnCtor(arg_13_0)
	return
end

function var_0_0.OnPlay(arg_14_0)
	return
end

function var_0_0.Update(arg_15_0)
	return
end

function var_0_0.OnPause(arg_16_0)
	return
end

function var_0_0.OnResume(arg_17_0)
	return
end

function var_0_0.OnFinish(arg_18_0)
	return
end

function var_0_0.OnSpeedChange(arg_19_0)
	return
end

return var_0_0
