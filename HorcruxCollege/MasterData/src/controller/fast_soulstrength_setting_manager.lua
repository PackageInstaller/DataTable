local FastSoulStrengthSettingManager = class("FastSoulStrengthSettingManager", (require("controller.base_manager")))

FastSoulStrengthSettingManager.MULTITON_MSG = "FastSoulStrengthSettingManager instancealready constructed!"
FastSoulStrengthSettingManager.Setting_Type = {
	Weapon = 1,
	Level = 0,
	SecondConfirmation = 3,
	Component = 2
}
FastSoulStrengthSettingManager.Setting_Key = {
	[FastSoulStrengthSettingManager.Setting_Type.Level] = "FastSoulStrengthSetting_Level",
	[FastSoulStrengthSettingManager.Setting_Type.Weapon] = "FastSoulStrengthSetting_Weapon",
	[FastSoulStrengthSettingManager.Setting_Type.Component] = "FastSoulStrengthSetting_Component",
	[FastSoulStrengthSettingManager.Setting_Type.SecondConfirmation] = "FastSoulStrengthSetting_SecondConfirmation"
}

function FastSoulStrengthSettingManager:ctor()
	FastSoulStrengthSettingManager.super.ctor(self)

	self._roleDefault = RoleDefault:getInstance()
	self._data = {
		[FastSoulStrengthSettingManager.Setting_Type.Level] = self._roleDefault:getBoolForKey(FastSoulStrengthSettingManager.Setting_Key[FastSoulStrengthSettingManager.Setting_Type.Level], true),
		[FastSoulStrengthSettingManager.Setting_Type.Weapon] = self._roleDefault:getBoolForKey(FastSoulStrengthSettingManager.Setting_Key[FastSoulStrengthSettingManager.Setting_Type.Weapon], true),
		[FastSoulStrengthSettingManager.Setting_Type.Component] = self._roleDefault:getBoolForKey(FastSoulStrengthSettingManager.Setting_Key[FastSoulStrengthSettingManager.Setting_Type.Component], true),
		[FastSoulStrengthSettingManager.Setting_Type.SecondConfirmation] = self._roleDefault:getBoolForKey(FastSoulStrengthSettingManager.Setting_Key[FastSoulStrengthSettingManager.Setting_Type.SecondConfirmation], true)
	}
end

function FastSoulStrengthSettingManager:requestInfo(arg_2_1)
	return
end

function FastSoulStrengthSettingManager:handlerInfo(arg_3_1)
	return
end

function FastSoulStrengthSettingManager:updateLayer()
	if self.layer then
		self.layer:updateLayer()
	end
end

function FastSoulStrengthSettingManager:updateRed()
	if self.layer then
		self.layer:updateRed()
	end
end

function FastSoulStrengthSettingManager:setConfigure(arg_6_1, arg_6_2)
	if self._data[arg_6_1] ~= nil then
		self._data[arg_6_1] = arg_6_2

		self._roleDefault:setBoolForKey(FastSoulStrengthSettingManager.Setting_Key[arg_6_1], arg_6_2)

		if self.layer then
			self.layer:updateLayer()
		end
	end
end

function FastSoulStrengthSettingManager:getConfigure(arg_7_1)
	if self._data[arg_7_1] ~= nil then
		return self._data[arg_7_1]
	end
end

function FastSoulStrengthSettingManager:getOpType()
	local var_8_0 = 0

	if self:getConfigure(FastSoulStrengthSettingManager.Setting_Type.Level) then
		var_8_0 = var_8_0 + 1
	end

	if self:getConfigure(FastSoulStrengthSettingManager.Setting_Type.Weapon) then
		var_8_0 = var_8_0 + 2 + 8
	end

	if self:getConfigure(FastSoulStrengthSettingManager.Setting_Type.Component) then
		var_8_0 = var_8_0 + 4
	end

	return var_8_0
end

return FastSoulStrengthSettingManager
