class = var_0_10000

local var_0_0 = "RegisterPanelView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "RegisterPanelView"
end

function var_0_1.OnLoaded(arg_2_0)
	return
end

function var_0_1.SetShareData(arg_3_0, arg_3_1)
	arg_3_0.shareData = arg_3_1

	return
end

function var_0_1.OnInit(arg_4_0)
	arg_4_0.registerPanel = arg_4_0._tf

	local var_4_0 = arg_4_0.registerPanel

	arg_4_0.registerUsername = var_1.Find(var_4_0, "account/username")

	local var_4_1 = arg_4_0.registerPanel

	arg_4_0.cancelButton = var_1.Find(var_4_1, "cancel_button")

	local var_4_2 = arg_4_0.registerPanel

	arg_4_0.confirmButton = var_1.Find(var_4_2, "confirm_button")

	arg_4_0:InitEvent()

	return
end

function var_0_1.InitEvent(arg_5_0)
	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.confirmButton

	local function var_5_2()
		getInputText = var_2_10000

		if var_2_10000(arg_5_0.registerUsername) == "" then
			pg = var_2_10001

			local var_6_0 = var_2_10001.TipsMgr.GetInstance()

			var_2_10001 = var_2_10001.ShowTips
			i18n = var_2_10004

			var_2_10001(var_6_0, var_2_10004("login_loginScene_error_noUserName"))

			ActivateInputField = var_2_10001

			var_2_10001(arg_5_0.registerUsername)

			return
		end

		User = var_2_10001

		if var_2_10001.New({
			arg3 = "",
			arg2 = "",
			type = 2,
			arg1 = var_0
		}) then
			local var_6_1 = arg_5_0.event
			local var_6_2 = var_2.emit

			LoginMediator = var_2_10005

			var_6_2(var_6_1, var_2_10005.ON_REGISTER, var_1)
		end

		return
	end

	SFX_CONFIRM = var_1_10006

	var_1_10001(var_5_0, var_5_1, var_5_2, var_1_10006)

	onButton = var_1_10001

	local var_5_3 = arg_5_0
	local var_5_4 = arg_5_0.cancelButton

	local function var_5_5()
		local var_7_0 = arg_5_0
		local var_7_1 = var_0.emit

		LoginSceneConst = var_2_10003

		local var_7_2 = var_2_10003.SWITCH_SUB_VIEW
		local var_7_3 = {}

		LoginSceneConst = var_2_10005
		var_7_3[1] = var_2_10005.DEFINE.LOGIN_PANEL_VIEW

		var_7_1(var_7_0, var_7_2, var_7_3)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_5_3, var_5_4, var_5_5, var_1_10006)

	return
end

function var_0_1.Clear(arg_8_0)
	return
end

function var_0_1.OnDestroy(arg_9_0)
	return
end

return var_0_1
