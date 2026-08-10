local var_0_0 = class("MatrixHeroSkillPageCom", MatrixHeroSkillPage)

function var_0_0.AddUIListener(arg_1_0)
	for iter_1_0 = 1, 6 do
		arg_1_0.skillItem_[iter_1_0]:RegistCallBack(function(arg_2_0)
			JumpTools.OpenPageByJump("matrixSkillUpgrade", {
				skillId = arg_2_0.id,
				heroId = arg_2_0.heroId,
				standardId = arg_1_0.standardId_,
				servantId = arg_2_0.servantId,
				lv = arg_2_0.lv
			})
		end)
	end

	arg_1_0:AddBtnListener(arg_1_0.buttonComboSkill_, nil, function()
		JumpTools.OpenPageByJump("comboSkillInfo", {
			heroID = arg_1_0.heroInfo_.id
		})
	end)
end

function var_0_0.SetMatirxHeroInfo(arg_4_0, arg_4_1)
	arg_4_0.standardId_ = arg_4_1
	arg_4_0.heroId_ = HeroStandardSystemCfg[arg_4_1].hero_id

	local var_4_0, var_4_1 = GetVirtualData(arg_4_1)

	arg_4_0.heroInfo_ = var_4_0
	arg_4_0.heroInfo_.servantId = 0

	arg_4_0:UpdateView()
end

return var_0_0
