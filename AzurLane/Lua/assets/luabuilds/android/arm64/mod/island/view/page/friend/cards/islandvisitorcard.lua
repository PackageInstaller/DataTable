class = var_0_10000

local var_0_0 = "IslandVisitorCard"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandBaseVisitorCard"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	local var_1_0 = arg_1_1.transform
	local var_1_1 = var_2.Find(var_1_0, "localtion/Text")
	local var_1_2 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.localtionTxt = var_1_2(var_1_1, var_5(var_1_10007))

	local var_1_3 = arg_1_0.btnTxt

	i18n = var_1_10003
	var_1_3.text = var_1_10003("island_btn_label_kick")

	return
end

function var_0_1.Update(arg_2_0, arg_2_1)
	var_0_1.super.Update(arg_2_0, arg_2_1)

	local var_2_0 = arg_2_0.localtionTxt

	i18n = var_1_10003
	var_2_0.text = var_1_10003("island_btn_label_location", arg_2_1:GetLoaction())

	return
end

return var_0_1
