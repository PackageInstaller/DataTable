local RogueTeamItemInfoSettingTreasureItem = class("RogueTeamItemInfoSettingTreasureItem", ReduxView)

function RogueTeamItemInfoSettingTreasureItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.rareController_ = self.controllerEx_:GetController("rare")
end

function RogueTeamItemInfoSettingTreasureItem:Dispose()
	RogueTeamItemInfoSettingTreasureItem.super.Dispose(self)
end

function RogueTeamItemInfoSettingTreasureItem:AddListeners()
	TerminologyTools.AddTerminologyHandler(self, self.descText_, nil, nil)
end

function RogueTeamItemInfoSettingTreasureItem:SetData(arg_4_1)
	self.icon_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetItemIcon(arg_4_1.id))
	self.nameText_.text = RogueTeamItemCfg[arg_4_1.id].name
	self.descText_.text = ChallengeRogueTeamTools.GetItemDesc(arg_4_1.id, arg_4_1.rare, self.descText_.color)

	self.rareController_:SetSelectedState(tostring(arg_4_1.rare))
end

return RogueTeamItemInfoSettingTreasureItem
