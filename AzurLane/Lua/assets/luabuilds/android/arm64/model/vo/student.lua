local var_0_0 = class("Student", import(".BaseVO"))

var_0_0.WAIT = 1
var_0_0.ATTEND = 2
var_0_0.CANCEL_TYPE_AUTO = 0
var_0_0.CANCEL_TYPE_MANUAL = 1
var_0_0.CANCEL_TYPE_QUICKLY = 2

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id or arg_1_1.room_id
	arg_1_0.skillId = arg_1_1.skill_pos
	arg_1_0.skillIdIndex = nil
	arg_1_0.lessonId = arg_1_1.lessonId
	arg_1_0.shipId = arg_1_1.ship_id
	arg_1_0.finishTime = arg_1_1.finish_time
	arg_1_0.startTime = arg_1_1.start_time
	arg_1_0.time = arg_1_1.time
	arg_1_0.exp = arg_1_1.exp
	arg_1_0.state = arg_1_1.state or var_0_0.ATTEND

	return
end

function var_0_0.IsFinish(arg_2_0)
	local var_2_0 = pg.TimeMgr.GetInstance()

	return var_2_0:GetServerTime() >= arg_2_0:getFinishTime()
end

function var_0_0.updateSkillId(arg_3_0, arg_3_1)
	arg_3_0.skillId = arg_3_1

	return
end

function var_0_0.setSkillIndex(arg_4_0, arg_4_1)
	arg_4_0.skillIdIndex = arg_4_1

	return
end

function var_0_0.getSkillId(arg_5_0, arg_5_1)
	if arg_5_0.skillId then
		return arg_5_0.skillId
	else
		return arg_5_1:getSkillList()[arg_5_0.skillIdIndex]
	end

	return
end

function var_0_0.setLesson(arg_6_0, arg_6_1)
	arg_6_0.lessonId = arg_6_1

	return
end

function var_0_0.setFinishTime(arg_7_0, arg_7_1)
	arg_7_0.finishTime = arg_7_1

	return
end

function var_0_0.setTime(arg_8_0, arg_8_1)
	arg_8_0.time = arg_8_1

	return
end

function var_0_0.getTime(arg_9_0)
	return arg_9_0.time or arg_9_0.finishTime - arg_9_0.startTime
end

function var_0_0.getFinishTime(arg_10_0)
	return arg_10_0.finishTime
end

function var_0_0.getState(arg_11_0)
	return arg_11_0.state
end

function var_0_0.getSkillDesc(arg_12_0, arg_12_1, arg_12_2)
	return (getSkillDescLearn(arg_12_0, arg_12_1, arg_12_2))
end

function var_0_0.getSkillName(arg_13_0)
	return getSkillName(arg_13_0:getSkillId((getProxy(BayProxy):getShipById(arg_13_0.shipId))))
end

function var_0_0.getShipVO(arg_14_0)
	return (getProxy(BayProxy):getShipById(arg_14_0.shipId))
end

return var_0_0
