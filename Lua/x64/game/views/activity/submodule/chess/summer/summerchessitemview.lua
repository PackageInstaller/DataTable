ActivityChessItem = import("game.views.activity.Submodule.Chess.ActivityChessItem")

local var_0_0 = class("SummerChessItemView", ActivityChessItem)

function var_0_0.RefreshUI(arg_1_0)
	local var_1_0 = ChessTools.GetChapterProgress(arg_1_0.chapterID_)

	arg_1_0.imageProgress_.fillAmount = var_1_0 / 100
	arg_1_0.textProress_.text = string.format("%s%%", var_1_0)
	arg_1_0.textName_.text = GetI18NText(WarchessLevelCfg[arg_1_0.chapterID_].name_level)
end

return var_0_0
