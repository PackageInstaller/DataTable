local ChallengeRogueTeamSuitSkillData = class("ChallengeRogueTeamSuitSkillData")

function ChallengeRogueTeamSuitSkillData:ExportMethod()
	return {
		"SuitSkillSetValue",
		"SuitSkillGetID",
		"SuitSkillGetEnergyValue",
		"SuitSkillClear"
	}
end

function ChallengeRogueTeamSuitSkillData:Init()
	self.suitSkillID_ = 0
	self.energyValue_ = 0
end

function ChallengeRogueTeamSuitSkillData:SuitSkillSetValue(arg_3_1)
	self.suitSkillID_ = arg_3_1.suitSkillID
	self.energyValue_ = arg_3_1.energyValue
end

function ChallengeRogueTeamSuitSkillData:SuitSkillGetID()
	return self.suitSkillID_
end

function ChallengeRogueTeamSuitSkillData:SuitSkillGetEnergyValue()
	return self.energyValue_
end

function ChallengeRogueTeamSuitSkillData:SuitSkillClear()
	self.suitSkillID_ = 0
	self.energyValue_ = 0
end

return ChallengeRogueTeamSuitSkillData
