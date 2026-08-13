class = var_0_10000

local var_0_0 = "LoginPanelView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "LoginPanelView"
end

function var_0_1.OnLoaded(arg_2_0)
	return
end

function var_0_1.SetShareData(arg_3_0, arg_3_1)
	arg_3_0.shareData = arg_3_1

	return
end

function var_0_1.OnInit(arg_4_0)
	arg_4_0.loginPanel = arg_4_0._tf

	local var_4_0 = arg_4_0.loginPanel

	arg_4_0.loginUsername = var_1.Find(var_4_0, "account/username")

	local var_4_1 = arg_4_0.loginPanel

	arg_4_0.loginPassword = var_1.Find(var_4_1, "password/password")

	local var_4_2 = arg_4_0.loginPanel

	arg_4_0.loginButton = var_1.Find(var_4_2, "login_button")

	local var_4_3 = arg_4_0.loginPanel

	arg_4_0.registerButton = var_1.Find(var_4_3, "register_button")

	arg_4_0:InitEvent()

	return
end

function var_0_1.InitEvent(arg_5_0)
	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.loginButton

	local function var_5_2()
		local var_6_1

		if arg_5_0.shareData.autoLoginEnabled and arg_5_0.shareData.lastLoginUser then
			local var_6_0 = arg_5_0.event

			var_6_1 = var_6_1.emit
			LoginMediator = var_2_10002

			var_6_1(var_6_0, var_2_10002.ON_LOGIN, arg_5_0.shareData.lastLoginUser)

			return
		end

		getInputText = var_6_1

		local var_6_3

		if var_6_1(arg_5_0.loginUsername) == "" then
			pg = var_6_3

			local var_6_2 = var_6_3.TipsMgr.GetInstance()

			var_6_3 = var_6_3.ShowTips
			i18n = var_2_10003

			var_6_3(var_6_2, var_2_10003("login_loginScene_error_noUserName"))

			ActivateInputField = var_6_3

			var_6_3(arg_5_0.loginUsername)

			return
		end

		getInputText = var_6_3

		local var_6_4

		if not var_6_3(arg_5_0.loginPassword) then
			var_6_4 = ""
		end

		User = var_2

		if var_2.New({
			type = 2,
			arg1 = var_0,
			arg2 = var_6_4
		}) then
			local var_6_5 = arg_5_0.event
			local var_6_6 = var_3.emit

			LoginMediator = var_2_10005

			var_6_6(var_6_5, var_2_10005.ON_LOGIN, var_2)
		end

		return
	end

	SFX_CONFIRM = var_1_10005

	var_1_10001(var_5_0, var_5_1, var_5_2, var_1_10005)

	onButton = var_1_10001

	local var_5_3 = arg_5_0
	local var_5_4 = arg_5_0.registerButton

	local function var_5_5()
		local var_7_0 = arg_5_0
		local var_7_1 = var_0.emit

		LoginSceneConst = var_2_10002

		local var_7_2 = var_2_10002.SWITCH_SUB_VIEW
		local var_7_3 = {}

		LoginSceneConst = var_2_10004
		var_7_3[1] = var_2_10004.DEFINE.REGISTER_PANEL_VIEW

		var_7_1(var_7_0, var_7_2, var_7_3)

		local var_7_4 = arg_5_0
		local var_7_5 = var_0.emit

		LoginSceneConst = var_7_2

		var_7_5(var_7_4, var_7_2.CLEAR_REGISTER_VIEW)

		return
	end

	SFX_MAIN = var_1_10005

	var_1_10001(var_5_3, var_5_4, var_5_5, var_1_10005)

	onInputChanged = var_1_10001

	var_1_10001(arg_5_0, arg_5_0.loginUsername, function()
		arg_5_0.shareData.autoLoginEnabled = false

		return
	end)

	onInputChanged = var_1_10001

	var_1_10001(arg_5_0, arg_5_0.loginPassword, function()
		arg_5_0.shareData.autoLoginEnabled = false

		return
	end)

	return
end

function var_0_1.SetContent(arg_10_0, arg_10_1, arg_10_2)
	setInputText = var_1_10003

	var_1_10003(arg_10_0.loginUsername, arg_10_1)

	setInputText = var_1_10003

	var_1_10003(arg_10_0.loginPassword, arg_10_2)

	return
end

function var_0_1.OnDestroy(arg_11_0)
	return
end

return var_0_1
