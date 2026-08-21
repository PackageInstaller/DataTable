SubPlotBaseView = import("game.views.sectionSelect.subPlot.base.SubPlotBaseView")

local var_0_0 = class("AthenaStoryView", SubPlotBaseView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Operation/ChapterSectionUI/VolumeIIIDownSubPlotUI"
end

function var_0_0.OnEnter(arg_2_0)
	var_0_0.super.OnEnter(arg_2_0)

	local var_2_0 = arg_2_0.params_.chapterClientID

	if not getData("SUB_PLOT_CHAPTER", "NEW_TAG_" .. var_2_0) then
		saveData("SUB_PLOT_CHAPTER", "NEW_TAG_" .. var_2_0, 1)
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.COMBAT_SUB_POLT_NEW_TAG, var_2_0), 0, RedPointStyle.SHOW_NEW_TAG)
	end
end

function var_0_0.GetItemClass(arg_3_0)
	return AthenaStoryItem
end

return var_0_0
