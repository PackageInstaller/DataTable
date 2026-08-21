local var_0_0 = class("IslandFriendSearchCard", import(".IslandFriendCard"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.addBtn = arg_1_1.transform:Find("add")

	setText(arg_1_0.addBtn:Find("Text"), i18n("island_add_friend"))

	return
end

function var_0_0.Update(arg_2_0, arg_2_1)
	var_0_0.super.Update(arg_2_0, arg_2_1)

	local var_2_0 = getProxy(FriendProxy):isFriend(arg_2_1.id)

	setActive(arg_2_0.addBtn, not var_2_0)
	setActive(arg_2_0.visitBtn, var_2_0)

	return
end

return var_0_0
