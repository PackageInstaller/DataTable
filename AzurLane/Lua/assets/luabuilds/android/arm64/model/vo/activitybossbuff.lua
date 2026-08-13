class = var_0_10000

local var_0_0 = "ActivityBossBuff"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.BaseVO"))

function var_0_1.bindConfigTable(arg_1_0)
	pg = var_1_10001

	return var_1_10001.worldboss_bufflist
end

function var_0_1.GetConfigID(arg_2_0)
	return arg_2_0.configId
end

function var_0_1.GetIcon(arg_3_0)
	return arg_3_0:getConfig("buff_icon")
end

function var_0_1.GetIconPath(arg_4_0)
	return "activitybossbuff/" .. arg_4_0:getConfig("buff_icon")
end

function var_0_1.GetName(arg_5_0)
	return arg_5_0:getConfig("name")
end

function var_0_1.GetDesc(arg_6_0)
	return arg_6_0:getConfig("desc")
end

function var_0_1.CastOnEnemy(arg_7_0)
	return arg_7_0:getConfig("buff_target") == 1
end

function var_0_1.GetBuffID(arg_8_0)
	return arg_8_0:getConfig("lua_id")
end

function var_0_1.GetBonus(arg_9_0)
	tonumber = var_1_10001

	return var_1_10001(arg_9_0:getConfig("bonus"))
end

function var_0_1.GetBonusText(arg_10_0)
	math = var_1_10001

	return var_1_10001.floor(arg_10_0:GetBonus() * 100) .. "%"
end

return var_0_1
