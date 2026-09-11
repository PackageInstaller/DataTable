local PolyhedronHeroInfoView = class("PolyhedronHeroInfoView", HeroInfoView)

function PolyhedronHeroInfoView:UpdateView()
	self.nameText_.text = GetI18NText(self.heroCfg_.name)
	self.subNameText_.text = GetI18NText(self.heroCfg_.suffix)

	local var_1_0 = PolyhedronData:GetPolyhedronHeroUnlock(self.heroInfo_.id)

	self.lockController_:SetSelectedState(tostring(not (HeroData:GetHeroData(self.heroInfo_.id).unlock == 1)))
	self.isSelfController_:SetSelectedState(tostring(not self.heroViewProxy_.isSelf))

	self.campLogo_.sprite = HeroTools.GetRaceIcon(self.heroCfg_.race)
	self.attackType_.sprite = HeroTools.GetHeroSkillAttributeIcon(self.heroCfg_.id)
	self.rangeTypeText_.text = CharactorParamCfg[self.heroInfo_.id].RangeType == 0 and GetTips("RANGETYPE_CLOSE") or GetTips("RANGETYPE_LONG")
	self.polyhedronCurrencyText_.text = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_UNLOCK_PROPS) == 0 and "<color=#FF0000> 1 </color>" or "1"
	self.polyhedronDesText_.text = HeroCfg[self.heroInfo_.id].hero_desc

	self:RefreshChargeType()
	self.polyhedronController_:SetSelectedState(tostring(not var_1_0))

	self.starImg_.sprite = getSprite("Atlas/Common", "star_" .. HeroStarCfg[self.heroInfo_.star].star)

	if self.heroInfo_.unlock == 0 then
		self:UpdateLockedView()
	else
		self:UpdateUnlockedView()

		if self.type_ == HeroConst.HERO_DATA_TYPE.DEFAULT then
			ArchiveAction.CheckAllRelationRedPoint(self.heroCfg_.id)
		end
	end
end

function PolyhedronHeroInfoView:AddUIListener()
	PolyhedronHeroInfoView.super.AddUIListener(self)
	self:AddBtnListener(self.polyhedronUnlockBtn_, nil, function()
		PolyhedronAction.QueryUnlockHero(self.heroCfg_.id)
	end)
end

function PolyhedronHeroInfoView:UpdateUnlockBtnState()
	self.levelStateController_:SetSelectedState("none")
end

function PolyhedronHeroInfoView:GetHeroPiece()
	return HeroData:GetHeroData(self.heroInfo_.id).piece
end

return PolyhedronHeroInfoView
