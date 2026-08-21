local var_0_0 = class("SculptureActivity", import("model.vo.Activity"))

var_0_0.STATE_NIL = 0
var_0_0.STATE_UNLOCK = 1
var_0_0.STATE_DRAW = 2
var_0_0.STATE_JOINT = 3
var_0_0.STATE_FINSIH = 4

function var_0_0.UpdateState(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.data1KeyValueList[1] = arg_1_0.data1KeyValueList[1] or {}
	arg_1_0.data1KeyValueList[1][arg_1_1] = arg_1_2

	return
end

function var_0_0.GetSculptureState(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0.data1KeyValueList[1] or {}

	return var_2_0[arg_2_1] or var_0_0.STATE_NIL
end

function var_0_0.getDataConfigTable(arg_3_0)
	return pg.activity_giftmake_template
end

function var_0_0.getDataConfig(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0:getDataConfigTable()

	return var_4_0[arg_4_1] and var_4_0[arg_4_1][arg_4_2]
end

function var_0_0.GetComsume(arg_5_0, arg_5_1)
	return arg_5_0:getDataConfig(arg_5_1, "consume")[3]
end

function var_0_0._GetComsume(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:getDataConfig(arg_6_1, "consume")

	return var_6_0[2], var_6_0[3]
end

function var_0_0.GetResorceName(arg_7_0, arg_7_1)
	return arg_7_0:getDataConfig(arg_7_1, "resources")
end

function var_0_0.GetScale(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getDataConfig(arg_8_1, "scaling")

	return Vector3(var_8_0[1], var_8_0[2], 1)
end

function var_0_0.CanEnterState(arg_9_0, arg_9_1, arg_9_2)
	return arg_9_0:GetSculptureState(arg_9_1) + 1 == arg_9_2
end

function var_0_0.GetAwardProgress(arg_10_0)
	local var_10_0 = arg_10_0:getConfig("config_data")
	local var_10_1 = 0

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		if arg_10_0:GetSculptureState(iter_10_1) == var_0_0.STATE_FINSIH then
			var_10_1 = var_10_1 + 1
		end
	end

	return var_10_1, #var_10_0
end

function var_0_0.GetAwards(arg_11_0, arg_11_1)
	return arg_11_0:getDataConfig(arg_11_1, "reward_display")
end

function var_0_0.GetAwardDesc(arg_12_0, arg_12_1)
	return arg_12_0:getDataConfig(arg_12_1, "reward_describe") or ""
end

function var_0_0.EnoughResToOpen(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0, var_13_1 = arg_13_0:_GetComsume(arg_13_1)

	return var_13_1 < arg_13_2:getVitemNumber(var_13_0)
end

function var_0_0.readyToAchieve(arg_14_0)
	local var_14_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_VIRTUAL_BAG)

	if not var_14_0 or var_14_0:isEnd() then
		return false
	end

	for iter_14_0, iter_14_1 in ipairs((arg_14_0:getConfig("config_data"))) do
		if arg_14_0:GetSculptureState(iter_14_1) == var_0_0.STATE_NIL and arg_14_0:EnoughResToOpen(iter_14_1, var_14_0) then
			return true
		end
	end

	return false
end

return var_0_0
