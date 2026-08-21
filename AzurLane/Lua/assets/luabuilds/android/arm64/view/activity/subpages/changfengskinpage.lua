local var_0_0 = class("ChangFengSkinPage", import(".TemplatePage.SkinTemplatePage"))

function var_0_0.OnUpdateFlush(arg_1_0)
	arg_1_0.nday = arg_1_0.activity.data3

	arg_1_0:PlayStory()
	SetActive(arg_1_0.dayTF, false)
	arg_1_0.uilist:align(#arg_1_0.taskGroup[arg_1_0.nday])

	return
end

function var_0_0.GetProgressColor(arg_2_0)
	return "#34424b"
end

return var_0_0
