local ChallengeRogueTeamBagOptionalAffixItem = class("ChallengeRogueTeamBagOptionalAffixItem", ReduxView)

function ChallengeRogueTeamBagOptionalAffixItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.stateController_ = self.stateCon_:GetController("state")
end

function ChallengeRogueTeamBagOptionalAffixItem:AddListeners()
	return
end

function ChallengeRogueTeamBagOptionalAffixItem:Dispose()
	ChallengeRogueTeamBagOptionalAffixItem.super.Dispose(self)
end

function ChallengeRogueTeamBagOptionalAffixItem:SetData(arg_4_1, arg_4_2)
	self.cfg_ = ActivityAffixPoolCfg[arg_4_2]
	self.nameText_.text = self.cfg_.name
	self.descText_.text = getAffixDesc(self.cfg_.affix)
	self.iconImg_.sprite = getAffixSprite(self.cfg_.affix)
	self.numText_.text = self.cfg_.point

	self.stateController_:SetSelectedState(self.cfg_.point > 0 and "red" or "blue")
end

return ChallengeRogueTeamBagOptionalAffixItem
