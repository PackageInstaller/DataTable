local var_0_0 = class("YingxiV4FrameRePage", import(".TemplatePage.NewFrameTemplatePage"))

function var_0_0.OnFirstFlush(arg_1_0)
	var_0_0.super.OnFirstFlush(arg_1_0)
	setActive(arg_1_0.switchBtn, false)

	return
end

return var_0_0
