local T0SoundSettingView = class("T0SoundSettingView", StorySoundSettingView)

function T0SoundSettingView:UIName()
	return "Widget/System/Story/StorySoundSettingUI"
end

function T0SoundSettingView:UIParent()
	return manager.ui.uiStory.transform
end

function T0SoundSettingView:Init()
	T0SoundSettingView.super.Init(self)

	self.options = {}

	for iter_3_0 = 1, self.settingOptionRoot_.childCount do
		self.options[iter_3_0] = {
			obj = self.settingOptionRoot_:GetChild(iter_3_0 - 1).gameObject
		}
	end
end

function T0SoundSettingView:AddListeners()
	self:AddBtnListener(self.closeBtn_, nil, function()
		self:Back()
	end)
end

function T0SoundSettingView:RefreshUI()
	self.soundMusicView_:SetData(self.settingData_.music, self.settingData_.sound_open == 1)
	self.soundEffectView_:SetData(self.settingData_.effect, self.settingData_.sound_open == 1)
	self.soundVoiceView_:SetData(self.settingData_.voice, self.settingData_.sound_open == 1)
	self.soundSwitchView_:SetData(false)
end

function T0SoundSettingView:OnEnter()
	T0SoundSettingView.super.OnEnter(self)

	for iter_7_0 = 4, #self.options do
		SetActive(self.options[iter_7_0].obj, false)
	end
end

return T0SoundSettingView
