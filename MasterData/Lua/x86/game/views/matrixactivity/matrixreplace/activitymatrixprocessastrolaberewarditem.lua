local ActivityMatrixProcessAstrolabeRewardItem = class("ActivityMatrixProcessAstrolabeRewardItem", MatrixProcessAstrolabeRewardItem)

function ActivityMatrixProcessAstrolabeRewardItem:SetMatrixActivityId(arg_1_1)
	self.matrix_activity_id = arg_1_1
end

function ActivityMatrixProcessAstrolabeRewardItem:GetHeroData(arg_2_1)
	return ActivityMatrixData:GetHeroData(self.matrix_activity_id, arg_2_1)
end

function ActivityMatrixProcessAstrolabeRewardItem:GetHeroSkin(arg_3_1)
	return ActivityMatrixData:GetHeroSkin(self.matrix_activity_id, arg_3_1)
end

function ActivityMatrixProcessAstrolabeRewardItem:GetItemDes(arg_4_1)
	return MatrixTools.GetMatrixItemDes(arg_4_1, nil, self.matrix_activity_id)
end

return ActivityMatrixProcessAstrolabeRewardItem
