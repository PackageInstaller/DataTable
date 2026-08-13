class = var_0_10000

local var_0_0 = "ResourceFieldPercentAttr"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".ResourceFieldProductAttr"))

function var_0_1.GetProgressDesc(arg_1_0)
	return arg_1_0.value .. "%" .. "/" .. arg_1_0.maxValue .. "%"
end

function var_0_1.GetAdditionDesc(arg_2_0)
	return arg_2_0.addition .. "%"
end

return var_0_1
