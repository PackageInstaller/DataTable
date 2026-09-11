local ChallengeRogueTeamNormalSkillEffectItem = class("ChallengeRogueTeamNormalSkillEffectItem", ReduxView)

function ChallengeRogueTeamNormalSkillEffectItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()
end

function ChallengeRogueTeamNormalSkillEffectItem:Dispose()
	ChallengeRogueTeamNormalSkillEffectItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function ChallengeRogueTeamNormalSkillEffectItem:AddListeners()
	return
end

function ChallengeRogueTeamNormalSkillEffectItem:SetData(arg_4_1)
	self.value_ = 0
	self.skillTemp_ = arg_4_1
	self.cfg_ = RogueTeamSkillTreeCfg[RogueTeamSkillTreeCfg.get_id_list_by_show_temp[arg_4_1][1]]
	self.icon_.sprite = pureGetSpriteWithoutAtlas(self.cfg_.icon)
	self.name_.text = self.cfg_.show_desc

	self:Show(true)
end

function ChallengeRogueTeamNormalSkillEffectItem:UpdateValue(arg_5_1)
	self.value_ = self.value_ + arg_5_1
	self.valueText_.text = self.value_ .. (self.cfg_.show_value[1] == 1 and "%" or "")
end

function ChallengeRogueTeamNormalSkillEffectItem:Show(arg_6_1)
	SetActive(self.gameObject_, arg_6_1)
end

return ChallengeRogueTeamNormalSkillEffectItem
