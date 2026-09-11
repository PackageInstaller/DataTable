local StrategyMatrixHeroEquipPage = class("StrategyMatrixHeroEquipPage", MatrixHeroEquipPage)

function StrategyMatrixHeroEquipPage:SetMatirxHeroInfo(arg_1_1, arg_1_2)
	self.matrix_activity_id = arg_1_1

	StrategyMatrixHeroEquipPage.super.SetMatirxHeroInfo(self, arg_1_2)
end

function StrategyMatrixHeroEquipPage:GetHeroData(arg_2_1)
	return StrategyMatrixData:GetHeroData(arg_2_1)
end

function StrategyMatrixHeroEquipPage:GetHeroEquipMaxCount()
	return StrategyMatrixData:GetHeroEquipMaxCount(self.matrix_activity_id)
end

return StrategyMatrixHeroEquipPage
