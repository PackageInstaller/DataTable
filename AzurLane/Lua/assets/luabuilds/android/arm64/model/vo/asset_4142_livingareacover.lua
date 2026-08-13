class = var_0_10000

local var_0_0 = "LivingAreaCover"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BaseVO"))

var_0_1.TYPE_DAY = "day"
var_0_1.TYPE_NIGHT = "night"

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id
	arg_1_0.unlock = arg_1_1.unlock
	arg_1_0.isNew = arg_1_1.isNew

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.livingarea_cover
end

function var_0_1.SetUnlock(arg_3_0, arg_3_1)
	arg_3_0.unlock = arg_3_1

	return
end

function var_0_1.IsUnlock(arg_4_0)
	return arg_4_0.unlock
end

function var_0_1.ClearNew(arg_5_0)
	arg_5_0.isNew = false

	return
end

function var_0_1.IsNew(arg_6_0)
	return arg_6_0.isNew
end

function var_0_1.GetDropType(arg_7_0)
	DROP_TYPE_LIVINGAREA_COVER = var_1_10001

	return var_1_10001
end

function var_0_1.GetUnlockText(arg_8_0)
	return arg_8_0:getConfig("unlock_text")
end

function var_0_1.GetIcon(arg_9_0)
	return "livingareacover/" .. arg_9_0:getConfig("icon_res")
end

function var_0_1.GetBg(arg_10_0, arg_10_1)
	return "livingareaCover/" .. arg_10_0:getConfig(arg_10_1 .. "time_res")
end

return var_0_1
