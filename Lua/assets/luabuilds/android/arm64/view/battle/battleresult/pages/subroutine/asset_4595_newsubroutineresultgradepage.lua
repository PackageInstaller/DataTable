local NewSubRoutineResultGradePage = class("NewSubRoutineResultGradePage", import("..NewBattleResultGradePage"))

function NewSubRoutineResultGradePage:GetGetObjectives()
	local var_1_0 = {}

	table.insert(var_1_0, {
		icon = "check_mark",
		text = setColorStr(i18n("battle_result_base_score"), "#FFFFFFFF"),
		value = setColorStr("+" .. self.contextData.statistics.subRunResult.basePoint, COLOR_BLUE)
	})
	table.insert(var_1_0, {
		icon = "check_mark",
		text = setColorStr(i18n("battle_result_dead_score", self.contextData.statistics.subRunResult.deadCount), "#FFFFFFFF"),
		value = setColorStr("-" .. self.contextData.statistics.subRunResult.losePoint, COLOR_BLUE)
	})
	table.insert(var_1_0, {
		icon = "check_mark",
		text = setColorStr(i18n("battle_result_score", self.contextData.statistics.subRunResult.score), "#FFFFFFFF"),
		value = setColorStr("+" .. self.contextData.statistics.subRunResult.point, COLOR_BLUE)
	})
	table.insert(var_1_0, {
		text = setColorStr(i18n("battle_result_score_total"), "#FFFFFFFF"),
		value = setColorStr(self.contextData.statistics.subRunResult.total, COLOR_YELLOW)
	})

	return var_1_0
end

return NewSubRoutineResultGradePage
