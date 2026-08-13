class = var_0_10000

local var_0_0 = "FriendListCard"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".FriendCard"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	local var_1_0 = arg_1_0.tf

	arg_1_0.occuptBtn = var_2.Find(var_1_0, "frame/btns/occupy_btn")

	local var_1_1 = arg_1_0.tf

	arg_1_0.deleteBtn = var_2.Find(var_1_1, "frame/btns/delete_btn")

	local var_1_2 = arg_1_0.tf

	arg_1_0.backYardBtn = var_2.Find(var_1_2, "frame/btns/backyard_btn")

	local var_1_3 = arg_1_0.tf

	arg_1_0.chatTip = var_2.Find(var_1_3, "frame/btns/occupy_btn/tip")

	local var_1_4 = arg_1_0.tf
	local var_1_5 = var_2.Find(var_1_4, "frame/request_info/date")
	local var_1_6 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.date = var_1_6(var_1_5, var_4(var_1_10005))

	local var_1_7 = arg_1_0.tf

	arg_1_0.online = var_2.Find(var_1_7, "frame/request_info/online")

	local var_1_8 = arg_1_0.tf
	local var_1_9 = var_2.Find(var_1_8, "frame/request_info/lv_bg/Text")
	local var_1_10 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.levelTF = var_1_10(var_1_9, var_4(var_1_10005))

	return
end

function var_0_1.update(arg_2_0, arg_2_1)
	var_0_1.super.update(arg_2_0, arg_2_1)

	setActive = var_2

	local var_2_0 = arg_2_0.chatTip
	local var_2_1 = arg_2_1.unreadCount

	var_2(var_2_0, 0 < var_2_1)

	local var_2_2 = arg_2_0.manifestoTF

	var_2_2.text = arg_2_1:GetManifesto()
	setActive = var_2_2

	local var_2_3 = arg_2_0.online
	local var_2_4 = arg_2_1.online

	Friend = var_5

	var_2_2(var_2_3, var_2_4 == var_5.ONLINE)

	setActive = var_2_2

	local var_2_5 = arg_2_0.date.gameObject
	local var_2_6 = arg_2_1.online

	Friend = var_5

	var_2_2(var_2_5, var_2_6 ~= var_5.ONLINE)

	local var_2_7 = arg_2_1.online

	Friend = var_2_5

	if var_2_7 ~= var_2_5.ONLINE then
		local var_2_8 = arg_2_0.date

		getOfflineTimeStamp = var_3
		var_2_8.text = var_3(arg_2_1.preOnLineTime)
	end

	arg_2_0.levelTF.text = "Lv." .. arg_2_1.level

	return
end

return var_0_1
