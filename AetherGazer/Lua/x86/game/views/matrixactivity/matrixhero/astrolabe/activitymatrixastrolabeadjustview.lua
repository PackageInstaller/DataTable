local var_0_0 = class("ActivityMatrixAstrolabeAdjustView", MatrixAstrolabeAdjustView)

function var_0_0.OnEnter(arg_1_0)
	arg_1_0.matrix_activity_id = arg_1_0.params_.matrix_activity_id

	var_0_0.super.OnEnter(arg_1_0)
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.overviewBtn_, nil, function()
		JumpTools.OpenPageByJump("activityMatrixOrigin/activityMatrixMiniHero")
	end)
end

function var_0_0.OnTop(arg_4_0)
	return
end

function var_0_0.GetHeroData(arg_5_0, arg_5_1)
	return ActivityMatrixData:GetHeroData(arg_5_0.matrix_activity_id, arg_5_1)
end

return var_0_0
