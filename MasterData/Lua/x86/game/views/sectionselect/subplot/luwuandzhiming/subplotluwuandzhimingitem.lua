SubPlotBaseItem = import("game.views.sectionSelect.subPlot.base.SubPlotBaseItem")

local SubPlotLuWuAndZhiMingItem = class("SubPlotLuWuAndZhiMingItem", SubPlotBaseItem)

function SubPlotLuWuAndZhiMingItem:RefreshCustomUI()
	self.textIndex_.text = BattleActivityStoryStageCfg[self.stageID_].name
end

return SubPlotLuWuAndZhiMingItem
