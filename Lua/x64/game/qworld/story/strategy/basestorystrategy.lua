local var_0_0 = class("QWBaseStroyStrategy")

function var_0_0.Ctor(arg_1_0)
	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0.luaTarget = nil
	arg_2_0.isInTalk = false
	arg_2_0.storyID = -1

	arg_2_0:OnInit()
end

function var_0_0.OnInit(arg_3_0)
	return
end

function var_0_0.Dispose(arg_4_0)
	return
end

function var_0_0.StartStory(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0.isInTalk then
		QWorldMgr:GetQWorldStoryMgr():PreContinueStop()
	end

	arg_5_0.luaTarget = arg_5_2
	arg_5_0.isInTalk = true
	arg_5_0.storyID = arg_5_1

	arg_5_0:OnStartStory(arg_5_1)
end

function var_0_0.StopStory(arg_6_0)
	arg_6_0:OnEndStory()

	arg_6_0.luaTarget = nil
	arg_6_0.isInTalk = false
	arg_6_0.storyID = -1
end

function var_0_0.OnStartStory(arg_7_0, arg_7_1, arg_7_2)
	return
end

function var_0_0.OnEndStory(arg_8_0)
	return
end

function var_0_0.PreContinueStop(arg_9_0)
	return
end

function var_0_0.GetTarget(arg_10_0)
	return arg_10_0.luaTarget
end

function var_0_0.GetStoryID(arg_11_0)
	return arg_11_0.storyID
end

function var_0_0.GetStoryHistory(arg_12_0)
	return {}
end

function var_0_0.ChangeAutoPlayState(arg_13_0, arg_13_1)
	return
end

function var_0_0.GetAutoPlayState(arg_14_0)
	return
end

return var_0_0
