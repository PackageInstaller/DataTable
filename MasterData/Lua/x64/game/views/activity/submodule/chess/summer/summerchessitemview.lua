ActivityChessItem = import("game.views.activity.Submodule.Chess.ActivityChessItem")

local SummerChessItemView = class("SummerChessItemView", ActivityChessItem)

function SummerChessItemView:RefreshUI()
	local var_1_0 = ChessTools.GetChapterProgress(self.chapterID_)

	self.imageProgress_.fillAmount = var_1_0 / 100
	self.textProress_.text = string.format("%s%%", var_1_0)
	self.textName_.text = GetI18NText(WarchessLevelCfg[self.chapterID_].name_level)
end

return SummerChessItemView
