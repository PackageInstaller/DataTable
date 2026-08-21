local var_0_0 = {}

function var_0_0.InitConst()
	var_0_0.heroTrialDic = {}

	for iter_1_0, iter_1_1 in ipairs(ActivityHeroTrialCfg.all) do
		local var_1_0 = var_0_0.GetHeroStandardID(iter_1_1)
		local var_1_1 = HeroStandardSystemCfg[var_1_0].hero_id

		var_0_0.heroTrialDic[var_1_1] = var_0_0.heroTrialDic[var_1_1] or {}

		table.insert(var_0_0.heroTrialDic[var_1_1], iter_1_1)
	end
end

function var_0_0.GetMainUIName(arg_2_0)
	local var_2_0 = ActivityTools.GetActivityTheme(arg_2_0)

	if ActivityHeroTrialUICfg[var_2_0] then
		return ActivityHeroTrialUICfg[var_2_0].main_ui_path
	else
		Debug.Log(string.format("<color=ff0000>ActivityHeroTrialUICfg has no theme(%d)</color>", var_2_0))

		return "Widget/System/Activity_Resident/Activity_HeroTrialUI/Activity_HeroTrialUI"
	end
end

function var_0_0.GetHeroStandardID(arg_3_0)
	local var_3_0 = HeroStandardSystemCfg.all[1]
	local var_3_1 = ActivityHeroTrialCfg[arg_3_0]

	if not var_3_1 then
		Debug.Log(string.format("<color=ff0000>ActivityHeroTrialCfg has no id(%s)</color>, return default standardID(%s)", arg_3_0, var_3_0))

		return var_3_0
	end

	local var_3_2 = BattleHeroTrialStageCfg[var_3_1.stage_id]

	if not var_3_2 then
		Debug.Log(string.format("<color=ff0000>BattleHeroTrialStageCfg has no id(%s)</color>, return default standardID(%s)", var_3_1.stage_id, var_3_0))

		return var_3_0
	end

	return var_3_2.hero_list[1][2]
end

function var_0_0.GetHeroTrialListByHeroID(arg_4_0)
	if not var_0_0.heroTrialDic then
		return {}
	end

	return var_0_0.heroTrialDic[arg_4_0] or {}
end

function var_0_0.GetLastOpenHeroTrial(arg_5_0)
	local var_5_0 = var_0_0.GetHeroTrialListByHeroID(arg_5_0)
	local var_5_1 = 0
	local var_5_2 = 0

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		local var_5_3 = ActivityHeroTrialCfg[iter_5_1].activity_id

		if ActivityData:GetActivityIsOpen(var_5_3) then
			local var_5_4 = ActivityData:GetActivityTime(var_5_3)

			if var_5_2 < var_5_4 then
				var_5_1 = iter_5_1
				var_5_2 = var_5_4
			end
		end
	end

	return var_5_1
end

function var_0_0.GetActivityIsUnlock(arg_6_0)
	local var_6_0 = ActivityHeroTrialCfg[arg_6_0].activity_id
	local var_6_1 = ActivityCfg[var_6_0].activity_theme
	local var_6_2 = ActivityEntraceCfg.get_id_list_by_theme[var_6_1][1]
	local var_6_3 = ActivityEntraceCfg[var_6_2].jump_system

	return not JumpTools.GetLinkIsLocked(var_6_3)
end

function var_0_0.EnterActivityBattle(arg_7_0)
	HeroTrialData:SaveStageID(arg_7_0)

	local var_7_0 = ActivityCfg.get_id_list_by_sub_activity_list[ActivityHeroTrialCfg[arg_7_0].activity_id][1]

	gameContext:Go("/sectionSelectHero", {
		section = ActivityHeroTrialCfg[arg_7_0].stage_id,
		sectionType = BattleConst.STAGE_TYPE_NEW.HERO_TRIAL,
		activityID = var_7_0
	})
end

function var_0_0.EnterResidentBattle(arg_8_0)
	gameContext:Go("/sectionSelectHero", {
		section = arg_8_0,
		sectionType = BattleConst.STAGE_TYPE_NEW.RESIDENT_HERO_TRIAL
	})
end

function var_0_0.GoBackFromBattle(arg_9_0)
	local var_9_0 = HeroTrialData:GetBattleWay()

	if var_9_0.way == ActivityHeroTrialConst.BATTLE_WAY.ACTIVITY then
		local var_9_1 = arg_9_0:GetActivityID()
		local var_9_2 = ActivityTools.GetActivityTheme(var_9_1)
		local var_9_3 = ActivityTools.GetOriginActivityTheme(var_9_2)

		if var_9_3 == ActivityConst.THEME.OSIRIS then
			OpenPageUntilLoaded("/heroTrialActivity", {
				activityID = var_9_1
			})
		elseif var_9_3 == ActivityConst.THEME.HELLA then
			OpenPageUntilLoaded("/hellaHeroTrialActivity", {
				activityID = var_9_1
			})
		elseif var_9_3 == ActivityConst.THEME.SUMMER then
			OpenPageUntilLoaded("/summerHeroTrialActivity", {
				activityID = var_9_1
			})
		elseif var_9_3 == ActivityConst.THEME.VOLUME or var_9_3 == ActivityConst.THEME.VOLUME_DOWN then
			OpenPageUntilLoaded("/thirdVolumeHeroTrial", {
				activityID = var_9_1
			})
		elseif var_9_3 == ActivityConst.THEME.FACTORY then
			OpenPageUntilLoaded("/factoryHeroTrial", {
				activityID = var_9_1
			})
		elseif var_9_3 == ActivityConst.THEME.DREAM then
			OpenPageUntilLoaded("/dreamHeroTrial", {
				activityID = var_9_1
			})
		elseif var_9_3 == ActivityConst.THEME.TYR then
			OpenPageUntilLoaded("/heroTrialView_1_7", {
				activityID = var_9_1
			})
		else
			local var_9_4, var_9_5 = ActivityTools.GetActivityMainRouteByTheme(var_9_3)

			OpenPageUntilLoaded(var_9_4, var_9_5)
		end
	else
		OpenPageUntilLoaded(var_9_0.route, var_9_0.params)
	end
end

return var_0_0
