local StorySoundSettingSwitch = class("StorySoundSettingSwitch", ReduxView)

function StorySoundSettingSwitch:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.soundType_ = arg_1_2
	self.switchController_ = self.conEx_:GetController("select")
end

function StorySoundSettingSwitch:Dispose()
	StorySoundSettingSwitch.super.Dispose(self)
end

function StorySoundSettingSwitch:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		self.isEnabled_ = not self.isEnabled_

		SettingAction.ChangeSoundSetting(self.soundType_, self.isEnabled_ == true and 1 or 0)
		self:RefreshUI()

		if self.soundType_ == "sound_open" then
			manager.notify:Invoke(SOUND_SETTING_SWICH)
		end
	end)
end

function StorySoundSettingSwitch:SetData(arg_5_1)
	self.isEnabled_ = arg_5_1

	self:RefreshUI()
end

function StorySoundSettingSwitch:RefreshUI()
	if self.isEnabled_ then
		self.switchController_:SetSelectedState("on")
	else
		self.switchController_:SetSelectedState("off")
	end
end

return StorySoundSettingSwitch
