local NewAirFightResultGradePage = class("NewAirFightResultGradePage", import("..NewBattleResultGradePage"))

function NewAirFightResultGradePage:LoadGrade(arg_1_1)
	LoadImageSpriteAsync("battlescore/battle_score_" .. ({
		"d",
		"c",
		"b",
		"a",
		"s"
	})[self.contextData.score + 1] .. "/letter_" .. ({
		"d",
		"c",
		"b",
		"a",
		"s"
	})[self.contextData.score + 1], self.gradeIcon, true)
	LoadImageSpriteAsync(nil, self.gradeTxt, true)

	if arg_1_1 then
		arg_1_1()
	end

	return
end

function NewAirFightResultGradePage:GetGetObjectives()
	local var_2_0 = {}

	table.insert(var_2_0, {
		text = setColorStr(i18n("fighterplane_destroy_tip") .. self.contextData.statistics._airFightStatistics.kill, "#FFFFFFFF"),
		value = setColorStr(self.contextData.statistics._airFightStatistics.score, COLOR_BLUE)
	})
	table.insert(var_2_0, {
		text = setColorStr(i18n("fighterplane_hit_tip") .. self.contextData.statistics._airFightStatistics.hit, "#FFFFFFFF"),
		value = setColorStr(-self.contextData.statistics._airFightStatistics.lose, COLOR_BLUE)
	})
	table.insert(var_2_0, {
		text = setColorStr(i18n("fighterplane_score_tip"), "#FFFFFFFF"),
		value = setColorStr(self.contextData.statistics._airFightStatistics.total, COLOR_YELLOW)
	})

	return var_2_0
end

return NewAirFightResultGradePage
