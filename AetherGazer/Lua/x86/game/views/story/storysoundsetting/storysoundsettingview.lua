local var_0_0 = class("StorySoundSettingView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Story/StorySoundSettingUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiStory.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.soundMusicView_ = StorySoundSettingItem.New(arg_3_0.soundMusicGo_, "music")
	arg_3_0.soundEffectView_ = StorySoundSettingItem.New(arg_3_0.soundEffectGo_, "effect")
	arg_3_0.soundVoiceView_ = StorySoundSettingItem.New(arg_3_0.soundVoiceGo_, "voice")
	arg_3_0.soundSwitchView_ = StorySoundSettingSwitch.New(arg_3_0.soundSwitchGo_, "sound_open")
	arg_3_0.OnVoiceLanguageSwitchHandler_ = handler(arg_3_0, arg_3_0.OnVoiceLanguageSwitch)
end

function var_0_0.OnEnter(arg_4_0)
	arg_4_0.settingData_ = SettingData:GetSoundSettingData()
	arg_4_0.tmpSettingData_ = deepClone(arg_4_0.settingData_)

	arg_4_0:RefreshUI()
	manager.notify:RegistListener(STORY_SWITCH_VOICE_LANGUAGE, arg_4_0.OnVoiceLanguageSwitchHandler_)
end

function var_0_0.OnTop(arg_5_0)
	SetActive(arg_5_0.gameObject_, true)
end

function var_0_0.OnExit(arg_6_0)
	manager.notify:RemoveListener(STORY_SWITCH_VOICE_LANGUAGE, arg_6_0.OnVoiceLanguageSwitchHandler_)
	arg_6_0:SaveData()
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0.OnVoiceLanguageSwitchHandler_ = nil

	arg_7_0.soundMusicView_:Dispose()

	arg_7_0.soundMusicView_ = nil

	arg_7_0.soundEffectView_:Dispose()

	arg_7_0.soundEffectView_ = nil

	arg_7_0.soundVoiceView_:Dispose()

	arg_7_0.soundVoiceView_ = nil

	arg_7_0.soundSwitchView_:Dispose()

	arg_7_0.soundSwitchView_ = nil

	var_0_0.super.Dispose(arg_7_0)
end

function var_0_0.AddListeners(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.closeBtn_, nil, function()
		local var_9_0 = gameContext:GetAllOpenRoute()

		if #var_9_0 >= 1 and var_9_0[1] == "home" then
			arg_8_0:Back()

			return
		end

		if #gameContext:GetCurHistory() <= 1 then
			SetActive(arg_8_0.gameObject_, false)
		else
			arg_8_0:Back()
		end
	end)
	arg_8_0:AddBtnListener(arg_8_0.languageBtn_, nil, function()
		JumpTools.OpenPageByJump("languageSwitch", {
			needSetParent = true
		})
	end)
	arg_8_0:AddBtnListener(arg_8_0.voiceBtn_, nil, function()
		JumpTools.OpenPageByJump("storyVoiceSwitch", {
			needSetParent = true,
			voiceLanguage = SettingData:GetStoryVoiceLanguageCache()
		})
	end)
	arg_8_0:AddBtnListener(arg_8_0.packageBtn_, nil, function()
		JumpTools.OpenPageByJump("languagePackage", {
			needSetParent = true
		})
	end)
end

function var_0_0.RefreshUI(arg_13_0)
	arg_13_0.soundMusicView_:SetData(arg_13_0.settingData_.music, arg_13_0.settingData_.sound_open == 1)
	arg_13_0.soundEffectView_:SetData(arg_13_0.settingData_.effect, arg_13_0.settingData_.sound_open == 1)
	arg_13_0.soundVoiceView_:SetData(arg_13_0.settingData_.voice, arg_13_0.settingData_.sound_open == 1)
	arg_13_0.soundSwitchView_:SetData(arg_13_0.settingData_.sound_open == 1)
	arg_13_0:RefreshVoiceLanguage()
	arg_13_0:RefreshTextLanguage()
end

function var_0_0.RefreshVoiceLanguage(arg_14_0)
	local var_14_0 = AreaDifferenceCfg[GameToSDK.CURRENT_SERVER]

	arg_14_0.voiceText_.text = VoiceLanguageCfg[SettingData:GetStoryVoiceLanguageCache()].name
end

function var_0_0.RefreshTextLanguage(arg_15_0)
	local var_15_0 = AreaDifferenceCfg[GameToSDK.CURRENT_SERVER]

	arg_15_0.languageText_.text = var_15_0.language_in_list[table.indexof(var_15_0.language_list, arg_15_0.settingData_.text_language)]
end

function var_0_0.SaveData(arg_16_0)
	if arg_16_0:CheckDataChange() then
		SDKTools.SendMessageToSDK("audio_setting", {
			bg_audio_setting = arg_16_0.settingData_.music,
			effect_setting = arg_16_0.settingData_.effect,
			sound_setting = arg_16_0.settingData_.voice,
			language = arg_16_0.settingData_.voice_language
		})
		manager.net:SendWithLoadingNew(12100, {
			language = arg_16_0.settingData_.text_language
		}, 12101, function(arg_17_0)
			if isSuccess(arg_17_0.result) then
				-- block empty
			else
				ShowTips(arg_17_0.result)
			end
		end)
	end

	arg_16_0.tmpSettingData_ = deepClone(arg_16_0.settingData_)
end

function var_0_0.CheckDataChange(arg_18_0)
	if arg_18_0.tmpSettingData_ and not table.equal(arg_18_0.tmpSettingData_, arg_18_0.settingData_, "all") then
		return true
	end

	return false
end

function var_0_0.OnSoundSettingChange(arg_19_0, arg_19_1, arg_19_2)
	arg_19_0:RefreshUI()
end

function var_0_0.OnVoiceLanguageSwitch(arg_20_0)
	arg_20_0:RefreshVoiceLanguage()
end

return var_0_0
