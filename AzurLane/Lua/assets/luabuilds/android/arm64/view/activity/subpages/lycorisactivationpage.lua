local var_0_0 = class("LycorisActivationPage", import(".TemplatePage.SkinTemplatePage"))

function var_0_0.OnUpdateFlush(arg_1_0)
	var_0_0.super.OnUpdateFlush(arg_1_0)
	arg_1_0:PlayStory()
	setText(arg_1_0.dayTF, tostring(arg_1_0.nday) .. "/7")

	return
end

return var_0_0
