local var_0_0 = class("ActivityMatrixProcessWeaponReplaceView", MatrixProcessWeaponReplaceView)

function var_0_0.InitUI(arg_1_0)
	arg_1_0:BindCfgUI()

	arg_1_0.item_l = ActivityMatrixProcessRewardItem.New(arg_1_0.m_item_l)
	arg_1_0.item_r = ActivityMatrixProcessRewardItem.New(arg_1_0.m_item_r)
end

function var_0_0.OnEnter(arg_2_0)
	arg_2_0.matrix_activity_id = arg_2_0.params_.matrix_activity_id

	arg_2_0.item_l:SetMatrixActivityId(arg_2_0.matrix_activity_id)
	arg_2_0.item_r:SetMatrixActivityId(arg_2_0.matrix_activity_id)
	var_0_0.super.OnEnter(arg_2_0)
end

function var_0_0.GetHeroData(arg_3_0, arg_3_1)
	return ActivityMatrixData:GetHeroData(arg_3_0.matrix_activity_id, arg_3_1)
end

return var_0_0
