local SectionSmallHeroItem = class("SectionSmallHeroItem", ReduxView)

function SectionSmallHeroItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function SectionSmallHeroItem:Init()
	self:InitUI()
end

function SectionSmallHeroItem:InitUI()
	self:BindCfgUI()

	self.emptyController_ = self.controllerExCollection_:GetController("empty")
	self.lockController_ = self.controllerExCollection_:GetController("lock")
	self.validController_ = self.controllerExCollection_:GetController("valid")
end

function SectionSmallHeroItem:SetData(arg_4_1)
	self:Show(true)

	self.heroID_ = arg_4_1

	self:RefreshUI()
end

function SectionSmallHeroItem:RefreshUI()
	if self.heroID_ and self.heroID_ ~= 0 then
		self.heroIcon_.sprite = getSpriteViaConfig("HeroItemshead", self.heroID_)

		self.emptyController_:SetSelectedState("false")
	else
		self.emptyController_:SetSelectedState("true")
	end
end

function SectionSmallHeroItem:RefreshLock(arg_6_1)
	self.lockController_:SetSelectedState(tostring(arg_6_1))
end

function SectionSmallHeroItem:RefreshValid(arg_7_1)
	self.validController_:SetSelectedState(tostring(arg_7_1))
end

function SectionSmallHeroItem:Show(arg_8_1)
	SetActive(self.gameObject_, arg_8_1)
end

return SectionSmallHeroItem
