local var_0_0 = class("NewEducateTopicState", import(".NewEducateStateBase"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.topics = arg_1_1.chats or {}
	arg_1_0.finishFlag = arg_1_1.finished == 1

	return
end

function var_0_0.SetTopics(arg_2_0, arg_2_1)
	arg_2_0.topics = arg_2_1

	return
end

function var_0_0.GetTopics(arg_3_0)
	return arg_3_0.topics
end

function var_0_0.MarkFinish(arg_4_0)
	arg_4_0.finishFlag = true

	return
end

function var_0_0.IsFinish(arg_5_0)
	return arg_5_0.finishFlag
end

function var_0_0.Reset(arg_6_0)
	arg_6_0.topics = {}
	arg_6_0.finishFlag = false

	return
end

return var_0_0
