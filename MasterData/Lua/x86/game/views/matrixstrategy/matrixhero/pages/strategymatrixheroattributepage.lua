local StrategyMatrixHeroAttributePage = class("StrategyMatrixHeroAttributePage", MatrixHeroAttributePage)

function StrategyMatrixHeroAttributePage:SetMatirxHeroInfo(arg_1_1, arg_1_2)
	self.matrix_activity_id = arg_1_1

	StrategyMatrixHeroAttributePage.super.SetMatirxHeroInfo(self, arg_1_2)
end

function StrategyMatrixHeroAttributePage:GetHeroData(arg_2_1)
	return StrategyMatrixData:GetHeroData(arg_2_1)
end

return StrategyMatrixHeroAttributePage
