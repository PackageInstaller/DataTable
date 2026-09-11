local PolyhedronHeroView = class("PolyhedronHeroView", HeroView)

function PolyhedronHeroView:OnTop()
	PolyhedronHeroView.super.OnTop(self)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_UNLOCK_PROPS
	})
	manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_TYPE_UNLOCK_PROPS, true)
end

function PolyhedronHeroView:OnEnter()
	PolyhedronHeroView.super.OnEnter(self)
end

function PolyhedronHeroView:InitHeroHeadList()
	self.shortScrollHelper_ = LuaList.New(handler(self, self.ShortHeadRenderer), self.heroShortListGo_, PolyhedronHeroShortHead)
	self.completeScrollHelper_ = LuaList.New(handler(self, self.LongHeadRenderer), self.heroCompleteListGo_, PolyhedronHeroLongHead)
end

function PolyhedronHeroView:SelectHero(arg_4_1)
	PolyhedronHeroView.super.SelectHero(self, arg_4_1)
	PolyhedronData:SetHeroClicked(arg_4_1)

	for iter_4_0, iter_4_1 in pairs(self.curScrollHelper_:GetItemList()) do
		iter_4_1:SetRedPoint()
	end
end

function PolyhedronHeroView:GetCurHeroInfo(arg_5_1)
	return self.heroViewProxy_:GetHeroData(arg_5_1)
end

function PolyhedronHeroView:OnPolyhedronHeroUnlock()
	self.filterView_:SetHeroIdList(self.heroIdList_, self.type_)
	self.curScrollHelper_:Refresh()
	self:CheckLocked()
	self:UpdateHeroView()
	self.pages_[self.curPageIndex_]:UpdateView()
end

return PolyhedronHeroView
