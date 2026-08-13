class = var_0_10000

local var_0_0 = "SkirmishVO"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BaseVO"))

var_0_1.TypeStoryOrExpedition = 1
var_0_1.TypeChapter = 2
var_0_1.StateInactive = 0
var_0_1.StateActive = 1
var_0_1.StateWorking = 2
var_0_1.StateClear = 3

function var_0_1.bindConfigTable(arg_1_0)
	pg = var_1_10001

	return var_1_10001.activity_skirmish_event
end

function var_0_1.Ctor(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1
	arg_2_0.configId = arg_2_1
	arg_2_0.state = var_0_1.StateInactive
	arg_2_0.flagNew = nil

	return
end

function var_0_1.SetState(arg_3_0, arg_3_1)
	arg_3_1 = arg_3_1 or 0

	if arg_3_1 == arg_3_0.state then
		return
	end

	if arg_3_0.state ~= nil then
		SkirmishVO = var_2

		if arg_3_1 == var_2.StateWorking then
			arg_3_0.flagNew = true
		end
	end

	arg_3_0.state = arg_3_1

	return
end

function var_0_1.GetState(arg_4_0)
	return arg_4_0.state
end

function var_0_1.GetType(arg_5_0)
	return arg_5_0:getConfig("type")
end

function var_0_1.GetEvent(arg_6_0)
	return arg_6_0:getConfig("event")
end

return var_0_1
