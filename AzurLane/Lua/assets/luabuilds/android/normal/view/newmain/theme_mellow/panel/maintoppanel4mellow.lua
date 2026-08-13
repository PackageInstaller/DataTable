class = var_0_10000

local var_0_0 = "MainTopPanel4Mellow"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.MainBasePanel"))

function var_0_1.GetBtns(arg_1_0)
	local var_1_0 = {}

	MainPlayerInfoBtn4Mellow = var_1_10002
	var_1_0[1] = var_1_10002.New(arg_1_0._tf, arg_1_0.event)
	MainMailBtn = var_2

	local var_1_1 = var_2.New

	findTF = var_3
	var_1_0[2] = var_1_1(var_3(arg_1_0._tf, "btns/mail"), arg_1_0.event)
	MainNoticeBtn = var_2

	local var_1_2 = var_2.New

	findTF = var_3
	var_1_0[3] = var_1_2(var_3(arg_1_0._tf, "btns/noti"), arg_1_0.event)
	MainSettingsBtn = var_2

	local var_1_3 = var_2.New

	findTF = var_3
	var_1_0[4] = var_1_3(var_3(arg_1_0._tf, "btns/settings"), arg_1_0.event)

	return var_1_0
end

function var_0_1.GetDirection(arg_2_0)
	Vector2 = var_1_10001

	return var_1_10001(0, 1)
end

return var_0_1
