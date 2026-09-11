local CaptureSettingDataTemplate = import("game.data.CaptureGame.CaptureSettingDataTemplate")
local var_0_1 = singletonClass("CaptureGameSettingData")

function var_0_1.Init(arg_1_0)
	return
end

function var_0_1:GetSetting()
	if self.setting == nil then
		self.setting = CaptureSettingDataTemplate.New()

		self.setting:init()
	end

	return self.setting
end

function var_0_1:InitSetting()
	self:GetSetting():SetLens(-1)
end

function var_0_1:CheckCanRotateModel()
	return self:GetSetting():CheckCanRotateModel()
end

function var_0_1:SetRotModelState(arg_5_1)
	self:GetSetting():SetRotModelState(arg_5_1)
end

function var_0_1:CheckNeedPlayerName()
	return self:GetSetting():CheckNeedPlayerName()
end

function var_0_1:SetNeedPlayerNameState(arg_7_1)
	self:GetSetting():SetNeedPlayerNameState(arg_7_1)
end

function var_0_1:CheckNeedLevel()
	return self:GetSetting():CheckNeedLevel()
end

function var_0_1:SetNeedLevelState(arg_9_1)
	self:GetSetting():SetNeedLevelState(arg_9_1)
end

function var_0_1:CheckNeedUid()
	return self:GetSetting():CheckNeedUid()
end

function var_0_1:SetNeedUidState(arg_11_1)
	self:GetSetting():SetNeedUidState(arg_11_1)
end

function var_0_1:SetLens(arg_12_1)
	self:GetSetting():SetLens(arg_12_1)
	CaptureGameMgr:GetCameraMgr():SwitchLens(arg_12_1)
	manager.notify:Invoke(CAPTURE_GAME_LENS_UPDATE)
end

function var_0_1:GetLens()
	return self:GetSetting():GetLens()
end

function var_0_1:GetLogoPos()
	return self:GetSetting():GetLogoPos()
end

function var_0_1:SetLogoPos(arg_15_1)
	self:GetSetting():SetLogoPos(arg_15_1)
end

function var_0_1:GetCardPos()
	return self:GetSetting():GetCardPos()
end

function var_0_1:SetCardPos(arg_17_1)
	self:GetSetting():SetCardPos(arg_17_1)
end

return var_0_1
