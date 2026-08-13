class = var_0_10000

local var_0_0 = "SettingsSecondPasswordPanle"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".SettingsBasePanel"))

function var_0_1.GetUIName(arg_1_0)
	return "SettingsSecondPassWord"
end

function var_0_1.GetTitle(arg_2_0)
	i18n = var_1_10001

	return var_1_10001("Settings_title_Secpw")
end

function var_0_1.GetTitleEn(arg_3_0)
	return "  / SECOND-TIER PASSWORD"
end

function var_0_1.OnInit(arg_4_0)
	findTF = var_1_10001
	arg_4_0.helpBtn = var_1_10001(arg_4_0._tf, "btnhelp")
	findTF = var_1
	arg_4_0.closeBtn = var_1(arg_4_0._tf, "options/close")
	findTF = var_1
	arg_4_0.openBtn = var_1(arg_4_0._tf, "options/open")
	setText = var_1

	local var_4_0 = arg_4_0._tf
	local var_4_1 = var_2.Find(var_4_0, "options/close/Text")

	i18n = var_4_0

	var_1(var_4_1, var_4_0("settings_pwd_label_close"))

	setText = var_1

	local var_4_2 = arg_4_0._tf
	local var_4_3 = var_2.Find(var_4_2, "options/open/Text")

	i18n = var_4_2

	var_1(var_4_3, var_4_2("settings_pwd_label_open"))
	arg_4_0:SetData()
	arg_4_0:RegisterEvent()

	return
end

function var_0_1.SetData(arg_5_0)
	getProxy = var_1_10001
	SecondaryPWDProxy = var_1_10002

	local var_5_0 = var_1_10001(var_1_10002)

	arg_5_0.rawdata = var_1.getRawData(var_5_0)

	return
end

function var_0_1.RegisterEvent(arg_6_0)
	onButton = var_1_10001

	var_1_10001(arg_6_0, arg_6_0.helpBtn, function()
		pg = var_2_10000

		local var_7_0 = var_2_10000.MsgboxMgr.GetInstance()
		local var_7_1 = var_0.ShowMsgBox
		local var_7_2 = {}

		MSGBOX_TYPE_HELP = var_2_10003
		var_7_2.type = var_2_10003
		i18n = var_2_10003
		var_7_2.helps = var_2_10003("secondary_password_help")

		var_7_1(var_7_0, var_7_2)

		return
	end)

	onButton = var_1_10001

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.closeBtn

	local function var_6_2()
		if arg_6_0.rawdata.state > 0 then
			pg = var_0

			local var_8_0 = var_0.SecondaryPWDMgr.GetInstance()

			var_0.ChangeSetting(var_8_0, {}, function()
				local var_9_0 = arg_6_0

				var_0.UpdateBtnState(var_9_0)

				return
			end)
		end

		return
	end

	SFX_UI_TAG = var_1_10005

	var_1_10001(var_6_0, var_6_1, var_6_2, var_1_10005)

	onButton = var_1_10001

	local var_6_3 = arg_6_0
	local var_6_4 = arg_6_0.openBtn

	local function var_6_5()
		if arg_6_0.rawdata.state <= 0 then
			local function var_10_0()
				pg = var_3_10000

				local var_11_0 = var_3_10000.SecondaryPWDMgr.GetInstance()

				var_0.SetPassword(var_11_0, function()
					local var_12_0 = arg_6_0

					var_0.UpdateBtnState(var_12_0)

					return
				end)

				return
			end

			PlayerPrefs = var_1

			if var_1.GetFloat("firstOpenSecondaryPassword") == 0 then
				pg = var_1

				local var_10_1 = var_1.MsgboxMgr.GetInstance()
				local var_10_2 = var_1.ShowMsgBox
				local var_10_3 = {}

				MSGBOX_TYPE_HELP = var_2_10004
				var_10_3.type = var_2_10004
				i18n = var_2_10004
				var_10_3.helps = var_2_10004("secondary_password_help")
				var_10_3.onYes = var_10_0
				var_10_3.onClose = var_10_0

				var_10_2(var_10_1, var_10_3)

				PlayerPrefs = var_10_2

				var_10_2.SetFloat("firstOpenSecondaryPassword", 1)

				PlayerPrefs = var_1

				var_1.Save()
			else
				var_10_0()
			end
		end

		return
	end

	SFX_UI_TAG = var_1_10005

	var_1_10001(var_6_3, var_6_4, var_6_5, var_1_10005)

	return
end

function var_0_1.UpdateBtnState(arg_13_0)
	local var_13_0 = arg_13_0.rawdata.state
	local var_13_1 = 0 < var_13_0

	setActive = var_2

	local var_13_2 = arg_13_0.closeBtn

	var_2(var_3.Find(var_13_2, "on"), not var_13_1)

	setActive = var_2

	local var_13_3 = arg_13_0.closeBtn

	var_2(var_3.Find(var_13_3, "off"), var_13_1)

	setActive = var_2

	local var_13_4 = arg_13_0.openBtn

	var_2(var_3.Find(var_13_4, "on"), var_13_1)

	setActive = var_2

	local var_13_5 = arg_13_0.openBtn

	var_2(var_3.Find(var_13_5, "off"), not var_13_1)

	pg = var_2

	local var_13_6 = var_2.m02
	local var_13_7 = var_2.sendNotification

	NewSettingsMediator = var_4

	var_13_7(var_13_6, var_4.ON_SECON_PWD_STATE_CHANGE)

	return
end

function var_0_1.OnUpdate(arg_14_0)
	arg_14_0:UpdateBtnState()

	return
end

return var_0_1
