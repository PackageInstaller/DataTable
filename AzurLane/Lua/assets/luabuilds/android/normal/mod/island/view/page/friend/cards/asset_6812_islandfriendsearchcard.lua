class = var_0_10000

local var_0_0 = "IslandFriendSearchCard"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandFriendCard"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	local var_1_0 = arg_1_1.transform

	arg_1_0.addBtn = var_2.Find(var_1_0, "add")
	setText = var_2

	local var_1_1 = arg_1_0.addBtn
	local var_1_2 = var_3.Find(var_1_1, "Text")

	i18n = var_1_1

	var_2(var_1_2, var_1_1("island_add_friend"))

	return
end

function var_0_1.Update(arg_2_0, arg_2_1)
	var_0_1.super.Update(arg_2_0, arg_2_1)

	getProxy = var_2
	FriendProxy = var_3

	local var_2_0 = var_2(var_3)
	local var_2_1 = var_2.isFriend(var_2_0, arg_2_1.id)

	setActive = var_2_0

	var_2_0(arg_2_0.addBtn, not var_2_1)

	setActive = var_2_0

	var_2_0(arg_2_0.visitBtn, var_2_1)

	return
end

return var_0_1
