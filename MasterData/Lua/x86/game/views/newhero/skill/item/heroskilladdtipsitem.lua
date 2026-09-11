local HeroSkillAddTipsItem = class("HeroSkillAddTipsItem", ReduxView)

function HeroSkillAddTipsItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function HeroSkillAddTipsItem:InitUI()
	self:BindCfgUI()
end

function HeroSkillAddTipsItem:RefreshUI(arg_3_1)
	SetActive(self.gameObject_, true)

	self.nametextText_.text = GetI18NText(arg_3_1.titleName)
	self.messagetextText_.text = GetI18NText(arg_3_1.showDesc)
end

function HeroSkillAddTipsItem:Dispose()
	HeroSkillAddTipsItem.super.Dispose(self)
end

return HeroSkillAddTipsItem
