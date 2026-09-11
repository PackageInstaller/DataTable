local NewHeroAstrolabePage = class("NewHeroAstrolabePage", (import("game.views.newHero.HeroPageBase")))

function NewHeroAstrolabePage:OnCtor(arg_1_1, arg_1_2)
	self.handler_ = arg_1_1
	self.gameObject_ = arg_1_2
	self.transform_ = arg_1_2.transform

	self:Init()
end

function NewHeroAstrolabePage:Init()
	self:InitUI()
	self:AddUIListener()
end

function NewHeroAstrolabePage:InitUI()
	self:BindCfgUI()

	self.infoSGo_ = {}
	self.desItemList = {}
	self.isSelfController_ = self.controller_:GetController("isSelf")
	self.isPreviewController_ = self.controller_:GetController("isPreview")
end

function NewHeroAstrolabePage:AddUIListener()
	if self.astrolabeInfoView_ then
		self.astrolabeInfoView_:SetClickAnimaton(true)
	end

	self:AddBtnListener(self.adjustBtn_, nil, function()
		JumpTools.OpenPageByJump("/astrolabeAdjust", {
			heroId = self.heroInfo_.id,
			selectPos = {
				0
			},
			astrolabe = self.astrolabeInfoView_,
			heroProxy = self.heroViewProxy_
		})
	end)
end

function NewHeroAstrolabePage:SetHeroInfo(arg_6_1)
	self.heroInfo_ = arg_6_1

	self:UpdateView()
end

function NewHeroAstrolabePage:HideMaskMessage()
	return
end

function NewHeroAstrolabePage:Show(arg_8_1)
	self.super.Show(self)
	self:UpdateView()
end

function NewHeroAstrolabePage:IsCanBackAnimation()
	if gameContext:GetLastOpenPage() ~= "astrolabeAdjust" then
		return false
	end

	if self.viewDataType == HeroConst.HERO_DATA_TYPE.PREVIEW then
		return gameContext:IsBack("/heroPreviewChange") > 0
	else
		return gameContext:IsBack("/newHero") > 0
	end
end

function NewHeroAstrolabePage:ShowBackAnimation()
	if self.astrolabeInfoView_ then
		self.astrolabeInfoView_:RefreshAnimationState(AstrolabeConst.AnimationState.HeroInfo)
	end
end

function NewHeroAstrolabePage:UpdateView()
	if self.heroInfo_ and self.heroViewProxy_ then
		self:RefreshAstrolabeInfo()
		self:ShowBackAnimation()

		self.viewDataType = self.heroViewProxy_:GetViewDataType()

		self:RefreshAstrolabeEffect()
	end
end

function NewHeroAstrolabePage:SelectItem(arg_12_1)
	if self.heroViewProxy_ and not self.heroViewProxy_.notGotoAstrolabeAdjust then
		return
	end

	local var_12_0 = arg_12_1:GetItemInfo()

	if self.astrolabeInfoView_ then
		self.astrolabeInfoView_:SetClickAnimaton(true)
	end

	JumpTools.OpenPageByJump("/astrolabeAdjust", {
		heroId = self.heroInfo_.id,
		selectPos = {
			var_12_0.posX,
			var_12_0.posY
		},
		heroProxy = self.heroViewProxy_,
		astrolabe = self.astrolabeInfoView_
	})
end

function NewHeroAstrolabePage:RefreshAstrolabeInfo()
	if self.heroInfo_ and self.heroViewProxy_ then
		if self.heroInfo_ then
			self.currentHeroID = self.heroInfo_.id or 1
		end

		local var_13_0 = false

		if self.astrolabeInfoView_ and self.lastHeroID ~= self.currentHeroID then
			var_13_0 = true

			self.astrolabeInfoView_:OnExit()
		end

		if not self.astrolabeInfoView_ then
			var_13_0 = true
			self.astrolabeInfoView_ = manager.heroRaiseTrack.astrolableController
		end

		if self.astrolabeInfoView_ then
			if var_13_0 then
				self.astrolabeInfoView_:LoadAstrolabeByPath(AstrolabeTools.GetAstrolabePrafabName(self.heroInfo_.id), self.heroInfo_.id)

				self.lastHeroID = self.currentHeroID

				self.astrolabeInfoView_:RefreshAnimationState(AstrolabeConst.AnimationState.none)
			end

			self.astrolabeInfoView_:SetNodeNameIsHide(true)
			self.astrolabeInfoView_:SetProxy(self.heroViewProxy_)
			self.astrolabeInfoView_:RegistCallBack(handler(self, self.SelectItem))
			self.astrolabeInfoView_:RefreshData(self.heroInfo_, (self:GetAstrolabeInfo(self.heroInfo_.id)))
		end

		self:UpdateNotice()
	end
end

function NewHeroAstrolabePage:GetHeroAstrolabeInfoView()
	return HeroAstrolabeInfoView
end

function NewHeroAstrolabePage:GetAstrolabeInfo(arg_15_1)
	if self.heroViewProxy_ then
		return self.heroViewProxy_:GetHeroAstrolabeS(arg_15_1)
	end

	return {}
end

function NewHeroAstrolabePage:RefreshAstrolabeEffect()
	local var_16_0

	if not self.heroInfo_ then
		do return end

		var_16_0 = self.heroViewProxy_:GetUsingAstrolabe(self.heroInfo_.id) or {}
	end

	local var_16_1 = clone(var_16_0)

	table.sort(var_16_1, function(arg_17_0, arg_17_1)
		return arg_17_0 < arg_17_1
	end)

	local var_16_2 = #var_16_1
	local var_16_3 = #var_16_1 > 0

	for iter_16_0 = 1, #var_16_1 do
		self.desItemList[iter_16_0] = self.desItemList[iter_16_0] or AstrolabeSuitDesItem.New((Object.Instantiate(self.messageGo_, self.contentTrs_)))

		self.desItemList[iter_16_0]:SetProxy(self.heroViewProxy_)
		self.desItemList[iter_16_0]:SetData(var_16_1[iter_16_0], self.heroInfo_, self.viewDataType)
		self.desItemList[iter_16_0]:SetActive(true)
	end

	for iter_16_1 = var_16_2 + 1, #self.desItemList do
		self.desItemList[iter_16_1]:SetActive(false)
	end

	SetActive(self.nullGo_, not var_16_3)
	TimeTools.StartAfterSeconds(0.1, function()
		LayoutRebuilder.ForceRebuildLayoutImmediate(self.contentTrs_)
	end, {})
end

function NewHeroAstrolabePage:OnTop()
	self:UpdateNotice()

	if self.astrolabeInfoView_ then
		self.astrolabeInfoView_:RegistCallBack(handler(self, self.SelectItem))
	end
end

function NewHeroAstrolabePage:UpdateNotice()
	if self.heroViewProxy_.showRedPoint then
		manager.redPoint:bindUIandKey(self.adjustBtn_.transform, RedPointConst.ASTROLABE_UNLOCK)
	end
end

function NewHeroAstrolabePage:OnEnter(arg_21_1, arg_21_2)
	self.heroViewProxy_ = arg_21_1
	self.isHided = true
	self.params_ = arg_21_2

	if self.heroViewProxy_:GetViewDataType() ~= HeroConst.HERO_DATA_TYPE.POLYHEDRON then
		self.isSelfController_:SetSelectedState(tostring(self.heroViewProxy_.isSelf))
	else
		self.isSelfController_:SetSelectedState("true")
	end

	self.isPreviewController_:SetSelectedState(tostring(self.heroViewProxy_:GetViewDataType() == HeroConst.HERO_DATA_TYPE.PREVIEW))
end

function NewHeroAstrolabePage:CameraEnter()
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		5,
		0
	})
	manager.heroRaiseTrack:RefreshAstrolabeColor(true)
end

function NewHeroAstrolabePage:OnExit()
	manager.redPoint:unbindUIandKey(self.adjustBtn_.transform)
	self.astrolabeInfoView_:RefreshAnimationState(AstrolabeConst.AnimationState.Hide)
	manager.heroRaiseTrack:RefreshAstrolabeColor(false)
end

function NewHeroAstrolabePage:Hide()
	manager.heroRaiseTrack:RefreshAstrolabeColor(false)
	NewHeroAstrolabePage.super.Hide(self)
	self.astrolabeInfoView_:RefreshAnimationState(AstrolabeConst.AnimationState.Hide)
	HeroTools.StopTalk()
end

function NewHeroAstrolabePage:Dispose()
	for iter_25_0, iter_25_1 in ipairs(self.desItemList or {}) do
		if iter_25_1 then
			iter_25_1:Dispose()
		end
	end

	self.desItemList = nil

	NewHeroAstrolabePage.super.Dispose(self)
end

return NewHeroAstrolabePage
