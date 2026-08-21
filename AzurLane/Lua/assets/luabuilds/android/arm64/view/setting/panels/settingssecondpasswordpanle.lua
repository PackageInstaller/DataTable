local var_0_0 = class("SettingsSecondPasswordPanle", import(".SettingsBasePanel"))

function var_0_0.GetUIName(arg_1_0)
	return "SettingsSecondPassWord"
end

function var_0_0.GetTitle(arg_2_0)
	return i18n("Settings_title_Secpw")
end

function var_0_0.GetTitleEn(arg_3_0)
	return "  / SECOND-TIER PASSWORD"
end

function var_0_0.OnInit(arg_4_0)
	arg_4_0.helpBtn = findTF(arg_4_0._tf, "btnhelp")
	arg_4_0.closeBtn = findTF(arg_4_0._tf, "options/close")
	arg_4_0.openBtn = findTF(arg_4_0._tf, "options/open")

	setText(arg_4_0._tf:Find("options/close/Text"), i18n("settings_pwd_label_close"))
	setText(arg_4_0._tf:Find("options/open/Text"), i18n("settings_pwd_label_open"))
	arg_4_0:SetData()
	arg_4_0:RegisterEvent()

	return
end

function var_0_0.SetData(arg_5_0)
	arg_5_0.rawdata = getProxy(SecondaryPWDProxy):getRawData()

	return
end

function var_0_0.RegisterEvent(arg_6_0)
	onButton(arg_6_0, arg_6_0.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("secondary_password_help")
		})

		return
	end)
	onButton(arg_6_0, arg_6_0.closeBtn, function()
		if arg_6_0.rawdata.state > 0 then
			pg.SecondaryPWDMgr.GetInstance():ChangeSetting({}, function()
				arg_6_0:UpdateBtnState()

				return
			end)
		end

		return
	end, SFX_UI_TAG)
	onButton(arg_6_0, arg_6_0.openBtn, function()
		if arg_6_0.rawdata.state <= 0 then
			if PlayerPrefs.GetFloat("firstOpenSecondaryPassword") == 0 then
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					type = MSGBOX_TYPE_HELP,
					helps = i18n("secondary_password_help"),
					onYes = function()
						pg.SecondaryPWDMgr.GetInstance():SetPassword(function()
							arg_6_0:UpdateBtnState()

							return
						end)

						return
					end,
					onClose = function()
						pg.SecondaryPWDMgr.GetInstance():SetPassword(function()
							arg_6_0:UpdateBtnState()

							return
						end)

						return
					end
				})
				PlayerPrefs.SetFloat("firstOpenSecondaryPassword", 1)
				PlayerPrefs.Save()
			else
				(function()
					pg.SecondaryPWDMgr.GetInstance():SetPassword(function()
						arg_6_0:UpdateBtnState()

						return
					end)

					return
				end)()
			end
		end

		return
	end, SFX_UI_TAG)

	return
end

function var_0_0.UpdateBtnState(arg_13_0)
	local var_13_0 = arg_13_0.rawdata.state > 0

	setActive(arg_13_0.closeBtn:Find("on"), not (arg_13_0.rawdata.state > 0))
	setActive(arg_13_0.closeBtn:Find("off"), var_13_0)
	setActive(arg_13_0.openBtn:Find("on"), var_13_0)
	setActive(arg_13_0.openBtn:Find("off"), not var_13_0)
	pg.m02:sendNotification(NewSettingsMediator.ON_SECON_PWD_STATE_CHANGE)

	return
end

function var_0_0.OnUpdate(arg_14_0)
	arg_14_0:UpdateBtnState()

	return
end

return var_0_0
