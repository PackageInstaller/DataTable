local SettingsAccountJPPanle = class("SettingsAccountJPPanle", import(".SettingsBasePanel"))

function SettingsAccountJPPanle:GetUIName()
	return "SettingsAccountJP"
end

function SettingsAccountJPPanle:GetTitle()
	return i18n("Settings_title_LoginJP")
end

function SettingsAccountJPPanle:GetTitleEn()
	return "  / ACCOUNT"
end

function SettingsAccountJPPanle:OnInit()
	self.userProxy = getProxy(UserProxy)
	self.accountTwitterUI = findTF(self._tf, "page1")
	self.yostarBtn = findTF(findTF(self.accountTwitterUI, "btn_layout/yostar_con"), "bind_yostar")

	setText(findTF(self.yostarBtn, "Text"), i18n("yostar_account_btn"))
	self:OnRegisterEvent()

	return
end

function SettingsAccountJPPanle:OnRegisterEvent()
	onButton(self, self.yostarBtn, function()
		pg.SdkMgr.GetInstance():YoStarShowUserCenter()

		return
	end)

	return
end

function SettingsAccountJPPanle:OnUpdate()
	return
end

return SettingsAccountJPPanle
