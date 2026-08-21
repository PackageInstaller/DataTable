local var_0_0 = class("IslandSignInInvitationCard", import(".IslandBaseVisitorCard"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.btn1 = arg_1_1.transform:Find("btn_1")
	arg_1_0.btn1Txt = arg_1_1.transform:Find("btn_1/Text"):GetComponent(typeof(Text))
	arg_1_0.online = arg_1_1.transform:Find("online")
	arg_1_0.offline = arg_1_1.transform:Find("offline")

	setText(arg_1_0.online:Find("Text"), i18n("island_btn_label_online"))

	arg_1_0.offlineTxt = arg_1_0.offline:Find("Text"):GetComponent(typeof(Text))

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2)
	var_0_0.super.Update(arg_2_0, arg_2_1)

	arg_2_0.btnTxt.text = i18n("island_btn_label_invitation")
	arg_2_0.btn1Txt.text = i18n("island_btn_label_invitation_already")

	local var_2_0 = arg_2_1:isOnline()

	setActive(arg_2_0.online, var_2_0)
	setActive(arg_2_0.offline, not var_2_0)

	if not var_2_0 then
		arg_2_0.offlineTxt.text = getOfflineTimeStamp(arg_2_1.preOnLineTime)
	end

	setActive(arg_2_0.btn, not arg_2_2)
	setActive(arg_2_0.btn1, arg_2_2)

	return
end

return var_0_0
