SubPlotBaseItem = import("game.views.sectionSelect.subPlot.base.SubPlotBaseItem")

local var_0_0 = class("AthenaStoryItem", SubPlotBaseItem)

function var_0_0.Ctor(arg_1_0, ...)
	var_0_0.super.Ctor(arg_1_0, ...)

	arg_1_0.selectController_ = ControllerUtil.GetController(arg_1_0.transform_, "select")
end

function var_0_0.RefreshCustomUI(arg_2_0)
	local var_2_0 = arg_2_0:GetPosition()

	arg_2_0.transform_.localPosition = Vector3(var_2_0[1], var_2_0[2], 0)

	local var_2_1 = ChapterCfg[arg_2_0.chapterID_]
	local var_2_2 = table.keyof(var_2_1.section_id_list, arg_2_0.stageID_)

	arg_2_0.textIndex_.text = string.format("%02d", var_2_2)
end

function var_0_0.Show(arg_3_0, arg_3_1)
	return
end

function var_0_0.SelectorItem(arg_4_0, arg_4_1)
	if arg_4_0.stageID_ == arg_4_1 and arg_4_0:IsOpenSectionInfo() then
		arg_4_0.selectController_:SetSelectedState("on")
	else
		arg_4_0.selectController_:SetSelectedState("off")
	end
end

return var_0_0
