SubPlotBaseView = import("game.views.sectionSelect.subPlot.base.SubPlotBaseView")

local var_0_0 = class("SubPlotTyrView", SubPlotBaseView)

function var_0_0.UIName(arg_1_0)
	return "UI/BranchlineUI/DFPlotTyreUI"
end

function var_0_0.GetItemClass(arg_2_0)
	return SubPlotTyrItem
end

return var_0_0
