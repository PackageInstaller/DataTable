local var_0_0 = class("ActivityMatrixHeroEquipPage", MatrixHeroEquipPage)

function var_0_0.SetMatirxHeroInfo(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.matrix_activity_id = arg_1_1

	var_0_0.super.SetMatirxHeroInfo(arg_1_0, arg_1_2)
end

function var_0_0.GetHeroData(arg_2_0, arg_2_1)
	return ActivityMatrixData:GetHeroData(arg_2_0.matrix_activity_id, arg_2_1)
end

function var_0_0.GetHeroEquipMaxCount(arg_3_0)
	return ActivityMatrixData:GetHeroEquipMaxCount(arg_3_0.matrix_activity_id)
end

return var_0_0
