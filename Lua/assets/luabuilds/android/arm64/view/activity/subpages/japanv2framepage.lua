local var_0_0 = class("JapanV2framePage", import(".TemplatePage.FrameTemplatePage"))

function var_0_0.OnUpdateFlush(arg_1_0)
	var_0_0.super.OnUpdateFlush(arg_1_0)
	setActive(arg_1_0.gotBtn, false)

	return
end

return var_0_0
