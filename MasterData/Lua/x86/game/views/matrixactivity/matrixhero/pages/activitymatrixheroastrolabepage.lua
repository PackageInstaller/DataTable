local ActivityMatrixHeroAstrolabePage = class("ActivityMatrixHeroAstrolabePage", MatrixHeroAstrolabePage)

function ActivityMatrixHeroAstrolabePage:SetMatirxHeroInfo(arg_1_1, arg_1_2)
	self.matrix_activity_id = arg_1_1

	ActivityMatrixHeroAstrolabePage.super.SetMatirxHeroInfo(self, arg_1_2)
end

function ActivityMatrixHeroAstrolabePage:AddUIListener()
	self:AddBtnListenerScale(self.adjustBtn_, nil, function()
		JumpTools.OpenPageByJump("activityMatrixOrigin/activityMatrixAstrolabeAdjust", {
			heroId = self.heroInfo_.id,
			selectPos = {
				0
			},
			matrix_activity_id = self.matrix_activity_id
		})
	end)
end

function ActivityMatrixHeroAstrolabePage:SelectItem(arg_4_1)
	local var_4_0 = arg_4_1:GetItemInfo()

	JumpTools.OpenPageByJump("activityMatrixOrigin/activityMatrixAstrolabeAdjust", {
		heroId = self.heroInfo_.id,
		selectPos = {
			var_4_0.posX,
			var_4_0.posY
		},
		matrix_activity_id = self.matrix_activity_id
	})
end

function ActivityMatrixHeroAstrolabePage:GetHeroData(arg_5_1)
	return ActivityMatrixData:GetHeroData(self.matrix_activity_id, arg_5_1)
end

function ActivityMatrixHeroAstrolabePage:GetAstrolabeMaxCount()
	return ActivityMatrixData:GetAstrolabeMaxCount(self.matrix_activity_id)
end

return ActivityMatrixHeroAstrolabePage
