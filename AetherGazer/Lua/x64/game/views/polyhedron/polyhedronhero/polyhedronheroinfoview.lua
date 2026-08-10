local var_0_0 = class("PolyhedronHeroInfoView", HeroInfoView)

function var_0_0.UpdateView(arg_1_0)
	arg_1_0.nameText_.text = GetI18NText(arg_1_0.heroCfg_.name)
	arg_1_0.subNameText_.text = GetI18NText(arg_1_0.heroCfg_.suffix)

	local var_1_0 = HeroData:GetHeroData(arg_1_0.heroInfo_.id).unlock == 1
	local var_1_1 = PolyhedronData:GetPolyhedronHeroUnlock(arg_1_0.heroInfo_.id)

	arg_1_0.lockController_:SetSelectedState(tostring(not var_1_0))
	arg_1_0.isSelfController_:SetSelectedState(tostring(not arg_1_0.heroViewProxy_.isSelf))

	arg_1_0.campLogo_.sprite = HeroTools.GetRaceIcon(arg_1_0.heroCfg_.race)
	arg_1_0.attackType_.sprite = HeroTools.GetHeroSkillAttributeIcon(arg_1_0.heroCfg_.id)
	arg_1_0.rangeTypeText_.text = CharactorParamCfg[arg_1_0.heroInfo_.id].RangeType == 0 and GetTips("RANGETYPE_CLOSE") or GetTips("RANGETYPE_LONG")

	if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_UNLOCK_PROPS) == 0 then
		arg_1_0.polyhedronCurrencyText_.text = "<color=#FF0000> 1 </color>"
	else
		arg_1_0.polyhedronCurrencyText_.text = "1"
	end

	arg_1_0.polyhedronDesText_.text = HeroCfg[arg_1_0.heroInfo_.id].hero_desc

	arg_1_0:RefreshChargeType()
	arg_1_0.polyhedronController_:SetSelectedState(tostring(not var_1_1))

	local var_1_2 = HeroStarCfg[arg_1_0.heroInfo_.star]

	arg_1_0.starImg_.sprite = getSprite("Atlas/Common", "star_" .. var_1_2.star)

	if arg_1_0.heroInfo_.unlock == 0 then
		arg_1_0:UpdateLockedView()
	else
		arg_1_0:UpdateUnlockedView()

		if arg_1_0.type_ == HeroConst.HERO_DATA_TYPE.DEFAULT then
			local var_1_3 = arg_1_0.heroCfg_.id

			ArchiveAction.CheckAllRelationRedPoint(var_1_3)
		end
	end
end

function var_0_0.AddUIListener(arg_2_0)
	var_0_0.super.AddUIListener(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.polyhedronUnlockBtn_, nil, function()
		PolyhedronAction.QueryUnlockHero(arg_2_0.heroCfg_.id)
	end)
end

function var_0_0.UpdateUnlockBtnState(arg_4_0)
	arg_4_0.levelStateController_:SetSelectedState("none")
end

function var_0_0.GetHeroPiece(arg_5_0)
	return HeroData:GetHeroData(arg_5_0.heroInfo_.id).piece
end

return var_0_0
