local var_0_0 = import("game.views.activity.Submodule.storyStage.StoryStageItemView")
local var_0_1 = class("HellaStoryRemasteredItem", var_0_0)

function var_0_1.RefreshLockData(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.selectChapterID_ = arg_1_2
end

function var_0_1.RefreshClearData(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = BattleStageData:GetStageData()[arg_2_1]

	if var_2_0 and var_2_0.clear_times > 0 then
		arg_2_0.isClear_ = true
	else
		arg_2_0.isClear_ = false
	end
end

function var_0_1.OnClick(arg_3_0)
	BattleFieldData:SetCacheStage(arg_3_0.selectChapterID_, arg_3_0.stageID_)
	arg_3_0:Go("subPlotSectionInfo", {
		chapterID = arg_3_0.selectChapterID_,
		section = arg_3_0.stageID_,
		sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT
	})
end

function var_0_1.IsOpenSectionInfo(arg_4_0)
	return arg_4_0:IsOpenRoute("subPlotSectionInfo")
end

return var_0_1
