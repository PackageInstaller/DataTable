local var_0_0 = class("NewLimitChallengeResultGradePage", import("..NewBattleResultGradePage"))

function var_0_0.GetGetObjectives(arg_1_0)
	local var_1_0 = {}

	if arg_1_0.contextData.statistics._battleScore > ys.Battle.BattleConst.BattleScore.C then
		table.insert(var_1_0, {
			text = setColorStr(i18n("battle_result_total_time"), "#FFFFFFFF"),
			value = setColorStr(ys.Battle.BattleTimerView.formatTime((math.floor(arg_1_0.contextData.statistics._totalTime))), COLOR_YELLOW)
		})
	end

	return var_1_0
end

return var_0_0
