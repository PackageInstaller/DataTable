local GameSettingView = class("GameSettingView", ReduxView)
local cjson = require("cjson")
local var_0_2 = {
	0,
	3,
	5,
	10
}
local var_0_3 = {
	[0] = 1,
	nil,
	nil,
	2,
	nil,
	3,
	[10] = 4
}

function GameSettingView:SetActive(arg_1_1)
	if self.gameObject_ then
		SetActive(self.gameObject_, arg_1_1)
	end

	if arg_1_1 then
		self.scrollView_.verticalNormalizedPosition = 1
	end
end

function GameSettingView:Ctor(arg_2_1, arg_2_2, arg_2_3)
	self.hander_ = arg_2_1
	self.transform_ = arg_2_2.transform
	self.gameObject_ = arg_2_2
	self.info_ = arg_2_3

	self:Init()
end

function GameSettingView:InitUI()
	self:BindCfgUI()
	self:InitController()
end

function GameSettingView:InitController()
	self.hideMainVoiceSubtitleCtr_ = self.hideMainVoiceSubtitleCtrEx_:GetController("default0")
	self.dlcBtnCtr_ = self.dlcBtnControllerexcollection_:GetController("dlcBtn")
end

function GameSettingView:AddUIListener()
	self.sliderSlr_.onValueChanged:AddListener(function()
		SettingAction.ChangeGameSetting("adapter_value", self.sliderSlr_.value)
	end)
	self:AddPressingByTimeListener(self.cutGo_, 3, 0.5, 0.5, function()
		if self.sliderSlr_.value > 0 then
			SettingAction.ChangeGameSetting("adapter_value", self.sliderSlr_.value - 1)

			return true
		end

		return false
	end)
	self:AddPressingByTimeListener(self.addGo_, 3, 0.5, 0.5, function()
		if self.sliderSlr_.value < 100 then
			SettingAction.ChangeGameSetting("adapter_value", self.sliderSlr_.value + 1)

			return true
		end

		return false
	end)
	self.cursorScaleSlider_.onValueChanged:AddListener(function(arg_9_0)
		LuaForCursor.ResizeCursor(arg_9_0 / self.cursorScaleSlider_.maxValue)
		SettingAction.ChangeGameSetting("cursor_size", arg_9_0)
		PlayerPrefs.SetFloat("PCCursor_CursorScalePercent", arg_9_0 / self.cursorScaleSlider_.maxValue)
	end)
	self:AddPressingByTimeListener(self.cursorScaleSubBtn_, 1, 0.5, 0.1, function()
		if self.cursorScaleSlider_.value > self.cursorScaleSlider_.minValue then
			self.cursorScaleSlider_.value = self.cursorScaleSlider_.value - 1

			return true
		end

		return false
	end)
	self:AddPressingByTimeListener(self.cursorScaleAddBtn_, 1, 0.5, 0.1, function()
		if self.cursorScaleSlider_.value < self.cursorScaleSlider_.maxValue then
			self.cursorScaleSlider_.value = self.cursorScaleSlider_.value + 1

			return true
		end

		return false
	end)

	for iter_5_0 = 1, 3 do
		self:AddToggleListener(self["hitNumberTeammate" .. iter_5_0 .. "Tgl_"], function(arg_12_0)
			if not arg_12_0 then
				return
			end

			if self.settingData_.battle_hit_num_teammate ~= iter_5_0 - 1 then
				SettingAction.ChangeGameSetting("battle_hit_num_teammate", iter_5_0 - 1)
			end
		end)
	end

	for iter_5_1 = 1, 3 do
		self:AddToggleListener(self["hitNumberPlayer" .. iter_5_1 .. "Tgl_"], function(arg_13_0)
			if not arg_13_0 then
				return
			end

			if self.settingData_.battle_hit_num_mine ~= iter_5_1 - 1 then
				SettingAction.ChangeGameSetting("battle_hit_num_mine", iter_5_1 - 1)
			end
		end)
	end

	self:AddToggleListener(self.moveableStickOnTgl_, function(arg_14_0)
		if arg_14_0 and self.settingData_.moveable_stick ~= 1 then
			SettingAction.ChangeGameSetting("moveable_stick", 1)
		end
	end)
	self:AddToggleListener(self.moveableStickOffTgl_, function(arg_15_0)
		if arg_15_0 and self.settingData_.moveable_stick ~= 0 then
			SettingAction.ChangeGameSetting("moveable_stick", 0)
		end
	end)
	self:AddBtnListener(self.lockBtn_, nil, function()
		JumpTools.OpenPageByJump("gameSettingLock", {
			type = self.settingData_.battle_lock_type
		})
	end)
	self:AddBtnListener(self.battlePlayBtn_, nil, function()
		JumpTools.OpenPageByJump("gameSettingBattlePlay", {
			type = self.settingData_.battle_play_type
		})
	end)
	self:AddBtnListener(self.connectBtn_, nil, function()
		JumpTools.OpenPageByJump("gameSettingConnect", {
			type = self.settingData_.cus_full_play_controlled_type
		})
	end)
	self:AddBtnListener(self.hideMainVoiceSubtitleBtn_, nil, function()
		if self.settingData_.hide_main_voice_subtitle ~= (self.settingData_.hide_main_voice_subtitle == 1 and 0 or 1) then
			SettingAction.ChangeGameSetting("hide_main_voice_subtitle", self.settingData_.hide_main_voice_subtitle == 1 and 0 or 1)
		end
	end)

	for iter_5_2 = 1, 2 do
		self:AddToggleListener(self["dlcToggle" .. iter_5_2 .. "Tgl_"], function(arg_20_0)
			if not arg_20_0 then
				return
			end

			SettingAction.ChangeGameSetting("home_scene_dlc_btn", iter_5_2 - 1)
		end)
	end

	self:AddToggleListener(self.m_musicNameTgl_, function(arg_21_0)
		SettingAction.ChangeGameSetting("show_music_name", arg_21_0 and 1 or 0)
	end)

	for iter_5_3 = 1, 4 do
		self:AddBtnListener(self["musicTime" .. iter_5_3 .. "Tgl_"], nil, function()
			if self.settingData_.music_time ~= var_0_2[iter_5_3] then
				SettingAction.ChangeGameSetting("music_time", var_0_2[iter_5_3])
			end
		end)
	end
end

function GameSettingView:RefreshHurtNum()
	if not self.gameObject_.activeSelf then
		for iter_23_0 = 1, 3 do
			self["hitNumberPlayer" .. iter_23_0 .. "Tgl_"].isOn = false
		end
	end

	self["hitNumberPlayer" .. self.settingData_.battle_hit_num_mine + 1 .. "Tgl_"].isOn = true
end

function GameSettingView:RefreshHurtNumMate()
	if not self.gameObject_.activeSelf then
		for iter_24_0 = 1, 3 do
			self["hitNumberTeammate" .. iter_24_0 .. "Tgl_"].isOn = false
		end
	end

	self["hitNumberTeammate" .. self.settingData_.battle_hit_num_teammate + 1 .. "Tgl_"].isOn = true
end

function GameSettingView:RefreshLockType()
	if self.settingData_.battle_lock_type == 0 then
		self.lockText_.text = GetTips("SYSTEM_SETTING_LOCK_1")
	elseif self.settingData_.battle_lock_type == 1 then
		self.lockText_.text = GetTips("SYSTEM_SETTING_LOCK_2")
	elseif self.settingData_.battle_lock_type == 2 then
		self.lockText_.text = GetTips("SYSTEM_SETTING_LOCK_3")
	end
end

function GameSettingView:RefreshBattlePlayType()
	if whereami == "battle" then
		SetActive(self.battlePlayGo_, false)

		return
	end

	SetActive(self.battlePlayGo_, true)

	if self.settingData_.battle_play_type == 2 then
		self.battlePlayText_.text = GetTips("BATTLE_ASSIST_SETTINGS_1")
	elseif self.settingData_.battle_play_type == 1 then
		self.battlePlayText_.text = GetTips("BATTLE_ASSIST_SETTINGS_2")
	elseif self.settingData_.battle_play_type == 0 then
		self.battlePlayText_.text = GetTips("BATTLE_ASSIST_SETTINGS_3")
	end
end

function GameSettingView:RefreshMoveableStick()
	if not self.gameObject_.activeSelf then
		self.moveableStickOnTgl_.isOn = false
		self.moveableStickOffTgl_.isOn = false
	end

	if self.settingData_.moveable_stick and self.settingData_.moveable_stick == 1 then
		self.moveableStickOnTgl_.isOn = true
	else
		self.moveableStickOffTgl_.isOn = true
	end
end

function GameSettingView:RefreshCUSFullPlay()
	if self.settingData_.cus_full_play_controlled_type then
		self.connectText_.text = self.settingData_.cus_full_play_controlled_type == 2 and GetTips("SYSTEM_SETTING_SKILLCHAIN_1") or self.settingData_.cus_full_play_controlled_type == 3 and GetTips("SYSTEM_SETTING_SKILLCHAIN_2") or self.settingData_.cus_full_play_controlled_type == 4 and GetTips("SYSTEM_SETTING_SKILLCHAIN_3") or self.settingData_.cus_full_play_controlled_type == 1 and GetTips("SYSTEM_SETTING_SKILLCHAIN_4") or GetTips("SYSTEM_SETTING_SKILLCHAIN_5")
	end
end

function GameSettingView:RefreshHideMainVoiceSubTitle()
	self.hideMainVoiceSubtitleCtr_:SetSelectedState(self.settingData_.hide_main_voice_subtitle == 1 and "on" or "off")
end

function GameSettingView:RefreshMusicNameTipReminder()
	self.m_musicNameTgl_.isOn = self.settingData_.show_music_name == 1

	self.m_musicNameCon_:GetController("default0"):SetSelectedIndex(self.settingData_.show_music_name)
end

function GameSettingView:RefreshMusicNameShowTime()
	local var_31_0 = self.settingData_.music_time

	for iter_31_0 = 1, 4 do
		SetActive(self[string.format("musicTime%dCheck_", iter_31_0)], var_0_3[var_31_0] == iter_31_0)
	end
end

function GameSettingView:RefreshHideDlcBtn()
	if self["dlcToggle" .. self.settingData_.home_scene_dlc_btn + 1 .. "Tgl_"] then
		self["dlcToggle" .. self.settingData_.home_scene_dlc_btn + 1 .. "Tgl_"].isOn = true
	end
end

function GameSettingView:CheckDataChange(arg_33_1)
	if self.tmpSettingData_ and not table.equal(self.tmpSettingData_, self.settingData_, "all") then
		return true
	end

	return false
end

function GameSettingView:SaveData()
	if self:CheckDataChange() then
		self.json_ = require("cjson")

		local var_34_0 = deepClone(self.settingData_)

		var_34_0.type = 3

		local var_34_1 = self.json_.encode(var_34_0)

		SDKTools.SendMessageToSDK("game_setting", {
			gamepad_setting = 0,
			main_damage_num = self.settingData_.battle_hit_num_mine + 1,
			ass_damage_num = self.settingData_.battle_hit_num_teammate + 1,
			lock_setting = self.settingData_.battle_lock_type + 1,
			ss_screen = self.settingData_.adapter_value,
			combo_skill_setting = SettingConst.COMBO_SKILL[self.settingData_.cus_full_play_controlled_type],
			other_data = {
				cursor_num = self.settingData_.cursor_size,
				talk_setting = self.settingData_.hide_main_voice_subtitle,
				story_music_set = self.settingData_.show_music_name,
				story_music_set_times = self.settingData_.music_time,
				T0skin_scene_change = self.settingData_.home_scene_dlc_btn
			}
		})
	end

	self.tmpSettingData_ = deepClone(self.settingData_)
end

function GameSettingView:RecoverTmpData()
	if self:CheckDataChange() then
		SettingAction.ChangeGameSetting("allData", self.tmpSettingData_)
	end
end

function GameSettingView:RefreshAdapterValue()
	self.sliderSlr_.value = self.settingData_.adapter_value
	ReduxView.VIEW_ADAPT_DISTANCE = self.settingData_.adapter_value
end

function GameSettingView:RefreshCursorSizeValue()
	if GameToSDK.PLATFORM_ID ~= 3 then
		SetActive(self.cursorScalerGo_, false)
	else
		SetActive(self.cursorScalerGo_, true)
	end

	self.cursorScaleSlider_.value = self.settingData_.cursor_size
end

function GameSettingView:OnGameSettingChange(arg_38_1, arg_38_2)
	if arg_38_2.key == "allData" then
		self:RefreshHurtNum()
		self:RefreshHurtNumMate()
		self:RefreshLockType()
		self:RefreshBattlePlayType()
		self:RefreshMoveableStick()
		self:RefreshCUSFullPlay()
		self:RefreshAdapterValue()
		self:RefreshCursorSizeValue()
		self:RefreshHideMainVoiceSubTitle()
		self:RefreshMusicNameTipReminder()
		self:RefreshMusicNameShowTime()
		self:RefreshHideDlcBtn()
	elseif arg_38_2.key == "battle_hit_num_mine" then
		self:RefreshHurtNum()
	elseif arg_38_2.key == "battle_hit_num_teammate" then
		self:RefreshHurtNumMate()
	elseif arg_38_2.key == "battle_lock_type" then
		self:RefreshLockType()
	elseif arg_38_2.key == "battle_play_type" then
		self:RefreshBattlePlayType()
	elseif arg_38_2.key == "adapter_value" then
		self:RefreshAdapterValue()
	elseif arg_38_2.key == "cursor_size" then
		self:RefreshCursorSizeValue()
	elseif arg_38_2.key == "moveable_stick" then
		self:RefreshMoveableStick()
	elseif arg_38_2.key == "cus_full_play_controlled_type" then
		self:RefreshCUSFullPlay()
	elseif arg_38_2.key == "hide_main_voice_subtitle" then
		self:RefreshHideMainVoiceSubTitle()
	elseif arg_38_2.key == "show_music_name" then
		self:RefreshMusicNameTipReminder()
	elseif arg_38_2.key == "music_time" then
		self:RefreshMusicNameShowTime()
	elseif arg_38_2.key == "home_scene_dlc_btn" then
		self:RefreshHideDlcBtn()
	end
end

function GameSettingView:Init()
	self:InitUI()
	self:AddUIListener()
	self:OnEnter()
end

function GameSettingView:OnTop()
	self:RefreshLockType()
	self:RefreshCUSFullPlay()
	self:RefreshBattlePlayType()
end

function GameSettingView:OnEnter()
	self.settingData_ = SettingData:GetGameSettingData()

	self:RefreshHurtNum()
	self:RefreshHurtNumMate()
	self:RefreshLockType()
	self:RefreshBattlePlayType()
	self:RefreshAdapterValue()
	self:RefreshCursorSizeValue()
	self:RefreshMoveableStick()
	self:RefreshCUSFullPlay()
	self:RefreshHideMainVoiceSubTitle()
	self:RefreshMusicNameTipReminder()
	self:RefreshMusicNameShowTime()
	self:RefreshHideDlcBtn()

	self.tmpSettingData_ = deepClone(self.settingData_)

	local var_41_0 = self.info_.setType
	local var_41_1

	if not self.info_.setType then
		var_41_0 = SettingConst.SETTING_TYPE.SYSTEM
		var_41_1 = SetActive
	end

	var_41_1(self.adapterGo_, var_41_0 == SettingConst.SETTING_TYPE.SYSTEM)
	self:BindRedPointUI()

	if getData("GAMESETTING", "DLC_BTN") ~= 1 then
		saveData("GAMESETTING", "DLC_BTN", 1)
		manager.redPoint:setTip(RedPointConst.DLC_BTN_RED, 0)
	end
end

function GameSettingView:BindRedPointUI()
	manager.redPoint:bindUIandKey(self.specialGo_.transform, RedPointConst.DLC_BTN_RED)
end

function GameSettingView:UnBindRedPointUI()
	manager.redPoint:unbindUIandKey(self.specialGo_.transform, RedPointConst.DLC_BTN_RED)
end

function GameSettingView:OnExit()
	self:UnBindRedPointUI()
end

function GameSettingView:Dispose()
	self.hander_ = nil

	GameSettingView.super.Dispose(self)
end

function GameSettingView:OnSoundSettingChange()
	self:RefreshLockType()
	self:RefreshBattlePlayType()
end

return GameSettingView
