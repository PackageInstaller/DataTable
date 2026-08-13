class = var_0_10000

local var_0_0 = "NodeCanvasBaseCondition"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".NodeCanvasBaseObject"))

function var_0_1.Enable(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:Init(arg_1_1, arg_1_2)
	arg_1_0:OnEnable()

	return
end

function var_0_1.Disable(arg_2_0)
	arg_2_0:OnDisable()

	return
end

function var_0_1.Check(arg_3_0)
	return arg_3_0:OnCheck()
end

function var_0_1.OnEnable(arg_4_0)
	return
end

function var_0_1.OnDisable(arg_5_0)
	return
end

function var_0_1.OnCheck(arg_6_0)
	return true
end

return var_0_1
