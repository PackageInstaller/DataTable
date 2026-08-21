local var_0_0 = class("SailingShip3PtPage", import("view.activity.CorePage.CorePageNewPtTemplatePage"))

function var_0_0.OnInit(arg_1_0)
	var_0_0.super.OnInit(arg_1_0)
	setText(arg_1_0.get, i18n("word_got"))

	return
end

function var_0_0.OnShowFlush(arg_2_0)
	setCanvasGroupAlpha(arg_2_0._tf, 1)

	return
end

return var_0_0
