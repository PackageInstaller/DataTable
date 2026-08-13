class = var_0_10000

local var_0_0 = "SailingShip3PtPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.CorePage.CorePageNewPtTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	setText = var_1

	local var_1_0 = arg_1_0.get

	i18n = var_1_10003

	var_1(var_1_0, var_1_10003("word_got"))

	return
end

function var_0_1.OnShowFlush(arg_2_0)
	setCanvasGroupAlpha = var_1_10001

	var_1_10001(arg_2_0._tf, 1)

	return
end

return var_0_1
