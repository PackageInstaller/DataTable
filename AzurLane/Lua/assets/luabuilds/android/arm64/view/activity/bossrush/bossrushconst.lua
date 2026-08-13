class = var_0_10000

local var_0_0 = var_0_10000("BossRushConst")

function var_0_0.GetPassedLayer(arg_1_0)
	switch = var_1_10001

	local var_1_0 = arg_1_0
	local var_1_1 = {}

	ActivityConst = var_1_10005
	var_1_1[var_1_10005.ALVIT_BOSS_RUSH_ID] = function()
		BossRushAlvitPassedLayer = var_2_10000

		return var_2_10000
	end
	ActivityConst = var_5
	var_1_1[var_5.ZENGKEHAIJUNSHANGJIANG_BOSS_RUSH_ID] = function()
		BossRushSardiniaPassedLayer = var_2_10000

		return var_2_10000
	end
	ActivityConst = var_5
	var_1_1[var_5.ESCAPE_BOSS_RUSH_ID] = function()
		BossRushEscapeManorPassedLayer = var_2_10000

		return var_2_10000
	end

	return var_1_10001(var_1_0, var_1_1, function()
		checkExist = var_2_10000
		pg = var_2_10002

		if var_2_10000(var_2_10002.activity_template[arg_1_0], {
			"config_client"
		}, {
			"passed"
		}) then
			_G = var_2_10001

			if not var_2_10001[var_0] then
				BossRushPassedCombatLoadLayer = var_2_10001
			end

			return var_2_10001
		end
	end)
end

function var_0_0.GetEXBattleResultLayer(arg_6_0)
	switch = var_1_10001

	local var_6_0 = arg_6_0
	local var_6_1 = {}

	ActivityConst = var_1_10005
	var_6_1[var_1_10005.ALVIT_BOSS_RUSH_ID] = function()
		BossRushAlvitEXBattleResultLayer = var_2_10000

		return var_2_10000
	end
	ActivityConst = var_5
	var_6_1[var_5.ZENGKEHAIJUNSHANGJIANG_BOSS_RUSH_ID] = function()
		BossRushVerZenkerEXBattleResultLayer = var_2_10000

		return var_2_10000
	end
	ActivityConst = var_5
	var_6_1[var_5.ESCAPE_BOSS_RUSH_ID] = function()
		BossRushEscapeManorBattleResultLayer = var_2_10000

		return var_2_10000
	end

	return var_1_10001(var_6_0, var_6_1, function()
		checkExist = var_2_10000
		pg = var_2_10002

		if var_2_10000(var_2_10002.activity_template[arg_6_0], {
			"config_client"
		}, {
			"result"
		}) then
			_G = var_2_10001

			if not var_2_10001[var_0] then
				BossRushEXBattleResultLayer = var_2_10001
			end

			return var_2_10001
		end
	end)
end

return var_0_0
