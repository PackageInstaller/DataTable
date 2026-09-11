local Guide_93 = class("Guide_93", BaseGuide)

function Guide_93:CheckGuide()
	if not GuideTool.SatisfyCondition(self.open_condition) then
		return false
	end

	return ChallengeRogueTeamData:UIGetTreasureCampMaxCnt() == 5
end

return Guide_93
