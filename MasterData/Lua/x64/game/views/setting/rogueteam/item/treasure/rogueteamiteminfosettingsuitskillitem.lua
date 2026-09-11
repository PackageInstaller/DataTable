local RogueTeamItemInfoSettingSuitSkillItem = class("RogueTeamItemInfoSettingSuitSkillItem", ReduxView)

function RogueTeamItemInfoSettingSuitSkillItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()
end

function RogueTeamItemInfoSettingSuitSkillItem:Dispose()
	RogueTeamItemInfoSettingSuitSkillItem.super.Dispose(self)
end

function RogueTeamItemInfoSettingSuitSkillItem:AddListeners()
	TerminologyTools.AddTerminologyHandler(self, self.descText_, nil, nil)
end

function RogueTeamItemInfoSettingSuitSkillItem:SetData(arg_4_1)
	self.icon_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetItemIcon(arg_4_1))
	self.nameText_.text = RogueTeamItemCfg[arg_4_1].name
	self.descText_.text = ChallengeRogueTeamTools.GetItemDesc(arg_4_1, nil, self.descText_.color)
end

return RogueTeamItemInfoSettingSuitSkillItem
