local SoundSettingView = class("SoundSettingView", ReduxView)

function SoundSettingView:SetActive(arg_1_1)
	if self.gameObject_ then
		SetActive(self.gameObject_, arg_1_1)
	end

	if arg_1_1 then
		self.scrollView_.verticalNormalizedPosition = 1
	end
end

function SoundSettingView:Ctor(arg_2_1, arg_2_2, arg_2_3)
	self.hander_ = arg_2_1
	self.transform_ = arg_2_2.transform
	self.gameObject_ = arg_2_2
	self.info_ = arg_2_3

	self:Init()
end

function SoundSettingView:InitUI()
	self:BindCfgUI()

	self.soundSlider_ = {}
	self.soundText_ = {}
	self.soundCutBtn_ = {}
	self.soundAddBtn_ = {}
	self.fillImg_ = {}

	for iter_3_0 = 1, 3 do
		self.soundSlider_[iter_3_0] = self["slider" .. iter_3_0 .. "Slr_"]
		self.soundText_[iter_3_0] = self["num" .. iter_3_0 .. "Text_"]
		self.soundCutBtn_[iter_3_0] = self["cut" .. iter_3_0 .. "Btn_"]
		self.soundAddBtn_[iter_3_0] = self["add" .. iter_3_0 .. "Btn_"]
		self.fillImg_[iter_3_0] = self["fill" .. iter_3_0 .. "Img_"]
	end

	self:InitTextLanguageOption()
end

function SoundSettingView:AddUIListener()
	for iter_4_0 = 1, 3 do
		self.soundSlider_[iter_4_0].onValueChanged:AddListener(function(arg_5_0)
			self:SetSoundValue(iter_4_0, self.soundSlider_[iter_4_0].value)
		end)
		self:AddPressingByTimeListener(self.soundCutBtn_[iter_4_0].gameObject, 3, 0.5, 0.5, function()
			if self.soundCutBtn_[iter_4_0].interactable and self.soundSlider_[iter_4_0].value > 0 then
				self:SetSoundValue(iter_4_0, self.soundSlider_[iter_4_0].value - 1)

				return true
			end

			return false
		end)
		self:AddPressingByTimeListener(self.soundAddBtn_[iter_4_0].gameObject, 3, 0.5, 0.5, function()
			if self.soundAddBtn_[iter_4_0].interactable and self.soundSlider_[iter_4_0].value < 100 then
				self:SetSoundValue(iter_4_0, self.soundSlider_[iter_4_0].value + 1)

				return true
			end

			return false
		end)

		local var_4_0 = self:GetOrAddComponent(self.soundSlider_[iter_4_0].gameObject, typeof(EventTriggerListener))

		var_4_0:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, LuaHelper.EventTriggerAction1(function()
			OperationRecorder.Record("setting", "setting_audio_slide")
		end))
		self:SetListener(var_4_0)
	end

	self:AddToggleListener(self.switchTeammateTgl_, function(arg_9_0)
		local var_9_0 = 0

		if arg_9_0 then
			var_9_0 = 1
		end

		if self.settingData_.teammate_sound_open ~= var_9_0 then
			SettingAction.ChangeSoundSetting("teammate_sound_open", var_9_0)
		end
	end)
	self:AddToggleListener(self.switchTgl_, function(arg_10_0)
		local var_10_0 = 0

		if arg_10_0 then
			var_10_0 = 1
		end

		if self.settingData_.sound_open ~= var_10_0 then
			SettingAction.ChangeSoundSetting("sound_open", var_10_0)
		end

		self:ChangeVoiceEnable(arg_10_0)
	end)
	self:AddBtnListener(self.packageBtn_, nil, function()
		JumpTools.OpenPageByJump("languagePackage")
	end)
	self:AddBtnListener(self.voiceBtn_, nil, function()
		JumpTools.OpenPageByJump("voiceSwitch")
	end)
	self:AddBtnListener(self.languageBtn_, nil, function()
		JumpTools.OpenPageByJump("languageSwitch")
	end)
end

function SoundSettingView:ChangeVoiceEnable(arg_14_1)
	for iter_14_0 = 1, 3 do
		self.soundSlider_[iter_14_0].interactable = arg_14_1
		self.soundCutBtn_[iter_14_0].interactable = arg_14_1
		self.soundAddBtn_[iter_14_0].interactable = arg_14_1

		manager.effect:SetGrey(self.fillImg_[iter_14_0], not arg_14_1)
	end
end

function SoundSettingView:OnDownloaded(arg_15_1)
	for iter_15_0 = 1, #AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].voice_list do
		if VoiceLanguageCfg[AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].voice_list[iter_15_0]].affix == arg_15_1 then
			SettingAction.ChangeSoundSetting("voice_language", iter_15_0)
		end
	end
end

function SoundSettingView:OnCancalDownload()
	self:RefreshVoiceLanguage()
end

function SoundSettingView:RefreshUI()
	self.soundSlider_[1].value = self.settingData_.music
	self.soundText_[1].text = self.settingData_.music .. "%"
	self.soundSlider_[2].value = self.settingData_.effect
	self.soundText_[2].text = self.settingData_.effect .. "%"
	self.soundSlider_[3].value = self.settingData_.voice
	self.soundText_[3].text = self.settingData_.voice .. "%"

	self:RefreshSoundSwitch()
	self:RefreshVoiceLanguage()
	self:RefreshTextLanguage()
	self:RefreshTeammateSoundSwitch()
end

function SoundSettingView:RefreshTeammateSoundSwitch()
	self.switchTeammateTgl_.isOn = self.settingData_.teammate_sound_open == 1

	self.switchTeammateTgl_.transform:GetComponent("ControllerExCollection"):GetController("default0"):SetSelectedIndex(self.settingData_.teammate_sound_open)
end

function SoundSettingView:RefreshSoundSwitch()
	self.switchTgl_.isOn = self.settingData_.sound_open == 1

	self.switchTgl_.transform:GetComponent("ControllerExCollection"):GetController("default0"):SetSelectedIndex(self.settingData_.sound_open)
end

function SoundSettingView:InitTextLanguageOption()
	if #AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].language_in_list < 2 then
		self.languageBtn_.enabled = false

		SetActive(self.languageIconGo_, false)
	else
		self.languageBtn_.enabled = true

		SetActive(self.languageIconGo_, true)
	end
end

function SoundSettingView:RefreshTextLanguage()
	self.languageText_.text = AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].language_in_list[table.indexof(AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].language_list, self.settingData_.text_language)]
end

function SoundSettingView:RefreshVoiceLanguage()
	self.voiceText_.text = VoiceLanguageCfg[self.settingData_.voice_language].name
end

function SoundSettingView:SetSoundValue(arg_23_1, arg_23_2)
	if arg_23_1 == 1 then
		SettingAction.ChangeSoundSetting("music", arg_23_2)
	elseif arg_23_1 == 2 then
		SettingAction.ChangeSoundSetting("effect", arg_23_2)
	elseif arg_23_1 == 3 then
		SettingAction.ChangeSoundSetting("voice", arg_23_2)
	end
end

function SoundSettingView:CheckDataChange(arg_24_1)
	if self.tmpSettingData_ and not table.equal(self.tmpSettingData_, self.settingData_, "all") then
		return true
	end

	return false
end

function SoundSettingView:SaveData()
	if self:CheckDataChange() then
		self.json_ = require("cjson")

		local var_25_0 = deepClone(self.settingData_)

		var_25_0.type = 2

		SDKTools.SendMessageToSDK("audio_setting", {
			bg_audio_setting = self.settingData_.music,
			effect_setting = self.settingData_.effect,
			sound_setting = self.settingData_.voice,
			language = self.settingData_.voice_language
		})

		local var_25_1 = self.json_.encode(var_25_0)

		manager.net:SendWithLoadingNew(12100, {
			language = self.settingData_.text_language
		}, 12101, function(arg_26_0)
			if isSuccess(arg_26_0.result) then
				-- block empty
			else
				ShowTips(arg_26_0.result)
			end
		end)
	end

	self.tmpSettingData_ = deepClone(self.settingData_)
end

function SoundSettingView:RecoverTmpData()
	if self:CheckDataChange() then
		if not VoicePackageManager.Instance:IsHavePackage(VoiceLanguageCfg[self.tmpSettingData_.voice_language].affix) then
			self.tmpSettingData_.voice_language = self.settingData_.voice_language
		end

		SettingAction.ChangeSoundSetting("allData", self.tmpSettingData_)
	end
end

function SoundSettingView:OnSoundSettingChange(arg_28_1, arg_28_2)
	self:RefreshUI()
end

function SoundSettingView:Init()
	self:InitUI()
	self:AddUIListener()
	self:OnEnter()
end

function SoundSettingView:OnEnter()
	self.settingData_ = SettingData:GetSoundSettingData()

	self:RefreshUI()

	self.tmpSettingData_ = deepClone(self.settingData_)

	local var_30_0 = self.hander_.params_.setType or SettingConst.SETTING_TYPE.SYSTEM

	SetActive(self.languageGo_, var_30_0 == SettingConst.SETTING_TYPE.SYSTEM)
	SetActive(self.voiceGo_, var_30_0 == SettingConst.SETTING_TYPE.SYSTEM)
	SetActive(self.packageGo_, false)
end

function SoundSettingView:OnExit()
	return
end

function SoundSettingView:Dispose()
	self.hander_ = nil

	SoundSettingView.super.Dispose(self)
end

return SoundSettingView
