local StrategyMatrixHeroAstrolabePage = class("StrategyMatrixHeroAstrolabePage", MatrixHeroAstrolabePage)

function StrategyMatrixHeroAstrolabePage:SetMatirxHeroInfo(arg_1_1, arg_1_2)
	self.matrix_activity_id = arg_1_1

	StrategyMatrixHeroAstrolabePage.super.SetMatirxHeroInfo(self, arg_1_2)
end

function StrategyMatrixHeroAstrolabePage:AddUIListener()
	self:AddBtnListenerScale(self.adjustBtn_, nil, function()
		JumpTools.OpenPageByJump("/strategyMatrixAstrolabeAdjust", {
			heroId = self.heroInfo_.id,
			selectPos = {
				0
			},
			matrix_activity_id = self.matrix_activity_id
		})
	end)
end

function StrategyMatrixHeroAstrolabePage:SelectItem(arg_4_1)
	local var_4_0 = arg_4_1:GetItemInfo()

	JumpTools.OpenPageByJump("/strategyMatrixAstrolabeAdjust", {
		heroId = self.heroInfo_.id,
		selectPos = {
			var_4_0.posX,
			var_4_0.posY
		},
		matrix_activity_id = self.matrix_activity_id
	})
end

function StrategyMatrixHeroAstrolabePage:GetHeroData(arg_5_1)
	return StrategyMatrixData:GetHeroData(arg_5_1)
end

function StrategyMatrixHeroAstrolabePage:GetAstrolabeMaxCount()
	return StrategyMatrixData:GetAstrolabeMaxCount(self.matrix_activity_id)
end

return StrategyMatrixHeroAstrolabePage
