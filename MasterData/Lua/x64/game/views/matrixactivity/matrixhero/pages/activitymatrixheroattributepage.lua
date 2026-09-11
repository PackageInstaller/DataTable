local ActivityMatrixHeroAttributePage = class("ActivityMatrixHeroAttributePage", MatrixHeroAttributePage)

function ActivityMatrixHeroAttributePage:SetMatirxHeroInfo(arg_1_1, arg_1_2)
	self.matrix_activity_id = arg_1_1

	ActivityMatrixHeroAttributePage.super.SetMatirxHeroInfo(self, arg_1_2)
end

function ActivityMatrixHeroAttributePage:GetHeroData(arg_2_1)
	return ActivityMatrixData:GetHeroData(self.matrix_activity_id, arg_2_1)
end

return ActivityMatrixHeroAttributePage
