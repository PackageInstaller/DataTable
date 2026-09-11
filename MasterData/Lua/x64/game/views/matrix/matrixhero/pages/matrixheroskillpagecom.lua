local MatrixHeroSkillPageCom = class("MatrixHeroSkillPageCom", MatrixHeroSkillPage)

function MatrixHeroSkillPageCom:AddUIListener()
	for iter_1_0 = 1, 6 do
		self.skillItem_[iter_1_0]:RegistCallBack(function(arg_2_0)
			JumpTools.OpenPageByJump("matrixSkillUpgrade", {
				skillId = arg_2_0.id,
				heroId = arg_2_0.heroId,
				standardId = self.standardId_,
				servantId = arg_2_0.servantId,
				lv = arg_2_0.lv
			})
		end)
	end

	self:AddBtnListener(self.buttonComboSkill_, nil, function()
		JumpTools.OpenPageByJump("comboSkillInfo", {
			heroID = self.heroInfo_.id
		})
	end)
end

function MatrixHeroSkillPageCom:SetMatirxHeroInfo(arg_4_1)
	self.standardId_ = arg_4_1
	self.heroId_ = HeroStandardSystemCfg[arg_4_1].hero_id

	local var_4_0, var_4_1 = GetVirtualData(arg_4_1)

	self.heroInfo_ = var_4_0
	self.heroInfo_.servantId = 0

	self:UpdateView()
end

return MatrixHeroSkillPageCom
