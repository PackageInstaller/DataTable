local var_0_0 = class("SettingsAccountJPPanle", import(".SettingsBasePanel"))

function var_0_0.GetUIName(arg_1_0)
	return "SettingsAccountJP"
end

function var_0_0.GetTitle(arg_2_0)
	return i18n("Settings_title_LoginJP")
end

function var_0_0.GetTitleEn(arg_3_0)
	return "  / ACCOUNT"
end

function var_0_0.OnInit(arg_4_0)
	arg_4_0.userProxy = getProxy(UserProxy)
	arg_4_0.accountTwitterUI = findTF(arg_4_0._tf, "page1")
	arg_4_0.yostarBtn = findTF(findTF(arg_4_0.accountTwitterUI, "btn_layout/yostar_con"), "bind_yostar")

	setText(findTF(arg_4_0.yostarBtn, "Text"), i18n("yostar_account_btn"))
	arg_4_0:OnRegisterEvent()

	return
end

function var_0_0.OnRegisterEvent(arg_5_0)
	onButton(arg_5_0, arg_5_0.yostarBtn, function()
		pg.SdkMgr.GetInstance():YoStarShowUserCenter()

		return
	end)

	return
end

function var_0_0.OnUpdate(arg_7_0)
	return
end

return var_0_0
