local StorySoundSettingItem = class("StorySoundSettingItem", ReduxView)

function StorySoundSettingItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.soundType_ = arg_1_2

	self:BindCfgUI()
	self:AddListeners()
end

function StorySoundSettingItem:Dispose()
	StorySoundSettingItem.super.Dispose(self)
end

function StorySoundSettingItem:AddListeners()
	self:AddToggleListener(self.slider_, function(arg_4_0)
		self:SetSoundValue(arg_4_0)
	end)
	self:AddPressingByTimeListener(self.subtractBtn_.gameObject, 3, 0.2, 0.2, function()
		if self.subtractBtn_.interactable and self.slider_.value > 0 then
			self:SetSoundValue(self.slider_.value - 1)

			return true
		end

		return false
	end)
	self:AddPressingByTimeListener(self.addBtn_.gameObject, 3, 0.2, 0.2, function()
		if self.addBtn_.interactable and self.slider_.value < 100 then
			self:SetSoundValue(self.slider_.value + 1)

			return true
		end

		return false
	end)
end

function StorySoundSettingItem:SetData(arg_7_1, arg_7_2)
	self:RefreshText(arg_7_1)
	self:Enabled(arg_7_2)
end

function StorySoundSettingItem:SetSoundValue(arg_8_1)
	SettingAction.ChangeSoundSetting(self.soundType_, arg_8_1)
	self:RefreshText(arg_8_1)
end

function StorySoundSettingItem:RefreshText(arg_9_1)
	self.percentText_.text = string.format("%s%%", arg_9_1)
	self.slider_.value = arg_9_1
end

function StorySoundSettingItem:Enabled(arg_10_1)
	self.slider_.interactable = arg_10_1
	self.subtractBtn_.interactable = arg_10_1
	self.addBtn_.interactable = arg_10_1
end

return StorySoundSettingItem
