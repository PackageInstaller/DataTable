local var_0_0 = class("LivingAreaCover", import(".BaseVO"))

var_0_0.TYPE_DAY = "day"
var_0_0.TYPE_NIGHT = "night"

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id
	arg_1_0.unlock = arg_1_1.unlock
	arg_1_0.isNew = arg_1_1.isNew

	return
end

function var_0_0.bindConfigTable(arg_2_0)
	return pg.livingarea_cover
end

function var_0_0.SetUnlock(arg_3_0, arg_3_1)
	arg_3_0.unlock = arg_3_1

	return
end

function var_0_0.IsUnlock(arg_4_0)
	return arg_4_0.unlock
end

function var_0_0.ClearNew(arg_5_0)
	arg_5_0.isNew = false

	return
end

function var_0_0.IsNew(arg_6_0)
	return arg_6_0.isNew
end

function var_0_0.GetDropType(arg_7_0)
	return DROP_TYPE_LIVINGAREA_COVER
end

function var_0_0.GetUnlockText(arg_8_0)
	return arg_8_0:getConfig("unlock_text")
end

function var_0_0.GetIcon(arg_9_0)
	return "livingareacover/" .. arg_9_0:getConfig("icon_res")
end

function var_0_0.GetBg(arg_10_0, arg_10_1)
	return "livingareaCover/" .. arg_10_0:getConfig(arg_10_1 .. "time_res")
end

return var_0_0
