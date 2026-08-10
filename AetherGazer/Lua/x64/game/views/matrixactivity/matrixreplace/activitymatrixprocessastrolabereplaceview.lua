local var_0_0 = class("ActivityMatrixProcessAstrolabeReplaceView", MatrixProcessAstrolabeReplaceView)

function var_0_0.InitUI(arg_1_0)
	arg_1_0:BindCfgUI()

	arg_1_0.item_ = ActivityMatrixProcessRewardItem.New(arg_1_0.m_item)
	arg_1_0.list_ = LuaList.New(handler(arg_1_0, arg_1_0.indexItem), arg_1_0.m_list, ActivityMatrixProcessAstrolabeRewardItem)
end

function var_0_0.indexItem(arg_2_0, arg_2_1, arg_2_2)
	arg_2_2:SetMatrixActivityId(arg_2_0.matrix_activity_id)
	var_0_0.super.indexItem(arg_2_0, arg_2_1, arg_2_2)
end

function var_0_0.OnEnter(arg_3_0)
	arg_3_0.matrix_activity_id = arg_3_0.params_.matrix_activity_id

	arg_3_0.item_:SetMatrixActivityId(arg_3_0.matrix_activity_id)
	var_0_0.super.OnEnter(arg_3_0)
end

function var_0_0.GetHeroData(arg_4_0, arg_4_1)
	return ActivityMatrixData:GetHeroData(arg_4_0.matrix_activity_id, arg_4_1)
end

return var_0_0
