local var_0_0 = class("GameSettingView", ReduxView)
local var_0_1 = require("cjson")
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
	arg_3_0:InitController()
end

function var_0_0.InitController(arg_4_0)
	arg_4_0.hideMainVoiceSubtitleCtr_ = arg_4_0.hideMainVoiceSubtitleCtrEx_:GetController("default0")
	arg_4_0.dlcBtnCtr_ = arg_4_0.dlcBtnControllerexcollection_:GetController("dlcBtn")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0.sliderSlr_.onValueChanged:AddListener(function()
		SettingAction.ChangeGameSetting("adapter_value", arg_5_0.sliderSlr_.value)
	end)
	arg_5_0:AddPressingByTimeListener(arg_5_0.cutGo_, 3, 0.5, 0.5, function()
		if arg_5_0.sliderSlr_.value > 0 then
			local var_7_0 = arg_5_0.sliderSlr_.value - 1

			SettingAction.ChangeGameSetting("adapter_value", var_7_0)

			return true
		end

		return false
	end)
	arg_5_0:AddPressingByTimeListener(arg_5_0.addGo_, 3, 0.5, 0.5, function()
		if arg_5_0.sliderSlr_.value < 100 then
			local var_8_0 = arg_5_0.sliderSlr_.value + 1

			SettingAction.ChangeGameSetting("adapter_value", var_8_0)

			return true
		end

		return false
	end)
	arg_5_0.cursorScaleSlider_.onValueChanged:AddListener(function(arg_9_0)
		local var_9_0 = arg_9_0 / arg_5_0.cursorScaleSlider_.maxValue

		LuaForCursor.ResizeCursor(var_9_0)
		SettingAction.ChangeGameSetting("cursor_size", arg_9_0)
		PlayerPrefs.SetFloat("PCCursor_CursorScalePercent", var_9_0)
	end)
	arg_5_0:AddPressingByTimeListener(arg_5_0.cursorScaleSubBtn_, 1, 0.5, 0.1, function()
		if arg_5_0.cursorScaleSlider_.value > arg_5_0.cursorScaleSlider_.minValue then
			arg_5_0.cursorScaleSlider_.value = arg_5_0.cursorScaleSlider_.value - 1

			return true
		end

		return false
	end)
	arg_5_0:AddPressingByTimeListener(arg_5_0.cursorScaleAddBtn_, 1, 0.5, 0.1, function()
		if arg_5_0.cursorScaleSlider_.value < arg_5_0.cursorScaleSlider_.maxValue then
			arg_5_0.cursorScaleSlider_.value = arg_5_0.cursorScaleSlider_.value + 1

			return true
		end

		return false
	end)

	for iter_5_0 = 1, 3 do
		arg_5_0:AddToggleListener(arg_5_0["hitNumberTeammate" .. iter_5_0 .. "Tgl_"], function(arg_12_0)
			if not arg_12_0 then
				return
			end

			if arg_5_0.settingData_.battle_hit_num_teammate ~= iter_5_0 - 1 then
				SettingAction.ChangeGameSetting("battle_hit_num_teammate", iter_5_0 - 1)
			end
		end)
	end

	for iter_5_1 = 1, 3 do
		arg_5_0:AddToggleListener(arg_5_0["hitNumberPlayer" .. iter_5_1 .. "Tgl_"], function(arg_13_0)
			if not arg_13_0 then
				return
			end

			if arg_5_0.settingData_.battle_hit_num_mine ~= iter_5_1 - 1 then
				SettingAction.ChangeGameSetting("battle_hit_num_mine", iter_5_1 - 1)
			end
		end)
	end

	arg_5_0:AddToggleListener(arg_5_0.moveableStickOnTgl_, function(arg_14_0)
		if arg_14_0 and arg_5_0.settingData_.moveable_stick ~= 1 then
			SettingAction.ChangeGameSetting("moveable_stick", 1)
		end
	end)
	arg_5_0:AddToggleListener(arg_5_0.moveableStickOffTgl_, function(arg_15_0)
		if arg_15_0 and arg_5_0.settingData_.moveable_stick ~= 0 then
			SettingAction.ChangeGameSetting("moveable_stick", 0)
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.lockBtn_, nil, function()
		JumpTools.OpenPageByJump("gameSettingLock", {
			type = arg_5_0.settingData_.battle_lock_type
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.battlePlayBtn_, nil, function()
		JumpTools.OpenPageByJump("gameSettingBattlePlay", {
			type = arg_5_0.settingData_.battle_play_type
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.connectBtn_, nil, function()
		JumpTools.OpenPageByJump("gameSettingConnect", {
			type = arg_5_0.settingData_.cus_full_play_controlled_type
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.hideMainVoiceSubtitleBtn_, nil, function()
		local var_19_0 = arg_5_0.settingData_.hide_main_voice_subtitle == 1 and 0 or 1

		if arg_5_0.settingData_.hide_main_voice_subtitle ~= var_19_0 then
			SettingAction.ChangeGameSetting("hide_main_voice_subtitle", var_19_0)
		end
	end)

	for iter_5_2 = 1, 2 do
		arg_5_0:AddToggleListener(arg_5_0["dlcToggle" .. iter_5_2 .. "Tgl_"], function(arg_20_0)
			if not arg_20_0 then
				return
			end

			SettingAction.ChangeGameSetting("home_scene_dlc_btn", iter_5_2 - 1)
		end)
	end

	arg_5_0:AddToggleListener(arg_5_0.m_musicNameTgl_, function(arg_21_0)
		local var_21_0
		local var_21_1 = arg_21_0 and 1 or 0

		SettingAction.ChangeGameSetting("show_music_name", var_21_1)
	end)

	for iter_5_3 = 1, 4 do
		arg_5_0:AddBtnListener(arg_5_0["musicTime" .. iter_5_3 .. "Tgl_"], nil, function()
			if arg_5_0.settingData_.music_time ~= var_0_2[iter_5_3] then
				SettingAction.ChangeGameSetting("music_time", var_0_2[iter_5_3])
			end
		end)
	end
end

function var_0_0.RefreshHurtNum(arg_23_0)
	if not arg_23_0.gameObject_.activeSelf then
		for iter_23_0 = 1, 3 do
			arg_23_0["hitNumberPlayer" .. iter_23_0 .. "Tgl_"].isOn = false
		end
	end

	arg_23_0["hitNumberPlayer" .. arg_23_0.settingData_.battle_hit_num_mine + 1 .. "Tgl_"].isOn = true
end

function var_0_0.RefreshHurtNumMate(arg_24_0)
	if not arg_24_0.gameObject_.activeSelf then
		for iter_24_0 = 1, 3 do
			arg_24_0["hitNumberTeammate" .. iter_24_0 .. "Tgl_"].isOn = false
		end
	end

	arg_24_0["hitNumberTeammate" .. arg_24_0.settingData_.battle_hit_num_teammate + 1 .. "Tgl_"].isOn = true
end

function var_0_0.RefreshLockType(arg_25_0)
	local var_25_0 = arg_25_0.settingData_.battle_lock_type

	if var_25_0 == 0 then
		arg_25_0.lockText_.text = GetTips("SYSTEM_SETTING_LOCK_1")
	elseif var_25_0 == 1 then
		arg_25_0.lockText_.text = GetTips("SYSTEM_SETTING_LOCK_2")
	elseif var_25_0 == 2 then
		arg_25_0.lockText_.text = GetTips("SYSTEM_SETTING_LOCK_3")
	end
end

function var_0_0.RefreshBattlePlayType(arg_26_0)
	if whereami == "battle" then
		SetActive(arg_26_0.battlePlayGo_, false)

		return
	end

	SetActive(arg_26_0.battlePlayGo_, true)

	local var_26_0 = arg_26_0.settingData_.battle_play_type

	if var_26_0 == 2 then
		arg_26_0.battlePlayText_.text = GetTips("BATTLE_ASSIST_SETTINGS_1")
	elseif var_26_0 == 1 then
		arg_26_0.battlePlayText_.text = GetTips("BATTLE_ASSIST_SETTINGS_2")
	elseif var_26_0 == 0 then
		arg_26_0.battlePlayText_.text = GetTips("BATTLE_ASSIST_SETTINGS_3")
	end
end

function var_0_0.RefreshMoveableStick(arg_27_0)
	if not arg_27_0.gameObject_.activeSelf then
		arg_27_0.moveableStickOnTgl_.isOn = false
		arg_27_0.moveableStickOffTgl_.isOn = false
	end

	local var_27_0 = arg_27_0.settingData_.moveable_stick

	if var_27_0 and var_27_0 == 1 then
		arg_27_0.moveableStickOnTgl_.isOn = true
	else
		arg_27_0.moveableStickOffTgl_.isOn = true
	end
end

function var_0_0.RefreshCUSFullPlay(arg_28_0)
	local var_28_0 = arg_28_0.settingData_.cus_full_play_controlled_type

	if var_28_0 then
		if var_28_0 == 2 then
			arg_28_0.connectText_.text = GetTips("SYSTEM_SETTING_SKILLCHAIN_1")
		elseif var_28_0 == 3 then
			arg_28_0.connectText_.text = GetTips("SYSTEM_SETTING_SKILLCHAIN_2")
		elseif var_28_0 == 4 then
			arg_28_0.connectText_.text = GetTips("SYSTEM_SETTING_SKILLCHAIN_3")
		elseif var_28_0 == 1 then
			arg_28_0.connectText_.text = GetTips("SYSTEM_SETTING_SKILLCHAIN_4")
		else
			arg_28_0.connectText_.text = GetTips("SYSTEM_SETTING_SKILLCHAIN_5")
		end
	end
end

function var_0_0.RefreshHideMainVoiceSubTitle(arg_29_0)
	local var_29_0 = arg_29_0.settingData_.hide_main_voice_subtitle == 1

	arg_29_0.hideMainVoiceSubtitleCtr_:SetSelectedState(var_29_0 and "on" or "off")
end

function var_0_0.RefreshMusicNameTipReminder(arg_30_0)
	local var_30_0 = arg_30_0.settingData_.show_music_name == 1

	arg_30_0.m_musicNameTgl_.isOn = var_30_0

	arg_30_0.m_musicNameCon_:GetController("default0"):SetSelectedIndex(arg_30_0.settingData_.show_music_name)
end

function var_0_0.RefreshMusicNameShowTime(arg_31_0)
	local var_31_0 = arg_31_0.settingData_.music_time

	for iter_31_0 = 1, 4 do
		SetActive(arg_31_0[string.format("musicTime%dCheck_", iter_31_0)], var_0_3[var_31_0] == iter_31_0)
	end
end

function var_0_0.RefreshHideDlcBtn(arg_32_0)
	local var_32_0 = arg_32_0.settingData_.home_scene_dlc_btn + 1
	local var_32_1 = "dlcToggle" .. var_32_0 .. "Tgl_"

	if arg_32_0[var_32_1] then
		arg_32_0[var_32_1].isOn = true
	end
end

function var_0_0.CheckDataChange(arg_33_0, arg_33_1)
	if arg_33_0.tmpSettingData_ and not table.equal(arg_33_0.tmpSettingData_, arg_33_0.settingData_, "all") then
		return true
	end

	return false
end

function var_0_0.SaveData(arg_34_0)
	if arg_34_0:CheckDataChange() then
		arg_34_0.json_ = require("cjson")

		local var_34_0 = deepClone(arg_34_0.settingData_)

		var_34_0.type = 3

		local var_34_1 = arg_34_0.json_.encode(var_34_0)
		local var_34_2 = {
			cursor_num = arg_34_0.settingData_.cursor_size,
			talk_setting = arg_34_0.settingData_.hide_main_voice_subtitle,
			story_music_set = arg_34_0.settingData_.show_music_name,
			story_music_set_times = arg_34_0.settingData_.music_time,
			T0skin_scene_change = arg_34_0.settingData_.home_scene_dlc_btn
		}

		SDKTools.SendMessageToSDK("game_setting", {
			gamepad_setting = 0,
			main_damage_num = arg_34_0.settingData_.battle_hit_num_mine + 1,
			ass_damage_num = arg_34_0.settingData_.battle_hit_num_teammate + 1,
			lock_setting = arg_34_0.settingData_.battle_lock_type + 1,
			ss_screen = arg_34_0.settingData_.adapter_value,
			combo_skill_setting = SettingConst.COMBO_SKILL[arg_34_0.settingData_.cus_full_play_controlled_type],
			other_data = var_34_2
		})
	end

	arg_34_0.tmpSettingData_ = deepClone(arg_34_0.settingData_)
end

function var_0_0.RecoverTmpData(arg_35_0)
	if arg_35_0:CheckDataChange() then
		SettingAction.ChangeGameSetting("allData", arg_35_0.tmpSettingData_)
	end
end

function var_0_0.RefreshAdapterValue(arg_36_0)
	local var_36_0 = arg_36_0.settingData_.adapter_value

	arg_36_0.sliderSlr_.value = var_36_0
	ReduxView.VIEW_ADAPT_DISTANCE = arg_36_0.settingData_.adapter_value
end

function var_0_0.RefreshCursorSizeValue(arg_37_0)
	if GameToSDK.PLATFORM_ID ~= 3 then
		SetActive(arg_37_0.cursorScalerGo_, false)
	else
		SetActive(arg_37_0.cursorScalerGo_, true)
	end

	local var_37_0 = arg_37_0.settingData_.cursor_size

	arg_37_0.cursorScaleSlider_.value = var_37_0
end

function var_0_0.OnGameSettingChange(arg_38_0, arg_38_1, arg_38_2)
	if arg_38_2.key == "allData" then
		arg_38_0:RefreshHurtNum()
		arg_38_0:RefreshHurtNumMate()
		arg_38_0:RefreshLockType()
		arg_38_0:RefreshBattlePlayType()
		arg_38_0:RefreshMoveableStick()
		arg_38_0:RefreshCUSFullPlay()
		arg_38_0:RefreshAdapterValue()
		arg_38_0:RefreshCursorSizeValue()
		arg_38_0:RefreshHideMainVoiceSubTitle()
		arg_38_0:RefreshMusicNameTipReminder()
		arg_38_0:RefreshMusicNameShowTime()
		arg_38_0:RefreshHideDlcBtn()
	elseif arg_38_2.key == "battle_hit_num_mine" then
		arg_38_0:RefreshHurtNum()
	elseif arg_38_2.key == "battle_hit_num_teammate" then
		arg_38_0:RefreshHurtNumMate()
	elseif arg_38_2.key == "battle_lock_type" then
		arg_38_0:RefreshLockType()
	elseif arg_38_2.key == "battle_play_type" then
		arg_38_0:RefreshBattlePlayType()
	elseif arg_38_2.key == "adapter_value" then
		arg_38_0:RefreshAdapterValue()
	elseif arg_38_2.key == "cursor_size" then
		arg_38_0:RefreshCursorSizeValue()
	elseif arg_38_2.key == "moveable_stick" then
		arg_38_0:RefreshMoveableStick()
	elseif arg_38_2.key == "cus_full_play_controlled_type" then
		arg_38_0:RefreshCUSFullPlay()
	elseif arg_38_2.key == "hide_main_voice_subtitle" then
		arg_38_0:RefreshHideMainVoiceSubTitle()
	elseif arg_38_2.key == "show_music_name" then
		arg_38_0:RefreshMusicNameTipReminder()
	elseif arg_38_2.key == "music_time" then
		arg_38_0:RefreshMusicNameShowTime()
	elseif arg_38_2.key == "home_scene_dlc_btn" then
		arg_38_0:RefreshHideDlcBtn()
	end
end

function var_0_0.Init(arg_39_0)
	arg_39_0:InitUI()
	arg_39_0:AddUIListener()
	arg_39_0:OnEnter()
end

function var_0_0.OnTop(arg_40_0)
	arg_40_0:RefreshLockType()
	arg_40_0:RefreshCUSFullPlay()
	arg_40_0:RefreshBattlePlayType()
end

function var_0_0.OnEnter(arg_41_0)
	arg_41_0.settingData_ = SettingData:GetGameSettingData()

	arg_41_0:RefreshHurtNum()
	arg_41_0:RefreshHurtNumMate()
	arg_41_0:RefreshLockType()
	arg_41_0:RefreshBattlePlayType()
	arg_41_0:RefreshAdapterValue()
	arg_41_0:RefreshCursorSizeValue()
	arg_41_0:RefreshMoveableStick()
	arg_41_0:RefreshCUSFullPlay()
	arg_41_0:RefreshHideMainVoiceSubTitle()
	arg_41_0:RefreshMusicNameTipReminder()
	arg_41_0:RefreshMusicNameShowTime()
	arg_41_0:RefreshHideDlcBtn()

	arg_41_0.tmpSettingData_ = deepClone(arg_41_0.settingData_)

	local var_41_0 = (arg_41_0.info_.setType or SettingConst.SETTING_TYPE.SYSTEM) == SettingConst.SETTING_TYPE.SYSTEM

	SetActive(arg_41_0.adapterGo_, var_41_0)
	arg_41_0:BindRedPointUI()

	if getData("GAMESETTING", "DLC_BTN") ~= 1 then
		saveData("GAMESETTING", "DLC_BTN", 1)
		manager.redPoint:setTip(RedPointConst.DLC_BTN_RED, 0)
	end
end

function var_0_0.BindRedPointUI(arg_42_0)
	manager.redPoint:bindUIandKey(arg_42_0.specialGo_.transform, RedPointConst.DLC_BTN_RED)
end

function var_0_0.UnBindRedPointUI(arg_43_0)
	manager.redPoint:unbindUIandKey(arg_43_0.specialGo_.transform, RedPointConst.DLC_BTN_RED)
end

function var_0_0.OnExit(arg_44_0)
	arg_44_0:UnBindRedPointUI()
end

function var_0_0.Dispose(arg_45_0)
	arg_45_0.hander_ = nil

	var_0_0.super.Dispose(arg_45_0)
end

function var_0_0.OnSoundSettingChange(arg_46_0)
	arg_46_0:RefreshLockType()
	arg_46_0:RefreshBattlePlayType()
end

return var_0_0
