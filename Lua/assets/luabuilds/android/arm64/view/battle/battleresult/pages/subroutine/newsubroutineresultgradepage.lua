local var_0_0 = class("NewSubRoutineResultGradePage", import("..NewBattleResultGradePage"))

function var_0_0.GetGetObjectives(arg_1_0)
	table.insert({}, {
		icon = "check_mark",
		text = setColorStr(i18n("battle_result_base_score"), "#FFFFFFFF"),
		value = setColorStr("+" .. arg_1_0.contextData.statistics.subRunResult.basePoint, COLOR_BLUE)
	})
	table.insert({}, {
		icon = "check_mark",
		text = setColorStr(i18n("battle_result_dead_score", arg_1_0.contextData.statistics.subRunResult.deadCount), "#FFFFFFFF"),
		value = setColorStr("-" .. arg_1_0.contextData.statistics.subRunResult.losePoint, COLOR_BLUE)
	})
	table.insert({}, {
		icon = "check_mark",
		text = setColorStr(i18n("battle_result_score", arg_1_0.contextData.statistics.subRunResult.score), "#FFFFFFFF"),
		value = setColorStr("+" .. arg_1_0.contextData.statistics.subRunResult.point, COLOR_BLUE)
	})
	table.insert({}, {
		text = setColorStr(i18n("battle_result_score_total"), "#FFFFFFFF"),
		value = setColorStr(arg_1_0.contextData.statistics.subRunResult.total, COLOR_YELLOW)
	})

	return {}
end

return var_0_0
