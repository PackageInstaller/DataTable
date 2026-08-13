class = var_0_10000

local var_0_0 = "IslandShipStatus"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.BaseVO"))

var_0_1.COLOR_NULL = 0
var_0_1.COLOR_RED = 1
var_0_1.COLOR_BLUE = 2

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_1.id

	local var_1_0

	if not arg_1_1.start_time then
		var_1_0 = 0
	end

	arg_1_0.startTime = var_1_0
	arg_1_0.isSkill = arg_1_1.isSkill
	arg_1_0.time = 0

	arg_1_0:InitEndTime()

	return
end

function var_0_1.InitEndTime(arg_2_0)
	if arg_2_0:GetDuration() == 0 then
		arg_2_0.time = 0
	else
		arg_2_0.time = arg_2_0.startTime + var_1
	end

	return
end

function var_0_1.GetEndTime(arg_3_0)
	return arg_3_0.time
end

function var_0_1.GetStartTime(arg_4_0)
	return arg_4_0.startTime
end

function var_0_1.IsSkillBuff(arg_5_0)
	return arg_5_0.isSkill
end

function var_0_1.GetGroup(arg_6_0)
	return arg_6_0:getConfig("buff_group")
end

function var_0_1.GetLevel(arg_7_0)
	return arg_7_0:getConfig("buff_level")
end

function var_0_1.GetDuelTypeList(arg_8_0)
	return arg_8_0:getConfig("type_duel")
end

function var_0_1.GetDuelIdList(arg_9_0)
	return arg_9_0:getConfig("buff_duel")
end

function var_0_1.GetDuration(arg_10_0)
	return arg_10_0:getConfig("buff_time")
end

function var_0_1.GetBuffType(arg_11_0)
	return arg_11_0:getConfig("buff_type")
end

function var_0_1.GetBuffEffect(arg_12_0)
	return arg_12_0:getConfig("type_use")
end

function var_0_1.bindConfigTable(arg_13_0)
	pg = var_1_10001

	return var_1_10001.island_buff_template
end

function var_0_1.AddTime(arg_14_0, arg_14_1)
	pg = var_1_10002

	local var_14_0 = var_1_10002.TimeMgr.GetInstance()
	local var_14_1 = var_2.GetServerTime(var_14_0)

	math = var_14_0
	arg_14_0.time = var_14_0.max(arg_14_0.time, var_14_1) + arg_14_1

	return
end

function var_0_1.IsExpiration(arg_15_0)
	if arg_15_0.time == 0 then
		return false
	end

	pg = var_1

	local var_15_0 = var_1.TimeMgr.GetInstance()

	return var_1.GetServerTime(var_15_0) >= arg_15_0.time
end

function var_0_1.GetDesc(arg_16_0)
	return arg_16_0:getConfig("buff_desc")
end

function var_0_1.GetName(arg_17_0)
	return arg_17_0:getConfig("name")
end

function var_0_1.IsRed(arg_18_0)
	return arg_18_0:getConfig("buff_color") == var_0_1.COLOR_RED
end

function var_0_1.IsBlue(arg_19_0)
	return arg_19_0:getConfig("buff_color") == var_0_1.COLOR_BLUE
end

function var_0_1.CanDisplay(arg_20_0)
	return arg_20_0:getConfig("buff_color") ~= var_0_1.COLOR_NULL
end

return var_0_1
