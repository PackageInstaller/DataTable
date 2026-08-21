local var_0_0 = class("IslandAwardDisplay4SignGiftWindow", import(".IslandAwardDisplayWindow"))

function var_0_0.getUIName(arg_1_0)
	return "IslandAwardDisplay4SignGiftUI"
end

function var_0_0.Show(arg_2_0, arg_2_1)
	var_0_0.super.Show(arg_2_0, arg_2_1)

	arg_2_0.title.text = ""

	return
end

return var_0_0
