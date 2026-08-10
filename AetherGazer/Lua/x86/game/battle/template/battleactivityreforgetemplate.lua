local var_0_0 = class("BattleActivityReforgeTemplate", BattleBaseStageTemplate)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.id = arg_1_1
	arg_1_0.activityID_ = arg_1_2.activityID
	arg_1_0.chapterActivityID_ = arg_1_2.chapterActivityID
	arg_1_0.levelID_ = arg_1_2.levelID
	arg_1_0.waveID_ = arg_1_2.waveID
	arg_1_0.skillList_ = arg_1_2.skillList
	arg_1_0.battleParams_ = arg_1_2.battleParams

	local var_1_0 = ActivityReforgeData:GetWaveTeamInfo(arg_1_0.waveID_)

	arg_1_0.teamID = var_1_0.teamID
	arg_1_0.level = var_1_0.level
	arg_1_0.teamCfg = ActivityReforgeTeamCfg[arg_1_0.teamID]
	arg_1_0.cfg = BattleActivityReforgeCfg[arg_1_1]
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitHeroList()
	arg_2_0:InitComboSkillID()
	arg_2_0:InitChipData()
end

function var_0_0.InitHeroList(arg_3_0)
	local var_3_0 = arg_3_0.teamCfg.team_info[arg_3_0.level]

	arg_3_0.heroList_, arg_3_0.heroTrialList_ = {}, {}

	for iter_3_0, iter_3_1 in pairs(var_3_0) do
		table.insert(arg_3_0.heroList_, HeroStandardSystemCfg[iter_3_1].hero_id)
		table.insert(arg_3_0.heroTrialList_, iter_3_1)
	end
end

function var_0_0.InitComboSkillID(arg_4_0)
	arg_4_0.comboSkillID_ = arg_4_0.teamCfg.combo_skill_id
end

function var_0_0.InitChipData(arg_5_0)
	arg_5_0.chipList_ = {}
end

function var_0_0.GetComboSkillLevel(arg_6_0)
	return 3
end

function var_0_0.GetDest(arg_7_0)
	return arg_7_0.waveID_
end

function var_0_0.GetStageId(arg_8_0)
	return arg_8_0.id
end

function var_0_0.GetType(arg_9_0)
	return BattleConst.STAGE_TYPE_NEW.ACTIVITY_REFORGE
end

function var_0_0.GetMap(arg_10_0)
	return arg_10_0.cfg.map, false
end

function var_0_0.GetAILevel(arg_11_0)
	return arg_11_0.cfg.ai_level
end

function var_0_0.GetEnemyLevel(arg_12_0)
	return arg_12_0.cfg.monster_level
end

function var_0_0.GetHeroTeam(arg_13_0)
	return arg_13_0.heroList_, arg_13_0.heroTrialList_
end

function var_0_0.GetChapterActivityID(arg_14_0)
	return arg_14_0.chapterActivityID_
end

function var_0_0.GetLevelID(arg_15_0)
	return arg_15_0.levelID_
end

function var_0_0.GetActivityID(arg_16_0)
	return arg_16_0.chapterActivityID_
end

function var_0_0.GetMainActivityID(arg_17_0)
	return arg_17_0.activityID_
end

function var_0_0.GetWaveID(arg_18_0)
	return arg_18_0.waveID_
end

function var_0_0.GetActivityReforgeSkillList(arg_19_0)
	return arg_19_0.skillList_
end

function var_0_0.GetBattleParams(arg_20_0)
	return arg_20_0.battleParams_
end

return var_0_0
