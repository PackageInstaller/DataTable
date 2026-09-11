local HeroSkillAttributeItem = class("HeroSkillAttributeItem", ReduxView)

function HeroSkillAttributeItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function HeroSkillAttributeItem:Init()
	self:InitUI()
end

function HeroSkillAttributeItem:InitUI()
	self:BindCfgUI()
end

function HeroSkillAttributeItem:SetData(arg_4_1)
	self.atrributeID_ = arg_4_1

	self:RefreshUI()
end

function HeroSkillAttributeItem:RefreshUI()
	self.icon_.sprite = HeroTools.GetSkillAttributeIcon(self.atrributeID_)
end

function HeroSkillAttributeItem:Show(arg_6_1)
	SetActive(self.gameObject_, arg_6_1)
end

return HeroSkillAttributeItem
