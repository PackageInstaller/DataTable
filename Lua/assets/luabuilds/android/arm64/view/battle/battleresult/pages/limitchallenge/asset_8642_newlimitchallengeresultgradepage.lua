local NewLimitChallengeResultGradePage = class("NewLimitChallengeResultGradePage", import("..NewBattleResultGradePage"))

function NewLimitChallengeResultGradePage:GetGetObjectives()
	local var_1_0 = {}

	if self.contextData.statistics._battleScore > ys.Battle.BattleConst.BattleScore.C then
		table.insert(var_1_0, {
			text = setColorStr(i18n("battle_result_total_time"), "#FFFFFFFF"),
			value = setColorStr(ys.Battle.BattleTimerView.formatTime((math.floor(self.contextData.statistics._totalTime))), COLOR_YELLOW)
		})
	end

	return var_1_0
end

return NewLimitChallengeResultGradePage
