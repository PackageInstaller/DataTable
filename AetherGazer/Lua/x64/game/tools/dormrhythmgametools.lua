local var_0_0 = {
	gameConfig = {
		Dorm = 1,
		Barbecue = ActivityConst.ACTIVITY_HERO_CHALLENGE_3_1
	}
}

var_0_0.gameConfigData = {
	[var_0_0.gameConfig.Dorm] = {
		failCueName = "ui_dorm_game_fail",
		successCueName = "ui_dorm_game_success",
		cueName = "ui_dorm",
		judgeWidth = GameDisplayCfg.dorm_mg_break_check_range.value[1],
		scoreLevel = GameSetting.dorm_mg_break_level.value,
		effectLevel = GameDisplayCfg.dorm_mg_break_effect.value,
		stageCfg = BackHomeBreakGameCfg
	},
	[var_0_0.gameConfig.Barbecue] = {
		failCueName = "ui_dorm_game_fail",
		successCueName = "ui_dorm_game_success",
		cueName = "ui_dorm",
		judgeWidth = GameDisplayCfg.dorm_mg_break_check_range.value[1],
		scoreLevel = GameSetting.dorm_mg_break_level.value,
		effectLevel = GameDisplayCfg.dorm_mg_break_effect.value,
		stageCfg = ActivityHeroChallengeBarbecueCfg
	}
}

function var_0_0.GetGameConfigData(arg_1_0, arg_1_1)
	if var_0_0.gameConfigData[arg_1_1] then
		return var_0_0.gameConfigData[arg_1_1]
	end

	Debug.LogError("未获取到对应活动的小游戏配置信息" .. arg_1_1)
end

function var_0_0.GetRank(arg_2_0, arg_2_1)
	local var_2_0 = GameSetting.dorm_mg_break_level.value

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		if arg_2_1 < iter_2_1 then
			return iter_2_0 - 1
		end
	end

	return #var_2_0
end

function var_0_0.GetEffectRank(arg_3_0, arg_3_1)
	local var_3_0 = GameDisplayCfg.dorm_mg_break_effect.value
	local var_3_1 = -1

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		if arg_3_1 < iter_3_1 then
			var_3_1 = iter_3_0 - 1

			break
		end
	end

	if var_3_1 < 0 then
		var_3_1 = #var_3_0
	end

	return var_3_1
end

function var_0_0.CalGameScore(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = arg_4_3 or 1

	if arg_4_1 then
		local var_4_1 = arg_4_0.gameConfigData[var_4_0].stageCfg
		local var_4_2 = (arg_4_1.successfulNum + arg_4_1.maxBatterNum) / var_4_1[arg_4_2].total_check * 100

		return math.ceil(var_4_2)
	end
end

function var_0_0.GetGameResult(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = arg_5_3 or 1

	if arg_5_0:CalGameScore(arg_5_1, arg_5_2, var_5_0) >= GameDisplayCfg.dorm_mg_break_success.value[1] then
		return true
	end

	return false
end

return var_0_0
