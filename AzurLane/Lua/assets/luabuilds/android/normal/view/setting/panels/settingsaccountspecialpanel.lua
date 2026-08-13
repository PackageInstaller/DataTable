class = var_0_10000

local var_0_0 = "SettingsAccountSpecialPanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".SettingsBasePanel"))

function var_0_1.GetUIName(arg_1_0)
	return "SettingsAccountSpecial"
end

function var_0_1.GetTitle(arg_2_0)
	i18n = var_1_10001

	return var_1_10001("settings_title_account_del")
end

function var_0_1.GetTitleEn(arg_3_0)
	return " / ACCOUNT SETTING"
end

function var_0_1.OnInit(arg_4_0)
	arg_4_0:findUI()
	arg_4_0:addListener()

	return
end

function var_0_1.OnUpdate(arg_5_0)
	return
end

function var_0_1.findUI(arg_6_0)
	local var_6_0 = arg_6_0._tf

	arg_6_0.expandBtn = var_1.Find(var_6_0, "ExpandBtn")

	local var_6_1 = arg_6_0._tf

	arg_6_0.panel = var_1.Find(var_6_1, "Panel")

	local var_6_2 = arg_6_0.panel

	arg_6_0.deleteTitle = var_1.Find(var_6_2, "Notice/DelTitle")

	local var_6_3 = arg_6_0.panel

	arg_6_0.deleteDesc = var_1.Find(var_6_3, "Notice/Text")

	local var_6_4 = arg_6_0.panel

	arg_6_0.confirmText = var_1.Find(var_6_4, "Confirm/Text")

	local var_6_5 = arg_6_0.panel

	arg_6_0.comfirmToggle = var_1.Find(var_6_5, "Confirm/Text/Toggle")

	local var_6_6 = arg_6_0.panel

	arg_6_0.delBtnDiasble = var_1.Find(var_6_6, "DelBtnDisable")

	local var_6_7 = arg_6_0.panel

	arg_6_0.delBtn = var_1.Find(var_6_7, "DelBtn")

	local var_6_8 = arg_6_0.delBtnDiasble
	local var_6_9 = var_1.Find(var_6_8, "Text")
	local var_6_10 = arg_6_0.delBtn
	local var_6_11 = var_2.Find(var_6_10, "Text")

	setText = var_6_10

	local var_6_12 = arg_6_0.deleteTitle

	i18n = var_1_10005

	var_6_10(var_6_12, var_1_10005("settings_text_account_del"))

	setText = var_6_10

	local var_6_13 = arg_6_0.deleteDesc

	i18n = var_5

	var_6_10(var_6_13, var_5("settings_text_account_del_desc"))

	setText = var_6_10

	local var_6_14 = arg_6_0.confirmText

	i18n = var_5

	var_6_10(var_6_14, var_5("settings_text_account_del_confirm"))

	setText = var_6_10

	local var_6_15 = var_6_9

	i18n = var_5

	var_6_10(var_6_15, var_5("settings_text_account_del_btn"))

	setText = var_6_10

	local var_6_16 = var_6_11

	i18n = var_5

	var_6_10(var_6_16, var_5("settings_text_account_del_btn"))

	triggerToggle = var_6_10

	var_6_10(arg_6_0.comfirmToggle, false)

	return
end

function var_0_1.addListener(arg_7_0)
	onButton = var_1_10001

	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.expandBtn

	local function var_7_2()
		setSizeDelta = var_2_10000

		var_2_10000(arg_7_0._tf, {
			x = 1558,
			y = 515
		})

		scrollToBottom = var_2_10000

		var_2_10000(arg_7_0._tf.parent.parent)

		setActive = var_2_10000

		var_2_10000(arg_7_0.panel, true)

		setActive = var_2_10000

		var_2_10000(arg_7_0.expandBtn, false)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_7_0, var_7_1, var_7_2, var_1_10005)

	onToggle = var_1_10001

	local var_7_3 = arg_7_0
	local var_7_4 = arg_7_0.comfirmToggle

	local function var_7_5(arg_9_0)
		setActive = var_2_10001

		var_2_10001(arg_7_0.delBtnDiasble, not arg_9_0)

		setActive = var_2_10001

		var_2_10001(arg_7_0.delBtn, arg_9_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_7_3, var_7_4, var_7_5, var_1_10005)

	onToggle = var_1_10001

	local var_7_6 = arg_7_0
	local var_7_7 = arg_7_0.confirmText

	local function var_7_8(arg_10_0)
		triggerToggle = var_2_10001

		var_2_10001(arg_7_0.comfirmToggle, arg_10_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_7_6, var_7_7, var_7_8, var_1_10005)

	onButton = var_1_10001

	local var_7_9 = arg_7_0
	local var_7_10 = arg_7_0.delBtn

	local function var_7_11()
		local var_11_0 = arg_7_0

		var_0.openMsgBox(var_11_0)

		return
	end

	SFX_PANEL = var_1_10005

	var_1_10001(var_7_9, var_7_10, var_7_11, var_1_10005)

	return
end

function var_0_1.openMsgBox(arg_12_0)
	pg = var_1_10001

	local var_12_0 = var_1_10001.MsgboxMgr.GetInstance()
	local var_12_1 = var_1.ShowMsgBox
	local var_12_2 = {
		modal = true
	}

	MSGBOX_TYPE_ACCOUNTDELETE = var_1_10004
	var_12_2.type = var_1_10004
	pg = var_1_10004
	var_12_2.title = var_1_10004.MsgboxMgr.TITLE_INFORMATION

	function var_12_2.onYes(arg_13_0)
		i18n = var_2_10001

		if arg_13_0 == var_2_10001("box_account_del_target") then
			pg = var_2

			local var_13_0 = var_2.SdkMgr.GetInstance()

			var_2.AccountDelete(var_13_0)
		else
			pg = var_2

			local var_13_1 = var_2.TipsMgr.GetInstance()
			local var_13_2 = var_2.ShowTips

			i18n = var_2_10004

			var_13_2(var_13_1, var_2_10004("tip_account_del_dismatch"))
		end

		return
	end

	var_12_1(var_12_0, var_12_2)

	return
end

return var_0_1
