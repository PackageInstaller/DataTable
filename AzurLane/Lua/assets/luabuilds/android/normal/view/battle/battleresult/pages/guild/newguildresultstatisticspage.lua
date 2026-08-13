class = var_0_10000

local var_0_0 = "NewGuildResultStatisticsPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..NewBattleResultStatisticsPage"))

function var_0_1.UpdateGrade(arg_1_0)
	local var_1_0 = "battlescore/grade_label_clear"

	LoadImageSpriteAsync = var_1_10002

	var_1_10002(var_1_0, arg_1_0.gradeTxt, false)

	setActive = var_1_10002

	var_1_10002(arg_1_0.gradeIcon, false)

	return
end

function var_0_1.UpdatePainting(arg_2_0, arg_2_1)
	arg_2_0:UpdatePaintingPosition()
	arg_2_0:UpdateMvpPainting(arg_2_1)

	return
end

return var_0_1
