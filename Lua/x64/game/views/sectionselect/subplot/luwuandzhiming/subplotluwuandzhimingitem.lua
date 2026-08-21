SubPlotBaseItem = import("game.views.sectionSelect.subPlot.base.SubPlotBaseItem")

local var_0_0 = class("SubPlotLuWuAndZhiMingItem", SubPlotBaseItem)

function var_0_0.RefreshCustomUI(arg_1_0)
	local var_1_0 = BattleActivityStoryStageCfg[arg_1_0.stageID_]

	arg_1_0.textIndex_.text = var_1_0.name
end

return var_0_0
