local ChallengeRogueTeamTreasureSkillItem = class("ChallengeRogueTeamTreasureSkillItem", ReduxView)

function ChallengeRogueTeamTreasureSkillItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()
end

function ChallengeRogueTeamTreasureSkillItem:Dispose()
	ChallengeRogueTeamTreasureSkillItem.super.Dispose(self)

	self.transform_ = nil
	self.gameObject_ = nil
end

function ChallengeRogueTeamTreasureSkillItem:AddListeners()
	return
end

function ChallengeRogueTeamTreasureSkillItem:SetData(arg_4_1)
	self.icon_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetCampIcon(arg_4_1))

	local var_4_0 = RogueTeamCfg[ChallengeRogueTeamData:GetCacheTemplateID()].item_temp

	self.cntText_.text = #ChallengeRogueTeamData:TreasureGetListByCampList({
		arg_4_1
	})

	self:Show(true)
end

function ChallengeRogueTeamTreasureSkillItem:Show(arg_5_1)
	SetActive(self.gameObject_, arg_5_1)
end

return ChallengeRogueTeamTreasureSkillItem
