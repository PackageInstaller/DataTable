local StrategyMatrixProcessRewardItem = class("StrategyMatrixProcessRewardItem", MatrixProcessRewardItem)

function StrategyMatrixProcessRewardItem:SetMatrixActivityId(arg_1_1)
	self.matrix_activity_id = arg_1_1
end

function StrategyMatrixProcessRewardItem:GetHeroData(arg_2_1)
	return StrategyMatrixData:GetHeroDataNew(arg_2_1)
end

function StrategyMatrixProcessRewardItem:GetHeroSkin(arg_3_1)
	return StrategyMatrixData:GetHeroSkin(self.matrix_activity_id, arg_3_1)
end

function StrategyMatrixProcessRewardItem:GetItemDes(arg_4_1)
	return MatrixTools.GetMatrixItemDes(arg_4_1, nil, self.matrix_activity_id)
end

return StrategyMatrixProcessRewardItem
