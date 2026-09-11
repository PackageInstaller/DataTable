return {
	GetMainUIName = function(arg_1_0)
		local var_1_0 = ActivityTools.GetActivityTheme(arg_1_0)

		if ActivityRaceTrialUICfg[var_1_0] then
			return ActivityRaceTrialUICfg[var_1_0].main_ui_path
		else
			Debug.Log(string.format("<color=ff0000>ActivityRaceTrialUICfg has no theme(%d)</color>", var_1_0))

			return "UI/VersionUI/OsirisUI/OsirisUITrialUI"
		end
	end,
	GetFirstRewardPopUIName = function(arg_2_0)
		local var_2_0 = ActivityTools.GetActivityTheme(arg_2_0)

		if ActivityRaceTrialUICfg[var_2_0] then
			return ActivityRaceTrialUICfg[var_2_0].first_reward_pop_ui_path
		else
			Debug.Log(string.format("<color=ff0000>ActivityRaceTrialUICfg has no theme(%d)</color>", var_2_0))

			return "UI/VolumeIIIDownUI/RaceTrial/VolumeIIIRaceTrialFirstRewardUI"
		end
	end,
	GetScoreRewardUIName = function(arg_3_0)
		local var_3_0 = ActivityTools.GetActivityTheme(arg_3_0)

		if ActivityRaceTrialUICfg[var_3_0] then
			return ActivityRaceTrialUICfg[var_3_0].score_reward_ui_path
		else
			Debug.Log(string.format("<color=ff0000>ActivityRaceTrialUICfg has no theme(%d)</color>", var_3_0))

			return "UI/VolumeIIIDownUI/RaceTrial/VolumeIIIRaceTrialScoreRewardUI"
		end
	end,
	GetReadyUIName = function(arg_4_0)
		local var_4_0 = ActivityTools.GetActivityTheme(arg_4_0)

		if ActivityRaceTrialUICfg[var_4_0] then
			return ActivityRaceTrialUICfg[var_4_0].ready_ui_path
		else
			Debug.Log(string.format("<color=ff0000>ActivityRaceTrialUICfg has no theme(%d)</color>", var_4_0))

			return "UI/VolumeIIIDownUI/RaceTrial/VolumeIIIDownRaceTrialSelectAffixUI"
		end
	end,
	GetPageUIName = function(arg_5_0)
		local var_5_0 = ActivityTools.GetActivityTheme(arg_5_0)

		if ActivityRaceTrialUICfg[var_5_0] then
			return ActivityRaceTrialUICfg[var_5_0].page_ui_path
		else
			Debug.Log(string.format("<color=ff0000>ActivityRaceTrialUICfg has no theme(%d)</color>", var_5_0))

			return "Widget/System/Activity_Resident/Activity_RaceTrial/Activity_RaceTrialEntranceUI"
		end
	end,
	GetBattleItemClass = function(arg_6_0)
		local var_6_0 = ActivityTools.GetActivityTheme(arg_6_0)

		if var_6_0 == ActivityConst.THEME.OSIRIS then
			return RaceTrialBattleItem
		elseif var_6_0 == ActivityConst.THEME.VOLUME_DOWN then
			return VolumeDownRaceTrialBattleItem
		elseif var_6_0 == ActivityConst.THEME.ACTIVITY_2_1 then
			return RaceTrialBattleItem_2_1
		elseif var_6_0 == ActivityConst.THEME.ACTIVITY_2_6 then
			return RaceTrialBattleItem_2_6
		elseif var_6_0 == ActivityConst.THEME.ACTIVITY_2_10 then
			return RaceTrialBattleItem_2_10
		elseif var_6_0 == ActivityConst.THEME.ACTIVITY_3_8 then
			return RaceTrialBattleItem_3_8
		else
			return RaceTrialBattleItem_3_8
		end
	end,
	GetFirstRewardPopItem = function(arg_7_0)
		if ActivityTools.GetActivityTheme(arg_7_0) == ActivityConst.THEME.ACTIVITY_3_8 then
			return RaceTrialFirstRewardItem_3_8
		else
			return RaceTrialFirstRewardItem_3_8
		end
	end,
	GetScoreRewardPopItem = function(arg_8_0)
		if ActivityTools.GetActivityTheme(arg_8_0) == ActivityConst.THEME.ACTIVITY_3_8 then
			return RaceTrialScoreRewardItem_3_8
		else
			return RaceTrialScoreRewardItem_3_8
		end
	end,
	GetDisplayScorePatternTips = function(arg_9_0)
		if ActivityTools.GetActivityTheme(arg_9_0) == ActivityConst.THEME.ACTIVITY_3_8 then
			return "RACE_TRIAL_DISPLAY_SCORE_3_8"
		else
			return "RACE_TRIAL_DISPLAY_SCORE_3_8"
		end
	end
}
