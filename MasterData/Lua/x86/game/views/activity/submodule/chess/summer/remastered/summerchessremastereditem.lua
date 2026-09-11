SummerStoryMainWarchessRemasteredItem = import("game.views.activity.Submodule.storyStage.summer.main.remastered.SummerStoryMainWarchessRemasteredItem")

local SummerChessRemasteredItem = class("SummerChessRemasteredItem", SummerStoryMainWarchessRemasteredItem)

function SummerChessRemasteredItem:RefreshUI()
	local var_1_0 = ChessTools.GetChapterProgress(self.chapterID_)

	self.imageProgress_.fillAmount = var_1_0 / 100
	self.textProress_.text = var_1_0 .. "%"
	self.textName_.text = WarchessLevelCfg[self.chapterID_].name_level
end

function SummerChessRemasteredItem:OnEnter()
	self:RefreshUI()
	manager.redPoint:bindUIandKey(self.transform_, string.format("%s_%s_%s", RedPointConst.WAR_CHESS, 71012, self.chapterID_))
	self:RefreshState()
end

function SummerChessRemasteredItem:OnExit()
	manager.redPoint:unbindUIandKey(self.transform_, string.format("%s_%s_%s", RedPointConst.WAR_CHESS, 71012, self.chapterID_))
end

return SummerChessRemasteredItem
