class = var_0_10000

local var_0_0 = "SculptureActivity"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.Activity"))

var_0_1.STATE_NIL = 0
var_0_1.STATE_UNLOCK = 1
var_0_1.STATE_DRAW = 2
var_0_1.STATE_JOINT = 3
var_0_1.STATE_FINSIH = 4

function var_0_1.UpdateState(arg_1_0, arg_1_1, arg_1_2)
	if not arg_1_0.data1KeyValueList[1] then
		arg_1_0.data1KeyValueList[1] = {}
	end

	arg_1_0.data1KeyValueList[1][arg_1_1] = arg_1_2

	return
end

function var_0_1.GetSculptureState(arg_2_0, arg_2_1)
	local var_2_0

	if not arg_2_0.data1KeyValueList[1] then
		var_2_0 = {}
	end

	local var_2_1

	if not var_2_0[arg_2_1] then
		var_2_1 = var_0_1.STATE_NIL
	end

	return var_2_1
end

function var_0_1.getDataConfigTable(arg_3_0)
	pg = var_1_10001

	return var_1_10001.activity_giftmake_template
end

function var_0_1.getDataConfig(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0

	if arg_4_0:getDataConfigTable()[arg_4_1] then
		var_4_0 = var_3[arg_4_1][arg_4_2]
	end

	return var_4_0
end

function var_0_1.GetComsume(arg_5_0, arg_5_1)
	return arg_5_0:getDataConfig(arg_5_1, "consume")[3]
end

function var_0_1._GetComsume(arg_6_0, arg_6_1)
	return arg_6_0:getDataConfig(arg_6_1, "consume")[2], var_2[3]
end

function var_0_1.GetResorceName(arg_7_0, arg_7_1)
	return arg_7_0:getDataConfig(arg_7_1, "resources")
end

function var_0_1.GetScale(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.getDataConfig(var_8_0, arg_8_1, "scaling")

	Vector3 = var_8_0

	return var_8_0(var_8_1[1], var_8_1[2], 1)
end

function var_0_1.CanEnterState(arg_9_0, arg_9_1, arg_9_2)
	return arg_9_0:GetSculptureState(arg_9_1) + 1 == arg_9_2
end

function var_0_1.GetAwardProgress(arg_10_0)
	local var_10_0 = #arg_10_0:getConfig("config_data")
	local var_10_1 = 0

	ipairs = var_1_10004

	for iter_10_0, iter_10_1 in var_1_10004(var_1) do
		if arg_10_0:GetSculptureState(iter_10_1) == var_0_1.STATE_FINSIH then
			var_10_1 = var_10_1 + 1
		end
	end

	return var_10_1, var_10_0
end

function var_0_1.GetAwards(arg_11_0, arg_11_1)
	return arg_11_0:getDataConfig(arg_11_1, "reward_display")
end

function var_0_1.GetAwardDesc(arg_12_0, arg_12_1)
	local var_12_0

	if not arg_12_0:getDataConfig(arg_12_1, "reward_describe") then
		var_12_0 = ""
	end

	return var_12_0
end

function var_0_1.EnoughResToOpen(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0, var_13_1 = arg_13_0:_GetComsume(arg_13_1)

	return var_13_1 < arg_13_2:getVitemNumber(var_13_0)
end

function var_0_1.readyToAchieve(arg_14_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_14_0 = var_1_10001(var_1_10002)
	local var_14_1 = var_1.getActivityByType

	ActivityConst = var_1_10003

	if not var_14_1(var_14_0, var_1_10003.ACTIVITY_TYPE_VIRTUAL_BAG) or var_1:isEnd() then
		return false
	end

	local var_14_2 = arg_14_0
	local var_14_3 = arg_14_0.getConfig(var_14_2, "config_data")

	ipairs = var_14_2

	for iter_14_0, iter_14_1 in var_14_2(var_14_3) do
		if arg_14_0:GetSculptureState(iter_14_1) == var_0_1.STATE_NIL and arg_14_0:EnoughResToOpen(iter_14_1, var_1) then
			return true
		end
	end

	return false
end

return var_0_1
