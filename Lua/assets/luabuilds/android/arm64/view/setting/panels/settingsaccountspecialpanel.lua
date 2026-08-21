local var_0_0 = class("SettingsAccountSpecialPanel", import(".SettingsBasePanel"))

function var_0_0.GetUIName(arg_1_0)
	return "SettingsAccountSpecial"
end

function var_0_0.GetTitle(arg_2_0)
	return i18n("settings_title_account_del")
end

function var_0_0.GetTitleEn(arg_3_0)
	return " / ACCOUNT SETTING"
end

function var_0_0.OnInit(arg_4_0)
	arg_4_0:findUI()
	arg_4_0:addListener()

	return
end

function var_0_0.OnUpdate(arg_5_0)
	return
end

function var_0_0.findUI(arg_6_0)
	arg_6_0.expandBtn = arg_6_0._tf:Find("ExpandBtn")
	arg_6_0.panel = arg_6_0._tf:Find("Panel")
	arg_6_0.deleteTitle = arg_6_0.panel:Find("Notice/DelTitle")
	arg_6_0.deleteDesc = arg_6_0.panel:Find("Notice/Text")
	arg_6_0.confirmText = arg_6_0.panel:Find("Confirm/Text")
	arg_6_0.comfirmToggle = arg_6_0.panel:Find("Confirm/Text/Toggle")
	arg_6_0.delBtnDiasble = arg_6_0.panel:Find("DelBtnDisable")
	arg_6_0.delBtn = arg_6_0.panel:Find("DelBtn")

	setText(arg_6_0.deleteTitle, i18n("settings_text_account_del"))
	setText(arg_6_0.deleteDesc, i18n("settings_text_account_del_desc"))
	setText(arg_6_0.confirmText, i18n("settings_text_account_del_confirm"))
	setText(arg_6_0.delBtnDiasble:Find("Text"), i18n("settings_text_account_del_btn"))
	setText(arg_6_0.delBtn:Find("Text"), i18n("settings_text_account_del_btn"))
	triggerToggle(arg_6_0.comfirmToggle, false)

	return
end

function var_0_0.addListener(arg_7_0)
	onButton(arg_7_0, arg_7_0.expandBtn, function()
		setSizeDelta(arg_7_0._tf, {
			x = 1558,
			y = 515
		})
		scrollToBottom(arg_7_0._tf.parent.parent)
		setActive(arg_7_0.panel, true)
		setActive(arg_7_0.expandBtn, false)

		return
	end, SFX_PANEL)
	onToggle(arg_7_0, arg_7_0.comfirmToggle, function(arg_9_0)
		setActive(arg_7_0.delBtnDiasble, not arg_9_0)
		setActive(arg_7_0.delBtn, arg_9_0)

		return
	end, SFX_PANEL)
	onToggle(arg_7_0, arg_7_0.confirmText, function(arg_10_0)
		triggerToggle(arg_7_0.comfirmToggle, arg_10_0)

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.delBtn, function()
		arg_7_0:openMsgBox()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.openMsgBox(arg_12_0)
	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		modal = true,
		type = MSGBOX_TYPE_ACCOUNTDELETE,
		title = pg.MsgboxMgr.TITLE_INFORMATION,
		onYes = function(arg_13_0)
			if arg_13_0 == i18n("box_account_del_target") then
				pg.SdkMgr.GetInstance():AccountDelete()
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("tip_account_del_dismatch"))
			end

			return
		end
	})

	return
end

return var_0_0
