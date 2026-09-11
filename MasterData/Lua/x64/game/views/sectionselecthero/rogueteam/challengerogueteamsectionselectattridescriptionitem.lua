local ChallengeRogueTeamSectionSelectAttriDescriptionItem = class("ChallengeRogueTeamSectionSelectAttriDescriptionItem", ReduxView)

function ChallengeRogueTeamSectionSelectAttriDescriptionItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function ChallengeRogueTeamSectionSelectAttriDescriptionItem:Init()
	self:InitUI()
end

function ChallengeRogueTeamSectionSelectAttriDescriptionItem:InitUI()
	self:BindCfgUI()

	self.activeController_ = self.controller_:GetController("bg")
end

function ChallengeRogueTeamSectionSelectAttriDescriptionItem:SetData(arg_4_1, arg_4_2, arg_4_3)
	self.attriID_ = arg_4_2
	self.attriIcon_.sprite = HeroTools.GetSkillAttributeIcon(self.attriID_)
	self.desc_.text = GetCfgDescription(AffixTypeCfg[ChallengeRogueTeamTools.GetRougeTeamSettingList(ChallengeRogueTeamConst.SETTING_VALUE.TEAM_ATTRIBUTE_BUFF_LIST, ChallengeRogueTeamData:GetCacheTemplateID())[arg_4_1]].description[1], arg_4_3, 1, 3, true, true)

	if arg_4_3 and arg_4_3 ~= 0 then
		self.activeController_:SetSelectedState("on")
	else
		self.activeController_:SetSelectedState("off")
	end

	self.attriName_.text = GetTips(HeroConst.HERO_ATTACK_TYPE_STR[arg_4_2])
end

function ChallengeRogueTeamSectionSelectAttriDescriptionItem:Dispose()
	ChallengeRogueTeamSectionSelectAttriDescriptionItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

return ChallengeRogueTeamSectionSelectAttriDescriptionItem
