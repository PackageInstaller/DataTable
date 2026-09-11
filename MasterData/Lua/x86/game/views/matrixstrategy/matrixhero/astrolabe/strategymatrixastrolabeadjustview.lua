local StrategyMatrixAstrolabeAdjustView = class("StrategyMatrixAstrolabeAdjustView", MatrixAstrolabeAdjustView)

function StrategyMatrixAstrolabeAdjustView:OnEnter()
	self.matrix_activity_id = self.params_.matrix_activity_id

	StrategyMatrixAstrolabeAdjustView.super.OnEnter(self)
end

function StrategyMatrixAstrolabeAdjustView:UIName()
	return "UI/StrategyMatrix/StrategyMatrixAstrolabeAdjustUI"
end

function StrategyMatrixAstrolabeAdjustView:AddListeners()
	return
end

function StrategyMatrixAstrolabeAdjustView:OnTop()
	return
end

function StrategyMatrixAstrolabeAdjustView:GetHeroData(arg_5_1)
	return StrategyMatrixData:GetHeroData(arg_5_1)
end

return StrategyMatrixAstrolabeAdjustView
