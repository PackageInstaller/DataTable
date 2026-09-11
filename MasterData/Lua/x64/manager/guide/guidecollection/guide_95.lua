local Guide_95 = class("Guide_95", BaseGuide)

function Guide_95:CheckGuide()
	if not GuideTool.SatisfyCondition(self.open_condition) then
		return false
	end

	return ChallengeRogueTeamData:UIGetOperatePopType() == ChallengeRogueTeamConst.NODE_UNOPERATE_EVENT.RELIC
end

return Guide_95
