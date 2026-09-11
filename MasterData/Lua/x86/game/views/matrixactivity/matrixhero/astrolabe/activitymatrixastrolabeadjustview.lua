local ActivityMatrixAstrolabeAdjustView = class("ActivityMatrixAstrolabeAdjustView", MatrixAstrolabeAdjustView)

function ActivityMatrixAstrolabeAdjustView:OnEnter()
	self.matrix_activity_id = self.params_.matrix_activity_id

	ActivityMatrixAstrolabeAdjustView.super.OnEnter(self)
end

function ActivityMatrixAstrolabeAdjustView:AddListeners()
	self:AddBtnListener(self.overviewBtn_, nil, function()
		JumpTools.OpenPageByJump("activityMatrixOrigin/activityMatrixMiniHero")
	end)
end

function ActivityMatrixAstrolabeAdjustView:OnTop()
	return
end

function ActivityMatrixAstrolabeAdjustView:GetHeroData(arg_5_1)
	return ActivityMatrixData:GetHeroData(self.matrix_activity_id, arg_5_1)
end

return ActivityMatrixAstrolabeAdjustView
