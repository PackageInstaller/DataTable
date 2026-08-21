local var_0_0 = class("PolyhedronHeroView", HeroView)

function var_0_0.OnTop(arg_1_0)
	var_0_0.super.OnTop(arg_1_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_UNLOCK_PROPS
	})
	manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_TYPE_UNLOCK_PROPS, true)
end

function var_0_0.OnEnter(arg_2_0)
	var_0_0.super.OnEnter(arg_2_0)
end

function var_0_0.InitHeroHeadList(arg_3_0)
	arg_3_0.shortScrollHelper_ = LuaList.New(handler(arg_3_0, arg_3_0.ShortHeadRenderer), arg_3_0.heroShortListGo_, PolyhedronHeroShortHead)
	arg_3_0.completeScrollHelper_ = LuaList.New(handler(arg_3_0, arg_3_0.LongHeadRenderer), arg_3_0.heroCompleteListGo_, PolyhedronHeroLongHead)
end

function var_0_0.SelectHero(arg_4_0, arg_4_1)
	var_0_0.super.SelectHero(arg_4_0, arg_4_1)
	PolyhedronData:SetHeroClicked(arg_4_1)

	for iter_4_0, iter_4_1 in pairs(arg_4_0.curScrollHelper_:GetItemList()) do
		iter_4_1:SetRedPoint()
	end
end

function var_0_0.GetCurHeroInfo(arg_5_0, arg_5_1)
	return arg_5_0.heroViewProxy_:GetHeroData(arg_5_1)
end

function var_0_0.OnPolyhedronHeroUnlock(arg_6_0)
	arg_6_0.filterView_:SetHeroIdList(arg_6_0.heroIdList_, arg_6_0.type_)
	arg_6_0.curScrollHelper_:Refresh()
	arg_6_0:CheckLocked()
	arg_6_0:UpdateHeroView()
	arg_6_0.pages_[arg_6_0.curPageIndex_]:UpdateView()
end

return var_0_0
