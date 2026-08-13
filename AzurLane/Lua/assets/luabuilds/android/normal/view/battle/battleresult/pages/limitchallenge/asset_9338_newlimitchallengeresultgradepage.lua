class = var_0_10000

local var_0_0 = "NewLimitChallengeResultGradePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..NewBattleResultGradePage"))

function var_0_1.GetGetObjectives(arg_1_0)
	local var_1_0 = arg_1_0.contextData
	local var_1_1 = {}
	local var_1_2 = var_1_0.statistics._battleScore

	ys = var_1_10004

	if var_1_2 > var_1_10004.Battle.BattleConst.BattleScore.C then
		local var_1_3 = var_1_0.statistics._totalTime

		math = var_1_10006

		local var_1_4 = var_1_10006.floor(var_1_3)

		ys = var_7

		local var_1_5 = var_7.Battle.BattleTimerView.formatTime(var_1_4)

		i18n = var_8

		local var_1_6 = var_8("battle_result_total_time")

		table = var_9

		local var_1_7 = var_9.insert
		local var_1_8 = var_1_1
		local var_1_9 = {}

		setColorStr = var_1_10012
		var_1_9.text = var_1_10012(var_1_6, "#FFFFFFFF")
		setColorStr = var_12

		local var_1_10 = var_1_5

		COLOR_YELLOW = var_14
		var_1_9.value = var_12(var_1_10, var_14)

		var_1_7(var_1_8, var_1_9)
	end

	return var_1_1
end

return var_0_1
