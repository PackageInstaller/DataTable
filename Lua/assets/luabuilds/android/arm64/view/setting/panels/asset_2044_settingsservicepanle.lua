local SettingsServicePanle = class("SettingsServicePanle", import(".SettingsBasePanel"))

function SettingsServicePanle:GetUIName()
	return "SettingsServiceCH"
end

function SettingsServicePanle:GetTitle()
	return "客服"
end

function SettingsServicePanle:GetTitleEn()
	return "/ Service"
end

function SettingsServicePanle:OnInit()
	self.serviceBtn = findTF(self._tf, "delete")

	onButton(self, self.serviceBtn, function()
		pg.SdkMgr.GetInstance():Service()

		return
	end, SFX_PANEL)

	return
end

function SettingsServicePanle:OnUpdate()
	return
end

return SettingsServicePanle
