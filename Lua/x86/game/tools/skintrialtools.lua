return {
	GetMainViewUIName = function(arg_1_0)
		local var_1_0 = ActivityTools.GetActivityTheme(arg_1_0)

		if ActivitySkinTrialUICfg[var_1_0] then
			return ActivitySkinTrialUICfg[var_1_0].main_ui_path
		else
			return "Widget/System/Activity_Resident/Acitvity_OutfitTrial/Acitvity_SkinTrialMainUI"
		end
	end,
	GetSelectViewUIName = function(arg_2_0)
		local var_2_0 = ActivityTools.GetActivityTheme(arg_2_0)

		if ActivitySkinTrialUICfg[var_2_0] then
			return ActivitySkinTrialUICfg[var_2_0].select_ui_path
		else
			return "Widget/System/Activity_Resident/Acitvity_OutfitTrial/Acitvity_SkinTrialUI"
		end
	end,
	GoToSelectView = function(arg_3_0, arg_3_1)
		local var_3_0 = ActivityTools.GetActivityTheme(arg_3_0)

		if var_3_0 < ActivityConst.THEME.ACTIVITY_3_6 then
			if ActivitySkinTrialUICfg[var_3_0] then
				if ActivitySkinTrialUICfg[var_3_0].script_version == "3" then
					JumpTools.OpenPageByJump("/skinTrialSelectView_3_0", {
						activityID = arg_3_0,
						skinTrialID = arg_3_1
					})
				else
					JumpTools.OpenPageByJump("/skinTrialSelectView_2_0", {
						activityID = arg_3_0,
						skinTrialID = arg_3_1
					})
				end
			else
				Debug.Log(string.format("<color=ff0000>ActivitySkinTrialUICfg has no theme(%d)</color>", var_3_0 or ""))
			end
		else
			JumpTools.OpenPageByJump("/skinTrialSelectView_Resident", {
				activityID = arg_3_0,
				skinTrialID = arg_3_1
			})
		end
	end,
	GetHeroStandardID = function(arg_4_0)
		local var_4_0 = HeroStandardSystemCfg.all[1]
		local var_4_1 = ActivitySkinTrialCfg[arg_4_0]

		if not var_4_1 then
			Debug.Log(string.format("<color=ff0000>ActivitySkinTrialCfg has no id(%s)</color>, return default standardID(%s)", arg_4_0, var_4_0))

			return var_4_0
		end

		local var_4_2 = BattleSkinTrialStageCfg[var_4_1.stage_id]

		if not var_4_2 then
			Debug.Log(string.format("<color=ff0000>BattleSkinTrialStageCfg has no id(%s)</color>, return default standardID(%s)", var_4_1.stage_id, var_4_0))

			return var_4_0
		end

		return var_4_2.hero_list[1][2]
	end
}
