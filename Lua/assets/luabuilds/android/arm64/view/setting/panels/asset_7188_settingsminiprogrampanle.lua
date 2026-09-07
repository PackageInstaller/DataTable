local SettingsMiniProgramPanle = class("SettingsMiniProgramPanle", import(".SettingsBasePanel"))

function SettingsMiniProgramPanle:GetUIName()
	return "SettingsMiniProgramCH"
end

function SettingsMiniProgramPanle:GetTitle()
	return "小程序"
end

function SettingsMiniProgramPanle:GetTitleEn()
	return "/ MiniProgram"
end

function SettingsMiniProgramPanle:OnInit()
	self.serviceBtn = findTF(self._tf, "delete")

	onButton(self, self.serviceBtn, function()
		pg.SdkMgr.GetInstance():OpenMiniProgram()

		return
	end, SFX_PANEL)

	return
end

function SettingsMiniProgramPanle:OnUpdate()
	return
end

return SettingsMiniProgramPanle
