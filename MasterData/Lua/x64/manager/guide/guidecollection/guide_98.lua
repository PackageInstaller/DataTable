local Guide_98 = class("Guide_98", BaseGuide)

function Guide_98:CheckGuide()
	if not GuideTool.SatisfyCondition(self.open_condition) then
		return false
	end

	return ChallengeRogueTeamData:IsFinishGuide()
end

return Guide_98
