SubPlotBaseView = import("game.views.sectionSelect.subPlot.base.SubPlotBaseView")

local var_0_0 = class("SubPlotHeraView", SubPlotBaseView)

function var_0_0.UIName(arg_1_0)
	return "UI/MardukUI/hera/HeraStoryUI"
end

function var_0_0.GetItemClass(arg_2_0)
	return SubPlotHeraItem
end

return var_0_0
