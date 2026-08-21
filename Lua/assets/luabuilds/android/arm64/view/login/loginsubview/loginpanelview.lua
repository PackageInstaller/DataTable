local var_0_0 = class("LoginPanelView", import("...base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "LoginPanelView"
end

function var_0_0.OnLoaded(arg_2_0)
	return
end

function var_0_0.SetShareData(arg_3_0, arg_3_1)
	arg_3_0.shareData = arg_3_1

	return
end

function var_0_0.OnInit(arg_4_0)
	arg_4_0.loginPanel = arg_4_0._tf
	arg_4_0.loginUsername = arg_4_0.loginPanel:Find("account/username")
	arg_4_0.loginPassword = arg_4_0.loginPanel:Find("password/password")
	arg_4_0.loginButton = arg_4_0.loginPanel:Find("login_button")
	arg_4_0.registerButton = arg_4_0.loginPanel:Find("register_button")

	arg_4_0:InitEvent()

	return
end

function var_0_0.InitEvent(arg_5_0)
	onButton(arg_5_0, arg_5_0.loginButton, function()
		if arg_5_0.shareData.autoLoginEnabled and arg_5_0.shareData.lastLoginUser then
			arg_5_0.event:emit(LoginMediator.ON_LOGIN, arg_5_0.shareData.lastLoginUser)

			return
		end

		local var_6_0 = getInputText(arg_5_0.loginUsername)

		if var_6_0 == "" then
			pg.TipsMgr.GetInstance():ShowTips(i18n("login_loginScene_error_noUserName"))
			ActivateInputField(arg_5_0.loginUsername)

			return
		end

		local var_6_1 = getInputText(arg_5_0.loginPassword) or ""
		local var_6_2 = User.New({
			type = 2,
			arg1 = var_6_0,
			arg2 = var_6_1
		})

		if var_6_2 then
			arg_5_0.event:emit(LoginMediator.ON_LOGIN, var_6_2)
		end

		return
	end, SFX_CONFIRM)
	onButton(arg_5_0, arg_5_0.registerButton, function()
		arg_5_0:emit(LoginSceneConst.SWITCH_SUB_VIEW, {
			LoginSceneConst.DEFINE.REGISTER_PANEL_VIEW
		})
		arg_5_0:emit(LoginSceneConst.CLEAR_REGISTER_VIEW)

		return
	end, SFX_MAIN)
	onInputChanged(arg_5_0, arg_5_0.loginUsername, function()
		arg_5_0.shareData.autoLoginEnabled = false

		return
	end)
	onInputChanged(arg_5_0, arg_5_0.loginPassword, function()
		arg_5_0.shareData.autoLoginEnabled = false

		return
	end)

	return
end

function var_0_0.SetContent(arg_10_0, arg_10_1, arg_10_2)
	setInputText(arg_10_0.loginUsername, arg_10_1)
	setInputText(arg_10_0.loginPassword, arg_10_2)

	return
end

function var_0_0.OnDestroy(arg_11_0)
	return
end

return var_0_0
