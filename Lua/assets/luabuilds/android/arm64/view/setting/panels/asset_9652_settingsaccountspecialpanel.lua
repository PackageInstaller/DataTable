local SettingsAccountSpecialPanel = class("SettingsAccountSpecialPanel", import(".SettingsBasePanel"))

function SettingsAccountSpecialPanel:GetUIName()
	return "SettingsAccountSpecial"
end

function SettingsAccountSpecialPanel:GetTitle()
	return i18n("settings_title_account_del")
end

function SettingsAccountSpecialPanel:GetTitleEn()
	return " / ACCOUNT SETTING"
end

function SettingsAccountSpecialPanel:OnInit()
	self:findUI()
	self:addListener()

	return
end

function SettingsAccountSpecialPanel:OnUpdate()
	return
end

function SettingsAccountSpecialPanel:findUI()
	self.expandBtn = self._tf:Find("ExpandBtn")
	self.panel = self._tf:Find("Panel")
	self.deleteTitle = self.panel:Find("Notice/DelTitle")
	self.deleteDesc = self.panel:Find("Notice/Text")
	self.confirmText = self.panel:Find("Confirm/Text")
	self.comfirmToggle = self.panel:Find("Confirm/Text/Toggle")
	self.delBtnDiasble = self.panel:Find("DelBtnDisable")
	self.delBtn = self.panel:Find("DelBtn")

	setText(self.deleteTitle, i18n("settings_text_account_del"))
	setText(self.deleteDesc, i18n("settings_text_account_del_desc"))
	setText(self.confirmText, i18n("settings_text_account_del_confirm"))
	setText(self.delBtnDiasble:Find("Text"), i18n("settings_text_account_del_btn"))
	setText(self.delBtn:Find("Text"), i18n("settings_text_account_del_btn"))
	triggerToggle(self.comfirmToggle, false)

	return
end

function SettingsAccountSpecialPanel:addListener()
	onButton(self, self.expandBtn, function()
		setSizeDelta(self._tf, {
			x = 1558,
			y = 515
		})
		scrollToBottom(self._tf.parent.parent)
		setActive(self.panel, true)
		setActive(self.expandBtn, false)

		return
	end, SFX_PANEL)
	onToggle(self, self.comfirmToggle, function(arg_9_0)
		setActive(self.delBtnDiasble, not arg_9_0)
		setActive(self.delBtn, arg_9_0)

		return
	end, SFX_PANEL)
	onToggle(self, self.confirmText, function(arg_10_0)
		triggerToggle(self.comfirmToggle, arg_10_0)

		return
	end, SFX_PANEL)
	onButton(self, self.delBtn, function()
		self:openMsgBox()

		return
	end, SFX_PANEL)

	return
end

function SettingsAccountSpecialPanel:openMsgBox()
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

return SettingsAccountSpecialPanel
