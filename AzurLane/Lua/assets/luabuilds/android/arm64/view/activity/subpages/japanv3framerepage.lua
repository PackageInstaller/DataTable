local var_0_0 = class("JapanV3FrameRePage", import(".TemplatePage.FrameReTemplatePage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.super.OnInit(arg_1_0)

	arg_1_0.bar = arg_1_0.bg:Find("frame/barContent/bar")

	return
end

return var_0_0
