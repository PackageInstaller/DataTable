SubPlotBaseView = import("game.views.sectionSelect.subPlot.base.SubPlotBaseView")

local SubPlotHeraView = class("SubPlotHeraView", SubPlotBaseView)

function SubPlotHeraView:UIName()
	return "UI/MardukUI/hera/HeraStoryUI"
end

function SubPlotHeraView:GetItemClass()
	return SubPlotHeraItem
end

return SubPlotHeraView
