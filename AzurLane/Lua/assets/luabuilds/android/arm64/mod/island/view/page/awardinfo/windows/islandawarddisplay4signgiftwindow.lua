class = var_0_10000

local var_0_0 = "IslandAwardDisplay4SignGiftWindow"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandAwardDisplayWindow"))

function var_0_1.getUIName(arg_1_0)
	return "IslandAwardDisplay4SignGiftUI"
end

function var_0_1.Show(arg_2_0, arg_2_1)
	var_0_1.super.Show(arg_2_0, arg_2_1)

	arg_2_0.title.text = ""

	return
end

return var_0_1
