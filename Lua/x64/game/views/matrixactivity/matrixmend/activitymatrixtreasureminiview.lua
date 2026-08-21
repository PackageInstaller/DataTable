local var_0_0 = class("ActivityMatrixTreasureMiniView", MatrixTreasureMiniView)

function var_0_0.OnEnter(arg_1_0)
	arg_1_0.matrix_activity_id = arg_1_0.params_.matrix_activity_id

	var_0_0.super.OnEnter(arg_1_0)
end

function var_0_0.OnTop(arg_2_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		ACTIVITY_MATRIX_COIN
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_MATRIX_DESC")
	manager.windowBar:SetActivityId(ACTIVITY_MATRIX_COIN, arg_2_0.matrix_activity_id)
end

function var_0_0.GetArtifactList(arg_3_0)
	return ActivityMatrixData:GetArtifactList(arg_3_0.matrix_activity_id)
end

return var_0_0
