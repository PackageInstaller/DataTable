return {
	GetShootReward1NowAndMax = function(arg_1_0)
		local var_1_0 = SpShooGameData:GetActivityData(arg_1_0)
		local var_1_1 = 0

		if var_1_0 then
			var_1_1 = var_1_0.today_coin or 0
		end

		local var_1_2 = 0

		for iter_1_0, iter_1_1 in ipairs(GameSetting.activity_kali_shot_game_coin_num.value) do
			if iter_1_1[1] == SpKaliConst.ItemConst.coinID1 then
				var_1_2 = iter_1_1[2]
			end
		end

		return var_1_1, var_1_2
	end,
	GetShootReward2NowAndMax = function(arg_2_0)
		local var_2_0 = SpShooGameData:GetActivityData(arg_2_0)
		local var_2_1 = 0

		if var_2_0 then
			var_2_1 = var_2_0.today_chip or 0
		end

		local var_2_2 = 0

		for iter_2_0, iter_2_1 in ipairs(GameSetting.activity_kali_shot_game_coin_num.value) do
			if iter_2_1[1] == SpKaliConst.ItemConst.coinID2 then
				var_2_2 = iter_2_1[2]
			end
		end

		return var_2_1, var_2_2
	end,
	GetNumDes = function(arg_3_0, arg_3_1)
		local var_3_0 = arg_3_0 < arg_3_1 and ColorConst.BLACK_HEX or ColorConst.RED_HEX

		return string.format("<color=#%s>%s</color>/%s", var_3_0, formatNumber(arg_3_0), formatNumber(arg_3_1))
	end,
	GetGameIDByMainActivityID = function(arg_4_0, arg_4_1)
		local var_4_0 = 0
		local var_4_1 = ActivityCfg[arg_4_0] and ActivityCfg[arg_4_0].sub_activity_list or {}

		for iter_4_0, iter_4_1 in ipairs(var_4_1) do
			if ActivityCfg[iter_4_1] and arg_4_1 == ActivityCfg[iter_4_1].activity_template then
				var_4_0 = iter_4_1

				break
			end
		end

		return var_4_0
	end,
	GetTugGameStageData = function(arg_5_0)
		local var_5_0 = {}
		local var_5_1 = ActivityKaliGameStageCfg.all
		local var_5_2 = 0

		for iter_5_0, iter_5_1 in ipairs(var_5_1) do
			local var_5_3 = TugGameData:GetStageData(arg_5_0, iter_5_1)
			local var_5_4 = var_5_3 and var_5_3.times > 0 or false

			var_5_2 = var_5_4 and iter_5_0 or var_5_2

			local var_5_5 = {
				id = iter_5_1,
				passState = var_5_4,
				times = var_5_3 and var_5_3.times or 0,
				unlockIndex = var_5_2
			}

			table.insert(var_5_0, var_5_5)
		end

		return var_5_0
	end,
	GetChanllengeStageData = function(arg_6_0)
		local var_6_0 = {}
		local var_6_1 = SPKaliChallengeData:GetShowPointList()
		local var_6_2 = 0

		for iter_6_0, iter_6_1 in ipairs(var_6_1) do
			local var_6_3 = SPKaliChallengeData:GetStageData(arg_6_0, iter_6_1)
			local var_6_4 = var_6_3 and var_6_3.times > 0 or false

			var_6_2 = var_6_4 and iter_6_0 or var_6_2

			local var_6_5 = {
				id = iter_6_1,
				passState = var_6_4,
				times = var_6_3 and var_6_3.times or 0,
				unlockIndex = var_6_2
			}

			table.insert(var_6_0, var_6_5)
		end

		return var_6_0
	end,
	GetFightIDByMainActivityID = function(arg_7_0)
		return
	end,
	GetAffixID = function(arg_8_0)
		local var_8_0 = ActivityAffixPoolCfg[arg_8_0]

		if var_8_0 and var_8_0.affix and var_8_0.affix[1] then
			return var_8_0.affix[1]
		end

		return 0
	end,
	GetRollCostDes = function()
		local var_9_0 = ItemTools.getItemNum(GameSetting.activity_kali_cost_item.value[1])
		local var_9_1 = GameSetting.activity_kali_cost_item.value[2]

		if var_9_0 < var_9_1 then
			return string.format("<color=#%s>%s</color>", ColorConst.RED_HEX, var_9_1)
		else
			return var_9_1
		end
	end,
	IsHaveRolled = function(arg_10_0)
		local var_10_0 = SPKaliChallengeData:GetKaliAffix(arg_10_0)

		return var_10_0 and var_10_0[3]
	end,
	GetChan = function(arg_11_0)
		local var_11_0 = SPKaliChallengeData:GetKaliAffix(arg_11_0)

		return var_11_0 and var_11_0[3]
	end
}
