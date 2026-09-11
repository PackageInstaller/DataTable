local Guide_96 = class("Guide_96", BaseGuide)

function Guide_96:CheckGuide()
	if not GuideTool.SatisfyCondition(self.open_condition) then
		return false
	end

	return ChallengeRogueTeamData:UIGetOperatePopType() == ChallengeRogueTeamConst.NODE_UNOPERATE_EVENT.MECHANISM
end

return Guide_96
