SummerStoryMainWarchessRemasteredItem = import("game.views.activity.Submodule.storyStage.summer.main.remastered.SummerStoryMainWarchessRemasteredItem")

local var_0_0 = class("SummerChessRemasteredItem", SummerStoryMainWarchessRemasteredItem)

function var_0_0.RefreshUI(arg_1_0)
	local var_1_0 = ChessTools.GetChapterProgress(arg_1_0.chapterID_)

	arg_1_0.imageProgress_.fillAmount = var_1_0 / 100
	arg_1_0.textProress_.text = var_1_0 .. "%"
	arg_1_0.textName_.text = WarchessLevelCfg[arg_1_0.chapterID_].name_level
end

function var_0_0.OnEnter(arg_2_0)
	arg_2_0:RefreshUI()
	manager.redPoint:bindUIandKey(arg_2_0.transform_, string.format("%s_%s_%s", RedPointConst.WAR_CHESS, 71012, arg_2_0.chapterID_))
	arg_2_0:RefreshState()
end

function var_0_0.OnExit(arg_3_0)
	manager.redPoint:unbindUIandKey(arg_3_0.transform_, string.format("%s_%s_%s", RedPointConst.WAR_CHESS, 71012, arg_3_0.chapterID_))
end

return var_0_0
