local ChallengeRogueAttributeValueData = class("ChallengeRogueAttributeValueData")

function ChallengeRogueAttributeValueData:ExportMethod()
	return {
		"AttributeUpdate",
		"AttributeClearData",
		"AttributeGetValue",
		"AttributeMechanismSetValue"
	}
end

function ChallengeRogueAttributeValueData:Init()
	self.attributeList_ = {}
end

function ChallengeRogueAttributeValueData:AttributeUpdate(arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_1.attr_list) do
		self.attributeList_[iter_3_1.attr_id] = iter_3_1.value

		if iter_3_1.attr_id == ChallengeRogueTeamConst.ATTRIBUTE_ENUM.MECHANISM_VALUE or iter_3_1.attr_id == ChallengeRogueTeamConst.ATTRIBUTE_ENUM.MECHANISM_THRESHOLD_VALUE then
			manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_UPDATE_WINDOW)
		end
	end
end

function ChallengeRogueAttributeValueData:AttributeGetValue(arg_4_1)
	return self.attributeList_[arg_4_1] or RogueTeamAttributeCfg[arg_4_1].default
end

function ChallengeRogueAttributeValueData:AttributeClearData()
	self.attributeList_ = {}
end

function ChallengeRogueAttributeValueData:AttributeMechanismSetValue(arg_6_1)
	self.attributeList_[ChallengeRogueTeamConst.ATTRIBUTE_ENUM.MECHANISM_VALUE] = arg_6_1
end

return ChallengeRogueAttributeValueData
