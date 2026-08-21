local var_0_0 = class("ActivityMatrixHeroSkillPage", MatrixHeroSkillPage)

function var_0_0.SetMatirxHeroInfo(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.matrix_activity_id = arg_1_1

	var_0_0.super.SetMatirxHeroInfo(arg_1_0, arg_1_2)
end

function var_0_0.AddUIListener(arg_2_0)
	for iter_2_0 = 1, 6 do
		arg_2_0.skillItem_[iter_2_0]:RegistCallBack(function(arg_3_0)
			JumpTools.OpenPageByJump("matrixSkillUpgrade", {
				skillId = arg_3_0.id,
				heroId = arg_3_0.heroId,
				standardId = arg_2_0.standardID,
				servantId = arg_3_0.servantId,
				lv = arg_3_0.lv
			})
		end)
	end

	arg_2_0:AddBtnListener(arg_2_0.buttonComboSkill_, nil, function()
		arg_2_0:Go("activityMatrixOrigin/activityMatrixComboSkillInfo", {
			heroId = arg_2_0.heroInfo_.id
		})
	end)
end

function var_0_0.GetHeroData(arg_5_0, arg_5_1)
	return ActivityMatrixData:GetHeroData(arg_5_0.matrix_activity_id, arg_5_1)
end

return var_0_0
