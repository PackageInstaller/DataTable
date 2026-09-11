local StrategyMatrixIncidentView = class("StrategyMatrixIncidentView", (import("game.views.matrixStrategy.matrixProcess.StrategyMatrixProcessView")))

function StrategyMatrixIncidentView:UIBackCount()
	return 1
end

function StrategyMatrixIncidentView:InitUI()
	StrategyMatrixIncidentView.super.InitUI(self)
	SetActive(self.m_infoBtn.gameObject, false)
end

return StrategyMatrixIncidentView
