local var_0_0 = class("StrategyMatrixProcessAstrolabeRewardItem", MatrixProcessAstrolabeRewardItem)

function var_0_0.SetMatrixActivityId(arg_1_0, arg_1_1)
	arg_1_0.matrix_activity_id = arg_1_1
end

function var_0_0.GetHeroData(arg_2_0, arg_2_1)
	return StrategyMatrixData:GetHeroDataNew(arg_2_1)
end

function var_0_0.GetHeroSkin(arg_3_0, arg_3_1)
	return StrategyMatrixData:GetHeroSkin(arg_3_0.matrix_activity_id, arg_3_1)
end

function var_0_0.GetItemDes(arg_4_0, arg_4_1)
	return MatrixTools.GetMatrixItemDes(arg_4_1, nil, arg_4_0.matrix_activity_id)
end

return var_0_0
