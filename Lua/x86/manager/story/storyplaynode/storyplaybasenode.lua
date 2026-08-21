local var_0_0 = class("StoryPlayBaseNode")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.storyPlayer_ = arg_1_1

	arg_1_0:ResetStatus()
	arg_1_0:OnCtor(arg_1_1)
end

function var_0_0.ResetStatus(arg_2_0)
	arg_2_0.curTime_ = 0
	arg_2_0.startTime_ = 0
	arg_2_0.duration_ = 0.033
	arg_2_0.isResident_ = false
	arg_2_0.status_ = StoryPlayerConst.NODE_STATUS.IDLE
	arg_2_0.onPlayInvoked_ = false
	arg_2_0.onFinishInvoked_ = false
	arg_2_0.onDisposeInvoked_ = false
end

function var_0_0.SetConfig(arg_3_0, arg_3_1)
	arg_3_0.config_ = arg_3_1 or {}
	arg_3_0.startTime_ = arg_3_1.startTime or 0
	arg_3_0.duration_ = arg_3_1.duration or 0.033
	arg_3_0.isResident_ = arg_3_1.isResident or false

	arg_3_0:OnSetConfig(arg_3_1)
end

function var_0_0.GetStartTime(arg_4_0)
	return arg_4_0.startTime_
end

function var_0_0.GetCurTime(arg_5_0)
	return arg_5_0.curTime_
end

function var_0_0.GetDuration(arg_6_0)
	return arg_6_0.duration_
end

function var_0_0.SetDuration(arg_7_0, arg_7_1)
	arg_7_0.duration_ = arg_7_1
end

function var_0_0.OnSetConfig(arg_8_0, arg_8_1)
	return
end

function var_0_0.OnCtor(arg_9_0, arg_9_1)
	return
end

function var_0_0.OnPlay(arg_10_0)
	return
end

function var_0_0.OnUpdate(arg_11_0)
	return
end

function var_0_0.OnFinish(arg_12_0)
	return
end

function var_0_0.OnPause(arg_13_0)
	return
end

function var_0_0.OnResume(arg_14_0)
	return
end

function var_0_0.OnHide(arg_15_0)
	return
end

function var_0_0.OnDispose(arg_16_0)
	return
end

function var_0_0.GetStatus(arg_17_0)
	return arg_17_0.status_
end

function var_0_0.GetConfig(arg_18_0)
	return arg_18_0.config_
end

function var_0_0.Play(arg_19_0)
	arg_19_0.onPlayInvoked_ = true
	arg_19_0.status_ = StoryPlayerConst.NODE_STATUS.PLAYING
	arg_19_0.curTime_ = 0

	arg_19_0:OnPlay()
end

function var_0_0.Update(arg_20_0, arg_20_1)
	arg_20_0.status_ = StoryPlayerConst.NODE_STATUS.PLAYING
	arg_20_0.curTime_ = arg_20_0.curTime_ + arg_20_1

	arg_20_0:OnUpdate(arg_20_1)
end

function var_0_0.Finish(arg_21_0)
	arg_21_0.onFinishInvoked_ = true
	arg_21_0.status_ = StoryPlayerConst.NODE_STATUS.FINISHED
	arg_21_0.curTime_ = arg_21_0.startTime_ + arg_21_0.duration_

	arg_21_0:OnFinish()
end

function var_0_0.Pause(arg_22_0)
	arg_22_0.status_ = StoryPlayerConst.NODE_STATUS.PAUSED

	arg_22_0:OnPause()
end

function var_0_0.Resume(arg_23_0)
	arg_23_0.status_ = StoryPlayerConst.NODE_STATUS.PLAYING

	arg_23_0:OnResume()
end

function var_0_0.Hide(arg_24_0)
	arg_24_0.status_ = StoryPlayerConst.NODE_STATUS.HIDE

	arg_24_0:OnHide()
end

function var_0_0.Dispose(arg_25_0)
	arg_25_0.onDisposeInvoked_ = true

	arg_25_0:OnDispose()
end

return var_0_0
