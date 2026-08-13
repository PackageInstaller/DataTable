class = var_0_10000

local var_0_0 = "FriendRequestCard"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".FriendCard"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	local var_1_0 = arg_1_0.tf

	arg_1_0.acceptBtn = var_2.Find(var_1_0, "frame/accpet_btn")

	local var_1_1 = arg_1_0.tf

	arg_1_0.refuseBtn = var_2.Find(var_1_1, "frame/refuse_btn")

	local var_1_2 = arg_1_0.tf

	arg_1_0.reportBtn = var_2.Find(var_1_2, "frame/report_btn")

	local var_1_3 = arg_1_0.tf
	local var_1_4 = var_2.Find(var_1_3, "frame/request_info/date/Text")
	local var_1_5 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.date = var_1_5(var_1_4, var_4(var_1_10005))

	local var_1_6 = arg_1_0.tf
	local var_1_7 = var_2.Find(var_1_6, "frame/request_info/lv_bg/Text")
	local var_1_8 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.levelTF = var_1_8(var_1_7, var_4(var_1_10005))

	return
end

function var_0_1.update(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	var_0_1.super.update(arg_2_0, arg_2_1)

	arg_2_0.manifestoTF.text = arg_2_3

	local var_2_0 = arg_2_0.date

	pg = var_5

	local var_2_1 = var_5.TimeMgr.GetInstance()

	var_2_0.text = var_5.STimeDescS(var_2_1, arg_2_2)
	arg_2_0.levelTF.text = "Lv." .. arg_2_1.level

	return
end

return var_0_1
