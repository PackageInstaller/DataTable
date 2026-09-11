local HodurChallengeHeroItem = class("HodurChallengeHeroItem", ReduxView)

function HodurChallengeHeroItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:InitUI()
end

function HodurChallengeHeroItem:InitUI()
	self:BindCfgUI()

	self.haveController_ = self.mainControllerEx_:GetController("default0")
end

function HodurChallengeHeroItem:SetData(arg_3_1, arg_3_2, arg_3_3)
	self.heroID_ = HeroStandardSystemCfg[arg_3_1] and HeroStandardSystemCfg[arg_3_1].hero_id or arg_3_1
	self.curHP_ = arg_3_2
	self.maxHP_ = arg_3_3

	self:RefreshUI()
end

function HodurChallengeHeroItem:RefreshUI()
	if self.heroID_ == nil then
		self.haveController_:SetSelectedState("none")

		return
	end

	self.haveController_:SetSelectedState("state1")

	self.headImg_.sprite = HeroTools.GetHeadSprite(self.heroID_)
	self.hpBarImg_.fillAmount = self.curHP_ / self.maxHP_
	self.hpText_.text = self.curHP_ == 0 and string.format("%d%%", 0) or string.format("%d%%", math.max(1, math.floor(self.curHP_ / self.maxHP_ * 100)))
end

function HodurChallengeHeroItem:Dispose()
	HodurChallengeHeroItem.super.Dispose(self)
end

return HodurChallengeHeroItem
