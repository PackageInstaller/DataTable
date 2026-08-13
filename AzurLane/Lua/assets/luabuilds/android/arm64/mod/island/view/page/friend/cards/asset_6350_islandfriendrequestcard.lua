class = var_0_10000

local var_0_0 = "IslandFriendRequestCard"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandFriendCard"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	local var_1_0 = arg_1_1.transform

	arg_1_0.agreeBtn = var_2.Find(var_1_0, "agree")

	local var_1_1 = arg_1_1.transform

	arg_1_0.refuseBtn = var_2.Find(var_1_1, "refuse")
	setText = var_2

	local var_1_2 = arg_1_0.agreeBtn
	local var_1_3 = var_4.Find(var_1_2, "Text")

	i18n = var_5

	var_2(var_1_3, var_5("island_friend_agree"))

	setText = var_2

	local var_1_4 = arg_1_0.refuseBtn
	local var_1_5 = var_4.Find(var_1_4, "Text")

	i18n = var_5

	var_2(var_1_5, var_5("island_friend_refuse"))

	return
end

function var_0_1.Update(arg_2_0, arg_2_1)
	var_0_1.super.Update(arg_2_0, arg_2_1.player)

	arg_2_0.descTxt.text = arg_2_1.content

	return
end

function var_0_1.UpdateOnline(arg_3_0, arg_3_1)
	setActive = var_1_10002

	var_1_10002(arg_3_0.onlineTr, false)

	setActive = var_1_10002

	var_1_10002(arg_3_0.offlineTr, false)

	setActive = var_1_10002

	var_1_10002(arg_3_0.giftTr, false)

	return
end

return var_0_1
