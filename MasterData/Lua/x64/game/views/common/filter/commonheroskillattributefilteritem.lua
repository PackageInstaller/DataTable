local CommonHeroSkillAttributeFilterItem = class("CommonHeroSkillAttributeFilterItem", ReduxView)

function CommonHeroSkillAttributeFilterItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function CommonHeroSkillAttributeFilterItem:Init()
	self:BindCfgUI()
	self:InitController()
	self:AddListeners()
end

function CommonHeroSkillAttributeFilterItem:InitController()
	self.selectController_ = self.controllerEx_:GetController("select")
	self.allController_ = self.controllerEx_:GetController("all")
	self.nameController_ = self.controllerEx_:GetController("name")
end

function CommonHeroSkillAttributeFilterItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, handler(self, self.OnSelect))
end

function CommonHeroSkillAttributeFilterItem:SetData(arg_5_1)
	self.id_ = arg_5_1
	self.isAll_ = arg_5_1 == HeroConst.HERO_ATTACK_TYPE.ALL

	self:Refresh()
end

function CommonHeroSkillAttributeFilterItem:Refresh()
	self:RefreshType()
	self:RefreshIcon()
end

function CommonHeroSkillAttributeFilterItem:RefreshType()
	self.allController_:SetSelectedState(self.isAll_ and "on" or "off")
end

function CommonHeroSkillAttributeFilterItem:RefreshIcon()
	if not self.isAll_ then
		self.icon_.sprite = HeroTools.GetSkillAttributeIcon(self.id_)
	end
end

function CommonHeroSkillAttributeFilterItem:SetSelectCallBack(arg_9_1)
	self.callback_ = arg_9_1
end

function CommonHeroSkillAttributeFilterItem:OnSelect()
	if self.callback_ then
		self.callback_(self.id_, self.isAll_)
	end
end

function CommonHeroSkillAttributeFilterItem:RefreshSelect(arg_11_1)
	self.selectController_:SetSelectedState(arg_11_1 and "on" or "off")
end

function CommonHeroSkillAttributeFilterItem:GetId()
	return self.id_
end

function CommonHeroSkillAttributeFilterItem:SetNeedName(arg_13_1)
	self.needName_ = arg_13_1

	self.nameController_:SetSelectedState(arg_13_1 and "on" or "off")

	if self.needName_ and self.id_ then
		self.name_.text = HeroTools.GetSkillAttributeName(self.id_)
	end
end

function CommonHeroSkillAttributeFilterItem:Show(arg_14_1)
	SetActive(self.gameObject_, arg_14_1)
end

return CommonHeroSkillAttributeFilterItem
