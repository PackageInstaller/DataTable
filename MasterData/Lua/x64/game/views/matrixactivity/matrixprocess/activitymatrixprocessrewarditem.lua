local ActivityMatrixProcessRewardItem = class("ActivityMatrixProcessRewardItem", MatrixProcessRewardItem)

function ActivityMatrixProcessRewardItem:SetMatrixActivityId(arg_1_1)
	self.matrix_activity_id = arg_1_1
end

function ActivityMatrixProcessRewardItem:GetHeroData(arg_2_1)
	return ActivityMatrixData:GetHeroData(self.matrix_activity_id, arg_2_1)
end

function ActivityMatrixProcessRewardItem:GetHeroSkin(arg_3_1)
	return ActivityMatrixData:GetHeroSkin(self.matrix_activity_id, arg_3_1)
end

function ActivityMatrixProcessRewardItem:GetItemDes(arg_4_1)
	return MatrixTools.GetMatrixItemDes(arg_4_1, nil, self.matrix_activity_id)
end

return ActivityMatrixProcessRewardItem
