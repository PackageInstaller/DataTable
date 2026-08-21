return {
	GetMainUIName = function(arg_1_0)
		local var_1_0 = ActivityTools.GetActivityTheme(arg_1_0)

		if ActivityCultivateHeroUICfg[var_1_0] then
			return ActivityCultivateHeroUICfg[var_1_0].main_ui_path
		else
			return "Widget/System/Activity_Resident/ActivityReceivedUI/ActivityReceivedUI"
		end
	end,
	GetRewardUIName = function(arg_2_0)
		local var_2_0 = ActivityTools.GetActivityTheme(arg_2_0)

		if ActivityCultivateHeroUICfg[var_2_0] then
			return ActivityCultivateHeroUICfg[var_2_0].reward_ui_path
		else
			return "Widget/System/Activity_Resident/ActivityReceivedUI/ActivityReceivedPopUI"
		end
	end,
	GetSwitchItemClass = function(arg_3_0)
		local var_3_0 = ActivityTools.GetActivityTheme(arg_3_0)

		return CultivateHeroSwitchItem_3_6
	end,
	GetTaskItemClass = function(arg_4_0)
		if ActivityTools.GetActivityTheme(arg_4_0) < 28 then
			return CultivateHeroTaskItem
		else
			return CultivateHeroTaskItem_3_6
		end
	end
}
