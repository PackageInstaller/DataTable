class = var_0_10000

local var_0_0 = "Student"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BaseVO"))

var_0_1.WAIT = 1
var_0_1.ATTEND = 2
var_0_1.CANCEL_TYPE_AUTO = 0
var_0_1.CANCEL_TYPE_MANUAL = 1
var_0_1.CANCEL_TYPE_QUICKLY = 2

function var_0_1.Ctor(arg_1_0, arg_1_1)
	local var_1_0

	if not arg_1_1.id then
		var_1_0 = arg_1_1.room_id
	end

	arg_1_0.id = var_1_0
	arg_1_0.skillId = arg_1_1.skill_pos
	arg_1_0.skillIdIndex = nil
	arg_1_0.lessonId = arg_1_1.lessonId
	arg_1_0.shipId = arg_1_1.ship_id
	arg_1_0.finishTime = arg_1_1.finish_time
	arg_1_0.startTime = arg_1_1.start_time
	arg_1_0.time = arg_1_1.time
	arg_1_0.exp = arg_1_1.exp

	local var_1_1

	if not arg_1_1.state then
		var_1_1 = var_0_1.ATTEND
	end

	arg_1_0.state = var_1_1

	return
end

function var_0_1.IsFinish(arg_2_0)
	pg = var_1_10001

	local var_2_0 = var_1_10001.TimeMgr.GetInstance()

	return var_1.GetServerTime(var_2_0) >= arg_2_0:getFinishTime()
end

function var_0_1.updateSkillId(arg_3_0, arg_3_1)
	arg_3_0.skillId = arg_3_1

	return
end

function var_0_1.setSkillIndex(arg_4_0, arg_4_1)
	arg_4_0.skillIdIndex = arg_4_1

	return
end

function var_0_1.getSkillId(arg_5_0, arg_5_1)
	if arg_5_0.skillId then
		return arg_5_0.skillId
	else
		return arg_5_1:getSkillList()[arg_5_0.skillIdIndex]
	end

	return
end

function var_0_1.setLesson(arg_6_0, arg_6_1)
	arg_6_0.lessonId = arg_6_1

	return
end

function var_0_1.setFinishTime(arg_7_0, arg_7_1)
	arg_7_0.finishTime = arg_7_1

	return
end

function var_0_1.setTime(arg_8_0, arg_8_1)
	arg_8_0.time = arg_8_1

	return
end

function var_0_1.getTime(arg_9_0)
	local var_9_0

	if not arg_9_0.time then
		var_9_0 = arg_9_0.finishTime - arg_9_0.startTime
	end

	return var_9_0
end

function var_0_1.getFinishTime(arg_10_0)
	return arg_10_0.finishTime
end

function var_0_1.getState(arg_11_0)
	return arg_11_0.state
end

function var_0_1.getSkillDesc(arg_12_0, arg_12_1, arg_12_2)
	getSkillDescLearn = var_1_10003

	return (var_1_10003(arg_12_0, arg_12_1, arg_12_2))
end

function var_0_1.getSkillName(arg_13_0)
	getProxy = var_1_10001
	BayProxy = var_1_10003

	local var_13_0 = var_1_10001(var_1_10003)
	local var_13_1 = var_1.getShipById(var_13_0, arg_13_0.shipId)

	getSkillName = var_1_10002

	return var_1_10002(arg_13_0:getSkillId(var_13_1))
end

function var_0_1.getShipVO(arg_14_0)
	getProxy = var_1_10001
	BayProxy = var_1_10003

	local var_14_0 = var_1_10001(var_1_10003)

	return (var_1.getShipById(var_14_0, arg_14_0.shipId))
end

return var_0_1
