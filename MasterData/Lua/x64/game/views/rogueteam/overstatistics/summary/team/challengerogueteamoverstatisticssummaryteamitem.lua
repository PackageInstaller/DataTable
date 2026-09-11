local ChallengeRogueTeamOverStatisticsSummaryTeamItem = class("ChallengeRogueTeamOverStatisticsSummaryTeamItem", ReduxView)

function ChallengeRogueTeamOverStatisticsSummaryTeamItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()
end

function ChallengeRogueTeamOverStatisticsSummaryTeamItem:Dispose()
	ChallengeRogueTeamOverStatisticsSummaryTeamItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function ChallengeRogueTeamOverStatisticsSummaryTeamItem:AddListeners()
	return
end

function ChallengeRogueTeamOverStatisticsSummaryTeamItem:SetData(arg_4_1)
	self.icon_.sprite = getSpriteViaConfig("HeroIcon", arg_4_1.trialID ~= 0 and HeroStandardSystemCfg[arg_4_1.trialID].skin_id or ChallengeRogueTeamData:GetHeroBattleUsingSkinInfo(arg_4_1.heroID).id)

	self:Show(true)
end

function ChallengeRogueTeamOverStatisticsSummaryTeamItem:Show(arg_5_1)
	SetActive(self.gameObject_, arg_5_1)
end

return ChallengeRogueTeamOverStatisticsSummaryTeamItem
