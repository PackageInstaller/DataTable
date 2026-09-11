local Guide_94 = class("Guide_94", BaseGuide)

function Guide_94:InitSteps()
	local var_1_0 = {}

	self:OnGuideStart()

	if ChallengeRogueTeamTools.HasSuitSkillPop() then
		table.insert(var_1_0, 9401)
	end

	self._steps = {}

	for iter_1_0 = 1, #var_1_0 do
		local var_1_1 = self:ProduceStep(var_1_0[iter_1_0])

		if var_1_1 then
			table.insert(self._steps, var_1_1)
		end
	end
end

function Guide_94:CheckGuide()
	if not GuideTool.SatisfyCondition(self.open_condition) then
		return false
	end

	return ChallengeRogueTeamData:UIGetTreasureCampMaxCnt() == 6
end

return Guide_94
