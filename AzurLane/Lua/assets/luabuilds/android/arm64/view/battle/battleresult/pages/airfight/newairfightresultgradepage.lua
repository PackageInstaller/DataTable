local var_0_0 = class("NewAirFightResultGradePage", import("..NewBattleResultGradePage"))

function var_0_0.LoadGrade(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0.contextData.score

	LoadImageSpriteAsync("battlescore/battle_score_" .. ({
		"d",
		"c",
		"b",
		"a",
		"s"
	})[var_1_0 + 1] .. "/letter_" .. ({
		"d",
		"c",
		"b",
		"a",
		"s"
	})[var_1_0 + 1], arg_1_0.gradeIcon, true)
	LoadImageSpriteAsync(nil, arg_1_0.gradeTxt, true)

	if arg_1_1 then
		arg_1_1()
	end

	return
end

function var_0_0.GetGetObjectives(arg_2_0)
	table.insert({}, {
		text = setColorStr(i18n("fighterplane_destroy_tip") .. arg_2_0.contextData.statistics._airFightStatistics.kill, "#FFFFFFFF"),
		value = setColorStr(arg_2_0.contextData.statistics._airFightStatistics.score, COLOR_BLUE)
	})
	table.insert({}, {
		text = setColorStr(i18n("fighterplane_hit_tip") .. arg_2_0.contextData.statistics._airFightStatistics.hit, "#FFFFFFFF"),
		value = setColorStr(-arg_2_0.contextData.statistics._airFightStatistics.lose, COLOR_BLUE)
	})
	table.insert({}, {
		text = setColorStr(i18n("fighterplane_score_tip"), "#FFFFFFFF"),
		value = setColorStr(arg_2_0.contextData.statistics._airFightStatistics.total, COLOR_YELLOW)
	})

	return {}
end

return var_0_0
