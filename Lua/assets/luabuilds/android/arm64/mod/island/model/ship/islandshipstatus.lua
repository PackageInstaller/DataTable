local var_0_0 = class("IslandShipStatus", import("model.vo.BaseVO"))

var_0_0.COLOR_NULL = 0
var_0_0.COLOR_RED = 1
var_0_0.COLOR_BLUE = 2

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_1.id
	arg_1_0.startTime = arg_1_1.start_time or 0
	arg_1_0.isSkill = arg_1_1.isSkill
	arg_1_0.time = 0

	arg_1_0:InitEndTime()

	return
end

function var_0_0.InitEndTime(arg_2_0)
	local var_2_0 = arg_2_0:GetDuration()

	arg_2_0.time = var_2_0 == 0 and 0 or arg_2_0.startTime + var_2_0

	return
end

function var_0_0.GetEndTime(arg_3_0)
	return arg_3_0.time
end

function var_0_0.GetStartTime(arg_4_0)
	return arg_4_0.startTime
end

function var_0_0.IsSkillBuff(arg_5_0)
	return arg_5_0.isSkill
end

function var_0_0.GetGroup(arg_6_0)
	return arg_6_0:getConfig("buff_group")
end

function var_0_0.GetLevel(arg_7_0)
	return arg_7_0:getConfig("buff_level")
end

function var_0_0.GetDuelTypeList(arg_8_0)
	return arg_8_0:getConfig("type_duel")
end

function var_0_0.GetDuelIdList(arg_9_0)
	return arg_9_0:getConfig("buff_duel")
end

function var_0_0.GetDuration(arg_10_0)
	return arg_10_0:getConfig("buff_time")
end

function var_0_0.GetBuffType(arg_11_0)
	return arg_11_0:getConfig("buff_type")
end

function var_0_0.GetBuffEffect(arg_12_0)
	return arg_12_0:getConfig("type_use")
end

function var_0_0.bindConfigTable(arg_13_0)
	return pg.island_buff_template
end

function var_0_0.AddTime(arg_14_0, arg_14_1)
	arg_14_0.time = math.max(arg_14_0.time, (pg.TimeMgr.GetInstance():GetServerTime())) + arg_14_1

	return
end

function var_0_0.IsExpiration(arg_15_0)
	if arg_15_0.time == 0 then
		return false
	end

	local var_15_0 = pg.TimeMgr.GetInstance()

	return var_15_0:GetServerTime() >= arg_15_0.time
end

function var_0_0.GetDesc(arg_16_0)
	return arg_16_0:getConfig("buff_desc")
end

function var_0_0.GetName(arg_17_0)
	return arg_17_0:getConfig("name")
end

function var_0_0.IsRed(arg_18_0)
	return arg_18_0:getConfig("buff_color") == var_0_0.COLOR_RED
end

function var_0_0.IsBlue(arg_19_0)
	return arg_19_0:getConfig("buff_color") == var_0_0.COLOR_BLUE
end

function var_0_0.CanDisplay(arg_20_0)
	return arg_20_0:getConfig("buff_color") ~= var_0_0.COLOR_NULL
end

return var_0_0
