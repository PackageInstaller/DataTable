local var_0_0 = class("FriendListCard", import(".FriendCard"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.occuptBtn = arg_1_0.tf:Find("frame/btns/occupy_btn")
	arg_1_0.deleteBtn = arg_1_0.tf:Find("frame/btns/delete_btn")
	arg_1_0.backYardBtn = arg_1_0.tf:Find("frame/btns/backyard_btn")
	arg_1_0.chatTip = arg_1_0.tf:Find("frame/btns/occupy_btn/tip")
	arg_1_0.date = arg_1_0.tf:Find("frame/request_info/date"):GetComponent(typeof(Text))
	arg_1_0.online = arg_1_0.tf:Find("frame/request_info/online")
	arg_1_0.levelTF = arg_1_0.tf:Find("frame/request_info/lv_bg/Text"):GetComponent(typeof(Text))

	return
end

function var_0_0.update(arg_2_0, arg_2_1)
	var_0_0.super.update(arg_2_0, arg_2_1)
	setActive(arg_2_0.chatTip, arg_2_1.unreadCount > 0)

	arg_2_0.manifestoTF.text = arg_2_1:GetManifesto()

	setActive(arg_2_0.online, arg_2_1.online == Friend.ONLINE)
	setActive(arg_2_0.date.gameObject, arg_2_1.online ~= Friend.ONLINE)

	if arg_2_1.online ~= Friend.ONLINE then
		arg_2_0.date.text = getOfflineTimeStamp(arg_2_1.preOnLineTime)
	end

	arg_2_0.levelTF.text = "Lv." .. arg_2_1.level

	return
end

return var_0_0
