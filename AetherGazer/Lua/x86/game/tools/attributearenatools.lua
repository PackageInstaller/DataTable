return {
	GetEnterUI = function(arg_1_0)
		if ActivityTools.GetActivityTheme(arg_1_0) >= ActivityConst.THEME.ACTIVITY_3_8 then
			return "Widget/System/Challenge_ArenaUI/IndiaArenaMainUI"
		else
			return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ArenaUI/NorseUI_3_0_ArenaMainUI"
		end
	end,
	GetMainUIName = function(arg_2_0)
		if ActivityTools.GetActivityTheme(arg_2_0) >= ActivityConst.THEME.ACTIVITY_3_8 then
			return "Widget/System/Challenge_ArenaUI/IndiaInletUI"
		else
			return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ArenaUI/NorseUI_3_0_InletUI"
		end
	end,
	GetRankUI = function(arg_3_0)
		if ActivityTools.GetActivityTheme(arg_3_0) >= ActivityConst.THEME.ACTIVITY_3_8 then
			return "Widget/System/Challenge_ArenaUI/IndiaPTRankUI"
		else
			return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ArenaUI/NorseUI_3_0_PTRankUI"
		end
	end,
	GetRewardUI = function(arg_4_0)
		if ActivityTools.GetActivityTheme(arg_4_0) >= ActivityConst.THEME.ACTIVITY_3_8 then
			return "Widget/System/Challenge_ArenaUI/IndiaRewardUI"
		else
			return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ArenaUI/NorseUI_3_0_RewardUI"
		end
	end,
	GetRoundUI = function(arg_5_0)
		if ActivityTools.GetActivityTheme(arg_5_0) >= ActivityConst.THEME.ACTIVITY_3_8 then
			return "Widget/System/Challenge_ArenaUI/IndiaRewardtimeUI"
		else
			return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ArenaUI/NorseUI_3_0_RewardtimeUI"
		end
	end,
	GetTrialHeroList = function(arg_6_0)
		return ActivityAttributeArenaCfg[arg_6_0].trial_hero_list
	end,
	GetTaskActivityID = function(arg_7_0)
		local var_7_0 = 0
		local var_7_1 = ActivityCfg[arg_7_0]

		for iter_7_0, iter_7_1 in ipairs(var_7_1.sub_activity_list) do
			if ActivityCfg[iter_7_1].activity_template == ActivityTemplateConst.TASK then
				var_7_0 = iter_7_1
			end
		end

		return var_7_0
	end,
	GetRankActivityID = function(arg_8_0)
		local var_8_0 = 0
		local var_8_1 = ActivityCfg[arg_8_0]

		for iter_8_0, iter_8_1 in ipairs(var_8_1.sub_activity_list) do
			if ActivityCfg[iter_8_1].activity_template == ActivityTemplateConst.ACTIVITY_ATTRIBUTE_ARENA_RANK then
				var_8_0 = iter_8_1
			end
		end

		return var_8_0
	end
}
