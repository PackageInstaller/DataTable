local var_0_0 = class("IslandVisitorCard", import(".IslandBaseVisitorCard"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.localtionTxt = arg_1_1.transform:Find("localtion/Text"):GetComponent(typeof(Text))
	arg_1_0.btnTxt.text = i18n("island_btn_label_kick")

	return
end

function var_0_0.Update(arg_2_0, arg_2_1)
	var_0_0.super.Update(arg_2_0, arg_2_1)

	arg_2_0.localtionTxt.text = i18n("island_btn_label_location", arg_2_1:GetLoaction())

	return
end

return var_0_0
