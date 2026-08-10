SummerStoryMainItem = import("game.views.activity.Submodule.storyStage.summer.main.SummerStoryMainItem")

local var_0_0 = class("SummerStoryMainRemasteredItem", SummerStoryMainItem)

function var_0_0.OnEnter(arg_1_0)
	var_0_0.super.OnEnter(arg_1_0)
	manager.redPoint:bindUIandKey(arg_1_0.transform_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, arg_1_0.chapterID_))
end

function var_0_0.OnExit(arg_2_0)
	var_0_0.super.OnExit(arg_2_0)
	manager.redPoint:unbindUIandKey(arg_2_0.transform_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT_CHAPTER, arg_2_0.chapterID_))
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.button_, nil, function()
		local var_4_0 = getChapterClientCfgByChapterID(arg_3_0.chapterID_)

		BattleFieldData:SetCacheChapterClient(var_4_0.id, var_4_0.id)
		BattleFieldData:SetCacheChapter(var_4_0.id, arg_3_0.chapterID_)
		BattleStageAction.ClickSubPlot(arg_3_0.chapterID_)
		arg_3_0:Go("/summerStoryRemastered", {
			chapterID = arg_3_0.chapterID_
		})
	end)
end

function var_0_0.RefreshUI(arg_5_0)
	local var_5_0 = #ChapterCfg[arg_5_0.chapterID_].section_id_list
	local var_5_1 = (var_5_0 - ChapterTools.GetUnclearStageCnt(arg_5_0.chapterID_)) / var_5_0

	arg_5_0.progressText_.text = string.format("%d%%", var_5_1 * 100)
	arg_5_0.slider_.fillAmount = var_5_1

	if var_5_1 < 1 then
		arg_5_0.controller_:SetSelectedState("enter")
	else
		arg_5_0.controller_:SetSelectedState("false")
	end
end

return var_0_0
