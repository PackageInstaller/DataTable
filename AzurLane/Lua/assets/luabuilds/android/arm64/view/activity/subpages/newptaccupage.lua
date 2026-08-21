local var_0_0 = class("NewPtAccuPage", import(".TemplatePage.PtTemplatePage"))

var_0_0.TIME = 300

function var_0_0.OnInit(arg_1_0)
	var_0_0.super.OnInit(arg_1_0)

	arg_1_0.value2 = arg_1_0._tf:Find("AD/value2")
	arg_1_0.sliderTxt = arg_1_0._tf:Find("AD/slider/Text")

	return
end

function var_0_0.OnUpdateFlush(arg_2_0)
	var_0_0.super.OnUpdateFlush(arg_2_0)
	setText(arg_2_0.value2, arg_2_0.ptData:GetValue2())

	local var_2_0, var_2_1, var_2_2 = arg_2_0.ptData:GetResProgress()

	setText(arg_2_0.sliderTxt, math.floor(math.min(var_2_2, 1) * 100) .. "%")
	arg_2_0:GetWorldPtData(var_0_0.TIME)

	return
end

return var_0_0
