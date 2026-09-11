local HeroPreviewChangeView = class("HeroPreviewChangeView", ReduxView)

function HeroPreviewChangeView:UIName()
	return "Widget/System/CharacterGuideUI/CharacterPreviewUI"
end

function HeroPreviewChangeView:UIParent()
	return manager.ui.uiMain.transform
end

function HeroPreviewChangeView:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroPreviewChangeView:InitUI()
	self:BindCfgUI()

	self.heroHeadList_ = LuaList.New(handler(self, self.HeadRenderer), self.uiListGo_, HeroLongHead)
	self.filterView_ = NewHeroListFilterView.New(self.filterGo_)

	self.filterView_:SetListChangeHandler(handler(self, self.OnListChange))

	self.heroInfoView_ = HeroPreviewInfoView.New(self.heroInfoGo_)
	self.emptyController_ = ControllerUtil.GetController(self.uiListGo_.transform, "empty")
	self.heroViewProxy_ = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.PREVIEW)
end

function HeroPreviewChangeView:OnListChange(arg_5_1)
	self.heroIdList_ = arg_5_1

	self.heroHeadList_:StartScroll(#arg_5_1)

	if #self.heroIdList_ > 0 then
		self.emptyController_:SetSelectedState("false")
		self:SelectHero(self.heroIdList_[1])
	else
		self.emptyController_:SetSelectedState("true")
	end
end

function HeroPreviewChangeView:AddUIListener()
	self:AddBtnListener(self.infoBtn_, nil, function()
		self:Go("/heroPreviewMain", {
			isEnter = true,
			isDraw = true,
			hid = self.curHeroId_
		})
	end)
end

function HeroPreviewChangeView:HeadRenderer(arg_8_1, arg_8_2)
	local var_8_0 = self.heroIdList_[arg_8_1]

	arg_8_2.gameObject_.name = tostring(self.heroIdList_[arg_8_1])

	arg_8_2:SetProxy(self.heroViewProxy_)
	arg_8_2:SetHeroId(var_8_0, self.type_)
	arg_8_2:SetRedPointEnable(self.heroViewProxy_.showHeroHeadRedPoint)
	arg_8_2:SetSelected(arg_8_2.heroId_ == self.curHeroId_)
	arg_8_2:SetRareIcon(HeroCfg[var_8_0].rare)
	arg_8_2:RegisterClickListener(function()
		self:SelectHero(arg_8_2.heroId_)
		OperationRecorder.Record("hero", "selectHero")
	end)
end

function HeroPreviewChangeView:SelectHero(arg_10_1)
	self.curHeroId_ = arg_10_1
	self.curHeroInfo_ = HeroData:GetHeroList()[self.curHeroId_]
	self.heroCfg_ = HeroCfg[arg_10_1]

	for iter_10_0, iter_10_1 in pairs(self.heroHeadList_:GetItemList()) do
		iter_10_1:SetSelected(iter_10_1.heroId_ == arg_10_1)
	end

	self.heroInfoView_:SetHeroInfo(self.curHeroInfo_)
	self:UpdateHeroView()
	self:UpdateAvatarView()
end

function HeroPreviewChangeView:UpdateHeroView()
	return
end

function HeroPreviewChangeView:UpdateAvatarView()
	manager.heroRaiseTrack:SetModelState(self.heroViewProxy_:GetHeroUsingSkinInfo(self.curHeroId_).id)
end

function HeroPreviewChangeView:CameraEnter()
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		1,
		0,
		0
	}, self.displayGo_)
	manager.heroRaiseTrack:SetAstrolableAtive(false)
end

function HeroPreviewChangeView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function HeroPreviewChangeView:OnEnter()
	self.filterView_:OnEnter(self.heroViewProxy_)
	self.filterView_:SetHeroIdList((HeroTools.Sort(HeroData:GetHeroList(), true)))

	local var_15_0 = 1

	if self.params_.index then
		var_15_0 = self.params_.index
	else
		for iter_15_0, iter_15_1 in ipairs(self.heroIdList_) do
			if iter_15_1 == self.curHeroId_ then
				var_15_0 = iter_15_0

				break
			end
		end
	end

	self:SelectHero(self.heroIdList_[var_15_0])
	self.heroHeadList_:StartScroll(#self.heroIdList_, var_15_0)
end

function HeroPreviewChangeView:OnMainHomeViewTop()
	if self.filterView_ then
		self.filterView_:Reset()
	end

	self.pos_ = nil
end

function HeroPreviewChangeView:OnExit()
	manager.windowBar:HideBar()

	if #self.heroIdList_ <= 0 then
		HeroData:ResetSortValue()
		self.filterView_:Reset()
	end

	self.params_.index = table.keyof(self.heroIdList_, self.curHeroId_)
	self.pos_ = self.heroHeadList_:GetScrolledPosition()

	self.heroInfoView_:OnExit()
	manager.heroRaiseTrack:CancelAllAsyncLoadModelOp()
end

function HeroPreviewChangeView:Dispose()
	if self.heroHeadList_ then
		self.heroHeadList_:Dispose()

		self.heroHeadList_ = nil
	end

	if self.filterView_ then
		self.filterView_:Dispose()

		self.filterView_ = nil
	end

	if self.heroInfoView_ then
		self.heroInfoView_:Dispose()

		self.heroInfoView_ = nil
	end

	HeroPreviewChangeView.super.Dispose(self)
end

return HeroPreviewChangeView
