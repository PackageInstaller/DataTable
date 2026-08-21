local var_0_0 = class("NewGuildResultStatisticsPage", import("..NewBattleResultStatisticsPage"))

function var_0_0.UpdateGrade(arg_1_0)
	LoadImageSpriteAsync("battlescore/grade_label_clear", arg_1_0.gradeTxt, false)
	setActive(arg_1_0.gradeIcon, false)

	return
end

function var_0_0.UpdatePainting(arg_2_0, arg_2_1)
	arg_2_0:UpdatePaintingPosition()
	arg_2_0:UpdateMvpPainting(arg_2_1)

	return
end

return var_0_0
