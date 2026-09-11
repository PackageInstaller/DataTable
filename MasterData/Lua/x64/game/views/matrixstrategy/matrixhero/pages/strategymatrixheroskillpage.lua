local StrategyMatrixHeroSkillPage = class("StrategyMatrixHeroSkillPage", MatrixHeroSkillPage)

function StrategyMatrixHeroSkillPage:SetMatirxHeroInfo(arg_1_1, arg_1_2)
	self.matrix_activity_id = arg_1_1

	StrategyMatrixHeroSkillPage.super.SetMatirxHeroInfo(self, arg_1_2)
end

function StrategyMatrixHeroSkillPage:AddUIListener()
	for iter_2_0 = 1, 6 do
		self.skillItem_[iter_2_0]:RegistCallBack(function(arg_3_0)
			JumpTools.OpenPageByJump("matrixSkillUpgrade", {
				skillId = arg_3_0.id,
				heroId = arg_3_0.heroId,
				standardId = self.standardID,
				servantId = arg_3_0.servantId,
				lv = arg_3_0.lv
			})
		end)
	end

	self:AddBtnListener(self.buttonComboSkill_, nil, function()
		JumpTools.OpenPageByJump("comboSkillInfo", {
			heroID = self.heroInfo_.id
		})
	end)
end

function StrategyMatrixHeroSkillPage:GetHeroData(arg_5_1)
	return StrategyMatrixData:GetHeroData(arg_5_1)
end

return StrategyMatrixHeroSkillPage
