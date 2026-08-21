local var_0_0 = class("ActivityMatrixHeroAstrolabePage", MatrixHeroAstrolabePage)

function var_0_0.SetMatirxHeroInfo(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.matrix_activity_id = arg_1_1

	var_0_0.super.SetMatirxHeroInfo(arg_1_0, arg_1_2)
end

function var_0_0.AddUIListener(arg_2_0)
	arg_2_0:AddBtnListenerScale(arg_2_0.adjustBtn_, nil, function()
		JumpTools.OpenPageByJump("activityMatrixOrigin/activityMatrixAstrolabeAdjust", {
			heroId = arg_2_0.heroInfo_.id,
			selectPos = {
				0
			},
			matrix_activity_id = arg_2_0.matrix_activity_id
		})
	end)
end

function var_0_0.SelectItem(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:GetItemInfo()

	JumpTools.OpenPageByJump("activityMatrixOrigin/activityMatrixAstrolabeAdjust", {
		heroId = arg_4_0.heroInfo_.id,
		selectPos = {
			var_4_0.posX,
			var_4_0.posY
		},
		matrix_activity_id = arg_4_0.matrix_activity_id
	})
end

function var_0_0.GetHeroData(arg_5_0, arg_5_1)
	return ActivityMatrixData:GetHeroData(arg_5_0.matrix_activity_id, arg_5_1)
end

function var_0_0.GetAstrolabeMaxCount(arg_6_0)
	return ActivityMatrixData:GetAstrolabeMaxCount(arg_6_0.matrix_activity_id)
end

return var_0_0
