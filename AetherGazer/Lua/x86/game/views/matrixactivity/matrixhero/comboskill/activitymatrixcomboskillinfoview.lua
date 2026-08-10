local var_0_0 = class("ActivityMatrixComboSkillInfoView", MatrixComboSkillInfoView)

function var_0_0.AddListeners(arg_1_0)
	arg_1_0:AddBtnListener(arg_1_0.backBtn_, nil, function()
		JumpTools.OpenPageByJump("activityMatrixOrigin/activityMatrixMiniHero")
	end)
end

return var_0_0
