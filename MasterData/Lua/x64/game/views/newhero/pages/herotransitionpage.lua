local HeroTransitionPage = class("HeroTransitionPage", HeroPageBase)

function HeroTransitionPage:OnCtor(arg_1_1, arg_1_2)
	self.handler_ = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function HeroTransitionPage:Init()
	self:InitUI()
	self:AddUIListeners()
end

function HeroTransitionPage:InitUI()
	self:BindCfgUI()

	self.transitionDiscView_ = TransitionSkillSlotsModule.New(self.transitionDiscGo_)
	self.transitionDetailInfoView_ = HeroTransitionDetailInfoView.New(self.detailInfoViewGo_)
	self.transitionSimpleInfoView_ = HeroTransitionSimpleInfoView.New(self.simpleInfoViewGo_)
	self.infoController_ = self.controller_:GetController("info")

	self:InitModule()
end

function HeroTransitionPage:InitModule()
	self.transitionDiscView_:LockJumpAnim(true)
	self.transitionDiscView_:LockSelect(false)
	self.transitionDiscView_:SetShowLocked(false)
	self.transitionDiscView_:RegisterSlotClickCallback(handler(self, self.OnSelectSlot))
end

function HeroTransitionPage:AddUIListeners()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self.infoController_:SetSelectedState("simple")
		self.transitionDiscView_:ClearSelect()
	end)
end

function HeroTransitionPage:CameraEnter()
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		7,
		0
	})
end

function HeroTransitionPage:OnEnter(arg_8_1, arg_8_2)
	self.enterIndex_ = arg_8_2.transitionIndex

	self.infoController_:SetSelectedState("simple")

	self.heroViewProxy_ = arg_8_1
	self.type_ = self.heroViewProxy_:GetViewDataType()

	self.transitionSimpleInfoView_:OnEnter(arg_8_1)
	self.transitionDetailInfoView_:OnEnter(arg_8_1)
	self:RegistEventListener(HERO_TRANSITION_CHANGE, function(arg_9_0)
		if arg_9_0.heroId == self.heroInfo_.id then
			self:UpdateView()
		end
	end)
end

function HeroTransitionPage:OnSelectSlot(arg_10_1)
	self.selectInfo_ = arg_10_1

	self.transitionDetailInfoView_:SetSlotInfo(arg_10_1)
	self.infoController_:SetSelectedState("detail")
end

function HeroTransitionPage:SetHeroInfo(arg_11_1)
	self.heroInfo_ = arg_11_1
	self.heroID_ = arg_11_1.id

	self.transitionSimpleInfoView_:SetHeroInfo(arg_11_1)
	self.transitionDetailInfoView_:SetHeroInfo(arg_11_1)

	self.isAdd_ = HeroTools.GetHeroEquipTransitionAddLevel(self.heroInfo_)

	SetActive(self.changeBtnGo_, self.heroViewProxy_:GetViewDataType() == HeroConst.HERO_DATA_TYPE.DEFAULT)
end

function HeroTransitionPage:UpdateView()
	self.transitionSimpleInfoView_:UpdateView()
	self.transitionDetailInfoView_:UpdateView()
	self.transitionDiscView_:RenderView({
		needRefresh = true,
		heroID = self.heroID_,
		proxy = self.heroViewProxy_
	})
	self.transitionDiscView_:RenderLock()

	if self.enterIndex_ then
		self:OnSelectSlot(self.transitionDiscView_:GetAllSlotMessage()[self.enterIndex_])
		self.transitionDiscView_:SelectSlot(self.enterIndex_)
	end
end

function HeroTransitionPage:Show()
	HeroTransitionPage.super.Show(self)
	self:UpdateView()
end

function HeroTransitionPage:OnTop()
	return
end

function HeroTransitionPage:Hide()
	HeroTransitionPage.super.Hide(self)

	self.enterIndex_ = nil

	self.infoController_:SetSelectedState("simple")
	self.transitionDiscView_:ClearSelect()
end

function HeroTransitionPage:OnExit()
	self:RemoveAllEventListener()
end

function HeroTransitionPage:Dispose()
	self.transitionDiscView_:Dispose()
	self.transitionDetailInfoView_:Dispose()
	self.transitionSimpleInfoView_:Dispose()
	HeroTransitionPage.super.Dispose(self)
end

return HeroTransitionPage
