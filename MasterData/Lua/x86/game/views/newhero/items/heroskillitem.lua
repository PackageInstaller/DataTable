local HeroSkillItem = class("HeroSkillItem", ReduxView)

function HeroSkillItem:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.data_ = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform
	self.info_ = arg_1_3

	self:InitUI()
	self:Init()
end

function HeroSkillItem:RefreshData(arg_2_1, arg_2_2, arg_2_3)
	self.data_ = arg_2_1
	self.info_ = arg_2_2
	self.heroViewProxy_ = arg_2_3

	self:Render()
end

function HeroSkillItem:InitUI()
	self:BindCfgUI()
	self:AddBtnListener(nil, nil, "OnClick")
end

function HeroSkillItem:Init()
	return
end

function HeroSkillItem:Render()
	self:RefreshUI(self.info_)
end

function HeroSkillItem:RefreshUI(arg_6_1)
	if arg_6_1 then
		local var_6_0 = self:GetRealSkillId(arg_6_1)

		self.iconImg_.sprite = getSprite("Atlas/" .. arg_6_1.heroId, var_6_0)
		self.nameText_.text = GetI18NText(HeroSkillCfg[var_6_0].name)

		SetActive(self.upGo_, arg_6_1.isCanUp)
		self:RefreshLv(arg_6_1)

		self.subnameText_.text = GetI18NText(HeroCfg[arg_6_1.heroId].skill_subhead[table.indexof(HeroCfg[arg_6_1.heroId].skills, arg_6_1.id)])
	end
end

function HeroSkillItem:RefreshLv(arg_7_1)
	self.lvText_.text = 0 <= 0 and string.format("%d", arg_7_1.lv + arg_7_1.addSkillLv) or string.format("<color=#F3DC5A>%d</color>", arg_7_1.lv + arg_7_1.addSkillLv + self.heroViewProxy_:GetTransitionAddLevel(arg_7_1.heroId))
end

function HeroSkillItem:GetRealSkillId(arg_8_1)
	return self.heroViewProxy_:GetRealSkillId(arg_8_1.heroId, arg_8_1.id)
end

function HeroSkillItem:OnClick()
	if self.clickFunc then
		self.clickFunc(self.info_)
	end
end

function HeroSkillItem:RegistCallBack(arg_10_1)
	self.clickFunc = arg_10_1
end

function HeroSkillItem:GetItemInfo()
	return self.info_
end

function HeroSkillItem:Dispose()
	self:RemoveAllListeners()
	HeroSkillItem.super.Dispose(self)
end

return HeroSkillItem
