local HeroShowChangeView = class("HeroShowChangeView", ReduxView)

function HeroShowChangeView:UIName()
	return "Widget/System/UserInfor/HeroShowChangeUI"
end

function HeroShowChangeView:UIParent()
	return manager.ui.uiMain.transform
end

function HeroShowChangeView:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroShowChangeView:InitUI()
	self:BindCfgUI()

	self.heroHeadList_ = LuaList.New(handler(self, self.HeadRenderer), self.uiListGo_, HeroLongHead)
	self.filterView_ = NewHeroListFilterView.New(self.filterGo_)

	self.filterView_:SetListChangeHandler(handler(self, self.OnListChange))

	self.emptyController_ = ControllerUtil.GetController(self.uiListGo_.transform, "empty")
	self.showController_ = self.controller_:GetController("show")
	self.nameDisplayController = self.controller_:GetController("nameDisplay")
	self.heroViewProxy_ = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
end

function HeroShowChangeView:OnListChange(arg_5_1)
	self.heroIdList_ = arg_5_1

	self.heroHeadList_:StartScroll(#self.heroIdList_)

	if #self.heroIdList_ > 0 then
		self.emptyController_:SetSelectedState("false")
		self:SelectHero(self.heroIdList_[1])
	else
		self.emptyController_:SetSelectedState("true")
	end
end

function HeroShowChangeView:AddUIListener()
	self:AddBtnListener(self.infoBtn_, nil, function()
		self:Go("/newHero", {
			isEnter = true,
			hid = self.curHeroId_,
			type = HeroConst.HERO_DATA_TYPE.DEFAULT
		})
	end)
	self:AddBtnListener(self.showBtn_, nil, function()
		self:SetHeroShowList(self.lastHeroID_, self.curHeroId_)
		self:Back()
		SendMessageManagerToSDK("changePosterGirl")
	end)
	self:AddBtnListener(self.unshowBtn_, nil, function()
		self:SetHeroShowList(self.curHeroId_, nil)
		self:Back()
		SendMessageManagerToSDK("changePosterGirl")
	end)
end

function HeroShowChangeView:OnChangePosterGirl(arg_10_1, arg_10_2)
	if self.params_.lastView == "home" then
		JumpTools.OpenPageByJump("/home", {
			changePoster = true
		})
	else
		self:Back()
	end
end

function HeroShowChangeView:HeadRenderer(arg_11_1, arg_11_2)
	local var_11_0 = self.heroIdList_[arg_11_1]

	arg_11_2.gameObject_.name = tostring(self.heroIdList_[arg_11_1])

	arg_11_2:SetProxy(self.heroViewProxy_)
	arg_11_2:SetHeroId(var_11_0, self.type_)
	arg_11_2:SetRedPointEnable(self.heroViewProxy_.showHeroHeadRedPoint)
	arg_11_2:SetSelected(arg_11_2.heroId_ == self.curHeroId_)
	arg_11_2:RegisterClickListener(function()
		self:SelectHero(arg_11_2.heroId_)
		OperationRecorder.Record("hero", "selectHero")
	end)
	arg_11_2:SetLable(self:CheckHeroIsShow(var_11_0) and GetTips("IS_IN_SHOW") or nil)
end

function HeroShowChangeView:SelectHero(arg_13_1)
	self.curHeroId_ = arg_13_1
	self.curHeroInfo_ = HeroData:GetHeroList()[self.curHeroId_]
	self.heroCfg_ = HeroCfg[arg_13_1]

	for iter_13_0, iter_13_1 in pairs(self.heroHeadList_:GetItemList()) do
		iter_13_1:SetSelected(iter_13_1.heroId_ == arg_13_1)
	end

	self.showController_:SetSelectedState(tostring(self:CheckHeroIsShow(arg_13_1)))

	if self.heroViewProxy_:IsHeroOath(arg_13_1) then
		if self.heroViewProxy_:HasCustomNickName(arg_13_1) then
			self.nameDisplayController:SetSelectedState("oathCustomName")
		else
			self.nameDisplayController:SetSelectedState("oath")
		end
	else
		self.nameDisplayController:SetSelectedState("normal")
	end

	self:UpdateHeroView()
	self:UpdateAvatarView()
end

function HeroShowChangeView:UpdateHeroView()
	self.nameText_.text = GetI18NText(self.heroCfg_.name)
	self.subNameText_.text = GetI18NText(self.heroViewProxy_:GetHeroName(self.curHeroId_))
	self.fightPowerText_.text = getBattlePower(HeroData:GetHeroData(self.curHeroId_))
end

function HeroShowChangeView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function HeroShowChangeView:UpdateAvatarView()
	manager.heroRaiseTrack:SetModelStateByHeroProxy(self.heroViewProxy_, self.curHeroId_)
end

function HeroShowChangeView:CameraEnter()
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		1,
		0,
		0
	}, false)
	manager.heroRaiseTrack:SetAstrolableAtive(false)
end

function HeroShowChangeView:OnEnter()
	self.filterView_:OnEnter(self.heroViewProxy_)
	self.filterView_:SetHeroIdList((HeroTools.Sort(HeroData:GetHeroList())))
	self.filterView_:SetExtraSorter(function(arg_19_0, arg_19_1)
		local var_19_0 = self:CheckHeroIsShow(arg_19_0.id)
		local var_19_1 = self:CheckHeroIsShow(arg_19_1.id)

		if var_19_0 ~= var_19_1 then
			return true, var_19_0 and not var_19_1
		end

		return false, false
	end)
	self:UpdateBar()

	self.lastHeroID_ = self.params_.heroID

	local var_18_0 = 1

	if self.params_.index then
		var_18_0 = self.params_.index
	end

	self.filterView_:SetHeroIdList(self.heroIdList_, self.type_)
	self:SelectHero(self.heroIdList_[var_18_0])
	self.heroHeadList_:StartScroll(#self.heroIdList_, var_18_0)
end

function HeroShowChangeView:CheckHeroIsShow(arg_20_1)
	for iter_20_0, iter_20_1 in pairs((PlayerData:GetHeroShowList())) do
		if iter_20_1 == arg_20_1 then
			return true
		end
	end

	return false
end

function HeroShowChangeView:OnMainHomeViewTop()
	if self.filterView_ then
		self.filterView_:Reset()
	end

	self.pos_ = nil
end

function HeroShowChangeView:OnHeroSort(arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5)
	self.filterView_:RefreshSort(arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5)
end

function HeroShowChangeView:OnExit()
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

function HeroShowChangeView:Dispose()
	if self.heroHeadList_ then
		self.heroHeadList_:Dispose()

		self.heroHeadList_ = nil
	end

	if self.filterView_ then
		self.filterView_:Dispose()

		self.filterView_ = nil
	end

	HeroShowChangeView.super.Dispose(self)
end

function HeroShowChangeView:SetHeroShowList(arg_26_1, arg_26_2)
	if arg_26_1 == nil and arg_26_2 == nil then
		return
	end

	local var_26_0 = PlayerData:GetHeroShowList()

	if arg_26_1 == nil then
		for iter_26_0 = 1, #var_26_0 do
			if var_26_0[iter_26_0] == arg_26_2 then
				table.remove(var_26_0, iter_26_0)
			end
		end

		table.insert(var_26_0, arg_26_2)
	elseif arg_26_2 == nil then
		for iter_26_1 = 1, #var_26_0 do
			if var_26_0[iter_26_1] == arg_26_1 then
				table.remove(var_26_0, iter_26_1)

				break
			end
		end
	else
		local var_26_1 = 0

		for iter_26_2 = 1, #var_26_0 do
			if var_26_0[iter_26_2] == arg_26_2 then
				var_26_1 = iter_26_2
			end
		end

		for iter_26_3 = 1, #var_26_0 do
			if var_26_0[iter_26_3] == arg_26_1 then
				if var_26_1 == 0 then
					var_26_0[iter_26_3] = arg_26_2
				else
					var_26_0[iter_26_3], var_26_0[var_26_1] = var_26_0[var_26_1], var_26_0[iter_26_3]
				end
			end
		end
	end

	PlayerAction.ChangeHeros(var_26_0)
end

return HeroShowChangeView
