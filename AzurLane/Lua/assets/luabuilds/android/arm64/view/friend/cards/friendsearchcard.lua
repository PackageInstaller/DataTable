local var_0_0 = class("FriendSearchCard", import(".FriendCard"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.addBtn = arg_1_0.tf:Find("frame/add_btn")
	arg_1_0.levelTF = arg_1_0.tf:Find("frame/request_info/lv_bg/Text"):GetComponent(typeof(Text))

	return
end

function var_0_0.update(arg_2_0, arg_2_1)
	var_0_0.super.update(arg_2_0, arg_2_1)

	arg_2_0.manifestoTF.text = arg_2_1:GetManifesto()
	arg_2_0.levelTF.text = "Lv." .. arg_2_1.level

	return
end

return var_0_0
