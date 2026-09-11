local JumpToStep = class("JumpToStep", BaseStep)

function JumpToStep:Init(arg_1_1)
	self.team = GuideStepCfg[self._stepId].params
end

function JumpToStep:Play()
	local var_2_0 = ReserveParams.New(ReserveConst.RESERVE_TYPE.PLOT, nil, nil)

	ReserveTools.SetHeroList(var_2_0, self.team[1], self.team[2] or {
		0,
		0,
		0
	})
	ReserveTools.SetComboSkillID(var_2_0, (ComboSkillTools.GetRecommendSkillID(self.team[1], true)))
	self:OnStepEnd()
end

function JumpToStep:GetShowMask()
	if self._stepId == 405 then
		return true
	end

	return false
end

return JumpToStep
