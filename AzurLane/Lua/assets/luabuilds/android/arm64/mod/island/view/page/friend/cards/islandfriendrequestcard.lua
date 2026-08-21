local var_0_0 = class("IslandFriendRequestCard", import(".IslandFriendCard"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.agreeBtn = arg_1_1.transform:Find("agree")
	arg_1_0.refuseBtn = arg_1_1.transform:Find("refuse")

	setText(arg_1_0.agreeBtn:Find("Text"), i18n("island_friend_agree"))
	setText(arg_1_0.refuseBtn:Find("Text"), i18n("island_friend_refuse"))

	return
end

function var_0_0.Update(arg_2_0, arg_2_1)
	var_0_0.super.Update(arg_2_0, arg_2_1.player)

	arg_2_0.descTxt.text = arg_2_1.content

	return
end

function var_0_0.UpdateOnline(arg_3_0, arg_3_1)
	setActive(arg_3_0.onlineTr, false)
	setActive(arg_3_0.offlineTr, false)
	setActive(arg_3_0.giftTr, false)

	return
end

return var_0_0
