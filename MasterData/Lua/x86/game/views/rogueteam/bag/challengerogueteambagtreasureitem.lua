local ChallengeRogueTeamBagTreasureItem = class("ChallengeRogueTeamBagTreasureItem", ReduxView)

function ChallengeRogueTeamBagTreasureItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.rareController_ = self.controller_:GetController("rare")
end

function ChallengeRogueTeamBagTreasureItem:AddListeners()
	TerminologyTools.AddTerminologyHandler(self, self.descText_, nil, nil)
end

function ChallengeRogueTeamBagTreasureItem:Dispose()
	ChallengeRogueTeamBagTreasureItem.super.Dispose(self)
end

function ChallengeRogueTeamBagTreasureItem:SetData(arg_4_1, arg_4_2)
	self.index_ = arg_4_1
	self.data_ = arg_4_2
	self.cfg_ = RogueTeamItemCfg[self.data_.id]
	self.nameText_.text = GetI18NText(self.cfg_.name)
	self.icon_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetItemIcon(self.data_.id))
	self.descText_.text = ChallengeRogueTeamTools.GetItemDesc(self.data_.id, self.data_.rare, self.descText_.color)

	self.rareController_:SetSelectedState(self.data_.rare)
end

return ChallengeRogueTeamBagTreasureItem
