local var_0_0 = class("BossSingleEnemyData", import("model.vo.baseVO"))

var_0_0.ACTIVIRY_TYPE = {
	OTHERWORLD = 1
}
var_0_0.TYPE = {
	EX = 5,
	SP = 4,
	EAST = 1,
	NORMAL = 2,
	HARD = 3
}

function var_0_0.bindConfigTable(arg_1_0)
	return pg.activity_single_enemy
end

function var_0_0.Ctor(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id
	arg_2_0.configId = arg_2_0.id
	arg_2_0.fleetIdx = arg_2_1.index

	return
end

function var_0_0.InTime(arg_3_0)
	return pg.TimeMgr.GetInstance():inTime(arg_3_0:getConfig("time"))
end

function var_0_0.GetFleetIdx(arg_4_0)
	return arg_4_0.fleetIdx
end

function var_0_0.IsContinuousType(arg_5_0)
	return arg_5_0:GetType() ~= var_0_0.TYPE.SP
end

function var_0_0.IsOilLimit(arg_6_0)
	return arg_6_0:GetOilLimit()[1] > 0 and arg_6_0:GetOilLimit()[2] > 0
end

function var_0_0.GetActiviryType(arg_7_0)
	return arg_7_0:getConfig("activity_type")
end

function var_0_0.GetType(arg_8_0)
	return arg_8_0:getConfig("type")
end

function var_0_0.GetExpeditionId(arg_9_0)
	return arg_9_0:getConfig("expedition_id")
end

function var_0_0.GetPreChapterId(arg_10_0)
	return arg_10_0:getConfig("pre_chapter")
end

function var_0_0.IsGuardianEffective(arg_11_0)
	return arg_11_0:getConfig("guardian_limit") == 1
end

function var_0_0.GetCount(arg_12_0)
	return arg_12_0:getConfig("count")
end

function var_0_0.GetOilLimit(arg_13_0)
	return arg_13_0:getConfig("use_oil_limit")
end

function var_0_0.GetPropertyLimitation(arg_14_0)
	return arg_14_0:getConfig("property_limitation")
end

return var_0_0
