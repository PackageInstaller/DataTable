class = var_0_10000

local var_0_0 = "NewPtAccuPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.PtTemplatePage"))

var_0_1.TIME = 300

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0._tf

	arg_1_0.value2 = var_1.Find(var_1_0, "AD/value2")

	local var_1_1 = arg_1_0._tf

	arg_1_0.sliderTxt = var_1.Find(var_1_1, "AD/slider/Text")

	return
end

function var_0_1.OnUpdateFlush(arg_2_0)
	var_0_1.super.OnUpdateFlush(arg_2_0)

	setText = var_1

	local var_2_0 = arg_2_0.value2
	local var_2_1 = arg_2_0.ptData

	var_1(var_2_0, var_3.GetValue2(var_2_1))

	local var_2_2 = arg_2_0.ptData
	local var_2_3, var_2_4, var_2_5 = var_1.GetResProgress(var_2_2)

	setText = var_2_1

	local var_2_6 = arg_2_0.sliderTxt

	math = var_1_10006

	local var_2_7 = var_1_10006.floor

	math = var_1_10007

	var_2_1(var_2_6, var_2_7(var_1_10007.min(var_2_5, 1) * 100) .. "%")
	arg_2_0:GetWorldPtData(var_0_1.TIME)

	return
end

return var_0_1
