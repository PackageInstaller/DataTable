local ActivityMatrixComboSkillInfoView = class("ActivityMatrixComboSkillInfoView", MatrixComboSkillInfoView)

function ActivityMatrixComboSkillInfoView:AddListeners()
	self:AddBtnListener(self.backBtn_, nil, function()
		JumpTools.OpenPageByJump("activityMatrixOrigin/activityMatrixMiniHero")
	end)
end

return ActivityMatrixComboSkillInfoView
