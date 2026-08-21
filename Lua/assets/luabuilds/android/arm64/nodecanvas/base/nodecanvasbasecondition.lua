local var_0_0 = class("NodeCanvasBaseCondition", import(".NodeCanvasBaseObject"))

function var_0_0.Enable(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:Init(arg_1_1, arg_1_2)
	arg_1_0:OnEnable()

	return
end

function var_0_0.Disable(arg_2_0)
	arg_2_0:OnDisable()

	return
end

function var_0_0.Check(arg_3_0)
	return arg_3_0:OnCheck()
end

function var_0_0.OnEnable(arg_4_0)
	return
end

function var_0_0.OnDisable(arg_5_0)
	return
end

function var_0_0.OnCheck(arg_6_0)
	return true
end

return var_0_0
