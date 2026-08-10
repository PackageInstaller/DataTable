local var_0_0 = import("game/views/newHero/HeroView")
local var_0_1 = class("StrategyMatrixHeroView_new", var_0_0)

function var_0_1.UIBackCount(arg_1_0)
	return 1
end

function var_0_1.UIName(arg_2_0)
	return "Widget/System/MatrixlUI/MatirxHeroUI"
end

function var_0_1.OnCtor(arg_3_0)
	arg_3_0.dirty_ = true
	arg_3_0.curPageIndex_ = 1
	arg_3_0.isChangePageAndBack_ = false
	arg_3_0.pageIndexS_ = {
		weapon = 3,
		astrolabe = 6,
		skill = 2,
		transition = 5,
		chip = 7,
		property = 1,
		equip = 4,
		treasure = 8
	}
	arg_3_0.viewType_ = {
		[1] = 1,
		[2] = 2,
		[3] = ViewConst.SYSTEM_ID.WEAPON,
		[4] = ViewConst.SYSTEM_ID.HERO_EQUIP,
		[5] = ViewConst.SYSTEM_ID.TRANSITION,
		[6] = ViewConst.SYSTEM_ID.HERO_ASTROLABE,
		[7] = ViewConst.SYSTEM_ID.HERO_CHIP,
		[8] = ViewConst.SYSTEM_ID.TREASURE
	}
	arg_3_0.sdkTeach_ = {
		"attribute",
		"skill",
		"weapon",
		"equip",
		"equip_skill",
		"astrolabe",
		"chip"
	}
end

function var_0_1.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.mainPageController_ = ControllerUtil.GetController(arg_4_0.transform_, "mainPage")
	arg_4_0.astroToggleController_ = ControllerUtil.GetController(arg_4_0.toggle6_.transform, "lock")
	arg_4_0.chipToggleController_ = ControllerUtil.GetController(arg_4_0.toggle7_.transform, "lock")
	arg_4_0.trasitionToggleController_ = ControllerUtil.GetController(arg_4_0.toggle5_.transform, "lock")
	arg_4_0.pages_ = {}

	arg_4_0:InitHeroHeadList()

	arg_4_0.curScrollHelper_ = arg_4_0.shortScrollHelper_

	if arg_4_0.pageContainerPop_ ~= nil then
		arg_4_0.pageContainerPop_.parent = arg_4_0.pageContainer_.parent
	end

	arg_4_0.toggles_ = {
		arg_4_0.toggle1_,
		arg_4_0.toggle2_,
		arg_4_0.toggle3_,
		arg_4_0.toggle4_,
		arg_4_0.toggle5_,
		arg_4_0.toggle6_,
		arg_4_0.toggle7_,
		arg_4_0.toggle8_
	}
	arg_4_0.filterView_ = NewHeroListFilterView.New(arg_4_0.filterGo_)

	arg_4_0.filterView_:SetListChangeHandler(handler(arg_4_0, arg_4_0.OnListChange))

	arg_4_0.lockController_ = arg_4_0.controller_:GetController("lock")
	arg_4_0.strategyRedController_ = arg_4_0.strategyCon_:GetController("redpoint")
end

function var_0_1.OnEnter(arg_5_0)
	arg_5_0.matrix_activity_id = arg_5_0.params_.matrix_activity_id
	arg_5_0.type_ = arg_5_0.params_.type or HeroConst.HERO_DATA_TYPE.DEFAULT
	arg_5_0.tempHeroList_ = arg_5_0.params_.tempHeroList
	arg_5_0.heroViewProxy_ = HeroViewDataProxy.New(arg_5_0.type_)
	arg_5_0.isEnter = arg_5_0.params_.isEnter

	if arg_5_0.params_.isSkillReturn then
		arg_5_0.leftAnimator_:Update(0)
	end

	if arg_5_0.tempHeroList_ then
		arg_5_0.heroViewProxy_:SetTempHeroList(arg_5_0.tempHeroList_)
	end

	arg_5_0.enteredPage_ = {}

	if arg_5_0.params_.pageIndex or arg_5_0.params_.isEnter then
		arg_5_0.dirty_ = true
	end

	arg_5_0.heroIdList_ = arg_5_0.heroViewProxy_:GetHeroIDList()

	if (arg_5_0.dirty_ or arg_5_0.guidePlaying) and arg_5_0.filterView_ then
		arg_5_0.filterView_:Reset()
	end

	arg_5_0.filterView_:OnEnter(arg_5_0.heroViewProxy_)
	arg_5_0.filterView_:SetExtraSorter(arg_5_0.heroViewProxy_:GetExFilterSorterFunc())

	if (arg_5_0.type_ == HeroConst.HERO_DATA_TYPE.TRIAL or arg_5_0.type_ == HeroConst.HERO_DATA_TYPE.CUSTOM) and arg_5_0.params_.hid then
		local var_5_0 = arg_5_0.params_.hid

		if table.indexof(arg_5_0.tempHeroList_, var_5_0) then
			local var_5_1 = HeroStandardSystemCfg[var_5_0]

			arg_5_0.params_.hid = SkinCfg[var_5_1.hero_id].hero
		end
	end

	local var_5_2 = 1

	for iter_5_0, iter_5_1 in pairs(arg_5_0.pages_) do
		arg_5_0:CheckPageEnter(iter_5_0)
	end

	local var_5_3 = {}

	if arg_5_0.heroIdList_ then
		for iter_5_2, iter_5_3 in ipairs(arg_5_0.heroIdList_) do
			local var_5_4 = arg_5_0.heroViewProxy_:GetHeroData(iter_5_3).tempID or 0

			var_5_3[iter_5_2] = {
				id = iter_5_3,
				trialID = var_5_4,
				type = arg_5_0.type_,
				heroViewProxy = arg_5_0.heroViewProxy_
			}
		end
	end

	arg_5_0.filterView_:SetHeroIdList(var_5_3)
	arg_5_0:RegistEventListener(HERO_DATA_MODIFY, handler(arg_5_0, arg_5_0.OnHeroUpdate))
	arg_5_0:RegistEventListener(HERO_PIECE_MODIFY, handler(arg_5_0, arg_5_0.OnHeroUpdate))
	arg_5_0:RegistEventListener(HERO_UNLOCK_SUCCESS, handler(arg_5_0, arg_5_0.OnHeroUnlock))
	arg_5_0:RegistEventListener(FAVORITE_HERO, handler(arg_5_0, arg_5_0.OnHeroFavorite))

	for iter_5_4 = 1, #arg_5_0.heroIdList_ do
		if arg_5_0.curHeroId_ == arg_5_0.heroIdList_[iter_5_4] then
			var_5_2 = iter_5_4

			break
		end
	end

	arg_5_0:SwitchToDetail()

	if arg_5_0.heroIdList_ and #arg_5_0.heroIdList_ <= 0 then
		arg_5_0.filterView_:RefreshSort(true)
		arg_5_0.filterView_:Reset()
	end

	arg_5_0.shortScrollHelper_:StartScroll(#arg_5_0.heroIdList_, var_5_2)
	arg_5_0:CheckLocked()

	arg_5_0.params_.isBack = false
end

function var_0_1.OnTop(arg_6_0)
	arg_6_0.curHeroInfo_ = arg_6_0:GetCurHeroInfo(arg_6_0.curHeroId_)

	if arg_6_0.pages_ then
		for iter_6_0, iter_6_1 in pairs(arg_6_0.pages_) do
			iter_6_1:OnTop()
		end
	end

	local var_6_0 = {
		BACK_BAR,
		HOME_BAR
	}

	if arg_6_0.heroViewProxy_.showInfoWindowBar then
		table.insert(var_6_0, INFO_BAR)
	end

	if arg_6_0.heroViewProxy_.showCurrencyWindowBar then
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

	if arg_6_0.heroViewProxy_.showInfoWindowBar then
		local var_6_1 = SettingData:GetCurrentLanguageKey()

		ChipAction.UpdateHeroChipRedPoint()
		HeroAction.UpdateModuleRedPointByHeroID(arg_6_0.curHeroId_)

		local var_6_2 = GameSetting.hero_view_describe and GameSetting.hero_view_describe.value or {}

		manager.windowBar:RegistInfoCallBack(function()
			JumpTools.OpenPageByJump("gameHelpPro", {
				isPrefab = true,
				pages = var_6_2
			})
		end)
	end

	manager.windowBar:RegistBackCallBack(function()
		if arg_6_0.mainPageController_:GetSelectedState() == "list" then
			arg_6_0:SwitchToDetail()
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

	if arg_6_0.params_.nextJump ~= nil then
		arg_6_0:HandleNextJump(arg_6_0.params_.nextJump)

		arg_6_0.params_.nextJump = nil
	end
end

function var_0_1.SelectHero(arg_10_0, arg_10_1)
	var_0_1.super.SelectHero(arg_10_0, arg_10_1)
	SetActive(arg_10_0.toggle7_.gameObject, false)
end

function var_0_1.CheckLocked(arg_11_0)
	SetActive(arg_11_0.toggle5_.gameObject, not arg_11_0.heroViewProxy_.hideTransitionToggle)
	SetActive(arg_11_0.allHeroBtn_.gameObject, false)
	arg_11_0.chipToggleController_:SetSelectedState("false")
	arg_11_0:ChangeAstrolabeIcon()
	arg_11_0.trasitionToggleController_:SetSelectedState(JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.TRANSITION) and not arg_11_0.heroViewProxy_.unlockToggle and "true" or "false")
end

function var_0_1.GetCurHeroInfo(arg_12_0, arg_12_1)
	return StrategyMatrixData:GetHeroData(arg_12_1)
end

return var_0_1
