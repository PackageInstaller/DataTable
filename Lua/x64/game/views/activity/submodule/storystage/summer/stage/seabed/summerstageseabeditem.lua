SummerStageBaseItem = import("game.views.activity.Submodule.storyStage.summer.stage.SummerStageBaseItem")

local var_0_0 = class("SummerStageSeabedItem", SummerStageBaseItem)

function var_0_0.InitUI(arg_1_0)
	var_0_0.super.InitUI(arg_1_0)

	arg_1_0.lineController_ = ControllerUtil.GetController(arg_1_0.transform_, "Item")
end

function var_0_0.RefreshText(arg_2_0)
	local var_2_0 = ActivityStoryChapterCfg[arg_2_0.chapterID_]
	local var_2_1 = var_2_0.activity_id
	local var_2_2 = table.keyof(var_2_0.stage_list, arg_2_0.stageID_)

	arg_2_0.text_.text = string.format("%d", var_2_2)

	local var_2_3 = var_2_2 - 1

	if var_2_3 == 0 then
		arg_2_0.lineController_:SetSelectedState("3-1")
	elseif var_2_3 == 1 then
		arg_2_0.lineController_:SetSelectedState("0-1")
	else
		local var_2_4 = (var_2_3 - 1) % 4

		arg_2_0.lineController_:SetSelectedState(tostring(var_2_4))
	end
end

return var_0_0
