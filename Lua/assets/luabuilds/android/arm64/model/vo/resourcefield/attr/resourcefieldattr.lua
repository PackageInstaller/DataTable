local var_0_0 = class("ResourceFieldAttr")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.name = arg_1_2
	arg_1_0.config = arg_1_1
	arg_1_0.attrName = arg_1_3
	arg_1_0.level = 0
	arg_1_0.nextLevel = 0
	arg_1_0.value = 0
	arg_1_0.nextValue = 0
	arg_1_0.maxValue = 0
	arg_1_0.addition = 0

	return
end

function var_0_0.Update(arg_2_0, arg_2_1)
	if arg_2_1 == arg_2_0.level then
		return
	end

	arg_2_0.level = arg_2_1
	arg_2_0.nextLevel = math.min(arg_2_1 + 1, #arg_2_0.config.all)

	arg_2_0:ReCalcValue()

	return
end

function var_0_0.ReCalcValue(arg_3_0)
	arg_3_0.value = arg_3_0.config[arg_3_0.level][arg_3_0.attrName]
	arg_3_0.nextValue = arg_3_0.config[arg_3_0.nextLevel][arg_3_0.attrName]
	arg_3_0.maxValue = arg_3_0.config[#arg_3_0.config.all][arg_3_0.attrName]
	arg_3_0.addition = arg_3_0.nextValue - arg_3_0.value

	return
end

function var_0_0.GetName(arg_4_0)
	return arg_4_0.name
end

function var_0_0.IsMaxLevel(arg_5_0)
	return arg_5_0.level == arg_5_0.nextLevel
end

function var_0_0.GetValue(arg_6_0)
	return arg_6_0.value
end

function var_0_0.GetNextValue(arg_7_0)
	return arg_7_0.nextValue
end

function var_0_0.GetMaxValue(arg_8_0)
	return arg_8_0.maxValue
end

function var_0_0.GetAddition(arg_9_0)
	return arg_9_0.addition
end

function var_0_0.GetAdditionDesc(arg_10_0)
	return arg_10_0.addition
end

function var_0_0.GetProgressDesc(arg_11_0)
	return arg_11_0.value .. "/" .. arg_11_0.maxValue
end

return var_0_0
