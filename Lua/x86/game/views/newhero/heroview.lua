local var_0_0 = class("HeroView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero/HeroUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
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
		equip = 4
	}
	arg_3_0.viewType_ = {
		[1] = 1,
		[2] = 2,
		[3] = ViewConst.SYSTEM_ID.WEAPON,
		[4] = ViewConst.SYSTEM_ID.HERO_EQUIP,
		[5] = ViewConst.SYSTEM_ID.TRANSITION,
		[6] = ViewConst.SYSTEM_ID.HERO_ASTROLABE,
		[7] = ViewConst.SYSTEM_ID.HERO_CHIP
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
	arg_3_0.uiTime_ = {
		"heroAttr",
		"heroSkill",
		"heroWeapon",
		"heroEquip",
		"heroEquipSkill",
		"heroAstro",
		"heroChip"
	}
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitConfig(arg_5_0)
	arg_5_0.filterView_:SetExtraSorter(nil)
	arg_5_0.filterView_:SetHeroIdList(HeroCfg.get_id_list_by_private[0])
end

function var_0_0.InitUI(arg_6_0)
	arg_6_0:BindCfgUI()

	arg_6_0.mainPageController_ = ControllerUtil.GetController(arg_6_0.transform_, "mainPage")
	arg_6_0.astroToggleController_ = ControllerUtil.GetController(arg_6_0.toggle6_.transform, "lock")
	arg_6_0.chipToggleController_ = ControllerUtil.GetController(arg_6_0.toggle7_.transform, "lock")
	arg_6_0.trasitionToggleController_ = ControllerUtil.GetController(arg_6_0.toggle5_.transform, "lock")
	arg_6_0.pages_ = {}

	arg_6_0:InitHeroHeadList()

	arg_6_0.curScrollHelper_ = arg_6_0.shortScrollHelper_

	if arg_6_0.pageContainerPop_ ~= nil then
		arg_6_0.pageContainerPop_.parent = arg_6_0.pageContainer_.parent
	end

	arg_6_0.toggles_ = {
		arg_6_0.toggle1_,
		arg_6_0.toggle2_,
		arg_6_0.toggle3_,
		arg_6_0.toggle4_,
		arg_6_0.toggle5_,
		arg_6_0.toggle6_,
		arg_6_0.toggle7_
	}
	arg_6_0.filterView_ = NewHeroListFilterView.New(arg_6_0.filterGo_)

	arg_6_0.filterView_:SetListChangeHandler(handler(arg_6_0, arg_6_0.OnListChange))

	arg_6_0.lockController_ = arg_6_0.controller_:GetController("lock")
	arg_6_0.strategyRedController_ = arg_6_0.strategyCon_:GetController("redpoint")
end

function var_0_0.InitHeroHeadList(arg_7_0)
	arg_7_0.shortScrollHelper_ = LuaList.New(handler(arg_7_0, arg_7_0.ShortHeadRenderer), arg_7_0.heroShortListGo_, HeroShortHead)
	arg_7_0.completeScrollHelper_ = LuaList.New(handler(arg_7_0, arg_7_0.LongHeadRenderer), arg_7_0.heroCompleteListGo_, HeroLongHead)
end

function var_0_0.CameraEnter(arg_8_0)
	return
end

function var_0_0.OnListChange(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	arg_9_0.heroIdList_ = arg_9_1
	arg_9_0.guidePlaying, arg_9_0.gudieId_ = manager.guide:IsPlaying()
	arg_9_0.filterType_ = arg_9_3

	if arg_9_0.guidePlaying and arg_9_0.gudieId_ ~= 46 and arg_9_0.gudieId_ ~= 4601 then
		table.sort(arg_9_0.heroIdList_, function(arg_10_0, arg_10_1)
			return arg_10_0 == 1084
		end)
	end

	arg_9_0.completeScrollHelper_:StartScroll(#arg_9_0.heroIdList_)

	if #arg_9_0.heroIdList_ > 0 then
		local var_9_0 = arg_9_0.curHeroId_

		if arg_9_0.dirty_ then
			local var_9_1

			if arg_9_0.isEnter and arg_9_0.params_.hid then
				if table.indexof(arg_9_0.heroIdList_, arg_9_0.params_.hid) then
					var_9_1 = arg_9_0.params_.hid
				else
					var_9_1 = arg_9_0.heroIdList_[1]
				end
			else
				var_9_1 = arg_9_0.heroIdList_[1]
			end

			arg_9_0:SelectHero(var_9_1)
		else
			if table.indexof(arg_9_0.heroIdList_, arg_9_0.curHeroId_) then
				arg_9_0:SelectHero(arg_9_0.curHeroId_)

				var_9_0 = arg_9_0.curHeroId_
			else
				arg_9_0:SelectHero(arg_9_0.heroIdList_[1])

				var_9_0 = arg_9_0.heroIdList_[1]
			end

			if not (var_9_0 ~= arg_9_0.curHeroId_ and true or false) then
				manager.audio:PlayUIAudioByVoice("hero_change")
			end
		end
	end
end

function var_0_0.ShortHeadRenderer(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.heroIdList_[arg_11_1]

	arg_11_2.gameObject_.name = tostring(var_11_0)

	arg_11_2:SetProxy(arg_11_0.heroViewProxy_)
	arg_11_2:SetHeroId(var_11_0, arg_11_0.type_, arg_11_0.tempHeroList_)
	arg_11_2:SetRedPointEnable(arg_11_0.heroViewProxy_.showHeroHeadRedPoint)
	arg_11_2:SetSelected(arg_11_2.heroId_ == arg_11_0.curHeroId_)
	arg_11_2:RegisterClickListener(function()
		arg_11_0:SelectHero(arg_11_2.heroId_)
		OperationRecorder.Record("hero", "selectHero")
	end)
end

function var_0_0.LongHeadRenderer(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0.heroIdList_[arg_13_1]

	arg_13_2.gameObject_.name = tostring(var_13_0)

	arg_13_2:SetProxy(arg_13_0.heroViewProxy_)
	arg_13_2:SetHeroId(var_13_0, arg_13_0.type_, arg_13_0.tempHeroList_)
	arg_13_2:SetRedPointEnable(arg_13_0.heroViewProxy_.showHeroHeadRedPoint)
	arg_13_2:SetSelected(arg_13_2.heroId_ == arg_13_0.curHeroId_)
	arg_13_2:RegisterClickListener(function()
		arg_13_0:SelectHero(arg_13_2.heroId_)
		OperationRecorder.Record("hero", "selectHero")
	end)
	arg_13_2:ShowFavorability(arg_13_0.filterType_ == 2)
end

function var_0_0.GetCurHeroInfo(arg_15_0, arg_15_1)
	return arg_15_0.heroViewProxy_:GetHeroData(arg_15_1)
end

function var_0_0.SelectHero(arg_16_0, arg_16_1)
	arg_16_0.changeHero = arg_16_1 ~= arg_16_0.curHeroId_ and true or false
	arg_16_0.curHeroId_ = arg_16_1
	arg_16_0.curHeroInfo_ = arg_16_0:GetCurHeroInfo(arg_16_0.curHeroId_)

	HeroAction.UpdateModuleRedPointByHeroID(arg_16_0.curHeroId_)
	AstrolabeAction.UpdateHeroAstrolabeCanUnLockRed(arg_16_0.curHeroInfo_.id)

	for iter_16_0, iter_16_1 in pairs(arg_16_0.curScrollHelper_:GetItemList()) do
		iter_16_1:SetSelected(iter_16_1.heroId_ == arg_16_1)
	end

	if arg_16_0.curHeroInfo_.unlock == 0 then
		if arg_16_0.curPageIndex_ == arg_16_0.pageIndexS_.chip then
			arg_16_0.toggles_[1].isOn = true
		end

		arg_16_0:SwitchPage(1)
	elseif arg_16_0.dirty_ then
		if arg_16_0.params_.pageIndex then
			arg_16_0:SwitchPage(arg_16_0.params_.pageIndex)

			arg_16_0.params_.pageIndex = nil
		else
			arg_16_0:SwitchPage(_G.heroViewPageIndex_ or 1)
		end

		arg_16_0.dirty_ = false
	else
		arg_16_0:SwitchPage(arg_16_0.curPageIndex_)
	end

	arg_16_0:UpdateHeroView()

	if arg_16_0.curHeroInfo_.unlock == 1 and arg_16_0.mainPageController_:GetSelectedState() == "detail" then
		arg_16_0.toggles_[arg_16_0.curPageIndex_].isOn = true
	end

	arg_16_0.params_.hid = arg_16_1

	arg_16_0.pages_[arg_16_0.curPageIndex_]:PlayEnterAni()

	local var_16_0 = arg_16_0.mainPageController_:GetSelectedState()

	if arg_16_0.curPageIndex_ == arg_16_0.pageIndexS_.chip then
		if arg_16_0.mainPageController_:GetSelectedState() == "list" then
			if ChipData:GetHeroIsHaveChip(arg_16_0.curHeroId_) == false then
				arg_16_0.isChangePageAndBack_ = true
			else
				arg_16_0.isChangePageAndBack_ = false
			end
		elseif ChipData:GetHeroIsHaveChip(arg_16_0.curHeroId_) == false then
			arg_16_0:SwitchPage(1)

			arg_16_0.toggles_[arg_16_0.curPageIndex_].isOn = true
		end
	end

	if var_16_0 == "detail" and (arg_16_0.curPageIndex_ == arg_16_0.pageIndexS_.equip or arg_16_0.curPageIndex_ == arg_16_0.pageIndexS_.weapon or arg_16_0.curPageIndex_ == arg_16_0.pageIndexS_.transition) then
		manager.audio:PlayEffect("ui_system", "page", "")
	elseif var_16_0 == "detail" and arg_16_0.curPageIndex_ == arg_16_0.pageIndexS_.astrolabe then
		manager.audio:PlayEffect("ui_system", "astrolabe_appear", "")
	end

	if (arg_16_0.changeHero or arg_16_0.isEnter) and arg_16_0.curPageIndex_ == 1 and not arg_16_0.params_.isBack then
		HeroTools.StopTalk()
		manager.heroRaiseTrack:PlayTalk()
	end

	arg_16_0.changeHero = false

	SetActive(arg_16_0.toggle7_.gameObject, ChipData:GetHeroIsHaveChip(arg_16_0.curHeroId_) and not arg_16_0.heroViewProxy_.hideChipToggle)
	arg_16_0:ChangeAstrolabeIcon()
end

function var_0_0.SwitchToDetail(arg_17_0)
	if arg_17_0.heroIdList_ and #arg_17_0.heroIdList_ <= 0 then
		arg_17_0.filterView_:RefreshSort(true)
		arg_17_0.filterView_:Reset()
	end

	arg_17_0.pageType_ = "detail"
	arg_17_0.curScrollHelper_ = arg_17_0.shortScrollHelper_

	arg_17_0.mainPageController_:SetSelectedState(arg_17_0.pageType_)

	local var_17_0 = table.indexof(arg_17_0.heroIdList_, arg_17_0.curHeroId_)

	if var_17_0 then
		arg_17_0.shortScrollHelper_:StartScroll(#arg_17_0.heroIdList_, var_17_0)
	end

	if arg_17_0.pages_[1] then
		arg_17_0.pages_[1]:SwichToDetail()
	end

	if arg_17_0.isChangePageAndBack_ then
		arg_17_0.isChangePageAndBack_ = false

		arg_17_0:SwitchPage(1)

		arg_17_0.toggles_[arg_17_0.curPageIndex_].isOn = true
	end
end

function var_0_0.AddUIListener(arg_18_0)
	arg_18_0:AddBtnListener(arg_18_0.allHeroBtn_, nil, function()
		arg_18_0:SwitchPage(1)
		arg_18_0.pages_[1]:SwichToAll(arg_18_0, arg_18_0.SwitchToDetail)

		arg_18_0.toggles_[1].isOn = true
		arg_18_0.pageType_ = "list"
		arg_18_0.curScrollHelper_ = arg_18_0.completeScrollHelper_

		arg_18_0.mainPageController_:SetSelectedState(arg_18_0.pageType_)

		local var_19_0 = table.indexof(arg_18_0.heroIdList_, arg_18_0.curHeroId_)

		if var_19_0 then
			arg_18_0.completeScrollHelper_:StartScroll(#arg_18_0.heroIdList_, var_19_0)
		end
	end)

	for iter_18_0, iter_18_1 in pairs(arg_18_0.toggles_) do
		iter_18_1.onValueChanged:AddListener(function(arg_20_0)
			if arg_20_0 then
				arg_18_0:SwitchPage(iter_18_0)
			end
		end)
	end

	arg_18_0:AddBtnListener(arg_18_0.cultureGravureBtn_, nil, function()
		OperationRecorder.RecordButtonTouch("hero_teach_" .. arg_18_0.sdkTeach_[arg_18_0.curPageIndex_])
		JumpTools.OpenPageByJump("/cultureGravureView", {
			selectIndex = 1,
			heroID = arg_18_0.curHeroInfo_.id
		})
	end)
end

function var_0_0.SwitchPage(arg_22_0, arg_22_1)
	arg_22_0:HideWeakGuide()

	local var_22_0 = true
	local var_22_1 = ""
	local var_22_2, var_22_3 = arg_22_0:CheckConditionByType(arg_22_0.viewType_[arg_22_1])

	if arg_22_0.heroViewProxy_.unlockToggle then
		var_22_2 = true
	end

	if not var_22_2 then
		ShowTips(var_22_3)

		arg_22_0.toggles_[arg_22_0.curPageIndex_].isOn = true

		return
	end

	if arg_22_0.curPageIndex_ == arg_22_1 and not arg_22_0.changeHero then
		arg_22_0.pages_[arg_22_0.curPageIndex_]:SetHeroInfo(arg_22_0.curHeroInfo_)
		arg_22_0.pages_[arg_22_0.curPageIndex_]:UpdateView()
		arg_22_0.pages_[arg_22_0.curPageIndex_]:CameraEnter()

		return
	end

	local var_22_4 = arg_22_0.pages_[arg_22_0.curPageIndex_]

	if var_22_4 then
		var_22_4:Hide()
		arg_22_0:ExitSendMgr(arg_22_0.curPageIndex_)
	end

	local var_22_5 = arg_22_0.curPageIndex_

	arg_22_0.curPageIndex_ = arg_22_1

	arg_22_0:EnterSendMgr(arg_22_1)

	_G.heroViewPageIndex_ = arg_22_1

	local var_22_6 = arg_22_0.pages_[arg_22_1] and arg_22_0.pages_[arg_22_1].class ~= arg_22_0.heroViewProxy_:GetUIClassByType(arg_22_0.curPageIndex_)

	if not arg_22_0.pages_[arg_22_1] or var_22_6 then
		local var_22_7 = arg_22_0.heroViewProxy_:GetUIClassByType(arg_22_0.curPageIndex_)
		local var_22_8 = arg_22_0.heroViewProxy_:GetUIPrefabByType(arg_22_0.curPageIndex_)

		if arg_22_0.pages_[arg_22_1] then
			arg_22_0.pages_[arg_22_1]:Dispose()

			arg_22_0.pages_[arg_22_1] = nil
		end

		if arg_22_0.enteredPage_ then
			arg_22_0.enteredPage_[arg_22_1] = false
		end

		if var_22_8 and var_22_7 then
			local var_22_9 = Asset.Load(var_22_8)
			local var_22_10 = Object.Instantiate(var_22_9, arg_22_0.pageContainer_)

			arg_22_0.pages_[arg_22_1] = var_22_7.New(arg_22_0, var_22_10)
		end
	end

	if arg_22_0.isEnter then
		arg_22_0:CheckPageEnter(arg_22_0.curPageIndex_)
	end

	arg_22_0.pages_[arg_22_0.curPageIndex_]:SetHeroInfo(arg_22_0.curHeroInfo_)

	if arg_22_0.pages_[arg_22_0.curPageIndex_].HideMaskMessage then
		arg_22_0.pages_[arg_22_0.curPageIndex_]:HideMaskMessage()
	end

	arg_22_0.pages_[arg_22_0.curPageIndex_]:Show()
	arg_22_0.pages_[arg_22_0.curPageIndex_]:CameraEnter()

	if arg_22_0.mainPageController_:GetSelectedState() == "list" or arg_22_0.curHeroInfo_.unlock == 0 then
		for iter_22_0, iter_22_1 in ipairs(arg_22_0.toggles_) do
			iter_22_1.isOn = iter_22_0 == arg_22_0.curPageIndex_
		end
	end

	if arg_22_0.curPageIndex_ == arg_22_0.pageIndexS_.equip then
		manager.audio:PlayEffect("ui_system", "equip_appear", "")
	elseif arg_22_0.curPageIndex_ == arg_22_0.pageIndexS_.astrolabe then
		manager.audio:PlayEffect("ui_system", "astrolabe_appear", "")
	end

	arg_22_0:RecordStay(var_22_5)
	arg_22_0:CheckWeakGuide()
end

function var_0_0.UpdateAvatarView(arg_23_0)
	manager.heroRaiseTrack:SetModelStateByHeroProxy(arg_23_0.heroViewProxy_, arg_23_0.curHeroId_)
end

function var_0_0.CheckPageEnter(arg_24_0, arg_24_1)
	if not arg_24_0.enteredPage_[arg_24_1] then
		arg_24_0.pages_[arg_24_1]:OnEnter(arg_24_0.heroViewProxy_, arg_24_0.params_)

		arg_24_0.enteredPage_[arg_24_1] = true
	end
end

function var_0_0.UpdateHeroView(arg_25_0)
	arg_25_0:UpdateAvatarView()
	arg_25_0.lockController_:SetSelectedState(arg_25_0.curHeroInfo_.unlock == 0 and "true" or "false")
	arg_25_0.strategyRedController_:SetSelectedState(tostring(HeroData:GetHeroStrategyRedPoint(arg_25_0.curHeroId_) and arg_25_0.curHeroInfo_.unlock > 0))
	SetActive(arg_25_0.cultureGravureBtn_.gameObject, not arg_25_0.heroViewProxy_.hideCultureGrvureBtn and arg_25_0.curHeroInfo_.unlock > 0)

	local var_25_0 = HeroCfg[arg_25_0.curHeroId_].study_stage[1]

	if arg_25_0.heroViewProxy_.showRedPoint then
		manager.redPoint:bindUIandKey(arg_25_0.toggle1_.transform, RedPointConst.HERO_PROPERTY_PAGE .. arg_25_0.curHeroInfo_.id)
		manager.redPoint:bindUIandKey(arg_25_0.toggle3_.transform, RedPointConst.HERO_WEAPON .. arg_25_0.curHeroInfo_.id)

		if not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.HERO_ASTROLABE) then
			manager.redPoint:bindUIandKey(arg_25_0.toggle6_.transform, RedPointConst.ASTROLABE_UNLOCK)
		end

		if not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.HERO_CHIP) then
			manager.redPoint:bindUIandKey(arg_25_0.toggle7_.transform, RedPointConst.CHIP_HERO_CHIP .. "_" .. arg_25_0.curHeroInfo_.id)
		end
	end
end

function var_0_0.OnTop(arg_26_0)
	arg_26_0.curHeroInfo_ = arg_26_0:GetCurHeroInfo(arg_26_0.curHeroId_)

	if arg_26_0.pages_ then
		for iter_26_0, iter_26_1 in pairs(arg_26_0.pages_) do
			iter_26_1:OnTop()
		end
	end

	local var_26_0 = {
		BACK_BAR,
		HOME_BAR
	}

	if arg_26_0.heroViewProxy_.showInfoWindowBar then
		table.insert(var_26_0, INFO_BAR)
	end

	if arg_26_0.heroViewProxy_.showCurrencyWindowBar then
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

	if arg_26_0.heroViewProxy_.showInfoWindowBar then
		local var_26_1 = SettingData:GetCurrentLanguageKey()

		ChipAction.UpdateHeroChipRedPoint()
		HeroAction.UpdateModuleRedPointByHeroID(arg_26_0.curHeroId_)

		local var_26_2 = GameSetting.hero_view_describe and GameSetting.hero_view_describe.value or {}

		manager.windowBar:RegistInfoCallBack(function()
			JumpTools.OpenPageByJump("gameHelpPro", {
				isPrefab = true,
				pages = var_26_2
			})
		end)
	end

	manager.windowBar:RegistBackCallBack(function()
		if arg_26_0.mainPageController_:GetSelectedState() == "list" then
			arg_26_0:SwitchToDetail()
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

	if arg_26_0.params_.nextJump ~= nil then
		arg_26_0:HandleNextJump(arg_26_0.params_.nextJump)

		arg_26_0.params_.nextJump = nil
	end
end

function var_0_0.OnEnter(arg_30_0)
	arg_30_0.type_ = arg_30_0.params_.type or HeroConst.HERO_DATA_TYPE.DEFAULT
	arg_30_0.tempHeroList_ = arg_30_0.params_.tempHeroList

	if arg_30_0.params_.heroViewProxy then
		arg_30_0.heroViewProxy_ = arg_30_0.params_.heroViewProxy
	else
		arg_30_0.heroViewProxy_ = HeroViewDataProxy.New(arg_30_0.type_)
	end

	arg_30_0.isEnter = arg_30_0.params_.isEnter

	if arg_30_0.params_.isSkillReturn then
		arg_30_0.leftAnimator_:Update(0)
	end

	if arg_30_0.tempHeroList_ then
		arg_30_0.heroViewProxy_:SetTempHeroList(arg_30_0.tempHeroList_)
	end

	arg_30_0.enteredPage_ = {}

	if arg_30_0.params_.pageIndex or arg_30_0.params_.isEnter then
		arg_30_0.dirty_ = true
	end

	arg_30_0.heroIdList_ = arg_30_0.heroViewProxy_:GetHeroIDList()

	if (arg_30_0.dirty_ or arg_30_0.guidePlaying) and arg_30_0.filterView_ then
		arg_30_0.filterView_:Reset()
	end

	arg_30_0.filterView_:OnEnter(arg_30_0.heroViewProxy_)
	arg_30_0.filterView_:SetExtraSorter(arg_30_0.heroViewProxy_:GetExFilterSorterFunc())

	if (arg_30_0.type_ == HeroConst.HERO_DATA_TYPE.TRIAL or arg_30_0.type_ == HeroConst.HERO_DATA_TYPE.CUSTOM) and arg_30_0.params_.hid then
		local var_30_0 = arg_30_0.params_.hid

		if table.indexof(arg_30_0.tempHeroList_, var_30_0) then
			local var_30_1 = HeroStandardSystemCfg[var_30_0]

			arg_30_0.params_.hid = SkinCfg[var_30_1.hero_id].hero
		end
	end

	local var_30_2 = 1

	for iter_30_0, iter_30_1 in pairs(arg_30_0.pages_) do
		arg_30_0:CheckPageEnter(iter_30_0)
	end

	local var_30_3 = {}

	for iter_30_2, iter_30_3 in ipairs(arg_30_0.heroIdList_) do
		local var_30_4 = arg_30_0.heroViewProxy_:GetHeroData(iter_30_3).tempID or 0

		var_30_3[iter_30_2] = {
			id = iter_30_3,
			trialID = var_30_4,
			type = arg_30_0.type_,
			heroViewProxy = arg_30_0.heroViewProxy_
		}
	end

	arg_30_0.filterView_:SetHeroIdList(var_30_3)
	arg_30_0:RegistEventListener(HERO_DATA_MODIFY, handler(arg_30_0, arg_30_0.OnHeroUpdate))
	arg_30_0:RegistEventListener(HERO_PIECE_MODIFY, handler(arg_30_0, arg_30_0.OnHeroUpdate))
	arg_30_0:RegistEventListener(HERO_UNLOCK_SUCCESS, handler(arg_30_0, arg_30_0.OnHeroUnlock))
	arg_30_0:RegistEventListener(FAVORITE_HERO, handler(arg_30_0, arg_30_0.OnHeroFavorite))

	for iter_30_4 = 1, #arg_30_0.heroIdList_ do
		if arg_30_0.curHeroId_ == arg_30_0.heroIdList_[iter_30_4] then
			var_30_2 = iter_30_4

			break
		end
	end

	arg_30_0:SwitchToDetail()

	if arg_30_0.heroIdList_ and #arg_30_0.heroIdList_ <= 0 then
		arg_30_0.filterView_:RefreshSort(true)
		arg_30_0.filterView_:Reset()
	end

	arg_30_0.shortScrollHelper_:StartScroll(#arg_30_0.heroIdList_, var_30_2)
	arg_30_0:CheckLocked()

	arg_30_0.params_.isBack = false
end

function var_0_0.OnHeroFavorite(arg_31_0)
	arg_31_0.curScrollHelper_:Refresh()
end

function var_0_0.CheckLocked(arg_32_0)
	SetActive(arg_32_0.toggle5_.gameObject, not arg_32_0.heroViewProxy_.hideTransitionToggle)
	SetActive(arg_32_0.allHeroBtn_.gameObject, not arg_32_0.heroViewProxy_.hideFilterBtn)

	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.HERO_CHIP) then
		arg_32_0.chipToggleController_:SetSelectedState("true")
	else
		arg_32_0.chipToggleController_:SetSelectedState("false")
	end

	arg_32_0:ChangeAstrolabeIcon()
	arg_32_0.trasitionToggleController_:SetSelectedState(JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.TRANSITION) and not arg_32_0.heroViewProxy_.unlockToggle and "true" or "false")
end

function var_0_0.ChangeAstrolabeIcon(arg_33_0)
	local var_33_0 = JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.HERO_ASTROLABE) and not arg_33_0.heroViewProxy_.unlockToggle
	local var_33_1 = (HeroTools.IsSpHero(arg_33_0.curHeroId_) and "sp" or "") .. (var_33_0 and "true" or "false")

	arg_33_0.astroToggleController_:SetSelectedState(var_33_1)
end

function var_0_0.OnHeroUnlock(arg_34_0, arg_34_1)
	if arg_34_1 == arg_34_0.curHeroId_ then
		HeroTools.StopTalk()

		arg_34_0.curHeroInfo_ = arg_34_0.heroViewProxy_:GetHeroData(arg_34_0.curHeroInfo_.id)

		arg_34_0.filterView_:UpdateList()
		arg_34_0.curScrollHelper_:Refresh()

		arg_34_0.curPageIndex_ = 1

		arg_34_0:UpdateHeroView()
		arg_34_0:SwitchPage(arg_34_0.curPageIndex_)
	end
end

function var_0_0.OnServantLock(arg_35_0, arg_35_1, arg_35_2)
	arg_35_0.pages_[3]:OnServantLock(arg_35_1, arg_35_2)
end

function var_0_0.OnHeroSkillUpgrade(arg_36_0, arg_36_1, arg_36_2)
	if isSuccess(arg_36_1.result) and arg_36_2.hero_id == arg_36_0.curHeroId_ and arg_36_0.pages_[arg_36_0.pageIndexS_.skill] and arg_36_0.curPageIndex_ == arg_36_0.pageIndexS_.skill then
		arg_36_0.pages_[arg_36_0.pageIndexS_.skill]:OnHeroSkillUpgrade(arg_36_1, arg_36_2)
	end
end

function var_0_0.OnHeroStarUp(arg_37_0, arg_37_1, arg_37_2)
	if isSuccess(arg_37_1.result) and arg_37_2.id == arg_37_0.curHeroId_ and arg_37_0.pages_[arg_37_0.pageIndexS_.star] and arg_37_0.curPageIndex_ == arg_37_0.pageIndexS_.star then
		arg_37_0.pages_[arg_37_0.pageIndexS_.star]:OnHeroStarUp(arg_37_1, arg_37_2)
	end
end

function var_0_0.OnHeroUpdate(arg_38_0, arg_38_1)
	for iter_38_0, iter_38_1 in pairs(arg_38_0.shortScrollHelper_:GetItemList()) do
		if iter_38_1.heroId_ == arg_38_1 then
			iter_38_1:SetHeroData(arg_38_1, iter_38_1.heroDataType_)
		end
	end

	for iter_38_2, iter_38_3 in pairs(arg_38_0.completeScrollHelper_:GetItemList()) do
		if iter_38_3.heroId_ == arg_38_1 then
			iter_38_3:SetHeroData(arg_38_1, iter_38_3.heroDataType_)
		end
	end

	if arg_38_1 == arg_38_0.curHeroId_ then
		arg_38_0:UpdateHeroView()
	end
end

function var_0_0.CheckConditionByType(arg_39_0, arg_39_1)
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

function var_0_0.OnMainHomeViewTop(arg_40_0)
	arg_40_0.dirty_ = true
	_G.heroViewPageIndex_ = 1
end

function var_0_0.GetPopContainer(arg_41_0)
	return arg_41_0.pageContainerPop_
end

function var_0_0.OnExit(arg_42_0)
	if arg_42_0.type_ == HeroConst.HERO_DATA_TYPE.COOPERATION then
		arg_42_0.dirty_ = true
	end

	arg_42_0:RemoveAllEventListener()
	manager.windowBar:HideBar()

	if #arg_42_0.heroIdList_ <= 0 then
		HeroData:ResetSortValue()
		arg_42_0.filterView_:Reset()

		if arg_42_0.type_ == HeroConst.HERO_DATA_TYPE.DEFAULT then
			arg_42_0:InitConfig()
		end
	end

	if arg_42_0.pages_ then
		for iter_42_0, iter_42_1 in pairs(arg_42_0.pages_) do
			iter_42_1:OnExit()
		end
	end

	arg_42_0.filterView_:OnExit()
	manager.redPoint:unbindUIandKey(arg_42_0.toggle1_.transform)
	manager.redPoint:unbindUIandKey(arg_42_0.toggle3_.transform)
	manager.redPoint:unbindUIandKey(arg_42_0.toggle6_.transform)
	manager.redPoint:unbindUIandKey(arg_42_0.toggle5_.transform)
	manager.redPoint:unbindUIandKey(arg_42_0.toggle7_.transform)
	arg_42_0:RecordStay(arg_42_0.curPageIndex_)

	if arg_42_0.talkTimer_ then
		arg_42_0.talkTimer_:Stop()

		arg_42_0.talkTimer_ = nil
	end

	HeroTools.StopTalk()
	arg_42_0:ExitSendMgr(arg_42_0.curPageIndex_)
	manager.heroRaiseTrack:CancelAllAsyncLoadModelOp()
end

function var_0_0.Dispose(arg_43_0)
	arg_43_0.mainPageController_:RemoveAllListeners()
	arg_43_0:RemoveAllListeners()

	if arg_43_0.filterView_ then
		arg_43_0.filterView_:Dispose()

		arg_43_0.filterView_ = nil
	end

	if arg_43_0.shortScrollHelper_ then
		arg_43_0.shortScrollHelper_:Dispose()

		arg_43_0.shortScrollHelper_ = nil
	end

	if arg_43_0.completeScrollHelper_ then
		arg_43_0.completeScrollHelper_:Dispose()

		arg_43_0.completeScrollHelper_ = nil
	end

	if arg_43_0.pages_ then
		for iter_43_0, iter_43_1 in pairs(arg_43_0.pages_) do
			iter_43_1:Dispose()
		end

		arg_43_0.pages_ = nil
	end

	if arg_43_0.toggles_ then
		for iter_43_2, iter_43_3 in pairs(arg_43_0.toggles_) do
			iter_43_3.onValueChanged:RemoveAllListeners()
		end

		arg_43_0.toggles_ = nil
	end

	var_0_0.super.Dispose(arg_43_0)
end

function var_0_0.RecordStay(arg_44_0, arg_44_1)
	local var_44_0 = arg_44_0:GetStayTime()

	if var_44_0 == 0 then
		return
	end

	local var_44_1 = 0

	if arg_44_1 == arg_44_0.pageIndexS_.property then
		var_44_1 = 20101
	elseif arg_44_1 == arg_44_0.pageIndexS_.skill then
		var_44_1 = 20102
	elseif arg_44_1 == arg_44_0.pageIndexS_.weapon then
		var_44_1 = 20103
	elseif arg_44_1 == arg_44_0.pageIndexS_.equip then
		var_44_1 = 20104
	elseif arg_44_1 == arg_44_0.pageIndexS_.astrolabe then
		var_44_1 = 20105
	end

	OperationRecorder.RecordStayView("STAY_VIEW_HERO", var_44_0, arg_44_0.curHeroId_, var_44_1)
	arg_44_0:UpdateLastOpenTime()
end

function var_0_0.OnHeroSort(arg_45_0, arg_45_1, arg_45_2, arg_45_3, arg_45_4, arg_45_5)
	arg_45_0.filterView_:RefreshSort(arg_45_1, arg_45_2, arg_45_3, arg_45_4, arg_45_5)
end

function var_0_0.HandleNextJump(arg_46_0, arg_46_1)
	if arg_46_1[1] == 231 then
		for iter_46_0, iter_46_1 in ipairs(arg_46_0.heroIdList_) do
			local var_46_0 = HeroTools.GetHeroOntologyID(iter_46_1)

			if #HeroRecordCfg[var_46_0].plot_id > 0 then
				table.insert(arg_46_1, iter_46_1)
				arg_46_0:SelectHero(iter_46_1)
				JumpTools.JumpToPage2(arg_46_1)

				return
			end
		end
	else
		table.insert(arg_46_1, arg_46_0.curHeroId_)
		JumpTools.JumpToPage2(arg_46_1)

		return
	end
end

function var_0_0.EnterSendMgr(arg_47_0, arg_47_1)
	arg_47_1 = arg_47_1 or 1

	if arg_47_0.uiTime_ then
		local var_47_0 = arg_47_0.uiTime_[arg_47_1]

		manager.uiTime:OnEnterRoute(var_47_0)
	end
end

function var_0_0.ExitSendMgr(arg_48_0, arg_48_1)
	if arg_48_1 and arg_48_0.uiTime_ then
		local var_48_0 = arg_48_0.uiTime_[arg_48_1]

		manager.uiTime:OnExitRoute(var_48_0)
	end
end

function var_0_0.CheckWeakGuide(arg_49_0)
	local var_49_0, var_49_1 = GuideTool.CheckWeakGuide(arg_49_0.routeName_)

	if var_49_0 and var_49_1.guide_component[2] == arg_49_0.curPageIndex_ then
		arg_49_0:RealCheckWeakGuide()
	end
end

function var_0_0.GetCurHeroID(arg_50_0)
	return arg_50_0.curHeroId_
end

return var_0_0
