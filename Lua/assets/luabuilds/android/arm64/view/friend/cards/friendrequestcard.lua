local var_0_0 = class("FriendRequestCard", import(".FriendCard"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.acceptBtn = arg_1_0.tf:Find("frame/accpet_btn")
	arg_1_0.refuseBtn = arg_1_0.tf:Find("frame/refuse_btn")
	arg_1_0.reportBtn = arg_1_0.tf:Find("frame/report_btn")
	arg_1_0.date = arg_1_0.tf:Find("frame/request_info/date/Text"):GetComponent(typeof(Text))
	arg_1_0.levelTF = arg_1_0.tf:Find("frame/request_info/lv_bg/Text"):GetComponent(typeof(Text))

	return
end

function var_0_0.update(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	var_0_0.super.update(arg_2_0, arg_2_1)

	arg_2_0.manifestoTF.text = arg_2_3
	arg_2_0.date.text = pg.TimeMgr.GetInstance():STimeDescS(arg_2_2)
	arg_2_0.levelTF.text = "Lv." .. arg_2_1.level

	return
end

return var_0_0
