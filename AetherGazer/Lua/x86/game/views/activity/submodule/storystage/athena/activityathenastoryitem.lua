ActivityStoryStageBaseItem = import("game.views.activity.Submodule.storyStage.base.ActivityStoryStageBaseItem")

local var_0_0 = class("ActivityAthenaStoryItem", ActivityStoryStageBaseItem)

function var_0_0.Ctor(arg_1_0, ...)
	var_0_0.super.Ctor(arg_1_0, ...)

	arg_1_0.selectController_ = ControllerUtil.GetController(arg_1_0.transform_, "select")
end

function var_0_0.RefreshUI(arg_2_0)
	local var_2_0 = arg_2_0:GetPosition()

	arg_2_0.transform_.localPosition = Vector3(var_2_0[1], var_2_0[2], 0)

	local var_2_1 = ActivityStoryChapterCfg[arg_2_0.chapterID_]
	local var_2_2 = var_2_1.activity_id
	local var_2_3 = table.keyof(var_2_1.stage_list, arg_2_0.stageID_)

	arg_2_0.textIndex_.text = string.format("%02d", var_2_3)

	arg_2_0:RefreshClear()
end

function var_0_0.SelectorItem(arg_3_0, arg_3_1)
	if arg_3_0.stageID_ == arg_3_1 and arg_3_0:IsOpenSectionInfo() then
		arg_3_0.selectController_:SetSelectedState("on")
	else
		arg_3_0.selectController_:SetSelectedState("off")
	end
end

return var_0_0
