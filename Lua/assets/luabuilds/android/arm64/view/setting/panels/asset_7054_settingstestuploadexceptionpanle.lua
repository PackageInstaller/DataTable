local SettingsTestUploadExceptionPanle = class("SettingsTestUploadExceptionPanle", import(".SettingsBasePanel"))

function SettingsTestUploadExceptionPanle:GetUIName()
	return "SettingsServiceCH"
end

function SettingsTestUploadExceptionPanle:GetTitle()
	return "测试异常上传"
end

function SettingsTestUploadExceptionPanle:GetTitleEn()
	return "/ Service"
end

function SettingsTestUploadExceptionPanle:OnInit()
	self.serviceBtn = findTF(self._tf, "delete")

	onButton(self, self.serviceBtn, function()
		return
	end, SFX_PANEL)

	return
end

function SettingsTestUploadExceptionPanle:OnUpdate()
	return
end

return SettingsTestUploadExceptionPanle
