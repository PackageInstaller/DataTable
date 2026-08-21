local var_0_0 = import("game.views.activity.Submodule.storyStage.summer.stage.seabed.SummerStageSeabedItem")
local var_0_1 = class("SummerSeabedStoryRemasteredItem", var_0_0)

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
end

function var_0_1.OnClick(arg_3_0)
	BattleFieldData:SetCacheStage(arg_3_0.chapterID_, arg_3_0.stageID_)
	arg_3_0:Go("subPlotSectionInfo", {
		section = arg_3_0.stageID_,
		chapterID = arg_3_0.chapterID_,
		sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT
	})
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
		arg_5_0.lineController_:SetSelectedState("3-1")
	elseif var_5_2 == 1 then
		arg_5_0.lineController_:SetSelectedState("0-1")
	else
		local var_5_3 = (var_5_2 - 1) % 4

		arg_5_0.lineController_:SetSelectedState(tostring(var_5_3))
	end
end

return var_0_1
