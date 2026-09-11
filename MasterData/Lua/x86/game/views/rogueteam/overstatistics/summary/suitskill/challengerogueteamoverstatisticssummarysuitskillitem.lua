local ChallengeRogueTeamOverStatisticsSummarySuitSkillItem = class("ChallengeRogueTeamOverStatisticsSummarySuitSkillItem", ReduxView)

function ChallengeRogueTeamOverStatisticsSummarySuitSkillItem:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.suitSkillID_ = arg_1_3
	self.cnt_ = arg_1_4

	self:RefreshUI()
end

function ChallengeRogueTeamOverStatisticsSummarySuitSkillItem:Dispose()
	ChallengeRogueTeamOverStatisticsSummarySuitSkillItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function ChallengeRogueTeamOverStatisticsSummarySuitSkillItem:AddListeners()
	return
end

function ChallengeRogueTeamOverStatisticsSummarySuitSkillItem:RefreshUI()
	self.icon_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetCampIcon(RogueTeamItemCfg[self.suitSkillID_].camp[1]))
	self.numText_.text = string.format("%d", self.cnt_)

	SetActive(self.gameObject_, true)
end

return ChallengeRogueTeamOverStatisticsSummarySuitSkillItem
