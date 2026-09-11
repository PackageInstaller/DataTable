local ChallengeRogueTeamOverStatisticsRelicItem = class("ChallengeRogueTeamOverStatisticsRelicItem", ReduxView)

function ChallengeRogueTeamOverStatisticsRelicItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()
end

function ChallengeRogueTeamOverStatisticsRelicItem:Dispose()
	ChallengeRogueTeamOverStatisticsRelicItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function ChallengeRogueTeamOverStatisticsRelicItem:AddListeners()
	return
end

function ChallengeRogueTeamOverStatisticsRelicItem:SetData(arg_4_1)
	self.id_ = arg_4_1
	self.icon_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetItemIcon(arg_4_1))
	self.name_.text = RogueTeamItemCfg[arg_4_1].name
	self.desc_.text = RogueTeamItemCfg[arg_4_1].desc

	self:Show(true)
end

function ChallengeRogueTeamOverStatisticsRelicItem:Show(arg_5_1)
	SetActive(self.gameObject_, arg_5_1)
end

return ChallengeRogueTeamOverStatisticsRelicItem
