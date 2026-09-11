local StorySoundSettingView = class("StorySoundSettingView", ReduxView)

function StorySoundSettingView:UIName()
	return "Widget/System/Story/StorySoundSettingUI"
end

function StorySoundSettingView:UIParent()
	return manager.ui.uiStory.transform
end

function StorySoundSettingView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.soundMusicView_ = StorySoundSettingItem.New(self.soundMusicGo_, "music")
	self.soundEffectView_ = StorySoundSettingItem.New(self.soundEffectGo_, "effect")
	self.soundVoiceView_ = StorySoundSettingItem.New(self.soundVoiceGo_, "voice")
	self.soundSwitchView_ = StorySoundSettingSwitch.New(self.soundSwitchGo_, "sound_open")
	self.OnVoiceLanguageSwitchHandler_ = handler(self, self.OnVoiceLanguageSwitch)
end

function StorySoundSettingView:OnEnter()
	self.settingData_ = SettingData:GetSoundSettingData()
	self.tmpSettingData_ = deepClone(self.settingData_)

	self:RefreshUI()
	manager.notify:RegistListener(STORY_SWITCH_VOICE_LANGUAGE, self.OnVoiceLanguageSwitchHandler_)
end

function StorySoundSettingView:OnTop()
	SetActive(self.gameObject_, true)
end

function StorySoundSettingView:OnExit()
	manager.notify:RemoveListener(STORY_SWITCH_VOICE_LANGUAGE, self.OnVoiceLanguageSwitchHandler_)
	self:SaveData()
end

function StorySoundSettingView:Dispose()
	self.OnVoiceLanguageSwitchHandler_ = nil

	self.soundMusicView_:Dispose()

	self.soundMusicView_ = nil

	self.soundEffectView_:Dispose()

	self.soundEffectView_ = nil

	self.soundVoiceView_:Dispose()

	self.soundVoiceView_ = nil

	self.soundSwitchView_:Dispose()

	self.soundSwitchView_ = nil

	StorySoundSettingView.super.Dispose(self)
end

function StorySoundSettingView:AddListeners()
	self:AddBtnListener(self.closeBtn_, nil, function()
		local var_9_0 = gameContext:GetAllOpenRoute()

		if #var_9_0 >= 1 and var_9_0[1] == "home" then
			self:Back()

			return
		end

		if #gameContext:GetCurHistory() <= 1 then
			SetActive(self.gameObject_, false)
		else
			self:Back()
		end
	end)
	self:AddBtnListener(self.languageBtn_, nil, function()
		JumpTools.OpenPageByJump("languageSwitch", {
			needSetParent = true
		})
	end)
	self:AddBtnListener(self.voiceBtn_, nil, function()
		JumpTools.OpenPageByJump("storyVoiceSwitch", {
			needSetParent = true,
			voiceLanguage = SettingData:GetStoryVoiceLanguageCache()
		})
	end)
	self:AddBtnListener(self.packageBtn_, nil, function()
		JumpTools.OpenPageByJump("languagePackage", {
			needSetParent = true
		})
	end)
end

function StorySoundSettingView:RefreshUI()
	self.soundMusicView_:SetData(self.settingData_.music, self.settingData_.sound_open == 1)
	self.soundEffectView_:SetData(self.settingData_.effect, self.settingData_.sound_open == 1)
	self.soundVoiceView_:SetData(self.settingData_.voice, self.settingData_.sound_open == 1)
	self.soundSwitchView_:SetData(self.settingData_.sound_open == 1)
	self:RefreshVoiceLanguage()
	self:RefreshTextLanguage()
end

function StorySoundSettingView:RefreshVoiceLanguage()
	self.voiceText_.text = VoiceLanguageCfg[SettingData:GetStoryVoiceLanguageCache()].name
end

function StorySoundSettingView:RefreshTextLanguage()
	self.languageText_.text = AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].language_in_list[table.indexof(AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].language_list, self.settingData_.text_language)]
end

function StorySoundSettingView:SaveData()
	if self:CheckDataChange() then
		SDKTools.SendMessageToSDK("audio_setting", {
			bg_audio_setting = self.settingData_.music,
			effect_setting = self.settingData_.effect,
			sound_setting = self.settingData_.voice,
			language = self.settingData_.voice_language
		})
		manager.net:SendWithLoadingNew(12100, {
			language = self.settingData_.text_language
		}, 12101, function(arg_17_0)
			if isSuccess(arg_17_0.result) then
				-- block empty
			else
				ShowTips(arg_17_0.result)
			end
		end)
	end

	self.tmpSettingData_ = deepClone(self.settingData_)
end

function StorySoundSettingView:CheckDataChange()
	if self.tmpSettingData_ and not table.equal(self.tmpSettingData_, self.settingData_, "all") then
		return true
	end

	return false
end

function StorySoundSettingView:OnSoundSettingChange(arg_19_1, arg_19_2)
	self:RefreshUI()
end

function StorySoundSettingView:OnVoiceLanguageSwitch()
	self:RefreshVoiceLanguage()
end

return StorySoundSettingView
