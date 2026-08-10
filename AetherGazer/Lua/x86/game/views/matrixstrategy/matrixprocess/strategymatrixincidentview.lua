local var_0_0 = import("game.views.matrixStrategy.matrixProcess.StrategyMatrixProcessView")
local var_0_1 = class("StrategyMatrixIncidentView", var_0_0)

function var_0_1.UIBackCount(arg_1_0)
	return 1
end

function var_0_1.InitUI(arg_2_0)
	var_0_1.super.InitUI(arg_2_0)
	SetActive(arg_2_0.m_infoBtn.gameObject, false)
end

return var_0_1
