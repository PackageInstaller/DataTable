local DrawAllHeroSelectItem = class("DrawAllHeroSelectItem", ReduxView)

function DrawAllHeroSelectItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function DrawAllHeroSelectItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function DrawAllHeroSelectItem:InitUI()
	self:BindCfgUI()

	self.selectCon_ = self.controller_:GetController("selected")
end

function DrawAllHeroSelectItem:AddUIListeners()
	self:AddBtnListener(self.selfBtn_, nil, function()
		if self.clickFunc_ and self.heroCfg_ then
			self.clickFunc_(self.heroCfg_.id)
		end
	end)
	self:AddBtnListener(self.lookBtn_, nil, function()
		JumpTools.OpenPageByJump("/heroPreviewMain", {
			isEnter = true,
			hid = self.heroID_
		})
	end)
end

function DrawAllHeroSelectItem:SetHeroID(arg_7_1)
	self.heroID_ = arg_7_1
	self.heroCfg_ = HeroCfg[arg_7_1]
	self.headIcon_.sprite = HeroTools.GetHeadSprite(arg_7_1)

	self.headIcon_:SetNativeSize()

	self.campLogo_.sprite = HeroTools.GetRaceIcon(self.heroCfg_.race)
	self.attackType_.sprite = HeroTools.GetHeroSkillAttributeIcon(self.heroID_)
	self.rareImg_.sprite = HeroTools.GetRareSprite(self.heroCfg_.rare)
	self.name_.text = GetI18NText(self.heroCfg_.name) .. "·" .. GetI18NText(self.heroCfg_.suffix)
end

function DrawAllHeroSelectItem:SetSelected(arg_8_1)
	self.selectCon_:SetSelectedState(tostring(arg_8_1))
end

function DrawAllHeroSelectItem:RegisterClickListener(arg_9_1)
	self.clickFunc_ = arg_9_1
end

function DrawAllHeroSelectItem:Dispose()
	self:RemoveAllEventListener()

	self.clickListener_ = nil

	DrawAllHeroSelectItem.super.Dispose(self)
end

return DrawAllHeroSelectItem
