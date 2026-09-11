local var_0_0 = {
	GetMainUIName = function(arg_1_0)
		return "Widget/Version/T0_107602/T0Scene"
	end,
	GetTaskUIName = function(arg_2_0)
		return "Widget/Version/T0_107602/T0Scene2"
	end,
	GetPopUIName = function(arg_3_0)
		return "Widget/Version/T0_107602/T0Scene3"
	end,
	GetDrawStartUIName = function(arg_4_0)
		return "Widget/Version/T0_107602/DrawCardsUI/T0_DrawCardUI"
	end,
	GetDrawRewardUIName = function(arg_5_0)
		return "Widget/Version/T0_107602/SingledrawUI/T0_Single"
	end,
	GetDrawResultUIName = function(arg_6_0)
		return "Widget/Version/T0_107602/T0Scene4"
	end,
	GetDrawInfoUIName = function(arg_7_0)
		return "Widget/Version/T0_107602/T0_DrawInfoUI"
	end
}
local var_0_1 = {
	[ActivityConst.ACTIVITY_2_2_SKIN_DRAW] = ActivityConst.ACTIVITY_2_2_SKIN_POOL,
	[ActivityConst.ACTIVITY_3_3_SKIN_DRAW] = ActivityConst.ACTIVITY_3_3_SKIN_POOL,
	[ActivityConst.ACTIVITY_3_10_SKIN_DRAW] = ActivityConst.ACTIVITY_3_10_SKIN_POOL
}

function var_0_0.GetSkinPoolActivityID(arg_8_0)
	return var_0_1[arg_8_0]
end

local var_0_2 = {
	[ActivityConst.ACTIVITY_2_2_SKIN_DRAW] = ActivityConst.ACTIVITY_2_2_SCENE_POOL,
	[ActivityConst.ACTIVITY_3_3_SKIN_DRAW] = ActivityConst.ACTIVITY_3_3_SCENE_POOL,
	[ActivityConst.ACTIVITY_3_10_SKIN_DRAW] = ActivityConst.ACTIVITY_3_10_SCENE_POOL
}

function var_0_0.GetScenePoolActivityID(arg_9_0)
	return var_0_2[arg_9_0]
end

local var_0_3 = {
	[ActivityConst.ACTIVITY_2_2_SKIN_DRAW] = ActivityConst.ACTIVITY_2_2_SKIN_TASK,
	[ActivityConst.ACTIVITY_3_3_SKIN_DRAW] = ActivityConst.ACTIVITY_3_3_SKIN_TASK,
	[ActivityConst.ACTIVITY_3_10_SKIN_DRAW] = ActivityConst.ACTIVITY_3_10_SKIN_TASK
}

function var_0_0.GetTaskActivityID(arg_10_0)
	return var_0_3[arg_10_0]
end

function var_0_0.GetActivityShopID(arg_11_0)
	return ActivityShopCfg[arg_11_0].shop_id
end

function var_0_0.GetStoryID(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(ActivityLimitedSkinStoryCfg.get_id_list_by_main_activity_id[arg_12_0]) do
		if ActivityLimitedSkinStoryCfg[iter_12_1].activity_id == 0 then
			return ActivityLimitedSkinStoryCfg[iter_12_1].story_id
		end
	end

	return 0
end

function var_0_0.GetTypeGo(arg_13_0)
	return {
		"Widget/Version/T0_107602/SingledrawUI/SingledrawUI_blue",
		"Widget/Version/T0_107602/SingledrawUI/SingledrawUI_purple",
		"Widget/Version/T0_107602/SingledrawUI/SingledrawUI_golden",
		special = "Widget/Version/T0_107602/SingledrawUI/SingledrawUI_special",
		movie = "Widget/Version/T0_107602/SingledrawUI/SingledrawUI_movie"
	}
end

local var_0_4 = {
	[ActivityConst.ACTIVITY_2_2_SKIN_DRAW] = {
		CurrencyIdMapCfg.CURRENCY_TYPE_GENGCHEN_SKIN_COIN.item_id
	},
	[ActivityConst.ACTIVITY_3_3_SKIN_DRAW] = {
		CurrencyIdMapCfg.CURRENCY_TYPE_GENGCHEN_SKIN_COIN_3_2.item_id
	},
	[ActivityConst.ACTIVITY_3_10_SKIN_DRAW] = {
		CurrencyIdMapCfg.CURRENCY_TYPE_GENGCHEN_SKIN_COIN_3_10.item_id
	}
}

function var_0_0.GetTaskCurrency(arg_14_0)
	return var_0_4[arg_14_0] or {}
end

function var_0_0.GetPoolID(arg_15_0)
	return ActivityLimitedDrawPoolListCfg.get_id_list_by_activity_id[arg_15_0][1]
end

function var_0_0.GetSceneID(arg_16_0)
	for iter_16_0, iter_16_1 in ipairs(ActivityLimitedDrawPoolListCfg[var_0_0.GetPoolID(arg_16_0)].main_icon_info) do
		if ItemCfg[iter_16_1[2]].type == ItemConst.ITEM_TYPE.SCENE then
			return iter_16_1[2]
		end
	end

	return 0
end

function var_0_0.GetSkinID(arg_17_0)
	for iter_17_0, iter_17_1 in ipairs(ActivityLimitedDrawPoolListCfg[var_0_0.GetPoolID(arg_17_0)].main_icon_info) do
		if ItemCfg[iter_17_1[2]].type == ItemConst.ITEM_TYPE.HERO_SKIN then
			return iter_17_1[2]
		end
	end

	return 0
end

function var_0_0.GetFrameID(arg_18_0)
	for iter_18_0, iter_18_1 in ipairs(ActivityLimitedDrawPoolListCfg[var_0_0.GetPoolID(arg_18_0)].main_icon_info) do
		if ItemCfg[iter_18_1[2]].type == ItemConst.ITEM_TYPE.FRAME then
			return iter_18_1[2]
		end
	end

	return 0
end

return var_0_0
