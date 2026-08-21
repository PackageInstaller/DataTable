local var_0_0 = class("WeaponView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero_key/HeroKeyDetailsUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.buildContext(arg_3_0)
	arg_3_0.context = {
		controllerWrap = {
			comps = arg_3_0.gameObject_:GetComponent("ControllerExCollection"),
			state = {
				selectDetail = {
					False = "false",
					name = "selectDetail",
					True = "true"
				},
				selectUp = {
					False = "false",
					name = "selectUp",
					True = "true"
				}
			}
		},
		tabGroup = {
			{
				btnState = "selectDetail",
				OnEnter = handler(arg_3_0, arg_3_0.SwitchToDetailTab)
			},
			{
				btnState = "selectUp",
				OnEnter = handler(arg_3_0, arg_3_0.SwitchToLvUpTab)
			}
		},
		data = {
			heroId = 0,
			curPageIdx = 0,
			proxyTag = 0,
			weaponInfo = {}
		},
		syntheiseHandle = handler(arg_3_0, arg_3_0.OnSynthesiseSuccess)
	}
	arg_3_0.pageView = {
		detailView = {
			viewPath = "game.views.weapon.WeaponSubView.WeaponDetailView",
			name = "detailView",
			uiRootPath = "Widget/System/Hero_key/HeroKeyMessageUI",
			pageIdx = 1,
			stateName = "Detail"
		},
		lvupView = {
			viewPath = "game.views.weapon.WeaponSubView.WeaponLvupView",
			name = "lvupView",
			uiRootPath = "Widget/System/Hero_key/HeroKeyLevelUpUI",
			pageIdx = 2,
			stateName = "LvUp",
			barCurrency = {
				CurrencyConst.CURRENCY_TYPE_GOLD
			}
		},
		breakView = {
			viewPath = "game.views.weapon.WeaponSubView.WeaponBreakSubView",
			name = "breakView",
			uiRootPath = "Widget/System/Hero_key/HeroKeyBreakUI",
			pageIdx = 3,
			stateName = "Break",
			barCurrency = {
				CurrencyConst.CURRENCY_TYPE_GOLD
			}
		}
	}
end

function var_0_0.InitContext(arg_4_0)
	local var_4_0 = arg_4_0.params_.type or HeroConst.HERO_DATA_TYPE.DEFAULT

	arg_4_0.data = {
		heroId = 0,
		curPageIdx = 0,
		proxyTag = 0,
		curTabIdx = -1,
		weaponInfo = {},
		type = var_4_0,
		dataPorxy = HeroViewDataProxy.New(var_4_0)
	}
end

function var_0_0.Init(arg_5_0)
	arg_5_0:BindCfgUI()
	arg_5_0:buildContext()
	arg_5_0:AddUIListener()
	arg_5_0:AddEventListeners()
end

function var_0_0.OnEnter(arg_6_0)
	manager.notify:RegistListener(ON_SYNTHESISE_USE_ITEM_SUCCESS, arg_6_0.context.syntheiseHandle)

	for iter_6_0, iter_6_1 in pairs(arg_6_0.pageView) do
		if iter_6_1.view then
			iter_6_1.view:OnEnter()
		end
	end

	local var_6_0 = 1

	if arg_6_0.params_.state and arg_6_0.params_.state == "strength" then
		var_6_0 = 2
	end

	arg_6_0:InitContext()
	arg_6_0:SetHeroId(arg_6_0.params_.HeroID)
	arg_6_0:UpdateWeaponInfo()
	arg_6_0:ResetWeaponView()
	arg_6_0:BuildTabDesc()
	arg_6_0:SwitchToTab(var_6_0, true)
end

function var_0_0.CameraEnter(arg_7_0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		HeroRaiseTrackConst.HeroRaiseType.weapon,
		1,
		HeroRaiseTrackConst.HeroServantType.weapon
	}, arg_7_0.displayGo_)
end

function var_0_0.OnExit(arg_8_0)
	manager.notify:RemoveListener(ON_SYNTHESISE_USE_ITEM_SUCCESS, arg_8_0.context.syntheiseHandle)

	for iter_8_0, iter_8_1 in pairs(arg_8_0.pageView) do
		if iter_8_1.view then
			iter_8_1.view:OnExit()
		end
	end

	manager.windowBar:HideBar()
end

function var_0_0.DisposeContext(arg_9_0)
	arg_9_0.context.controllerWrap.comps = nil

	for iter_9_0, iter_9_1 in pairs(arg_9_0.pageView) do
		iter_9_1.viewObj = nil

		if iter_9_1.view then
			iter_9_1.view:Dispose()

			iter_9_1.view = nil
		end
	end
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0:DisposeContext()
	arg_10_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_10_0)
end

function var_0_0.AddEventListeners(arg_11_0)
	arg_11_0:RegistEventListener(CURRENCY_UPDATE, function(arg_12_0)
		if arg_12_0 == CurrencyConst.CURRENCY_TYPE_GOLD then
			arg_11_0:OnGoldChange()
		end
	end)
	arg_11_0:RegistEventListener(WEAPON_BREAK, function()
		arg_11_0:OnWeaponBreak()
		arg_11_0:ChangeWindowBar()
	end)
	arg_11_0:RegistEventListener(WEAPON_STR, function()
		arg_11_0:OnWeaponLvUp()
		arg_11_0:ChangeWindowBar()
	end)
	arg_11_0:RegistEventListener(WEAPON_QUICK, function(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
		arg_11_0:OnWeaponQuick(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
		arg_11_0:ChangeWindowBar()
	end)
end

function var_0_0.AddUIListener(arg_16_0)
	for iter_16_0 = 1, 2 do
		arg_16_0:AddToggleListener(arg_16_0[string.format("tabToggle%d_", iter_16_0)], function(arg_17_0)
			if arg_16_0.data.curTabIdx == iter_16_0 then
				return
			end

			arg_16_0:OnTabSwitch(iter_16_0, arg_17_0)
		end)
	end
end

function var_0_0.OnTabSwitch(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_2 then
		arg_18_0:SwitchToTab(arg_18_1, true)
		OperationRecorder.Record("hero", string.format("weaponPage2%d", arg_18_1))
	end
end

function var_0_0.SwitchToTab(arg_19_0, arg_19_1, arg_19_2)
	arg_19_0.data.curTabIdx = arg_19_1

	local var_19_0 = arg_19_0.context.tabGroup

	for iter_19_0, iter_19_1 in pairs(var_19_0) do
		if iter_19_0 == arg_19_1 then
			arg_19_0:SwitchControllerState(var_19_0[iter_19_0].btnState, "true")

			if arg_19_2 then
				var_19_0[iter_19_0].OnEnter(true)
			end
		else
			arg_19_0:SwitchControllerState(var_19_0[iter_19_0].btnState, "false")
		end
	end
end

function var_0_0.OnWeaponBreak(arg_20_0)
	arg_20_0:ShowBreakTips()
	arg_20_0:UpdateWeaponInfo()
	arg_20_0:SwitchToTab(2, false)
	arg_20_0:SwitchToView(arg_20_0.pageView.lvupView, true)
	arg_20_0:BuildTabDesc()
end

function var_0_0.OnWeaponLvUp(arg_21_0)
	arg_21_0:UpdateWeaponInfo()

	local var_21_0 = arg_21_0.data.weaponInfo
	local var_21_1 = var_21_0.breakthrough
	local var_21_2 = GameSetting.weapon_exp_limit.value[var_21_1 + 1]

	if var_21_0.level == HeroConst.WEAPON_LV_MAX then
		arg_21_0:SwitchToTab(1, true)
	elseif var_21_0.level == var_21_2 then
		arg_21_0:SwitchToTab(2, false)
		arg_21_0:SwitchToView(arg_21_0.pageView.breakView, true)
	end

	arg_21_0:BuildTabDesc()
end

function var_0_0.OnWeaponQuick(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	if arg_22_2.breakthrough_times > 0 then
		arg_22_0:ShowQuickBreakTips(arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	else
		arg_22_0:OpenLvUpPop(arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	end

	arg_22_0:UpdateWeaponInfo()

	local var_22_0 = arg_22_0.data.weaponInfo
	local var_22_1 = var_22_0.breakthrough
	local var_22_2 = GameSetting.weapon_exp_limit.value[var_22_1 + 1]

	if var_22_0.level == HeroConst.WEAPON_LV_MAX then
		arg_22_0:SwitchToTab(1, true)
	elseif var_22_0.level == var_22_2 then
		arg_22_0:SwitchToTab(2, false)
		arg_22_0:SwitchToView(arg_22_0.pageView.breakView, true)
	else
		arg_22_0:SwitchToTab(2, false)
		arg_22_0:SwitchToView(arg_22_0.pageView.lvupView, true)
	end

	arg_22_0:BuildTabDesc()
end

function var_0_0.ShowQuickBreakTips(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	local var_23_0 = arg_23_4
	local var_23_1 = arg_23_2.target_level
	local var_23_2 = arg_23_0.data.heroId
	local var_23_3 = arg_23_3 + arg_23_2.breakthrough_times

	JumpTools.OpenPageByJump("weaponOneKeyStr", {
		isBreak = true,
		oriLv = var_23_0,
		afterLv = arg_23_2.target_level,
		heroID = var_23_2,
		beforeBreak = arg_23_3,
		afterBreak = var_23_3,
		beforeLevel = arg_23_4,
		afterLevel = arg_23_2.target_level,
		callback = function()
			local var_24_0 = arg_23_1.mat_list

			getReward(formatRewardCfgList(var_24_0))
		end
	})
end

function var_0_0.OpenLvUpPop(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	local var_25_0 = arg_25_4
	local var_25_1 = arg_25_2.target_level
	local var_25_2 = arg_25_3 + arg_25_2.breakthrough_times

	JumpTools.OpenPageByJump("weaponOneKeyStr", {
		isBreak = false,
		oriLv = var_25_0,
		afterLv = arg_25_2.target_level,
		beforeBreak = arg_25_3,
		afterBreak = var_25_2,
		callback = function()
			local var_26_0 = arg_25_1.mat_list

			getReward(formatRewardCfgList(var_26_0))
		end
	})
end

function var_0_0.ShowBreakTips(arg_27_0)
	local var_27_0 = arg_27_0.data.weaponInfo
	local var_27_1 = arg_27_0.data.heroId

	JumpTools.OpenPageByJump("weaponBreak", {
		heroID = var_27_1,
		breakthrough = var_27_0.breakthrough
	})
end

function var_0_0.OnSynthesiseSuccess(arg_28_0)
	arg_28_0:OnGoldChange()
end

function var_0_0.SwitchControllerState(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = arg_29_0.context.controllerWrap.comps:GetController(arg_29_1)

	if var_29_0 then
		var_29_0:SetSelectedState(arg_29_2)
	end
end

function var_0_0.ResetWeaponView(arg_30_0)
	local var_30_0 = arg_30_0:GetHeroId()

	if var_30_0 and var_30_0 ~= 0 then
		manager.heroRaiseTrack:SetModelState(HeroTools.HeroUsingSkinInfo(var_30_0).id)
	end
end

function var_0_0.BuildTabDesc(arg_31_0)
	if arg_31_0:CheckWeaponCanBreakUp() then
		arg_31_0.tab2Txt_.text = GetTips("TIP_BREAK")
	else
		arg_31_0.tab2Txt_.text = GetTips("TIP_STRENGTH")
	end
end

function var_0_0.OnGoldChange(arg_32_0)
	if arg_32_0.data.curPageIdx == arg_32_0.pageView.lvupView.pageIdx then
		arg_32_0.pageView.lvupView.view:OnGoldChange()
	elseif arg_32_0.data.curPageIdx == arg_32_0.pageView.breakView.pageIdx then
		arg_32_0.pageView.breakView.view:OnGoldChange()
	end
end

function var_0_0.SwitchToDetailTab(arg_33_0, arg_33_1)
	arg_33_0:SwitchToView(arg_33_0.pageView.detailView, arg_33_1)
end

function var_0_0.SwitchToLvUpTab(arg_34_0, arg_34_1)
	if arg_34_0:CheckWeaponCanBreakUp() then
		arg_34_0:SwitchToView(arg_34_0.pageView.breakView, arg_34_1)
	else
		arg_34_0:SwitchToView(arg_34_0.pageView.lvupView, arg_34_1)
	end
end

function var_0_0.IsMeetShowBar(arg_35_0, arg_35_1)
	if not arg_35_1 or not arg_35_1.barCurrency then
		return false
	end

	if arg_35_1.pageIdx == 2 then
		local var_35_0 = arg_35_0:GetWeaponInfo()

		if var_35_0 then
			return var_35_0.level ~= HeroConst.WEAPON_LV_MAX
		else
			return false
		end
	end

	return true
end

function var_0_0.OnTop(arg_36_0)
	arg_36_0:ChangeWindowBar()
end

function var_0_0.ChangeWindowBar(arg_37_0, arg_37_1)
	if not arg_37_1 then
		for iter_37_0, iter_37_1 in pairs(arg_37_0.pageView) do
			if iter_37_1.view and iter_37_1.pageIdx == arg_37_0.data.curPageIdx then
				arg_37_1 = iter_37_1

				break
			end
		end
	end

	local var_37_0 = {
		BACK_BAR,
		HOME_BAR
	}

	if arg_37_0:IsMeetShowBar(arg_37_1) then
		for iter_37_2, iter_37_3 in pairs(arg_37_1.barCurrency) do
			table.insert(var_37_0, iter_37_3)
		end

		manager.windowBar:SwitchBar(var_37_0)

		for iter_37_4, iter_37_5 in pairs(arg_37_1.barCurrency) do
			manager.windowBar:SetBarCanAdd(iter_37_5, true)
		end
	else
		manager.windowBar:SwitchBar(var_37_0)
	end
end

function var_0_0.SwitchToView(arg_38_0, arg_38_1, arg_38_2)
	if arg_38_1 then
		local var_38_0 = arg_38_0.data.curPageIdx

		arg_38_0:ChangeWindowBar(arg_38_1)

		if var_38_0 ~= arg_38_1.pageIdx then
			arg_38_0.data.curPageIdx = arg_38_1.pageIdx

			arg_38_0:EnterViewOrInst(arg_38_1, true)
			arg_38_0:RefreshPageView(arg_38_1.view)
		elseif arg_38_2 then
			arg_38_0.data.curPageIdx = arg_38_1.pageIdx

			arg_38_0:EnterViewOrInst(arg_38_1, false)
			arg_38_0:RefreshPageView(arg_38_1.view)
		end
	end
end

function var_0_0.RefreshPageView(arg_39_0, arg_39_1)
	arg_39_1:ShowWeaponInfo(arg_39_0:GetHeroId(), arg_39_0:GetWeaponInfo(), arg_39_0.data.type)
end

function var_0_0.EnterViewOrInst(arg_40_0, arg_40_1, arg_40_2)
	if not arg_40_1.view then
		local var_40_0 = Asset.Load(arg_40_1.uiRootPath)

		arg_40_1.viewObj = Object.Instantiate(var_40_0, arg_40_0.pageContainer_)
		arg_40_1.view = import(arg_40_1.viewPath).New(arg_40_1.viewObj)

		arg_40_1.view:OnEnter()
	end

	if arg_40_2 then
		for iter_40_0, iter_40_1 in pairs(arg_40_0.pageView) do
			if iter_40_1.view then
				if iter_40_1.pageIdx ~= arg_40_0.data.curPageIdx then
					iter_40_1.viewObj:SetActive(false)
				else
					iter_40_1.viewObj:SetActive(true)
				end
			end
		end
	else
		arg_40_1.viewObj:SetActive(true)
	end
end

function var_0_0.UpdateWeaponInfo(arg_41_0)
	local var_41_0 = arg_41_0:GetHeroId()

	if var_41_0 and var_41_0 ~= 0 then
		local var_41_1 = deepClone(arg_41_0.data.dataPorxy:GetHeroWeaponInfo(var_41_0))

		arg_41_0.data.weaponInfo = var_41_1
	end
end

function var_0_0.GetWeaponInfo(arg_42_0)
	return arg_42_0.data.weaponInfo
end

function var_0_0.SetHeroId(arg_43_0, arg_43_1)
	arg_43_0.data.heroId = arg_43_1
end

function var_0_0.GetHeroId(arg_44_0)
	return arg_44_0.data.heroId
end

function var_0_0.GetControllerState(arg_45_0)
	return arg_45_0.context.controllerWrap.state
end

function var_0_0.CheckWeaponCanBreakUp(arg_46_0)
	local var_46_0 = arg_46_0:GetWeaponInfo()

	if var_46_0 then
		if GameSetting.weapon_exp_limit.value[var_46_0.breakthrough + 1] == var_46_0.level and var_46_0.level ~= HeroConst.WEAPON_LV_MAX then
			return true
		end
	else
		return false
	end

	return false
end

return var_0_0
