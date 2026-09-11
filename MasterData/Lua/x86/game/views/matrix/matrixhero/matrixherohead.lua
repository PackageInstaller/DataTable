local MatrixHeroHead = class("MatrixHeroHead", (import("game.views.newHero.NewHeroHead")))

function MatrixHeroHead:SetHeroId(arg_1_1)
	self.standardId_ = arg_1_1
	self.heroId_ = HeroStandardSystemCfg[arg_1_1].hero_id
	self.heroCfg_ = HeroCfg[self.heroId_]

	local var_1_0, var_1_1 = GetVirtualData(arg_1_1)

	self.heroInfo_ = var_1_0

	self:UpdateView()
end

function MatrixHeroHead:GetHeroStandardId()
	return self.standardId_
end

function MatrixHeroHead:UpdateView()
	self.headIcon_.sprite = HeroTools.GetHeadSprite((MatrixData:GetHeroSkin(self.heroId_)))

	self.headIcon_:SetNativeSize()
	self.campController_:SetSelectedState(self.heroCfg_.race)
	self.lockedController_:SetSelectedState("false")

	self.levelText_.text = tostring(self.heroInfo_.level or 1)

	self.gradeController_:SetSelectedState(HeroStarCfg[self.heroInfo_.star].star)
end

return MatrixHeroHead
