local ChallengeRogueTeamOverStatisticsSummaryRelicItem = class("ChallengeRogueTeamOverStatisticsSummaryRelicItem", ReduxView)

function ChallengeRogueTeamOverStatisticsSummaryRelicItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()
end

function ChallengeRogueTeamOverStatisticsSummaryRelicItem:Dispose()
	ChallengeRogueTeamOverStatisticsSummaryRelicItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function ChallengeRogueTeamOverStatisticsSummaryRelicItem:AddListeners()
	return
end

function ChallengeRogueTeamOverStatisticsSummaryRelicItem:SetData(arg_4_1)
	self.icon_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetItemIcon(arg_4_1.id))

	self:Show(true)
end

function ChallengeRogueTeamOverStatisticsSummaryRelicItem:Show(arg_5_1)
	SetActive(self.gameObject_, arg_5_1)
end

return ChallengeRogueTeamOverStatisticsSummaryRelicItem
