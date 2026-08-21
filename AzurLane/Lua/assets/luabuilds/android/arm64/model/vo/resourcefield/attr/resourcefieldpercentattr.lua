local var_0_0 = class("ResourceFieldPercentAttr", import(".ResourceFieldProductAttr"))

function var_0_0.GetProgressDesc(arg_1_0)
	return arg_1_0.value .. "%" .. "/" .. arg_1_0.maxValue .. "%"
end

function var_0_0.GetAdditionDesc(arg_2_0)
	return arg_2_0.addition .. "%"
end

return var_0_0
