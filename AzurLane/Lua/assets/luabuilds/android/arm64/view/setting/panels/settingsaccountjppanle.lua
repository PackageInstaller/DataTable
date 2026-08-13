class = var_0_10000

local var_0_0 = "SettingsAccountJPPanle"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".SettingsBasePanel"))

function var_0_1.GetUIName(arg_1_0)
	return "SettingsAccountJP"
end

function var_0_1.GetTitle(arg_2_0)
	i18n = var_1_10001

	return var_1_10001("Settings_title_LoginJP")
end

function var_0_1.GetTitleEn(arg_3_0)
	return "  / ACCOUNT"
end

function var_0_1.OnInit(arg_4_0)
	getProxy = var_1_10001
	UserProxy = var_1_10003
	arg_4_0.userProxy = var_1_10001(var_1_10003)

	local var_4_0 = arg_4_0._tf

	findTF = var_1_10002
	arg_4_0.accountTwitterUI = var_1_10002(var_4_0, "page1")
	findTF = var_2

	local var_4_1 = var_2(arg_4_0.accountTwitterUI, "btn_layout/yostar_con")

	findTF = var_1_10003
	arg_4_0.yostarBtn = var_1_10003(var_4_1, "bind_yostar")
	setText = var_3
	findTF = var_5

	local var_4_2 = var_5(arg_4_0.yostarBtn, "Text")

	i18n = var_6

	var_3(var_4_2, var_6("yostar_account_btn"))
	arg_4_0:OnRegisterEvent()

	return
end

function var_0_1.OnRegisterEvent(arg_5_0)
	onButton = var_1_10001

	var_1_10001(arg_5_0, arg_5_0.yostarBtn, function()
		pg = var_2_10000

		local var_6_0 = var_2_10000.SdkMgr.GetInstance()

		var_0.YoStarShowUserCenter(var_6_0)

		return
	end)

	return
end

function var_0_1.OnUpdate(arg_7_0)
	return
end

return var_0_1
