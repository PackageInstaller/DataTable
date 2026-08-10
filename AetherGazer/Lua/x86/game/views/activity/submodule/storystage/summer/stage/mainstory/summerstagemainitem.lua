SummerStageBaseItem = import("game.views.activity.Submodule.storyStage.summer.stage.SummerStageBaseItem")

local var_0_0 = class("SummerStageMainItem", SummerStageBaseItem)

function var_0_0.InitUI(arg_1_0)
	var_0_0.super.InitUI(arg_1_0)

	arg_1_0.lineController_ = ControllerUtil.GetController(arg_1_0.transform_, "Item")
end

function var_0_0.RefreshText(arg_2_0)
	local var_2_0 = ActivityStoryChapterCfg[arg_2_0.chapterID_]
	local var_2_1 = table.keyof(var_2_0.stage_list, arg_2_0.stageID_)

	arg_2_0.text_.text = string.format("%d", var_2_1)

	local var_2_2 = var_2_1 - 1

	if var_2_2 == 0 then
		arg_2_0.lineController_:SetSelectedState("-1")
	else
		local var_2_3 = var_2_2 % 2

		if var_2_3 == 0 then
			arg_2_0.lineController_:SetSelectedState(tostring(var_2_3))
		else
			arg_2_0.lineController_:SetSelectedState(tostring(var_2_2 % 4))
		end
	end
end

return var_0_0
