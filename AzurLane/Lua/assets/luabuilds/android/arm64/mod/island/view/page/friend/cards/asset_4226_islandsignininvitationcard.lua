class = var_0_10000

local var_0_0 = "IslandSignInInvitationCard"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandBaseVisitorCard"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	local var_1_0 = arg_1_1.transform

	arg_1_0.btn1 = var_2.Find(var_1_0, "btn_1")

	local var_1_1 = arg_1_1.transform
	local var_1_2 = var_2.Find(var_1_1, "btn_1/Text")
	local var_1_3 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.btn1Txt = var_1_3(var_1_2, var_5(var_1_10007))

	local var_1_4 = arg_1_1.transform

	arg_1_0.online = var_2.Find(var_1_4, "online")

	local var_1_5 = arg_1_1.transform

	arg_1_0.offline = var_2.Find(var_1_5, "offline")
	setText = var_2

	local var_1_6 = arg_1_0.online
	local var_1_7 = var_4.Find(var_1_6, "Text")

	i18n = var_5

	var_2(var_1_7, var_5("island_btn_label_online"))

	local var_1_8 = arg_1_0.offline
	local var_1_9 = var_2.Find(var_1_8, "Text")
	local var_1_10 = var_2.GetComponent

	typeof = var_5
	Text = var_7
	arg_1_0.offlineTxt = var_1_10(var_1_9, var_5(var_7))

	return
end

function var_0_1.Update(arg_2_0, arg_2_1, arg_2_2)
	var_0_1.super.Update(arg_2_0, arg_2_1)

	local var_2_0 = arg_2_0.btnTxt

	i18n = var_1_10004
	var_2_0.text = var_1_10004("island_btn_label_invitation")

	local var_2_1 = arg_2_0.btn1Txt

	i18n = var_4
	var_2_1.text = var_4("island_btn_label_invitation_already")

	local var_2_2 = arg_2_1
	local var_2_3 = arg_2_1.isOnline(var_2_2)

	setActive = var_2_4

	var_2_4(arg_2_0.online, var_2_3)

	setActive = var_2_4

	var_2_4(arg_2_0.offline, not var_2_3)

	local var_2_4

	if not var_2_3 then
		var_2_4 = arg_2_0.offlineTxt
		getOfflineTimeStamp = var_2_2
		var_2_4.text = var_2_2(arg_2_1.preOnLineTime)
	end

	setActive = var_2_4

	var_2_4(arg_2_0.btn, not arg_2_2)

	setActive = var_2_4

	var_2_4(arg_2_0.btn1, arg_2_2)

	return
end

return var_0_1
