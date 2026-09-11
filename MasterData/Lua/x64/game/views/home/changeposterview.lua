local ChangePosterView = class("ChangePosterView", ReduxView)

function ChangePosterView:UIName()
	return "Widget/System/Hero/HeroChangeUI"
end

function ChangePosterView:UIParent()
	return manager.ui.uiMain.transform
end

function ChangePosterView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ChangePosterView:InitUI()
	self:BindCfgUI()

	self.heroHeadList_ = LuaList.New(handler(self, self.HeadRenderer), self.uiListGo_, HeroLongHead)
	self.filterView_ = NewHeroListFilterView.New(self.filterGo_)

	self.filterView_:SetListChangeHandler(handler(self, self.OnListChange))

	self.emptyController_ = ControllerUtil.GetController(self.uiListGo_.transform, "empty")
	self.heroViewProxy_ = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
end

function ChangePosterView:OnListChange(arg_5_1)
	self.heroIdList_ = arg_5_1

	self.heroHeadList_:StartScroll(#self.heroIdList_)

	if #self.heroIdList_ > 0 then
		self.emptyController_:SetSelectedState("false")
		self:SelectHero(self.heroIdList_[1])
	else
		self.emptyController_:SetSelectedState("true")
	end
end

function ChangePosterView:AddUIListener()
	self:AddBtnListener(self.showBtn_, nil, function()
		if PlayerData:IsRandomHero() then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("RANDOM_ASSIST_TIPS"),
				OkCallback = function()
					PlayerAction.SetIsRandomHero(false, function()
						return
					end)
					PlayerAction.ChangePosterGirl(self.curHeroId_)
				end
			})
		else
			PlayerAction.ChangePosterGirl(self.curHeroId_)
		end
	end)
	self:AddBtnListener(self.skinBtn_, nil, function()
		self:Go("/heroSkin", {
			heroID = self.curHeroId_
		})
	end)
	self:AddBtnListener(self.randomHeroBtn_, nil, function()
		JumpTools.GoToSystem("/randomHero", {})
	end)
end

function ChangePosterView:OnChangePosterGirl(arg_12_1, arg_12_2)
	if self.params_.lastView == "home" then
		JumpTools.OpenPageByJump("/home", {
			changePoster = true
		})
	else
		self:Back()
	end
end

function ChangePosterView:HeadRenderer(arg_13_1, arg_13_2)
	arg_13_2.gameObject_.name = tostring(self.heroIdList_[arg_13_1])

	arg_13_2:SetProxy(self.heroViewProxy_)
	arg_13_2:SetHeroId(self.heroIdList_[arg_13_1], self.type_)
	arg_13_2:SetRedPointEnable(self.heroViewProxy_.showHeroHeadRedPoint)
	arg_13_2:SetSelected(arg_13_2.heroId_ == self.curHeroId_)
	arg_13_2:RegisterClickListener(function()
		self:SelectHero(arg_13_2.heroId_)
		OperationRecorder.Record("hero", "selectHero")
	end)
end

function ChangePosterView:SelectHero(arg_15_1)
	self.curHeroId_ = arg_15_1
	self.curHeroInfo_ = HeroData:GetHeroList()[self.curHeroId_]
	self.heroCfg_ = HeroCfg[arg_15_1]

	for iter_15_0, iter_15_1 in pairs(self.heroHeadList_:GetItemList()) do
		iter_15_1:SetSelected(iter_15_1.heroId_ == arg_15_1)
	end

	self:UpdateHeroView()
	self:UpdateAvatarView()
end

function ChangePosterView:UpdateHeroView()
	self.nameText_.text = GetI18NText(self.heroCfg_.name)
	self.subNameText_.text = HeroTools.GetHeroName(self.curHeroId_)
	self.fightPowerText_.text = getBattlePower(HeroData:GetHeroData(self.curHeroId_))
end

function ChangePosterView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function ChangePosterView:UpdateAvatarView()
	manager.heroRaiseTrack:SetModelState(self.heroViewProxy_:GetHeroUsingSkinInfo(self.curHeroId_).id)
end

function ChangePosterView:CameraEnter()
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		1,
		0,
		0
	}, self.displayGo_)
end

function ChangePosterView:OnEnter()
	self.filterView_:OnEnter(self.heroViewProxy_)
	self.filterView_:SetHeroIdList((HeroTools.Sort(HeroData:GetHeroList())))
	self:UpdateBar()

	local var_20_0 = SkinCfg[PlayerData:GetPosterGirlHeroSkinId()].hero
	local var_20_1 = 1

	if self.params_.index then
		var_20_1 = self.params_.index
		var_20_0 = self.heroIdList_[self.params_.index]
	else
		for iter_20_0, iter_20_1 in ipairs(self.heroIdList_) do
			if iter_20_1 == var_20_0 then
				var_20_1 = iter_20_0

				break
			end
		end
	end

	self:SelectHero(var_20_0)
	self.heroHeadList_:StartScroll(#self.heroIdList_, var_20_1)
end

function ChangePosterView:OnMainHomeViewTop()
	if self.filterView_ then
		self.filterView_:Reset()
	end

	self.pos_ = nil
end

function ChangePosterView:OnHeroSort(arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5)
	self.filterView_:RefreshSort(arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5)
end

function ChangePosterView:OnExit()
	if self.filterView_ and self.filterView_.OnExit then
		self.filterView_:OnExit()
	end

	manager.windowBar:HideBar()

	if #self.heroIdList_ <= 0 then
		HeroData:ResetSortValue()
		self.filterView_:Reset()
	end

	self.params_.index = table.keyof(self.heroIdList_, self.curHeroId_)
	self.pos_ = self.heroHeadList_:GetScrolledPosition()
end

function OnCameraEnter()
	return
end

function ChangePosterView:Dispose()
	if self.heroHeadList_ then
		self.heroHeadList_:Dispose()

		self.heroHeadList_ = nil
	end

	if self.filterView_ then
		self.filterView_:Dispose()

		self.filterView_ = nil
	end

	ChangePosterView.super.Dispose(self)
end

return ChangePosterView
