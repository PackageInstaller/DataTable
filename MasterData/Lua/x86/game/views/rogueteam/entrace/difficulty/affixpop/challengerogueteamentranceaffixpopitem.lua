local ChallengeRogueTeamEntranceAffixPopItem = class("ChallengeRogueTeamEntranceAffixPopItem", ReduxView)

function ChallengeRogueTeamEntranceAffixPopItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()
end

function ChallengeRogueTeamEntranceAffixPopItem:Dispose()
	ChallengeRogueTeamEntranceAffixPopItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

function ChallengeRogueTeamEntranceAffixPopItem:AddListeners()
	return
end

function ChallengeRogueTeamEntranceAffixPopItem:SetData(arg_4_1)
	self.nameText_.text = getAffixName(arg_4_1)
	self.descText_.text = getAffixDesc(arg_4_1)

	self:Show(true)
end

function ChallengeRogueTeamEntranceAffixPopItem:Show(arg_5_1)
	SetActive(self.gameObject_, arg_5_1)
end

return ChallengeRogueTeamEntranceAffixPopItem
