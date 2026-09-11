local ActivityMatrixHeroEquipPage = class("ActivityMatrixHeroEquipPage", MatrixHeroEquipPage)

function ActivityMatrixHeroEquipPage:SetMatirxHeroInfo(arg_1_1, arg_1_2)
	self.matrix_activity_id = arg_1_1

	ActivityMatrixHeroEquipPage.super.SetMatirxHeroInfo(self, arg_1_2)
end

function ActivityMatrixHeroEquipPage:GetHeroData(arg_2_1)
	return ActivityMatrixData:GetHeroData(self.matrix_activity_id, arg_2_1)
end

function ActivityMatrixHeroEquipPage:GetHeroEquipMaxCount()
	return ActivityMatrixData:GetHeroEquipMaxCount(self.matrix_activity_id)
end

return ActivityMatrixHeroEquipPage
