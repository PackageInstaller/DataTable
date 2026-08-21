local var_0_0 = class("ResourceFieldProductAttr", import(".ResourceFieldAttr"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	arg_1_0.multiple = arg_1_4

	return
end

function var_0_0.ReCalcValue(arg_2_0)
	arg_2_0.value = arg_2_0.config[arg_2_0.level][arg_2_0.attrName] * arg_2_0.multiple
	arg_2_0.nextValue = arg_2_0.config[arg_2_0.nextLevel][arg_2_0.attrName] * arg_2_0.multiple
	arg_2_0.maxValue = arg_2_0.config[#arg_2_0.config.all][arg_2_0.attrName] * arg_2_0.multiple
	arg_2_0.addition = arg_2_0.nextValue - arg_2_0.value

	return
end

function var_0_0.GetAdditionDesc(arg_3_0)
	return arg_3_0.addition .. "/h"
end

function var_0_0.GetProgressDesc(arg_4_0)
	return arg_4_0.value .. "/h" .. "/" .. arg_4_0.maxValue .. "/h"
end

return var_0_0
