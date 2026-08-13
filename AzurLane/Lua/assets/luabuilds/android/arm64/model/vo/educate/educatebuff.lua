class = var_0_10000

local var_0_0 = "EducateBuff"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.BaseVO"))

var_0_1.TYPE_ATTR = 1
var_0_1.TYPE_RES = 2
var_0_1.ADDITION_TYPE_RATIO = 1
var_0_1.ADDITION_TYPE_NUMBER = 2

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id

	local var_1_0

	if not arg_1_1.time then
		EducateHelper = var_1_0
		var_1_0 = var_1_0.GetTimeAfterWeeks
		getProxy = var_1_10004
		EducateProxy = var_1_10006

		local var_1_1 = var_1_10004(var_1_10006)

		var_1_0 = var_1_0(var_4.GetCurTime(var_1_1), arg_1_0:getConfig("during_time"))
	end

	arg_1_0.endTime = var_1_0

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.child_buff
end

function var_0_1.GetReaminTime(arg_3_0, arg_3_1)
	if not arg_3_1 then
		getProxy = var_1_10002
		EducateProxy = var_1_10004

		local var_3_0 = var_1_10002(var_1_10004)

		arg_3_1 = var_1_10002.GetCurTime(var_3_0)
	end

	EducateHelper = var_1_10002

	return var_1_10002.GetDaysBetweenTimes(arg_3_1, arg_3_0.endTime)
end

function var_0_1.GetReaminWeek(arg_4_0, arg_4_1)
	if arg_4_0:GetReaminTime(arg_4_1) == 0 then
		return 0
	else
		return var_2 / 7
	end

	return
end

function var_0_1.ResetEndTime(arg_5_0, arg_5_1)
	if not arg_5_1 then
		getProxy = var_1_10002
		EducateProxy = var_1_10004

		local var_5_0 = var_1_10002(var_1_10004)

		arg_5_1 = var_1_10002.GetCurTime(var_5_0)
	end

	EducateHelper = var_1_10002
	arg_5_0.endTime = var_1_10002.GetTimeAfterWeeks(arg_5_1, arg_5_0:getConfig("during_time"))

	return
end

function var_0_1.IsEnd(arg_6_0, arg_6_1)
	return arg_6_0:GetReaminTime(arg_6_1) < 0
end

function var_0_1.IsAttrType(arg_7_0)
	return arg_7_0:getConfig("effect")[1] == var_0_1.TYPE_ATTR
end

function var_0_1.IsResType(arg_8_0)
	return arg_8_0:getConfig("effect")[1] == var_0_1.TYPE_RES
end

function var_0_1.IsId(arg_9_0, arg_9_1)
	return arg_9_0:getConfig("effect")[2] == arg_9_1
end

function var_0_1.IsRatio(arg_10_0)
	return arg_10_0:getConfig("effect")[3] == var_0_1.ADDITION_TYPE_RATIO
end

function var_0_1.IsNumber(arg_11_0)
	return arg_11_0:getConfig("effect")[3] == var_0_1.ADDITION_TYPE_NUMBER
end

function var_0_1.GetEffectValue(arg_12_0)
	if arg_12_0:IsRatio() then
		return arg_12_0:getConfig("effect")[4] / 16
	elseif arg_12_0:IsNumber() then
		return arg_12_0:getConfig("effect")[4]
	end

	return 0
end

function var_0_1.GetBuffEffects(arg_13_0)
	local var_13_0 = 0
	local var_13_1 = 0

	underscore = var_1_10003

	var_1_10003.each(arg_13_0, function(arg_14_0)
		if arg_14_0:IsRatio() then
			var_13_0 = var_13_0 + arg_14_0:GetEffectValue()
		elseif arg_14_0:IsNumber() then
			var_13_1 = var_13_1 + arg_14_0:GetEffectValue()
		end

		return
	end)

	return var_13_0, var_13_1
end

return var_0_1
