ActivityChessItem = import("game.views.activity.Submodule.Chess.ActivityChessItem")

local SummerStoryMainWarchessItem = class("SummerStoryMainWarchessItem", ActivityChessItem)

function SummerStoryMainWarchessItem:RefreshUI()
	local var_1_0 = ChessTools.GetChapterProgress(self.chapterID_)

	self.progressText_.text = string.format("%d%%", math.floor(var_1_0))
	self.slider_.fillAmount = var_1_0 / 100
	self.textName_.text = GetI18NText(WarchessLevelCfg[self.chapterID_].name_level)
end

return SummerStoryMainWarchessItem
