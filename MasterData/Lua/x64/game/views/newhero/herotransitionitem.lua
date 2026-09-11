local HeroTransitionItem = class("HeroTransitionItem", ReduxView)

function HeroTransitionItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function HeroTransitionItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroTransitionItem:InitUI()
	self:BindCfgUI()
end

function HeroTransitionItem:AddUIListener()
	TerminologyTools.AddTerminologyHandler(self, self.descText_, nil, nil)
end

function HeroTransitionItem:SetData(arg_5_1)
	self.data_ = arg_5_1
	self.cfg_ = EquipSkillCfg[arg_5_1.skill_id or arg_5_1.skillId]
	self.level_ = arg_5_1.skill_level or arg_5_1.level

	self:UpdateView()
end

function HeroTransitionItem:UpdateView()
	self.nameText_.text = self.cfg_.name
	self.descText_.text = self:GetDesc()
	self.iconImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Equip/EquipSkillIcon/" .. self.cfg_.icon or "")
	self.levelText_.text = GetTips("LEVEL") .. self.level_
end

function HeroTransitionItem:GetDesc()
	return EquipTools.GetSkillDescWithoutHero(self.data_.skill_id or self.data_.skillId, self.level_, true)
end

function HeroTransitionItem:OnExit()
	return
end

function HeroTransitionItem:Dispose()
	self:RemoveAllListeners()
	HeroTransitionItem.super.Dispose(self)
end

return HeroTransitionItem
