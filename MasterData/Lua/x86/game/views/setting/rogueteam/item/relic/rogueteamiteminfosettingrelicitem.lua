local RogueTeamItemInfoSettingRelicItem = class("RogueTeamItemInfoSettingRelicItem", ReduxView)

function RogueTeamItemInfoSettingRelicItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()
end

function RogueTeamItemInfoSettingRelicItem:Dispose()
	RogueTeamItemInfoSettingRelicItem.super.Dispose(self)
end

function RogueTeamItemInfoSettingRelicItem:AddListeners()
	return
end

function RogueTeamItemInfoSettingRelicItem:SetData(arg_4_1)
	self.icon_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetItemIcon(arg_4_1))
	self.nameText_.text = RogueTeamItemCfg[arg_4_1].name
	self.descText_.text = ChallengeRogueTeamTools.GetItemEffectDesc(arg_4_1)
end

return RogueTeamItemInfoSettingRelicItem
