local ChallengeRogueTeamSpeacilSkillEffectItem = class("ChallengeRogueTeamSpeacilSkillEffectItem", ReduxView)

function ChallengeRogueTeamSpeacilSkillEffectItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()
end

function ChallengeRogueTeamSpeacilSkillEffectItem:Dispose()
	ChallengeRogueTeamSpeacilSkillEffectItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function ChallengeRogueTeamSpeacilSkillEffectItem:AddListeners()
	return
end

function ChallengeRogueTeamSpeacilSkillEffectItem:SetData(arg_4_1)
	self.id_ = arg_4_1
	self.cfg_ = RogueTeamSkillTreeCfg[arg_4_1]
	self.icon_.sprite = pureGetSpriteWithoutAtlas(self.cfg_.icon)
	self.name_.text = self.cfg_.name
	self.desc_.text = self.cfg_.description

	self:Show(true)
end

function ChallengeRogueTeamSpeacilSkillEffectItem:Show(arg_5_1)
	SetActive(self.gameObject_, arg_5_1)
end

return ChallengeRogueTeamSpeacilSkillEffectItem
