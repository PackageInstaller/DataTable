SubPlotBaseView = import("game.views.sectionSelect.subPlot.base.SubPlotBaseView")

local SubPlotTyrView = class("SubPlotTyrView", SubPlotBaseView)

function SubPlotTyrView:UIName()
	return "UI/BranchlineUI/DFPlotTyreUI"
end

function SubPlotTyrView:GetItemClass()
	return SubPlotTyrItem
end

return SubPlotTyrView
