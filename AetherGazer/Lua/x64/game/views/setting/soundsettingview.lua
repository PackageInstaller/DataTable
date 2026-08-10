local var_0_0 = class("SoundSettingView", ReduxView)

function var_0_0.SetActive(arg_1_0, arg_1_1)
	if arg_1_0.gameObject_ then
		SetActive(arg_1_0.gameObject_, arg_1_1)
	end

	if arg_1_1 then
		arg_1_0.scrollView_.verticalNormalizedPosition = 1
	end
end

function var_0_0.Ctor(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.hander_ = arg_2_1
	arg_2_0.transform_ = arg_2_2.transform
	arg_2_0.gameObject_ = arg_2_2
	arg_2_0.info_ = arg_2_3

	arg_2_0:Init()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.soundSlider_ = {}
	arg_3_0.soundText_ = {}
	arg_3_0.soundCutBtn_ = {}
	arg_3_0.soundAddBtn_ = {}
	arg_3_0.fillImg_ = {}

	for iter_3_0 = 1, 3 do
		arg_3_0.soundSlider_[iter_3_0] = arg_3_0["slider" .. iter_3_0 .. "Slr_"]
		arg_3_0.soundText_[iter_3_0] = arg_3_0["num" .. iter_3_0 .. "Text_"]
		arg_3_0.soundCutBtn_[iter_3_0] = arg_3_0["cut" .. iter_3_0 .. "Btn_"]
		arg_3_0.soundAddBtn_[iter_3_0] = arg_3_0["add" .. iter_3_0 .. "Btn_"]
		arg_3_0.fillImg_[iter_3_0] = arg_3_0["fill" .. iter_3_0 .. "Img_"]
	end

	arg_3_0:InitTextLanguageOption()
end

function var_0_0.AddUIListener(arg_4_0)
	for iter_4_0 = 1, 3 do
		arg_4_0.soundSlider_[iter_4_0].onValueChanged:AddListener(function(arg_5_0)
			arg_4_0:SetSoundValue(iter_4_0, arg_4_0.soundSlider_[iter_4_0].value)
		end)
		arg_4_0:AddPressingByTimeListener(arg_4_0.soundCutBtn_[iter_4_0].gameObject, 3, 0.5, 0.5, function()
			if arg_4_0.soundCutBtn_[iter_4_0].interactable and arg_4_0.soundSlider_[iter_4_0].value > 0 then
				local var_6_0 = arg_4_0.soundSlider_[iter_4_0].value - 1

				arg_4_0:SetSoundValue(iter_4_0, var_6_0)

				return true
			end

			return false
		end)
		arg_4_0:AddPressingByTimeListener(arg_4_0.soundAddBtn_[iter_4_0].gameObject, 3, 0.5, 0.5, function()
			if arg_4_0.soundAddBtn_[iter_4_0].interactable and arg_4_0.soundSlider_[iter_4_0].value < 100 then
				local var_7_0 = arg_4_0.soundSlider_[iter_4_0].value + 1

				arg_4_0:SetSoundValue(iter_4_0, var_7_0)

				return true
			end

			return false
		end)

		local var_4_0 = arg_4_0:GetOrAddComponent(arg_4_0.soundSlider_[iter_4_0].gameObject, typeof(EventTriggerListener))

		var_4_0:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function()
			OperationRecorder.Record("setting", "setting_audio_slide")
		end))
		arg_4_0:SetListener(var_4_0)
	end

	arg_4_0:AddToggleListener(arg_4_0.switchTeammateTgl_, function(arg_9_0)
		local var_9_0 = 0

		if arg_9_0 then
			var_9_0 = 1
		end

		if arg_4_0.settingData_.teammate_sound_open ~= var_9_0 then
			SettingAction.ChangeSoundSetting("teammate_sound_open", var_9_0)
		end
	end)
	arg_4_0:AddToggleListener(arg_4_0.switchTgl_, function(arg_10_0)
		local var_10_0 = 0

		if arg_10_0 then
			var_10_0 = 1
		end

		if arg_4_0.settingData_.sound_open ~= var_10_0 then
			SettingAction.ChangeSoundSetting("sound_open", var_10_0)
		end

		arg_4_0:ChangeVoiceEnable(arg_10_0)
	end)
	arg_4_0:AddBtnListener(arg_4_0.packageBtn_, nil, function()
		JumpTools.OpenPageByJump("languagePackage")
	end)
	arg_4_0:AddBtnListener(arg_4_0.voiceBtn_, nil, function()
		JumpTools.OpenPageByJump("voiceSwitch")
	end)
	arg_4_0:AddBtnListener(arg_4_0.languageBtn_, nil, function()
		JumpTools.OpenPageByJump("languageSwitch")
	end)
end

function var_0_0.ChangeVoiceEnable(arg_14_0, arg_14_1)
	for iter_14_0 = 1, 3 do
		arg_14_0.soundSlider_[iter_14_0].interactable = arg_14_1
		arg_14_0.soundCutBtn_[iter_14_0].interactable = arg_14_1
		arg_14_0.soundAddBtn_[iter_14_0].interactable = arg_14_1

		manager.effect:SetGrey(arg_14_0.fillImg_[iter_14_0], not arg_14_1)
	end
end

function var_0_0.OnDownloaded(arg_15_0, arg_15_1)
	local var_15_0 = AreaDifferenceCfg[GameToSDK.CURRENT_SERVER]
	local var_15_1 = #var_15_0.voice_list

	for iter_15_0 = 1, var_15_1 do
		local var_15_2 = var_15_0.voice_list[iter_15_0]

		if VoiceLanguageCfg[var_15_2].affix == arg_15_1 then
			SettingAction.ChangeSoundSetting("voice_language", iter_15_0)
		end
	end
end

function var_0_0.OnCancalDownload(arg_16_0)
	arg_16_0:RefreshVoiceLanguage()
end

function var_0_0.RefreshUI(arg_17_0)
	arg_17_0.soundSlider_[1].value = arg_17_0.settingData_.music
	arg_17_0.soundText_[1].text = arg_17_0.settingData_.music .. "%"
	arg_17_0.soundSlider_[2].value = arg_17_0.settingData_.effect
	arg_17_0.soundText_[2].text = arg_17_0.settingData_.effect .. "%"
	arg_17_0.soundSlider_[3].value = arg_17_0.settingData_.voice
	arg_17_0.soundText_[3].text = arg_17_0.settingData_.voice .. "%"

	arg_17_0:RefreshSoundSwitch()
	arg_17_0:RefreshVoiceLanguage()
	arg_17_0:RefreshTextLanguage()
	arg_17_0:RefreshTeammateSoundSwitch()
end

function var_0_0.RefreshTeammateSoundSwitch(arg_18_0)
	local var_18_0 = arg_18_0.settingData_.teammate_sound_open
	local var_18_1 = arg_18_0.switchTeammateTgl_.transform:GetComponent("ControllerExCollection"):GetController("default0")

	arg_18_0.switchTeammateTgl_.isOn = var_18_0 == 1

	var_18_1:SetSelectedIndex(var_18_0)
end

function var_0_0.RefreshSoundSwitch(arg_19_0)
	local var_19_0 = arg_19_0.settingData_.sound_open
	local var_19_1 = arg_19_0.switchTgl_.transform:GetComponent("ControllerExCollection"):GetController("default0")

	arg_19_0.switchTgl_.isOn = var_19_0 == 1

	var_19_1:SetSelectedIndex(var_19_0)
end

function var_0_0.InitTextLanguageOption(arg_20_0)
	if #AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].language_in_list < 2 then
		arg_20_0.languageBtn_.enabled = false

		SetActive(arg_20_0.languageIconGo_, false)
	else
		arg_20_0.languageBtn_.enabled = true

		SetActive(arg_20_0.languageIconGo_, true)
	end
end

function var_0_0.RefreshTextLanguage(arg_21_0)
	local var_21_0 = AreaDifferenceCfg[GameToSDK.CURRENT_SERVER]

	arg_21_0.languageText_.text = var_21_0.language_in_list[table.indexof(var_21_0.language_list, arg_21_0.settingData_.text_language)]
end

function var_0_0.RefreshVoiceLanguage(arg_22_0)
	local var_22_0 = AreaDifferenceCfg[GameToSDK.CURRENT_SERVER]

	arg_22_0.voiceText_.text = VoiceLanguageCfg[arg_22_0.settingData_.voice_language].name
end

function var_0_0.SetSoundValue(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_1 == 1 then
		SettingAction.ChangeSoundSetting("music", arg_23_2)
	elseif arg_23_1 == 2 then
		SettingAction.ChangeSoundSetting("effect", arg_23_2)
	elseif arg_23_1 == 3 then
		SettingAction.ChangeSoundSetting("voice", arg_23_2)
	end
end

function var_0_0.CheckDataChange(arg_24_0, arg_24_1)
	if arg_24_0.tmpSettingData_ and not table.equal(arg_24_0.tmpSettingData_, arg_24_0.settingData_, "all") then
		return true
	end

	return false
end

function var_0_0.SaveData(arg_25_0)
	if arg_25_0:CheckDataChange() then
		arg_25_0.json_ = require("cjson")

		local var_25_0 = deepClone(arg_25_0.settingData_)

		var_25_0.type = 2

		SDKTools.SendMessageToSDK("audio_setting", {
			bg_audio_setting = arg_25_0.settingData_.music,
			effect_setting = arg_25_0.settingData_.effect,
			sound_setting = arg_25_0.settingData_.voice,
			language = arg_25_0.settingData_.voice_language
		})

		local var_25_1 = arg_25_0.json_.encode(var_25_0)

		manager.net:SendWithLoadingNew(12100, {
			language = arg_25_0.settingData_.text_language
		}, 12101, function(arg_26_0)
			if isSuccess(arg_26_0.result) then
				-- block empty
			else
				ShowTips(arg_26_0.result)
			end
		end)
	end

	arg_25_0.tmpSettingData_ = deepClone(arg_25_0.settingData_)
end

function var_0_0.RecoverTmpData(arg_27_0)
	if arg_27_0:CheckDataChange() then
		local var_27_0 = VoiceLanguageCfg[arg_27_0.tmpSettingData_.voice_language]

		if not VoicePackageManager.Instance:IsHavePackage(var_27_0.affix) then
			arg_27_0.tmpSettingData_.voice_language = arg_27_0.settingData_.voice_language
		end

		SettingAction.ChangeSoundSetting("allData", arg_27_0.tmpSettingData_)
	end
end

function var_0_0.OnSoundSettingChange(arg_28_0, arg_28_1, arg_28_2)
	arg_28_0:RefreshUI()
end

function var_0_0.Init(arg_29_0)
	arg_29_0:InitUI()
	arg_29_0:AddUIListener()
	arg_29_0:OnEnter()
end

function var_0_0.OnEnter(arg_30_0)
	arg_30_0.settingData_ = SettingData:GetSoundSettingData()

	arg_30_0:RefreshUI()

	arg_30_0.tmpSettingData_ = deepClone(arg_30_0.settingData_)

	local var_30_0 = arg_30_0.hander_.params_.setType or SettingConst.SETTING_TYPE.SYSTEM

	SetActive(arg_30_0.languageGo_, var_30_0 == SettingConst.SETTING_TYPE.SYSTEM)
	SetActive(arg_30_0.voiceGo_, var_30_0 == SettingConst.SETTING_TYPE.SYSTEM)
	SetActive(arg_30_0.packageGo_, false)
end

function var_0_0.OnExit(arg_31_0)
	return
end

function var_0_0.Dispose(arg_32_0)
	arg_32_0.hander_ = nil

	var_0_0.super.Dispose(arg_32_0)
end

return var_0_0
