return {
	GetChildId = function(arg_1_0, arg_1_1, arg_1_2)
		if DemonChallengeCfg.get_id_list_by_activity_id[arg_1_0] then
			return DemonChallengeCfg.get_id_list_by_activity_id[arg_1_0][arg_1_1]
		end
	end,
	GetStageId = function(arg_2_0, arg_2_1, arg_2_2)
		if DemonChallengeCfg.get_id_list_by_activity_id[arg_2_0] then
			return DemonChallengeCfg[DemonChallengeCfg.get_id_list_by_activity_id[arg_2_0][arg_2_1]].stage_id
		end
	end,
	GetMainUIName = function(arg_3_0)
		local var_3_0 = ActivityTools.GetOriginActivityTheme((ActivityTools.GetActivityTheme(arg_3_0)))

		if var_3_0 == ActivityConst.THEME.OSIRIS then
			return "UI/VersionUI/OsirisUI/DemonChallenge/DemonMainUI"
		elseif var_3_0 == ActivityConst.THEME.HELLA then
			return "UI/VersionUI/HellaUI/HellaBossChallengeUI"
		elseif var_3_0 == ActivityConst.THEME.VOLUME_DOWN then
			return "UI/VolumeIIIDownUI/VolumeIIIDownDemonChallenge/VolumeDemonChallengeMainUI"
		elseif var_3_0 == ActivityConst.THEME.DREAM then
			return "UI/EmptyDream/DemonChallenge/EDream_DCMainUI"
		elseif var_3_0 == ActivityConst.THEME.ACTIVITY_2_2 then
			return "UI/VersionUI/XuHeng3rdUI/XH3rdMindDemonUI/XuHeng3rdDemonLevelUI"
		else
			return "UI/VersionUI/OsirisUI/DemonChallenge/DemonMainUI"
		end
	end,
	GetDifficultyUIName = function(arg_4_0)
		local var_4_0 = ActivityTools.GetOriginActivityTheme((ActivityTools.GetActivityTheme(arg_4_0)))

		if var_4_0 == ActivityConst.THEME.OSIRIS then
			return "UI/VersionUI/OsirisUI/DemonChallenge/DemonDifficultyUI"
		elseif var_4_0 == ActivityConst.THEME.HELLA then
			return "UI/VersionUI/HellaUI/HellaChoosedifficultyUI"
		elseif var_4_0 == ActivityConst.THEME.VOLUME_DOWN then
			return "UI/VolumeIIIDownUI/VolumeIIIDownDemonChallenge/VolumeDemonChallengeDifficultyUI"
		elseif var_4_0 == ActivityConst.THEME.DREAM or var_4_0 == ActivityConst.THEME.ACTIVITY_2_2 then
			return "UI/EmptyDream/DemonChallenge/EDream_DCChoosedifficultUI"
		else
			return "UI/VersionUI/OsirisUI/DemonChallenge/DemonDifficultyUI"
		end
	end,
	GetAwardUIName = function(arg_5_0)
		local var_5_0 = ActivityTools.GetOriginActivityTheme((ActivityTools.GetActivityTheme(arg_5_0)))

		if var_5_0 == ActivityConst.THEME.OSIRIS then
			return "UI/PopUp/DemonAwardUI"
		elseif var_5_0 == ActivityConst.THEME.VOLUME_DOWN then
			return "UI/VolumeIIIDownUI/VolumeIIIDownDemonChallenge/VolumeDemonChallengeRewardPop"
		elseif var_5_0 == ActivityConst.THEME.DREAM then
			return "UI/EmptyDream/DemonChallenge/EDream_DCRewardUI"
		else
			return "UI/PopUp/DemonAwardUI"
		end
	end
}
