class = var_0_10000

local var_0_0 = "FriendSearchCard"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".FriendCard"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	local var_1_0 = arg_1_0.tf

	arg_1_0.addBtn = var_2.Find(var_1_0, "frame/add_btn")

	local var_1_1 = arg_1_0.tf
	local var_1_2 = var_2.Find(var_1_1, "frame/request_info/lv_bg/Text")
	local var_1_3 = var_2.GetComponent

	typeof = var_4
	Text = var_1_10005
	arg_1_0.levelTF = var_1_3(var_1_2, var_4(var_1_10005))

	return
end

function var_0_1.update(arg_2_0, arg_2_1)
	var_0_1.super.update(arg_2_0, arg_2_1)

	arg_2_0.manifestoTF.text = arg_2_1:GetManifesto()
	arg_2_0.levelTF.text = "Lv." .. arg_2_1.level

	return
end

return var_0_1
