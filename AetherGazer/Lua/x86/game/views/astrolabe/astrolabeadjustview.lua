local var_0_0 = class("AstrolabeAdjustView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero_god/HeroGodDetailUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddListeners()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.stateController_ = ControllerUtil.GetController(arg_5_0.transform_, "state")
	arg_5_0.infoSGo_ = {}
	arg_5_0.astrolabeMessageView_ = AstrolabeInfoView.New(arg_5_0, arg_5_0.messageGo_)
	arg_5_0.astrolabeUnlockView_ = AstrolabeUnlockView.New(arg_5_0, arg_5_0.unlockinfoGo_)
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.loadBtn_, nil, "ClickBtn")
	arg_6_0:AddBtnListener(arg_6_0.equipallBtn_, nil, "ClickBtn")
	arg_6_0:AddBtnListener(arg_6_0.canequipBtn_, nil, "ClickBtn")
	arg_6_0:AddBtnListener(arg_6_0.unloadBtn_, nil, "ClickBtn")
	arg_6_0:AddBtnListener(arg_6_0.hasequipedBtn_, nil, "ClickBtn")
	arg_6_0:AddBtnListener(arg_6_0.unequipBtn_, nil, "ClickBtn")
	arg_6_0:AddBtnListener(arg_6_0.unlock2Btn_, nil, "ClickBtn")
	arg_6_0:AddBtnListener(arg_6_0.spcanequipBtn_, nil, "ClickBtn")
	arg_6_0:AddBtnListener(arg_6_0.btn_twoBtn_, nil, function()
		arg_6_0.heroProxy:AstrolabeUnloadAll(arg_6_0.params_.heroId)
	end)
end

function var_0_0.ClickEquipallBtn(arg_8_0)
	return
end

function var_0_0.ClickHasEquipedBtn(arg_9_0)
	return
end

function var_0_0.ClickBtn(arg_10_0)
	local var_10_0 = arg_10_0.lastSelectItem_:GetItemInfo()
	local var_10_1 = HeroAstrolabeCfg[var_10_0.id]
	local var_10_2 = arg_10_0.lastSelectItem_.nodeState

	if var_10_2 == AstrolabeConst.NODE_STATE.LOCK then
		if var_10_1.unlock[1] and not checkGold(var_10_1.unlock[1][2], true) then
			return
		end

		ShowTips("ERROR_ASTROLABE_UNLOCK_CONDITION_NOT_MATCH")
	elseif var_10_2 == AstrolabeConst.NODE_STATE.CANLOCK then
		AstrolabeAction.AstrolabeUnlock(var_10_0.heroId, var_10_0.id)
	elseif var_10_2 == AstrolabeConst.NODE_STATE.UNLOCK then
		local var_10_3 = arg_10_0.isSp and AstrolabeConst.SPASTROLABE_MAX_NUM or AstrolabeConst.ASTROLABE_MAX_NUM

		if var_10_1.pos == 3 and not arg_10_0.isSp then
			arg_10_0.heroProxy:AstrolabeEquipAll(var_10_0.heroId, var_10_1.hero_astrolabe_suit_id)
		else
			if var_10_3 <= arg_10_0.equipNum_ then
				ShowTips("TIP_ASTROLABE_NUM_MAX")

				return
			end

			if not arg_10_0.heroProxy:GetLastIsEquiped(var_10_0.id, var_10_0.heroId) then
				local var_10_4 = HeroAstrolabeCfg[var_10_0.id].pre_astrolabe_id
				local var_10_5 = HeroAstrolabeCfg[var_10_4]

				ShowTips(string.format(GetTips("TIP_ASTROLABE_FRONT"), GetI18NText(var_10_5.suit_name), GetI18NText(var_10_5.name)))

				return
			end

			arg_10_0.heroProxy:AstrolabeEquip(var_10_0.heroId, var_10_0.id)
		end
	elseif var_10_2 == AstrolabeConst.NODE_STATE.EQUIPED then
		if arg_10_0.heroProxy:GetNextIsEquiped(var_10_0.id, var_10_0.heroId) then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("TIP_ASTROLABE_UNINSTALL"),
				OkCallback = function()
					arg_10_0.heroProxy:AstrolabeUnload(var_10_0.heroId, var_10_0.id)
				end
			})
		else
			arg_10_0.heroProxy:AstrolabeUnload(var_10_0.heroId, var_10_0.id)
		end
	end
end

function var_0_0.SelectItem(arg_12_0, arg_12_1)
	if arg_12_0.lastSelectItem_ then
		arg_12_0.lastSelectItem_:ShowSelect(false)
	end

	local var_12_0 = arg_12_1:GetItemInfo()

	arg_12_1:ShowSelect(true)
	arg_12_0.astrolabeMessageView_:RefreshUI(var_12_0, arg_12_0.extra_)

	arg_12_0.lastSelectItem_ = arg_12_1

	arg_12_0:RefreshState(var_12_0)

	if arg_12_0.panelAni_ then
		arg_12_0.panelAni_:Play("Fx_Common_right_cx", 0, 0)
	end
end

function var_0_0.RefreshUI(arg_13_0)
	arg_13_0.heroInfo_ = arg_13_0.heroProxy:GetHeroData(arg_13_0.params_.heroId)
	arg_13_0.isSp = HeroTools.IsSpHero(arg_13_0.params_.heroId)

	SetActive(arg_13_0.resetBtnGo_, arg_13_0:Adjustable())
	arg_13_0:RefreshAstrolabeInfo()
end

function var_0_0.RefreshAstrolabeInfo(arg_14_0)
	if arg_14_0.heroInfo_ then
		local var_14_0 = arg_14_0.isSp or arg_14_0.heroProxy and arg_14_0.heroProxy.isHideAstrolabeReset

		SetActive(arg_14_0.btn_twoBtn_.gameObject, not var_14_0)
		SetActive(arg_14_0.numText_.gameObject, not var_14_0)

		arg_14_0.equipNum_ = #arg_14_0.heroInfo_.using_astrolabe

		if not arg_14_0.isSp then
			arg_14_0.numText_.text = string.format(GetTips("ASTROLABE_NUM_MAX"), arg_14_0.equipNum_, AstrolabeConst.ASTROLABE_MAX_NUM)
		end

		if arg_14_0.heroProxy:GetViewDataType() == HeroConst.HERO_DATA_TYPE.PREVIEW then
			arg_14_0.titleText_.text = GetTips("ASTROLABE_TITLE_PREVIEW")
		else
			arg_14_0.titleText_.text = GetTips("ASTROLABE_TITLE_COMMON")
		end

		arg_14_0:RefreshAstrolabeView()
	end
end

function var_0_0.RefreshAstrolabeView(arg_15_0)
	if arg_15_0.heroInfo_ and arg_15_0.astrolabeInfoView_ then
		if arg_15_0.params_ and arg_15_0.params_.isEnter then
			arg_15_0.astrolabeInfoView_:LoadAstrolabeByPath(AstrolabeTools.GetAstrolabePrafabName(arg_15_0.heroInfo_.id), arg_15_0.heroInfo_.id)
			manager.heroRaiseTrack:SetAstrolableAtive(true)
			arg_15_0.astrolabeInfoView_:PlayAni("TX_GodHood_02", 0, 1)

			arg_15_0.params_.isEnter = false
		end

		arg_15_0.astrolabeInfoView_:RefreshAnimationState(AstrolabeConst.AnimationState.AdjustView)
		arg_15_0.astrolabeInfoView_:RegistCallBack(handler(arg_15_0, arg_15_0.SelectItem))

		local var_15_0 = arg_15_0:GetAstrolabeInfo(arg_15_0.heroInfo_.id)

		arg_15_0.astrolabeInfoView_:SetProxy(arg_15_0.heroProxy)
		arg_15_0.astrolabeInfoView_:SetNodeNameIsHide(false)
		arg_15_0.astrolabeInfoView_:RefreshData(arg_15_0.heroInfo_, var_15_0)
	end
end

function var_0_0.GetHeroAstrolabeInfoView(arg_16_0)
	return HeroAstrolabeInfoView
end

function var_0_0.GetAstrolabeInfo(arg_17_0, arg_17_1)
	if arg_17_0.heroProxy then
		return arg_17_0.heroProxy:GetHeroAstrolabeS(arg_17_1, arg_17_0.viewDataType)
	end

	return {}
end

function var_0_0.CanLock(arg_18_0)
	if arg_18_0.viewDataType == HeroConst.HERO_DATA_TYPE.POLYHEDRON then
		return false
	end

	return true
end

function var_0_0.RefreshState(arg_19_0, arg_19_1)
	if not arg_19_0:Adjustable() then
		arg_19_0.stateController_:SetSelectedState("none")
		arg_19_0:ChangeBar(false)

		return
	end

	local var_19_0 = HeroAstrolabeCfg[arg_19_1.id]

	if arg_19_1.isUnlock or arg_19_1.isEquiped then
		if arg_19_1.isEquiped then
			if arg_19_0.isSp then
				if var_19_0.astrolabe_type == 2 then
					arg_19_0.stateController_:SetSelectedState("sphasEquiped")
				else
					arg_19_0.stateController_:SetSelectedState("spEquiped")
				end
			else
				arg_19_0.stateController_:SetSelectedState("unEquip")
			end
		elseif var_19_0.pos == 3 and not arg_19_0.isSp then
			arg_19_0.stateController_:SetSelectedState("equipAll")
		elseif var_19_0.astrolabe_type == 2 then
			arg_19_0.stateController_:SetSelectedState("spcanEquip")
		else
			arg_19_0.stateController_:SetSelectedState("canEquip")
		end

		arg_19_0:ChangeBar(false)
	else
		if arg_19_0.isSp then
			arg_19_0.stateController_:SetSelectedState("splock")
		elseif arg_19_0:Adjustable() then
			if arg_19_1.isCanLock then
				arg_19_0.stateController_:SetSelectedState("lock")
			else
				arg_19_0.stateController_:SetSelectedState("lock2")
			end

			arg_19_0.astrolabeUnlockView_:RefreshUI(arg_19_1)
		else
			arg_19_0.stateController_:SetSelectedState("none")
		end

		arg_19_0.astrolabeUnlockView_:RefreshUI(arg_19_1)
		arg_19_0:ChangeBar(true)
	end
end

function var_0_0.PlayHeroTalk(arg_20_0, arg_20_1)
	if arg_20_0.isTalkCD_ then
		return
	end

	HeroTools.PlayTalk(arg_20_1, "echo")

	arg_20_0.isTalkCD_ = true
	arg_20_0.talkCDTimer_ = Timer.New(function()
		arg_20_0.isTalkCD_ = false
	end, 10, 1)

	arg_20_0.talkCDTimer_:Start()
end

function var_0_0.OnAstrolabeUnlock(arg_22_0, arg_22_1, arg_22_2)
	if isSuccess(arg_22_1.result) then
		arg_22_0:RefreshUI()
		arg_22_0.astrolabeMessageView_:RefreshUI(arg_22_0.lastSelectItem_:GetItemInfo())
		arg_22_0:RefreshState(arg_22_0.lastSelectItem_:GetItemInfo())
		arg_22_0.astrolabeUnlockView_:OnAstrolabeUnlock(arg_22_1, arg_22_2)

		if arg_22_0.astrolabeInfoView_ then
			arg_22_0.astrolabeInfoView_:RefreshRedPoint()
		end
	else
		ShowTips(arg_22_1.result)
	end
end

function var_0_0.OnAstrolabeEquip(arg_23_0, arg_23_1, arg_23_2)
	if isSuccess(arg_23_1.result) then
		if arg_23_2.astrolabe_id and HeroAstrolabeCfg[arg_23_2.astrolabe_id] and HeroAstrolabeCfg[arg_23_2.astrolabe_id].astrolabe_type == 2 then
			ShowTips("SP_ASTROLABE_BIND")
		else
			ShowTips("ASTROLABE_BIND")
		end

		arg_23_0:RefreshUI()
		arg_23_0.astrolabeMessageView_:RefreshUI(arg_23_0.lastSelectItem_:GetItemInfo())
		arg_23_0:RefreshState(arg_23_0.lastSelectItem_:GetItemInfo())
		arg_23_0:PlayHeroTalk(arg_23_0.heroInfo_.id)

		if arg_23_0.astrolabeInfoView_ then
			arg_23_0.astrolabeInfoView_:RefreshRedPoint()
		end
	else
		ShowTips(arg_23_1.result)
	end
end

function var_0_0.OnAstrolabeUnload(arg_24_0, arg_24_1, arg_24_2)
	if isSuccess(arg_24_1.result) then
		if arg_24_2.astrolabe_id then
			ShowTips("ASTROLABE_UNBIND")
		else
			ShowTips("ASTROLABE_RESET")
		end

		arg_24_0:RefreshUI()
		arg_24_0.astrolabeMessageView_:RefreshUI(arg_24_0.lastSelectItem_:GetItemInfo())
		arg_24_0:RefreshState(arg_24_0.lastSelectItem_:GetItemInfo())

		if arg_24_0.astrolabeInfoView_ then
			arg_24_0.astrolabeInfoView_:RefreshRedPoint()
		end
	else
		ShowTips(arg_24_1.result)
	end
end

function var_0_0.ChangeBar(arg_25_0, arg_25_1)
	if arg_25_1 then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			CurrencyConst.CURRENCY_TYPE_GOLD
		})
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	end
end

function var_0_0.OnBehind(arg_26_0)
	if arg_26_0.astrolabeInfoView_ then
		arg_26_0.astrolabeInfoView_:SetAdjustHide(true)
	end
end

function var_0_0.OnTop(arg_27_0)
	if arg_27_0.astrolabeInfoView_ then
		arg_27_0.astrolabeInfoView_:CheckadjustHide()
	end

	if arg_27_0.lastSelectItem_ then
		if arg_27_0.heroInfo_ and arg_27_0.astrolabeInfoView_ then
			local var_27_0 = arg_27_0:GetAstrolabeInfo(arg_27_0.heroInfo_.id)

			arg_27_0.astrolabeInfoView_:RefreshData(arg_27_0.heroInfo_, var_27_0)
		end

		local var_27_1 = arg_27_0.lastSelectItem_:GetItemInfo()

		if var_27_1 ~= nil and not var_27_1.isUnlock then
			arg_27_0.astrolabeUnlockView_:RefreshCost()
			arg_27_0:RefreshState(var_27_1)
		end
	end

	if arg_27_0.astrolabeInfoView_ then
		arg_27_0.astrolabeInfoView_:CheckadjustHide()
		arg_27_0.astrolabeInfoView_:RefreshRedPoint()
	end
end

function var_0_0.OnEnter(arg_28_0)
	arg_28_0.heroProxy = arg_28_0.params_.heroProxy or HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
	arg_28_0.viewDataType = arg_28_0.heroProxy.viewDataType or HeroConst.HERO_DATA_TYPE.DEFAULT
	arg_28_0.astrolabeInfoView_ = manager.heroRaiseTrack.astrolableController

	if arg_28_0.panelAni_ then
		arg_28_0.panelAni_:Play("Fx_Common_right_cx", 0, 0)
	end

	arg_28_0:ShowDefaultBar()
	arg_28_0:RefreshUI()

	if arg_28_0.astrolabeUnlockView_ then
		arg_28_0.astrolabeUnlockView_:SetProxy(arg_28_0.heroProxy)
	end

	if arg_28_0.astrolabeMessageView_ then
		arg_28_0.astrolabeMessageView_:SetProxy(arg_28_0.heroProxy)
	end

	local var_28_0 = arg_28_0.params_.selectPos

	if var_28_0 and var_28_0[1] ~= 0 then
		arg_28_0:SelectItem(arg_28_0.astrolabeInfoView_:GetItem(var_28_0[1], var_28_0[2]))
	else
		arg_28_0:SelectItem(arg_28_0.astrolabeInfoView_:GetFirstSelectItem())
	end
end

function var_0_0.CameraEnter(arg_29_0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		5,
		1
	}, false)
end

function var_0_0.OnExit(arg_30_0)
	manager.windowBar:HideBar()

	if arg_30_0.lastSelectItem_ then
		arg_30_0.lastSelectItem_:ShowSelect(false)

		arg_30_0.lastSelectItem_ = nil
	end

	if arg_30_0.astrolabeUnlockView_ then
		arg_30_0.astrolabeUnlockView_:OnExit()
	end

	if arg_30_0.talkCDTimer_ then
		arg_30_0.talkCDTimer_:Stop()

		arg_30_0.talkCDTimer_ = nil
	end

	arg_30_0.isTalkCD_ = nil
end

function var_0_0.Adjustable(arg_31_0)
	if arg_31_0.viewDataType == HeroConst.HERO_DATA_TYPE.PREVIEW then
		return false
	end

	if arg_31_0.viewDataType == HeroConst.HERO_DATA_TYPE.FOREIGN then
		return false
	end

	if arg_31_0.viewDataType == HeroConst.HERO_DATA_TYPE.ADVANCETEST then
		return false
	end

	return true
end

function var_0_0.Dispose(arg_32_0)
	var_0_0.super.Dispose(arg_32_0)

	if arg_32_0.astrolabeMessageView_ then
		arg_32_0.astrolabeMessageView_:Dispose()

		arg_32_0.astrolabeMessageView_ = nil
	end

	if arg_32_0.astrolabeUnlockView_ then
		arg_32_0.astrolabeUnlockView_:Dispose()

		arg_32_0.astrolabeUnlockView_ = nil
	end
end

return var_0_0
