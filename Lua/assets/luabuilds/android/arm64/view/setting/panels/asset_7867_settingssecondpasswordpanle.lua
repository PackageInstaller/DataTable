local SettingsSecondPasswordPanle = class("SettingsSecondPasswordPanle", import(".SettingsBasePanel"))

function SettingsSecondPasswordPanle:GetUIName()
	return "SettingsSecondPassWord"
end

function SettingsSecondPasswordPanle:GetTitle()
	return i18n("Settings_title_Secpw")
end

function SettingsSecondPasswordPanle:GetTitleEn()
	return "  / SECOND-TIER PASSWORD"
end

function SettingsSecondPasswordPanle:OnInit()
	self.helpBtn = findTF(self._tf, "btnhelp")
	self.closeBtn = findTF(self._tf, "options/close")
	self.openBtn = findTF(self._tf, "options/open")

	setText(self._tf:Find("options/close/Text"), i18n("settings_pwd_label_close"))
	setText(self._tf:Find("options/open/Text"), i18n("settings_pwd_label_open"))
	self:SetData()
	self:RegisterEvent()

	return
end

function SettingsSecondPasswordPanle:SetData()
	self.rawdata = getProxy(SecondaryPWDProxy):getRawData()

	return
end

function SettingsSecondPasswordPanle:RegisterEvent()
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("secondary_password_help")
		})

		return
	end)
	onButton(self, self.closeBtn, function()
		if self.rawdata.state > 0 then
			pg.SecondaryPWDMgr.GetInstance():ChangeSetting({}, function()
				self:UpdateBtnState()

				return
			end)
		end

		return
	end, SFX_UI_TAG)
	onButton(self, self.openBtn, function()
		if self.rawdata.state <= 0 then
			local function var_10_0()
				pg.SecondaryPWDMgr.GetInstance():SetPassword(function()
					self:UpdateBtnState()

					return
				end)

				return
			end

			if PlayerPrefs.GetFloat("firstOpenSecondaryPassword") == 0 then
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					type = MSGBOX_TYPE_HELP,
					helps = i18n("secondary_password_help"),
					onYes = var_10_0,
					onClose = var_10_0
				})
				PlayerPrefs.SetFloat("firstOpenSecondaryPassword", 1)
				PlayerPrefs.Save()
			else
				var_10_0()
			end
		end

		return
	end, SFX_UI_TAG)

	return
end

function SettingsSecondPasswordPanle:UpdateBtnState()
	local var_13_0 = self.rawdata.state > 0

	setActive(self.closeBtn:Find("on"), not (self.rawdata.state > 0))
	setActive(self.closeBtn:Find("off"), var_13_0)
	setActive(self.openBtn:Find("on"), var_13_0)
	setActive(self.openBtn:Find("off"), not var_13_0)
	pg.m02:sendNotification(NewSettingsMediator.ON_SECON_PWD_STATE_CHANGE)

	return
end

function SettingsSecondPasswordPanle:OnUpdate()
	self:UpdateBtnState()

	return
end

return SettingsSecondPasswordPanle
