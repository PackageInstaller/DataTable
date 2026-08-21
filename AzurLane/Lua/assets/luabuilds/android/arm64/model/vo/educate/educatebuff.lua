local var_0_0 = class("EducateBuff", import("model.vo.BaseVO"))

var_0_0.TYPE_ATTR = 1
var_0_0.TYPE_RES = 2
var_0_0.ADDITION_TYPE_RATIO = 1
var_0_0.ADDITION_TYPE_NUMBER = 2

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id
	arg_1_0.endTime = arg_1_1.time or EducateHelper.GetTimeAfterWeeks(getProxy(EducateProxy):GetCurTime(), arg_1_0:getConfig("during_time"))

	return
end

function var_0_0.bindConfigTable(arg_2_0)
	return pg.child_buff
end

function var_0_0.GetReaminTime(arg_3_0, arg_3_1)
	arg_3_1 = arg_3_1 or getProxy(EducateProxy):GetCurTime()

	return EducateHelper.GetDaysBetweenTimes(arg_3_1, arg_3_0.endTime)
end

function var_0_0.GetReaminWeek(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:GetReaminTime(arg_4_1)

	if var_4_0 == 0 then
		return 0
	else
		return var_4_0 / 7
	end

	return
end

function var_0_0.ResetEndTime(arg_5_0, arg_5_1)
	arg_5_1 = arg_5_1 or getProxy(EducateProxy):GetCurTime()
	arg_5_0.endTime = EducateHelper.GetTimeAfterWeeks(arg_5_1, arg_5_0:getConfig("during_time"))

	return
end

function var_0_0.IsEnd(arg_6_0, arg_6_1)
	return arg_6_0:GetReaminTime(arg_6_1) < 0
end

function var_0_0.IsAttrType(arg_7_0)
	return arg_7_0:getConfig("effect")[1] == var_0_0.TYPE_ATTR
end

function var_0_0.IsResType(arg_8_0)
	return arg_8_0:getConfig("effect")[1] == var_0_0.TYPE_RES
end

function var_0_0.IsId(arg_9_0, arg_9_1)
	return arg_9_0:getConfig("effect")[2] == arg_9_1
end

function var_0_0.IsRatio(arg_10_0)
	return arg_10_0:getConfig("effect")[3] == var_0_0.ADDITION_TYPE_RATIO
end

function var_0_0.IsNumber(arg_11_0)
	return arg_11_0:getConfig("effect")[3] == var_0_0.ADDITION_TYPE_NUMBER
end

function var_0_0.GetEffectValue(arg_12_0)
	if arg_12_0:IsRatio() then
		return arg_12_0:getConfig("effect")[4] / 16
	elseif arg_12_0:IsNumber() then
		return arg_12_0:getConfig("effect")[4]
	end

	return 0
end

function var_0_0.GetBuffEffects(arg_13_0)
	local var_13_0 = 0
	local var_13_1 = 0

	underscore.each(arg_13_0, function(arg_14_0)
		if arg_14_0:IsRatio() then
			var_13_0 = var_13_0 + arg_14_0:GetEffectValue()
		elseif arg_14_0:IsNumber() then
			var_13_1 = var_13_1 + arg_14_0:GetEffectValue()
		end

		return
	end)

	return 0, 0
end

return var_0_0
