SubPlotBaseItem = import("game.views.sectionSelect.subPlot.base.SubPlotBaseItem")

local var_0_0 = class("SubPlotHeraItem", SubPlotBaseItem)

function var_0_0.Ctor(arg_1_0, ...)
	var_0_0.super.Ctor(arg_1_0, ...)

	arg_1_0.lineController_ = ControllerUtil.GetController(arg_1_0.transform_, "connect")
end

function var_0_0.RefreshCustomUI(arg_2_0)
	local var_2_0 = ChapterCfg[arg_2_0.chapterID_]
	local var_2_1 = table.keyof(var_2_0.section_id_list, arg_2_0.stageID_)

	arg_2_0.textIndex_.text = string.format("%02d", var_2_1)

	if var_2_1 == 1 then
		arg_2_0.lineController_:SetSelectedState("01")
	elseif var_2_1 % 2 == 0 then
		arg_2_0.lineController_:SetSelectedState("02")
	else
		arg_2_0.lineController_:SetSelectedState("03")
	end
end

return var_0_0
