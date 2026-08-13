class = var_0_10000

local var_0_0 = "NewEducateTopicState"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".NewEducateStateBase"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	local var_1_0

	if not arg_1_1.chats then
		var_1_0 = {}
	end

	arg_1_0.topics = var_1_0
	arg_1_0.finishFlag = arg_1_1.finished == 1 and true or false

	return
end

function var_0_1.SetTopics(arg_2_0, arg_2_1)
	arg_2_0.topics = arg_2_1

	return
end

function var_0_1.GetTopics(arg_3_0)
	return arg_3_0.topics
end

function var_0_1.MarkFinish(arg_4_0)
	arg_4_0.finishFlag = true

	return
end

function var_0_1.IsFinish(arg_5_0)
	return arg_5_0.finishFlag
end

function var_0_1.Reset(arg_6_0)
	arg_6_0.topics = {}
	arg_6_0.finishFlag = false

	return
end

return var_0_1
