local StrategyMatrixHeroView_new = class("StrategyMatrixHeroView_new", (import("game/views/newHero/HeroView")))

function StrategyMatrixHeroView_new:UIBackCount()
	return 1
end

function StrategyMatrixHeroView_new:UIName()
	return "Widget/System/MatrixlUI/MatirxHeroUI"
end

function StrategyMatrixHeroView_new:OnCtor()
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
		equip = 4,
		treasure = 8
	}
	self.viewType_ = {
		[1] = 1,
		[2] = 2,
		[3] = ViewConst.SYSTEM_ID.WEAPON,
		[4] = ViewConst.SYSTEM_ID.HERO_EQUIP,
		[5] = ViewConst.SYSTEM_ID.TRANSITION,
		[6] = ViewConst.SYSTEM_ID.HERO_ASTROLABE,
		[7] = ViewConst.SYSTEM_ID.HERO_CHIP,
		[8] = ViewConst.SYSTEM_ID.TREASURE
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
end

function StrategyMatrixHeroView_new:InitUI()
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
		self.toggle7_,
		self.toggle8_
	}
	self.filterView_ = NewHeroListFilterView.New(self.filterGo_)

	self.filterView_:SetListChangeHandler(handler(self, self.OnListChange))

	self.lockController_ = self.controller_:GetController("lock")
	self.strategyRedController_ = self.strategyCon_:GetController("redpoint")
end

function StrategyMatrixHeroView_new:OnEnter()
	self.matrix_activity_id = self.params_.matrix_activity_id
	self.type_ = self.params_.type or HeroConst.HERO_DATA_TYPE.DEFAULT
	self.tempHeroList_ = self.params_.tempHeroList
	self.heroViewProxy_ = HeroViewDataProxy.New(self.type_)
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

	local var_5_0 = 1

	for iter_5_0, iter_5_1 in pairs(self.pages_) do
		self:CheckPageEnter(iter_5_0)
	end

	local var_5_1 = {}

	if self.heroIdList_ then
		for iter_5_2, iter_5_3 in ipairs(self.heroIdList_) do
			local var_5_2 = self.heroViewProxy_:GetHeroData(iter_5_3).tempID or 0

			var_5_1[iter_5_2] = {
				id = iter_5_3,
				trialID = var_5_2,
				type = self.type_,
				heroViewProxy = self.heroViewProxy_
			}
		end
	end

	self.filterView_:SetHeroIdList(var_5_1)
	self:RegistEventListener(HERO_DATA_MODIFY, handler(self, self.OnHeroUpdate))
	self:RegistEventListener(HERO_PIECE_MODIFY, handler(self, self.OnHeroUpdate))
	self:RegistEventListener(HERO_UNLOCK_SUCCESS, handler(self, self.OnHeroUnlock))
	self:RegistEventListener(FAVORITE_HERO, handler(self, self.OnHeroFavorite))

	for iter_5_4 = 1, #self.heroIdList_ do
		if self.curHeroId_ == self.heroIdList_[iter_5_4] then
			var_5_0 = iter_5_4

			break
		end
	end

	self:SwitchToDetail()

	if self.heroIdList_ and #self.heroIdList_ <= 0 then
		self.filterView_:RefreshSort(true)
		self.filterView_:Reset()
	end

	self.shortScrollHelper_:StartScroll(#self.heroIdList_, var_5_0)
	self:CheckLocked()

	self.params_.isBack = false
end

function StrategyMatrixHeroView_new:OnTop()
	self.curHeroInfo_ = self:GetCurHeroInfo(self.curHeroId_)

	if self.pages_ then
		for iter_6_0, iter_6_1 in pairs(self.pages_) do
			iter_6_1:OnTop()
		end
	end

	local var_6_0 = {
		BACK_BAR,
		HOME_BAR
	}

	if self.heroViewProxy_.showInfoWindowBar then
		table.insert(var_6_0, INFO_BAR)
	end

	if self.heroViewProxy_.showCurrencyWindowBar then
		table.insert(var_6_0, CurrencyConst.CURRENCY_TYPE_VITALITY)
		table.insert(var_6_0, CurrencyConst.CURRENCY_TYPE_GOLD)
		table.insert(var_6_0, CurrencyConst.CURRENCY_TYPE_DIAMOND)
		manager.windowBar:SwitchBar(var_6_0)
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_VITALITY, true)
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	else
		manager.windowBar:SwitchBar(var_6_0)
	end

	if self.heroViewProxy_.showInfoWindowBar then
		local var_6_1 = SettingData:GetCurrentLanguageKey()

		ChipAction.UpdateHeroChipRedPoint()
		HeroAction.UpdateModuleRedPointByHeroID(self.curHeroId_)

		if GameSetting.hero_view_describe then
			local var_6_2 = GameSetting.hero_view_describe.value or {}
		end

		manager.windowBar:RegistInfoCallBack(function()
			JumpTools.OpenPageByJump("gameHelpPro", {
				isPrefab = true,
				pages = var_6_2
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

	local var_6_3 = manager.windowBar:GetWhereTag()

	if var_6_3 ~= "guildActivity" and var_6_3 ~= "chess" and var_6_3 ~= "newchess" then
		manager.windowBar:RegistHomeCallBack(function()
			gameContext:Go("/home", nil, nil, true)
		end)
	end

	if self.params_.nextJump ~= nil then
		self:HandleNextJump(self.params_.nextJump)

		self.params_.nextJump = nil
	end
end

function StrategyMatrixHeroView_new:SelectHero(arg_10_1)
	StrategyMatrixHeroView_new.super.SelectHero(self, arg_10_1)
	SetActive(self.toggle7_.gameObject, false)
end

function StrategyMatrixHeroView_new:CheckLocked()
	SetActive(self.toggle5_.gameObject, not self.heroViewProxy_.hideTransitionToggle)
	SetActive(self.allHeroBtn_.gameObject, false)
	self.chipToggleController_:SetSelectedState("false")
	self:ChangeAstrolabeIcon()
	self.trasitionToggleController_:SetSelectedState(JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.TRANSITION) and not self.heroViewProxy_.unlockToggle and "true" or "false")
end

function StrategyMatrixHeroView_new:GetCurHeroInfo(arg_12_1)
	return StrategyMatrixData:GetHeroData(arg_12_1)
end

return StrategyMatrixHeroView_new
