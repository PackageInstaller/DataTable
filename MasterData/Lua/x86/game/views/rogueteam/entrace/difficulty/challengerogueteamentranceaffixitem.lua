local ChallengeRogueTeamEntranceAffixItem = class("ChallengeRogueTeamEntranceAffixItem", ReduxView)

function ChallengeRogueTeamEntranceAffixItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()
end

function ChallengeRogueTeamEntranceAffixItem:Dispose()
	ChallengeRogueTeamEntranceAffixItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

function ChallengeRogueTeamEntranceAffixItem:AddListeners()
	return
end

function ChallengeRogueTeamEntranceAffixItem:SetData(arg_4_1)
	self.icon_.sprite = getAffixSprite(arg_4_1)

	self:Show(true)
end

function ChallengeRogueTeamEntranceAffixItem:Show(arg_5_1)
	SetActive(self.gameObject_, arg_5_1)
end

return ChallengeRogueTeamEntranceAffixItem
