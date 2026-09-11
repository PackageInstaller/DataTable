local CaptureSettingDataTemplate = class("CaptureSettingDataTemplate")

function CaptureSettingDataTemplate:init()
	self.setting = {
		playerName = true,
		rotateModel = false,
		playerPivot = 2,
		lens = -1,
		uid = false,
		logoPivot = 1,
		level = false
	}
end

function CaptureSettingDataTemplate:CheckCanRotateModel()
	return self.setting.rotateModel
end

function CaptureSettingDataTemplate:SetRotModelState(arg_3_1)
	self.setting.rotateModel = arg_3_1
end

function CaptureSettingDataTemplate:CheckNeedPlayerName()
	return self.setting.playerName
end

function CaptureSettingDataTemplate:SetNeedPlayerNameState(arg_5_1)
	self.setting.playerName = arg_5_1
end

function CaptureSettingDataTemplate:CheckNeedLevel()
	return self.setting.level
end

function CaptureSettingDataTemplate:SetNeedLevelState(arg_7_1)
	self.setting.level = arg_7_1
end

function CaptureSettingDataTemplate:CheckNeedUid()
	return self.setting.uid
end

function CaptureSettingDataTemplate:SetNeedUidState(arg_9_1)
	self.setting.uid = arg_9_1
end

function CaptureSettingDataTemplate:SetLens(arg_10_1)
	self.setting.lens = arg_10_1
end

function CaptureSettingDataTemplate:GetLens(arg_11_1)
	return self.setting.lens
end

function CaptureSettingDataTemplate:GetLogoPos()
	return self.setting.logoPivot
end

function CaptureSettingDataTemplate:SetLogoPos(arg_13_1)
	self.setting.logoPivot = arg_13_1
end

function CaptureSettingDataTemplate:GetCardPos()
	return self.setting.playerPivot
end

function CaptureSettingDataTemplate:SetCardPos(arg_15_1)
	self.setting.playerPivot = arg_15_1
end

return CaptureSettingDataTemplate
