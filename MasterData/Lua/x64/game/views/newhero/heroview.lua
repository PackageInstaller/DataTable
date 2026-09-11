local HeroView = class("HeroView", ReduxView)

function HeroView:UIName()
	return "Widget/System/Hero/HeroUI"
end

function HeroView:UIParent()
	return manager.ui.uiMain.transform
end

function HeroView:OnCtor()
	self.dirty_ = true
	self.curPageIndex_ = 1
	self.isChangePageAndBack_ = false
	self.pageIndexS_ = {
		weapon = 3,
		astrolabe = 6,
		skill = 2,
		transition = 5,
		chip = 7,
		property = 1,
		equip = 4
	}
	self.viewType_ = {
		[1] = 1,
		[2] = 2,
		[3] = ViewConst.SYSTEM_ID.WEAPON,
		[4] = ViewConst.SYSTEM_ID.HERO_EQUIP,
		[5] = ViewConst.SYSTEM_ID.TRANSITION,
		[6] = ViewConst.SYSTEM_ID.HERO_ASTROLABE,
		[7] = ViewConst.SYSTEM_ID.HERO_CHIP
	}
	self.sdkTeach_ = {
		"attribute",
		"skill",
		"weapon",
		"equip",
		"equip_skill",
		"astrolabe",
		"chip"
	}
	self.uiTime_ = {
		"heroAttr",
		"heroSkill",
		"heroWeapon",
		"heroEquip",
		"heroEquipSkill",
		"heroAstro",
		"heroChip"
	}
end

function HeroView:Init()
	self:InitUI()
	self:AddUIListener()
end

function HeroView:InitConfig()
	self.filterView_:SetExtraSorter(nil)
	self.filterView_:SetHeroIdList(HeroCfg.get_id_list_by_private[0])
end

function HeroView:InitUI()
	self:BindCfgUI()

	self.mainPageController_ = ControllerUtil.GetController(self.transform_, "mainPage")
	self.astroToggleController_ = ControllerUtil.GetController(self.toggle6_.transform, "lock")
	self.chipToggleController_ = ControllerUtil.GetController(self.toggle7_.transform, "lock")
	self.trasitionToggleController_ = ControllerUtil.GetController(self.toggle5_.transform, "lock")
	self.pages_ = {}

	self:InitHeroHeadList()

	self.curScrollHelper_ = self.shortScrollHelper_

	if self.pageContainerPop_ ~= nil then
		self.pageContainerPop_.parent = self.pageContainer_.parent
	end

	self.toggles_ = {
		self.toggle1_,
		self.toggle2_,
		self.toggle3_,
		self.toggle4_,
		self.toggle5_,
		self.toggle6_,
		self.toggle7_
	}
	self.filterView_ = NewHeroListFilterView.New(self.filterGo_)

	self.filterView_:SetListChangeHandler(handler(self, self.OnListChange))

	self.lockController_ = self.controller_:GetController("lock")
	self.strategyRedController_ = self.strategyCon_:GetController("redpoint")
end

function HeroView:InitHeroHeadList()
	self.shortScrollHelper_ = LuaList.New(handler(self, self.ShortHeadRenderer), self.heroShortListGo_, HeroShortHead)
	self.completeScrollHelper_ = LuaList.New(handler(self, self.LongHeadRenderer), self.heroCompleteListGo_, HeroLongHead)
end

function HeroView:CameraEnter()
	return
end

function HeroView:OnListChange(arg_9_1, arg_9_2, arg_9_3)
	self.heroIdList_ = arg_9_1
	self.guidePlaying, self.gudieId_ = manager.guide:IsPlaying()
	self.filterType_ = arg_9_3

	if self.guidePlaying and self.gudieId_ ~= 46 and self.gudieId_ ~= 4601 then
		table.sort(self.heroIdList_, function(arg_10_0, arg_10_1)
			return arg_10_0 == 1084
		end)
	end

	self.completeScrollHelper_:StartScroll(#self.heroIdList_)

	if #self.heroIdList_ > 0 then
		local var_9_0 = self.curHeroId_

		if self.dirty_ then
			self:SelectHero(self.isEnter and self.params_.hid and (table.indexof(self.heroIdList_, self.params_.hid) and self.params_.hid or self.heroIdList_[1]) or self.heroIdList_[1])
		else
			if table.indexof(self.heroIdList_, self.curHeroId_) then
				self:SelectHero(self.curHeroId_)

				var_9_0 = self.curHeroId_
			else
				self:SelectHero(self.heroIdList_[1])

				var_9_0 = self.heroIdList_[1]
			end

			if var_9_0 == self.curHeroId_ then
				manager.audio:PlayUIAudioByVoice("hero_change")
			end
		end
	end
end

function HeroView:ShortHeadRenderer(arg_11_1, arg_11_2)
	arg_11_2.gameObject_.name = tostring(self.heroIdList_[arg_11_1])

	arg_11_2:SetProxy(self.heroViewProxy_)
	arg_11_2:SetHeroId(self.heroIdList_[arg_11_1], self.type_, self.tempHeroList_)
	arg_11_2:SetRedPointEnable(self.heroViewProxy_.showHeroHeadRedPoint)
	arg_11_2:SetSelected(arg_11_2.heroId_ == self.curHeroId_)
	arg_11_2:RegisterClickListener(function()
		self:SelectHero(arg_11_2.heroId_)
		OperationRecorder.Record("hero", "selectHero")
	end)
end

function HeroView:LongHeadRenderer(arg_13_1, arg_13_2)
	arg_13_2.gameObject_.name = tostring(self.heroIdList_[arg_13_1])

	arg_13_2:SetProxy(self.heroViewProxy_)
	arg_13_2:SetHeroId(self.heroIdList_[arg_13_1], self.type_, self.tempHeroList_)
	arg_13_2:SetRedPointEnable(self.heroViewProxy_.showHeroHeadRedPoint)
	arg_13_2:SetSelected(arg_13_2.heroId_ == self.curHeroId_)
	arg_13_2:RegisterClickListener(function()
		self:SelectHero(arg_13_2.heroId_)
		OperationRecorder.Record("hero", "selectHero")
	end)
	arg_13_2:ShowFavorability(self.filterType_ == 2)
end

function HeroView:GetCurHeroInfo(arg_15_1)
	return self.heroViewProxy_:GetHeroData(arg_15_1)
end

function HeroView:SelectHero(arg_16_1)
	self.changeHero = arg_16_1 ~= self.curHeroId_
	self.curHeroId_ = arg_16_1
	self.curHeroInfo_ = self:GetCurHeroInfo(self.curHeroId_)

	HeroAction.UpdateModuleRedPointByHeroID(self.curHeroId_)
	AstrolabeAction.UpdateHeroAstrolabeCanUnLockRed(self.curHeroInfo_.id)

	for iter_16_0, iter_16_1 in pairs(self.curScrollHelper_:GetItemList()) do
		iter_16_1:SetSelected(iter_16_1.heroId_ == arg_16_1)
	end

	if self.curHeroInfo_.unlock == 0 then
		if self.curPageIndex_ == self.pageIndexS_.chip then
			self.toggles_[1].isOn = true
		end

		self:SwitchPage(1)
	elseif self.dirty_ then
		if self.params_.pageIndex then
			self:SwitchPage(self.params_.pageIndex)

			self.params_.pageIndex = nil
		else
			self:SwitchPage(_G.heroViewPageIndex_ or 1)
		end

		self.dirty_ = false
	else
		self:SwitchPage(self.curPageIndex_)
	end

	self:UpdateHeroView()

	if self.curHeroInfo_.unlock == 1 and self.mainPageController_:GetSelectedState() == "detail" then
		self.toggles_[self.curPageIndex_].isOn = true
	end

	self.params_.hid = arg_16_1

	self.pages_[self.curPageIndex_]:PlayEnterAni()

	local var_16_1 = self.mainPageController_:GetSelectedState()

	if self.curPageIndex_ == self.pageIndexS_.chip then
		if self.mainPageController_:GetSelectedState() == "list" then
			self.isChangePageAndBack_ = ChipData:GetHeroIsHaveChip(self.curHeroId_) == false
		elseif ChipData:GetHeroIsHaveChip(self.curHeroId_) == false then
			self:SwitchPage(1)

			self.toggles_[self.curPageIndex_].isOn = true
		end
	end

	if var_16_1 == "detail" and (self.curPageIndex_ == self.pageIndexS_.equip or self.curPageIndex_ == self.pageIndexS_.weapon or self.curPageIndex_ == self.pageIndexS_.transition) then
		manager.audio:PlayEffect("ui_system", "page", "")
	elseif var_16_1 == "detail" and self.curPageIndex_ == self.pageIndexS_.astrolabe then
		manager.audio:PlayEffect("ui_system", "astrolabe_appear", "")
	end

	if (self.changeHero or self.isEnter) and self.curPageIndex_ == 1 and not self.params_.isBack then
		HeroTools.StopTalk()
		manager.heroRaiseTrack:PlayTalk()
	end

	self.changeHero = false

	SetActive(self.toggle7_.gameObject, ChipData:GetHeroIsHaveChip(self.curHeroId_) and not self.heroViewProxy_.hideChipToggle)
	self:ChangeAstrolabeIcon()
end

function HeroView:SwitchToDetail()
	if self.heroIdList_ and #self.heroIdList_ <= 0 then
		self.filterView_:RefreshSort(true)
		self.filterView_:Reset()
	end

	self.pageType_ = "detail"
	self.curScrollHelper_ = self.shortScrollHelper_

	self.mainPageController_:SetSelectedState(self.pageType_)

	local var_17_0 = table.indexof(self.heroIdList_, self.curHeroId_)

	if var_17_0 then
		self.shortScrollHelper_:StartScroll(#self.heroIdList_, var_17_0)
	end

	if self.pages_[1] then
		self.pages_[1]:SwichToDetail()
	end

	if self.isChangePageAndBack_ then
		self.isChangePageAndBack_ = false

		self:SwitchPage(1)

		self.toggles_[self.curPageIndex_].isOn = true
	end
end

function HeroView:AddUIListener()
	self:AddBtnListener(self.allHeroBtn_, nil, function()
		self:SwitchPage(1)
		self.pages_[1]:SwichToAll(self, self.SwitchToDetail)

		self.toggles_[1].isOn = true
		self.pageType_ = "list"
		self.curScrollHelper_ = self.completeScrollHelper_

		self.mainPageController_:SetSelectedState(self.pageType_)

		local var_19_0 = table.indexof(self.heroIdList_, self.curHeroId_)

		if var_19_0 then
			self.completeScrollHelper_:StartScroll(#self.heroIdList_, var_19_0)
		end
	end)

	for iter_18_0, iter_18_1 in pairs(self.toggles_) do
		iter_18_1.onValueChanged:AddListener(function(arg_20_0)
			if arg_20_0 then
				self:SwitchPage(iter_18_0)
			end
		end)
	end

	self:AddBtnListener(self.cultureGravureBtn_, nil, function()
		OperationRecorder.RecordButtonTouch("hero_teach_" .. self.sdkTeach_[self.curPageIndex_])
		JumpTools.OpenPageByJump("/cultureGravureView", {
			selectIndex = 1,
			heroID = self.curHeroInfo_.id
		})
	end)
end

function HeroView:SwitchPage(arg_22_1)
	self:HideWeakGuide()

	local var_22_2, var_22_3 = self:CheckConditionByType(self.viewType_[arg_22_1])

	if not ((self.heroViewProxy_.unlockToggle or nil) and true) then
		ShowTips(var_22_3)

		self.toggles_[self.curPageIndex_].isOn = true

		return
	end

	if self.curPageIndex_ == arg_22_1 and not self.changeHero then
		self.pages_[self.curPageIndex_]:SetHeroInfo(self.curHeroInfo_)
		self.pages_[self.curPageIndex_]:UpdateView()
		self.pages_[self.curPageIndex_]:CameraEnter()

		return
	end

	if self.pages_[self.curPageIndex_] then
		self.pages_[self.curPageIndex_]:Hide()
		self:ExitSendMgr(self.curPageIndex_)
	end

	local var_22_4 = self.curPageIndex_

	self.curPageIndex_ = arg_22_1

	self:EnterSendMgr(arg_22_1)

	_G.heroViewPageIndex_ = arg_22_1

	if not self.pages_[arg_22_1] or self.pages_[arg_22_1] and self.pages_[arg_22_1].class ~= self.heroViewProxy_:GetUIClassByType(self.curPageIndex_) then
		local var_22_5 = self.heroViewProxy_:GetUIClassByType(self.curPageIndex_)
		local var_22_6 = self.heroViewProxy_:GetUIPrefabByType(self.curPageIndex_)

		if self.pages_[arg_22_1] then
			self.pages_[arg_22_1]:Dispose()

			self.pages_[arg_22_1] = nil
		end

		if self.enteredPage_ then
			self.enteredPage_[arg_22_1] = false
		end

		if var_22_6 and var_22_5 then
			self.pages_[arg_22_1] = var_22_5.New(self, (Object.Instantiate(Asset.Load(var_22_6), self.pageContainer_)))
		end
	end

	if self.isEnter then
		self:CheckPageEnter(self.curPageIndex_)
	end

	self.pages_[self.curPageIndex_]:SetHeroInfo(self.curHeroInfo_)

	if self.pages_[self.curPageIndex_].HideMaskMessage then
		self.pages_[self.curPageIndex_]:HideMaskMessage()
	end

	self.pages_[self.curPageIndex_]:Show()
	self.pages_[self.curPageIndex_]:CameraEnter()

	if self.mainPageController_:GetSelectedState() == "list" or self.curHeroInfo_.unlock == 0 then
		for iter_22_0, iter_22_1 in ipairs(self.toggles_) do
			iter_22_1.isOn = iter_22_0 == self.curPageIndex_
		end
	end

	if self.curPageIndex_ == self.pageIndexS_.equip then
		manager.audio:PlayEffect("ui_system", "equip_appear", "")
	elseif self.curPageIndex_ == self.pageIndexS_.astrolabe then
		manager.audio:PlayEffect("ui_system", "astrolabe_appear", "")
	end

	self:RecordStay(var_22_4)
	self:CheckWeakGuide()
end

function HeroView:UpdateAvatarView()
	manager.heroRaiseTrack:SetModelStateByHeroProxy(self.heroViewProxy_, self.curHeroId_)
end

function HeroView:CheckPageEnter(arg_24_1)
	if not self.enteredPage_[arg_24_1] then
		self.pages_[arg_24_1]:OnEnter(self.heroViewProxy_, self.params_)

		self.enteredPage_[arg_24_1] = true
	end
end

function HeroView:UpdateHeroView()
	self:UpdateAvatarView()
	self.lockController_:SetSelectedState(self.curHeroInfo_.unlock == 0 and "true" or "false")
	self.strategyRedController_:SetSelectedState(tostring(HeroData:GetHeroStrategyRedPoint(self.curHeroId_) and self.curHeroInfo_.unlock > 0))
	SetActive(self.cultureGravureBtn_.gameObject, not self.heroViewProxy_.hideCultureGrvureBtn and self.curHeroInfo_.unlock > 0)

	if self.heroViewProxy_.showRedPoint then
		manager.redPoint:bindUIandKey(self.toggle1_.transform, RedPointConst.HERO_PROPERTY_PAGE .. self.curHeroInfo_.id)
		manager.redPoint:bindUIandKey(self.toggle3_.transform, RedPointConst.HERO_WEAPON .. self.curHeroInfo_.id)

		if not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.HERO_ASTROLABE) then
			manager.redPoint:bindUIandKey(self.toggle6_.transform, RedPointConst.ASTROLABE_UNLOCK)
		end

		if not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.HERO_CHIP) then
			manager.redPoint:bindUIandKey(self.toggle7_.transform, RedPointConst.CHIP_HERO_CHIP .. "_" .. self.curHeroInfo_.id)
		end
	end
end

function HeroView:OnTop()
	self.curHeroInfo_ = self:GetCurHeroInfo(self.curHeroId_)

	if self.pages_ then
		for iter_26_0, iter_26_1 in pairs(self.pages_) do
			iter_26_1:OnTop()
		end
	end

	local var_26_0 = {
		BACK_BAR,
		HOME_BAR
	}

	if self.heroViewProxy_.showInfoWindowBar then
		table.insert(var_26_0, INFO_BAR)
	end

	if self.heroViewProxy_.showCurrencyWindowBar then
		table.insert(var_26_0, CurrencyConst.CURRENCY_TYPE_VITALITY)
		table.insert(var_26_0, CurrencyConst.CURRENCY_TYPE_GOLD)
		table.insert(var_26_0, CurrencyConst.CURRENCY_TYPE_DIAMOND)
		manager.windowBar:SwitchBar(var_26_0)
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	else
		manager.windowBar:SwitchBar(var_26_0)
	end

	if self.heroViewProxy_.showInfoWindowBar then
		local var_26_1 = SettingData:GetCurrentLanguageKey()

		ChipAction.UpdateHeroChipRedPoint()
		HeroAction.UpdateModuleRedPointByHeroID(self.curHeroId_)

		if GameSetting.hero_view_describe then
			local var_26_2 = GameSetting.hero_view_describe.value or {}
		end

		manager.windowBar:RegistInfoCallBack(function()
			JumpTools.OpenPageByJump("gameHelpPro", {
				isPrefab = true,
				pages = var_26_2
			})
		end)
	end

	manager.windowBar:RegistBackCallBack(function()
		if self.mainPageController_:GetSelectedState() == "list" then
			self:SwitchToDetail()
		else
			JumpTools:Back()
		end
	end)

	local var_26_3 = manager.windowBar:GetWhereTag()

	if var_26_3 ~= "guildActivity" and var_26_3 ~= "chess" and var_26_3 ~= "newchess" then
		manager.windowBar:RegistHomeCallBack(function()
			gameContext:Go("/home", nil, nil, true)
		end)
	end

	if self.params_.nextJump ~= nil then
		self:HandleNextJump(self.params_.nextJump)

		self.params_.nextJump = nil
	end
end

function HeroView:OnEnter()
	self.type_ = self.params_.type or HeroConst.HERO_DATA_TYPE.DEFAULT
	self.tempHeroList_ = self.params_.tempHeroList
	self.heroViewProxy_ = self.params_.heroViewProxy and self.params_.heroViewProxy or HeroViewDataProxy.New(self.type_)
	self.isEnter = self.params_.isEnter

	if self.params_.isSkillReturn then
		self.leftAnimator_:Update(0)
	end

	if self.tempHeroList_ then
		self.heroViewProxy_:SetTempHeroList(self.tempHeroList_)
	end

	self.enteredPage_ = {}

	if self.params_.pageIndex or self.params_.isEnter then
		self.dirty_ = true
	end

	self.heroIdList_ = self.heroViewProxy_:GetHeroIDList()

	if (self.dirty_ or self.guidePlaying) and self.filterView_ then
		self.filterView_:Reset()
	end

	self.filterView_:OnEnter(self.heroViewProxy_)
	self.filterView_:SetExtraSorter(self.heroViewProxy_:GetExFilterSorterFunc())

	if (self.type_ == HeroConst.HERO_DATA_TYPE.TRIAL or self.type_ == HeroConst.HERO_DATA_TYPE.CUSTOM) and self.params_.hid then
		if table.indexof(self.tempHeroList_, self.params_.hid) then
			self.params_.hid = SkinCfg[HeroStandardSystemCfg[self.params_.hid].hero_id].hero
		end
	end

	local var_30_0 = 1

	for iter_30_0, iter_30_1 in pairs(self.pages_) do
		self:CheckPageEnter(iter_30_0)
	end

	local var_30_1 = {}

	for iter_30_2, iter_30_3 in ipairs(self.heroIdList_) do
		local var_30_2 = self.heroViewProxy_:GetHeroData(iter_30_3).tempID or 0

		var_30_1[iter_30_2] = {
			id = iter_30_3,
			trialID = var_30_2,
			type = self.type_,
			heroViewProxy = self.heroViewProxy_
		}
	end

	self.filterView_:SetHeroIdList(var_30_1)
	self:RegistEventListener(HERO_DATA_MODIFY, handler(self, self.OnHeroUpdate))
	self:RegistEventListener(HERO_PIECE_MODIFY, handler(self, self.OnHeroUpdate))
	self:RegistEventListener(HERO_UNLOCK_SUCCESS, handler(self, self.OnHeroUnlock))
	self:RegistEventListener(FAVORITE_HERO, handler(self, self.OnHeroFavorite))

	for iter_30_4 = 1, #self.heroIdList_ do
		if self.curHeroId_ == self.heroIdList_[iter_30_4] then
			var_30_0 = iter_30_4

			break
		end
	end

	self:SwitchToDetail()

	if self.heroIdList_ and #self.heroIdList_ <= 0 then
		self.filterView_:RefreshSort(true)
		self.filterView_:Reset()
	end

	self.shortScrollHelper_:StartScroll(#self.heroIdList_, var_30_0)
	self:CheckLocked()

	self.params_.isBack = false
end

function HeroView:OnHeroFavorite()
	self.curScrollHelper_:Refresh()
end

function HeroView:CheckLocked()
	SetActive(self.toggle5_.gameObject, not self.heroViewProxy_.hideTransitionToggle)
	SetActive(self.allHeroBtn_.gameObject, not self.heroViewProxy_.hideFilterBtn)

	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.HERO_CHIP) then
		self.chipToggleController_:SetSelectedState("true")
	else
		self.chipToggleController_:SetSelectedState("false")
	end

	self:ChangeAstrolabeIcon()
	self.trasitionToggleController_:SetSelectedState(JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.TRANSITION) and not self.heroViewProxy_.unlockToggle and "true" or "false")
end

function HeroView:ChangeAstrolabeIcon()
	self.astroToggleController_:SetSelectedState((HeroTools.IsSpHero(self.curHeroId_) and "sp" or "") .. (JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.HERO_ASTROLABE) and not self.heroViewProxy_.unlockToggle and "true" or "false"))
end

function HeroView:OnHeroUnlock(arg_34_1)
	if arg_34_1 == self.curHeroId_ then
		HeroTools.StopTalk()

		self.curHeroInfo_ = self.heroViewProxy_:GetHeroData(self.curHeroInfo_.id)

		self.filterView_:UpdateList()
		self.curScrollHelper_:Refresh()

		self.curPageIndex_ = 1

		self:UpdateHeroView()
		self:SwitchPage(self.curPageIndex_)
	end
end

function HeroView:OnServantLock(arg_35_1, arg_35_2)
	self.pages_[3]:OnServantLock(arg_35_1, arg_35_2)
end

function HeroView:OnHeroSkillUpgrade(arg_36_1, arg_36_2)
	if isSuccess(arg_36_1.result) and arg_36_2.hero_id == self.curHeroId_ and self.pages_[self.pageIndexS_.skill] and self.curPageIndex_ == self.pageIndexS_.skill then
		self.pages_[self.pageIndexS_.skill]:OnHeroSkillUpgrade(arg_36_1, arg_36_2)
	end
end

function HeroView:OnHeroStarUp(arg_37_1, arg_37_2)
	if isSuccess(arg_37_1.result) and arg_37_2.id == self.curHeroId_ and self.pages_[self.pageIndexS_.star] and self.curPageIndex_ == self.pageIndexS_.star then
		self.pages_[self.pageIndexS_.star]:OnHeroStarUp(arg_37_1, arg_37_2)
	end
end

function HeroView:OnHeroUpdate(arg_38_1)
	for iter_38_0, iter_38_1 in pairs(self.shortScrollHelper_:GetItemList()) do
		if iter_38_1.heroId_ == arg_38_1 then
			iter_38_1:SetHeroData(arg_38_1, iter_38_1.heroDataType_)
		end
	end

	for iter_38_2, iter_38_3 in pairs(self.completeScrollHelper_:GetItemList()) do
		if iter_38_3.heroId_ == arg_38_1 then
			iter_38_3:SetHeroData(arg_38_1, iter_38_3.heroDataType_)
		end
	end

	if arg_38_1 == self.curHeroId_ then
		self:UpdateHeroView()
	end
end

function HeroView:CheckConditionByType(arg_39_1)
	if not table.keyof(ViewConst.SYSTEM_ID, arg_39_1) then
		return true, ""
	end

	local var_39_0 = JumpTools.IsSystemLocked(arg_39_1)

	if not var_39_0 then
		return true, ""
	else
		return false, JumpTools.GetSystemLockedTip(arg_39_1, var_39_0)
	end
end

function HeroView:OnMainHomeViewTop()
	self.dirty_ = true
	_G.heroViewPageIndex_ = 1
end

function HeroView:GetPopContainer()
	return self.pageContainerPop_
end

function HeroView:OnExit()
	if self.type_ == HeroConst.HERO_DATA_TYPE.COOPERATION then
		self.dirty_ = true
	end

	self:RemoveAllEventListener()
	manager.windowBar:HideBar()

	if #self.heroIdList_ <= 0 then
		HeroData:ResetSortValue()
		self.filterView_:Reset()

		if self.type_ == HeroConst.HERO_DATA_TYPE.DEFAULT then
			self:InitConfig()
		end
	end

	if self.pages_ then
		for iter_42_0, iter_42_1 in pairs(self.pages_) do
			iter_42_1:OnExit()
		end
	end

	self.filterView_:OnExit()
	manager.redPoint:unbindUIandKey(self.toggle1_.transform)
	manager.redPoint:unbindUIandKey(self.toggle3_.transform)
	manager.redPoint:unbindUIandKey(self.toggle6_.transform)
	manager.redPoint:unbindUIandKey(self.toggle5_.transform)
	manager.redPoint:unbindUIandKey(self.toggle7_.transform)
	self:RecordStay(self.curPageIndex_)

	if self.talkTimer_ then
		self.talkTimer_:Stop()

		self.talkTimer_ = nil
	end

	HeroTools.StopTalk()
	self:ExitSendMgr(self.curPageIndex_)
	manager.heroRaiseTrack:CancelAllAsyncLoadModelOp()
end

function HeroView:Dispose()
	self.mainPageController_:RemoveAllListeners()
	self:RemoveAllListeners()

	if self.filterView_ then
		self.filterView_:Dispose()

		self.filterView_ = nil
	end

	if self.shortScrollHelper_ then
		self.shortScrollHelper_:Dispose()

		self.shortScrollHelper_ = nil
	end

	if self.completeScrollHelper_ then
		self.completeScrollHelper_:Dispose()

		self.completeScrollHelper_ = nil
	end

	if self.pages_ then
		for iter_43_0, iter_43_1 in pairs(self.pages_) do
			iter_43_1:Dispose()
		end

		self.pages_ = nil
	end

	if self.toggles_ then
		for iter_43_2, iter_43_3 in pairs(self.toggles_) do
			iter_43_3.onValueChanged:RemoveAllListeners()
		end

		self.toggles_ = nil
	end

	HeroView.super.Dispose(self)
end

function HeroView:RecordStay(arg_44_1)
	local var_44_0 = self:GetStayTime()

	if var_44_0 == 0 then
		return
	end

	local var_44_1 = 0

	if arg_44_1 == self.pageIndexS_.property then
		var_44_1 = 20101
	elseif arg_44_1 == self.pageIndexS_.skill then
		var_44_1 = 20102
	elseif arg_44_1 == self.pageIndexS_.weapon then
		var_44_1 = 20103
	elseif arg_44_1 == self.pageIndexS_.equip then
		var_44_1 = 20104
	elseif arg_44_1 == self.pageIndexS_.astrolabe then
		var_44_1 = 20105
	end

	OperationRecorder.RecordStayView("STAY_VIEW_HERO", var_44_0, self.curHeroId_, var_44_1)
	self:UpdateLastOpenTime()
end

function HeroView:OnHeroSort(arg_45_1, arg_45_2, arg_45_3, arg_45_4, arg_45_5)
	self.filterView_:RefreshSort(arg_45_1, arg_45_2, arg_45_3, arg_45_4, arg_45_5)
end

function HeroView:HandleNextJump(arg_46_1)
	if arg_46_1[1] == 231 then
		for iter_46_0, iter_46_1 in ipairs(self.heroIdList_) do
			if #HeroRecordCfg[HeroTools.GetHeroOntologyID(iter_46_1)].plot_id > 0 then
				table.insert(arg_46_1, iter_46_1)
				self:SelectHero(iter_46_1)
				JumpTools.JumpToPage2(arg_46_1)

				return
			end
		end
	else
		table.insert(arg_46_1, self.curHeroId_)
		JumpTools.JumpToPage2(arg_46_1)

		return
	end
end

function HeroView:EnterSendMgr(arg_47_1)
	arg_47_1 = arg_47_1 or 1

	if self.uiTime_ then
		manager.uiTime:OnEnterRoute(self.uiTime_[arg_47_1])
	end
end

function HeroView:ExitSendMgr(arg_48_1)
	if arg_48_1 and self.uiTime_ then
		manager.uiTime:OnExitRoute(self.uiTime_[arg_48_1])
	end
end

function HeroView:CheckWeakGuide()
	local var_49_0, var_49_1 = GuideTool.CheckWeakGuide(self.routeName_)

	if var_49_0 and var_49_1.guide_component[2] == self.curPageIndex_ then
		self:RealCheckWeakGuide()
	end
end

function HeroView:GetCurHeroID()
	return self.curHeroId_
end

return HeroView
