class = var_0_10000

local var_0_0 = "IslandBlackWhitListCard"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandFriendCard"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	local var_1_0 = arg_1_1.transform

	arg_1_0.removeBtn = var_2.Find(var_1_0, "remove")
	setText = var_2

	local var_1_1 = arg_1_0.removeBtn
	local var_1_2 = var_3.Find(var_1_1, "Text")

	i18n = var_1_1

	var_2(var_1_2, var_1_1("island_btn_label_remove"))

	return
end

return var_0_1
