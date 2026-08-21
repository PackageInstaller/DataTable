local var_0_0 = class("StarSeaFacilityRePage", import(".TemplatePage.SkinTemplatePage"))

function var_0_0.OnUpdateFlush(arg_1_0)
	arg_1_0.nday = arg_1_0.activity.data3

	arg_1_0:PlayStory()

	if arg_1_0.dayTF then
		setText(arg_1_0.dayTF, tostring(arg_1_0.nday) .. "/7")
	end

	arg_1_0.uilist:align(#arg_1_0.taskGroup[arg_1_0.nday])

	return
end

return var_0_0
