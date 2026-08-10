local var_0_0 = import("game.views.activity.Submodule.storyStage.summer.stage.mainStory.SummerStageMainItem")
local var_0_1 = class("SummerStoryRemasteredItem", var_0_0)

function var_0_1.RefreshLockData(arg_1_0)
	arg_1_0.isLock_ = false
end

function var_0_1.RefreshData(arg_2_0)
	local var_2_0 = BattleStageData:GetStageData()[arg_2_0.stageID_]

	if var_2_0 then
		arg_2_0.clearTimes_ = var_2_0.clear_times
	else
		arg_2_0.clearTimes_ = 0
	end

	arg_2_0.isLock_ = StageTools.IsLockSubChapterStage(arg_2_0.chapterID_, arg_2_0.stageID_)
end

function var_0_1.OnClick(arg_3_0)
	if arg_3_0.isLock_ then
		ShowTips("ACTIVITY_FINISH_ALL_SUMMER_CHESS")
	else
		BattleFieldData:SetCacheStage(arg_3_0.chapterID_, arg_3_0.stageID_)
		arg_3_0:Go("subPlotSectionInfo", {
			section = arg_3_0.stageID_,
			chapterID = arg_3_0.chapterID_,
			sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT
		})
	end
end

function var_0_1.IsOpenSectionInfo(arg_4_0)
	return arg_4_0:IsOpenRoute("subPlotSectionInfo")
end

function var_0_1.RefreshText(arg_5_0)
	local var_5_0 = ChapterCfg[arg_5_0.chapterID_]
	local var_5_1 = table.keyof(var_5_0.section_id_list, arg_5_0.stageID_)

	arg_5_0.text_.text = string.format("%d", var_5_1)

	local var_5_2 = var_5_1 - 1

	if var_5_2 == 0 then
		arg_5_0.lineController_:SetSelectedState("-1")
	else
		local var_5_3 = var_5_2 % 2

		if var_5_3 == 0 then
			arg_5_0.lineController_:SetSelectedState(tostring(var_5_3))
		else
			arg_5_0.lineController_:SetSelectedState(tostring(var_5_2 % 4))
		end
	end
end

return var_0_1
