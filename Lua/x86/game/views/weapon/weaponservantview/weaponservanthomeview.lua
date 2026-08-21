local var_0_0 = class("WeaponServantHomeView", ReduxView)

function var_0_0.CameraEnter(arg_1_0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		HeroRaiseTrackConst.HeroRaiseType.weapon,
		2,
		HeroRaiseTrackConst.HeroServantType.servant
	})
	manager.heroRaiseTrack:PlayServantAnim("Fade")
end

function var_0_0.UIName(arg_2_0)
	return "Widget/System/Hero_servant/HeroServantUI"
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiMain.transform
end

function var_0_0.BuildContext(arg_4_0)
	arg_4_0.controller = {
		comps = arg_4_0.gameObject_:GetComponent("ControllerExCollection"),
		state = {
			selectTab = {
				name = "selectTab",
				hold = "hold",
				callName = "callName"
			},
			inFullScreen = {
				False = "false",
				name = "inFullScreen",
				True = "true"
			},
			avatarShow = {
				False = "false",
				name = "avatarShow",
				True = "true"
			},
			emptyView = {
				False = "false",
				name = "emptyView",
				True = "true"
			},
			customPage = {
				Off = "off",
				name = "customPage",
				On = "on"
			}
		}
	}
	arg_4_0.singleton = {
		viewDetail = WeaponServantMainDetailModule.New(arg_4_0.mainDetailsObj_),
		listView = {
			viewHold = {
				viewModulePath = "game.views.weapon.WeaponServantView.ServantHoldListViewModule",
				detailBtnStyle = 1,
				uiRootPath = "Widget/System/Hero_servant/Module/HoldListViewModule",
				pageIdx = 1,
				detailNoHeroBtnStyle = 3,
				onServantItemClick = function(arg_5_0)
					arg_4_0:onHoldItemClick(arg_5_0)
				end,
				OnRefresh = function()
					arg_4_0:OnHoldBtnClick()
				end
			},
			viewCallName = {
				viewModulePath = "game.views.weapon.WeaponServantView.ServantCallNameListViewModule",
				detailBtnStyle = 2,
				uiRootPath = "Widget/System/Hero_servant/Module/CallNameListViewModule",
				pageIdx = 2,
				detailNoHeroBtnStyle = 2,
				onServantItemClick = function(arg_7_0)
					arg_4_0:onCallNameItemClick(arg_7_0)
				end,
				OnRefresh = function()
					arg_4_0:OnCallNameBtnClick()
				end
			}
		},
		viewFullList = {
			detailBtnStyle = 1,
			detailNoHeroBtnStyle = 3,
			uiRootPath = "Widget/System/Hero_servant/Module/FullScreenServantView",
			viewModulePath = "game.views.weapon.WeaponServantView.WeaponServantFullListViewModule",
			onServantItemClick = function(arg_9_0)
				arg_4_0:onFullListItemClick(arg_9_0)
			end
		},
		avatarView = ServantAvatarViewModule.New(arg_4_0.scaleImageObj_)
	}

	arg_4_0.singleton.viewDetail:RegisteCallNameClickCallback(handler(arg_4_0, arg_4_0.onCallNameClick))
end

function var_0_0.InitContext(arg_10_0)
	arg_10_0.data = {
		curViewIdx = 0,
		heroId = 0,
		isOpen = true,
		isOnFullScreenView = false,
		isInAvatarShowView = false,
		isTalkCD = false,
		state = arg_10_0.params_.state or "onlydetail",
		custom = {
			isCustom = arg_10_0.params_.customServant or false,
			data = arg_10_0.params_.customServant
		}
	}
end

function var_0_0.Init(arg_11_0)
	arg_11_0:BindCfgUI()
	arg_11_0:BuildContext()
	arg_11_0:AddUIListener()
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0:InitContext()
	arg_12_0:AddEventListeners()

	if arg_12_0.data.custom.isCustom then
		arg_12_0:EnterCustomPage()
		arg_12_0:SwitchControllerState(arg_12_0.controller.state.customPage.name, arg_12_0.controller.state.customPage.On)
		SetActive(arg_12_0.contentObj_, false)
		arg_12_0:ShowBar()

		return
	else
		arg_12_0:SwitchControllerState(arg_12_0.controller.state.customPage.name, arg_12_0.controller.state.customPage.Off)
		SetActive(arg_12_0.contentObj_, true)

		arg_12_0.data.heroId = arg_12_0.params_.HeroID

		arg_12_0:OnPreOpenPage()
		arg_12_0:RefreshTabCount()
		arg_12_0:ShowBar()
	end
end

function var_0_0.ShowBar(arg_13_0)
	if not arg_13_0.data.isOpen then
		return
	end

	if arg_13_0.data.custom.isCustom then
		local var_13_0 = {
			BACK_BAR,
			HOME_BAR
		}

		manager.windowBar:SwitchBar(var_13_0)
	else
		local var_13_1 = {
			BACK_BAR,
			HOME_BAR,
			INFO_BAR
		}

		if arg_13_0.data and arg_13_0.data.curViewIdx == 2 then
			table.insert(var_13_1, CurrencyConst.CURRENCY_TYPE_GOLD)
			manager.windowBar:SwitchBar(var_13_1)
			manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
		else
			manager.windowBar:SwitchBar(var_13_1)
			manager.windowBar:RegistBackCallBack(function()
				arg_13_0:OnBackBtnClick()
			end)
		end

		manager.windowBar:SetGameHelpKey("SERVANT_AWAKE_DESC_1")
	end
end

function var_0_0.EnterCustomPage(arg_15_0)
	arg_15_0:OnHoldBtnClick()
end

function var_0_0.OnPreOpenPage(arg_16_0)
	if not arg_16_0.params_.tempParams then
		local var_16_0 = arg_16_0.params_.isFullScreen
		local var_16_1 = arg_16_0.params_.race
		local var_16_2 = arg_16_0.params_.servantID
		local var_16_3 = arg_16_0.params_.uid

		if var_16_1 and var_16_1 ~= 0 then
			arg_16_0:OnCallNameBtnClick(var_16_1, var_16_2)
		else
			local var_16_4

			if arg_16_0.data.heroId then
				var_16_4 = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT):GetHeroServantInfo(arg_16_0.data.heroId)

				arg_16_0:OnHoldBtnClick(var_16_4)
			else
				if var_16_3 then
					var_16_4 = WeaponServantData:GetServantDataByUID(var_16_3)
				end

				arg_16_0:OnHoldBtnClick(var_16_4)
			end
		end
	else
		local var_16_5 = arg_16_0.params_.tempParams

		arg_16_0.data.heroId = var_16_5.HeroID or nil

		if var_16_5.isFullScreen ~= nil then
			local var_16_6 = var_16_5.servantData

			if var_16_5.isFullScreen then
				if var_16_6.uid then
					if WeaponServantData:GetServantDataByUID(var_16_6.uid) then
						arg_16_0:OnFullScreenBtnClick(var_16_6)
					elseif not arg_16_0.data.heroId then
						if WeaponServantData:GetServantNum() == 0 then
							arg_16_0:OnHoldBtnClick()
						else
							arg_16_0:OnFullScreenBtnClick()
						end
					else
						arg_16_0:OnFullScreenBtnClick()
					end
				else
					arg_16_0:OnFullScreenBtnClick(var_16_6)
				end
			elseif var_16_5.viewIdx == 1 then
				arg_16_0:OnHoldBtnClick(var_16_6)
			elseif var_16_6.id and var_16_6.id ~= 0 then
				arg_16_0:OnCallNameBtnClick(arg_16_0:GetServantRace(var_16_6.id), var_16_6.id)
			else
				arg_16_0:OnCallNameBtnClick()
			end
		else
			local var_16_7

			if arg_16_0.data.heroId then
				var_16_7 = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT):GetHeroServantInfo(arg_16_0.data.heroId)
			end

			arg_16_0:OnHoldBtnClick(var_16_7)
		end
	end

	arg_16_0.params_.tempParams = nil
end

function var_0_0.RecordPageStatus(arg_17_0)
	arg_17_0.params_.tempParams = {
		isFullScreen = arg_17_0.data.isOnFullScreenView,
		HeroID = arg_17_0.data.heroId,
		servantData = clone(arg_17_0.data.curServantData or {}),
		viewIdx = arg_17_0.data.curViewIdx
	}
end

function var_0_0.OnExit(arg_18_0)
	arg_18_0.data.isOpen = false

	arg_18_0:RecordPageStatus()

	if arg_18_0.data.isOnFullScreenView then
		arg_18_0:EnterFullScreenView(false)
	end

	arg_18_0:RemoveAllEventListener()

	if arg_18_0.data.talkCDTimer_ then
		arg_18_0.data.talkCDTimer_:Stop()

		arg_18_0.data.talkCDTimer_ = nil
	end

	for iter_18_0, iter_18_1 in pairs(arg_18_0.singleton.listView) do
		if arg_18_0.data.curViewIdx == iter_18_1.pageIdx and iter_18_1.viewModule then
			iter_18_1.viewModule:OnExit()
		end
	end

	arg_18_0.singleton.viewDetail:OnExit()
	manager.windowBar:HideBar()
	arg_18_0:RemoveNotifyListeners()
end

function var_0_0.Dispose(arg_19_0)
	arg_19_0:RemoveAllListeners()
	arg_19_0:RemoveAllEventListener()
	arg_19_0.singleton.viewDetail:Dispose()

	if arg_19_0.singleton.viewFullList.viewModule then
		arg_19_0.singleton.viewFullList.viewModule:Dispose()
	end

	for iter_19_0, iter_19_1 in pairs(arg_19_0.singleton.listView) do
		if iter_19_1 and iter_19_1.viewModule then
			iter_19_1.viewObj = nil

			iter_19_1.viewModule:Dispose()

			iter_19_1.viewModule = nil
		end
	end

	arg_19_0.singleton.avatarView:Dispose()

	arg_19_0.singleton.avatarView = nil

	if arg_19_0.data.talkCDTimer_ then
		arg_19_0.data.talkCDTimer_:Stop()

		arg_19_0.data.talkCDTimer_ = nil
	end

	var_0_0.super.Dispose(arg_19_0)
end

function var_0_0.OnServantReplaced(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	if arg_20_2.servant_id == 0 then
		ShowTips("SUCCESS_REMOVE_SERVANT")
	else
		ShowTips("SUCCESS_EQUIP_SERVANT")
		arg_20_0:PlayHeroTalk()
	end
end

function var_0_0.OnSwitchTo(arg_21_0, arg_21_1)
	if arg_21_0.data.isOnFullScreenView then
		arg_21_0:EnterFullScreenView(false)
		arg_21_0:ShowBar()
	end

	local var_21_0 = arg_21_1.openTab
	local var_21_1 = arg_21_1.race
	local var_21_2 = arg_21_1.servantID
	local var_21_3 = arg_21_1.HeroID

	if var_21_3 then
		arg_21_0.data.heroId = var_21_3
	end

	if var_21_1 and var_21_1 ~= 0 then
		arg_21_0:OnCallNameBtnClick(var_21_1, var_21_2)
	elseif var_21_0 == "hold" then
		arg_21_0:OnHoldBtnClick({
			uid = arg_21_1.servantUID
		})
	end
end

function var_0_0.AddUIListener(arg_22_0)
	arg_22_0:AddBtnListener(arg_22_0.holdBtn_, nil, function()
		if arg_22_0.data.curViewIdx == arg_22_0.singleton.listView.viewHold.pageIdx then
			return
		end

		arg_22_0:OnHoldBtnClick()
	end)
	arg_22_0:AddBtnListener(arg_22_0.callNameBtn_, nil, function()
		if arg_22_0.data.curViewIdx == arg_22_0.singleton.listView.viewCallName.pageIdx then
			return
		end

		arg_22_0:OnCallNameBtnClick()
	end)
	arg_22_0:AddBtnListener(arg_22_0.showIconBtn_, nil, function()
		arg_22_0:ControlIconScaleClick()
	end)
	arg_22_0:AddBtnListener(arg_22_0.showPathBtn_, nil, function()
		arg_22_0:OnPathClick()
	end)
	arg_22_0.singleton.avatarView:RegisterCloseCallback(function()
		arg_22_0:EnterAvatarShow(false)
	end)
end

function var_0_0.AddEventListeners(arg_28_0)
	arg_28_0:RegistEventListener(SERVANT_REPLACE, handler(arg_28_0, arg_28_0.OnServantReplaced))
	arg_28_0:RegistEventListener(SERVANT_SWITCH_TO_CALLNAME, handler(arg_28_0, arg_28_0.OnSwitchTo))
end

function var_0_0.RemoveNotifyListeners(arg_29_0)
	return
end

function var_0_0.OnHoldBtnClick(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0.singleton.listView.viewHold
	local var_30_1 = arg_30_0.singleton.viewDetail

	arg_30_0:EnterViewOrInst(var_30_0, true)

	if arg_30_0:IsCustomPage() then
		var_30_1:SwitchBtnStyle(var_30_0.detailNoHeroBtnStyle)
		var_30_0.viewModule:HideFilter(true)
		arg_30_0:RefreshHoldServantList()
	else
		arg_30_0:SwitchControllerState(arg_30_0.controller.state.selectTab.name, arg_30_0.controller.state.selectTab.hold)
		var_30_0.viewModule:HideFilter(false)
		var_30_0.viewModule:RegisterFullScreenCallback(function()
			arg_30_0:OnFullScreenBtnClick()
		end)
		arg_30_0:RefreshHoldServantList(arg_30_1)
		arg_30_0:ShowBar()
	end
end

function var_0_0.OnCallNameBtnClick(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = arg_32_0.singleton.listView.viewCallName
	local var_32_1 = arg_32_0.singleton.viewDetail

	arg_32_0:SwitchControllerState(arg_32_0.controller.state.selectTab.name, arg_32_0.controller.state.selectTab.callName)
	arg_32_0:EnterViewOrInst(var_32_0, true)
	arg_32_0:RefreshCallNameServantList(arg_32_1, arg_32_2)
	var_32_1:SwitchBtnStyle(var_32_0.detailBtnStyle)
	arg_32_0:ShowBar()
end

function var_0_0.OnBackBtnClick(arg_33_0)
	if arg_33_0.data.isOnFullScreenView then
		arg_33_0:EnterFullScreenView(false)
		arg_33_0:RefreshView()
		arg_33_0:ShowBar()
	else
		arg_33_0:Back()
	end
end

function var_0_0.OnFullScreenBtnClick(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_0.singleton.viewDetail

	arg_34_0:EnterFullScreenView(true, arg_34_1)

	if arg_34_0.data.heroId then
		var_34_0:SwitchBtnStyle(arg_34_0.singleton.viewFullList.detailBtnStyle)
	else
		var_34_0:SwitchBtnStyle(arg_34_0.singleton.viewFullList.detailNoHeroBtnStyle)
	end
end

function var_0_0.ControlIconScaleClick(arg_35_0)
	arg_35_0:EnterAvatarShow(true)
end

function var_0_0.OnPathClick(arg_36_0)
	local var_36_0 = arg_36_0.data.curServantData

	if not var_36_0 then
		return
	end

	local var_36_1 = var_36_0.id

	ShowPopItemOnly(POP_SOURCE_ITEM, {
		var_36_1,
		"servant"
	})
end

function var_0_0.onCallNameClick(arg_37_0)
	arg_37_0:OnCallNameBtnClick()
end

function var_0_0.onShowEmptyView(arg_38_0)
	return
end

function var_0_0.PlayHeroTalk(arg_39_0)
	if arg_39_0.data.heroId and arg_39_0.data.heroId ~= 0 then
		if arg_39_0.data.isTalkCD then
			return
		end

		HeroTools.PlayTalk(arg_39_0.data.heroId, "equip")

		arg_39_0.data.isTalkCD = true
		arg_39_0.data.talkCDTimer_ = Timer.New(function()
			arg_39_0.data.isTalkCD = false
		end, 10, 1)

		arg_39_0.data.talkCDTimer_:Start()
	end
end

function var_0_0.SwitchControllerState(arg_41_0, arg_41_1, arg_41_2)
	local var_41_0 = arg_41_0.controller.comps:GetController(arg_41_1)

	if var_41_0 then
		var_41_0:SetSelectedState(arg_41_2)
	end
end

function var_0_0.IsCustomPage(arg_42_0)
	return arg_42_0.data.custom.isCustom
end

function var_0_0.onHoldItemClick(arg_43_0, arg_43_1)
	arg_43_0:SelectServant(arg_43_1)
end

function var_0_0.onCallNameItemClick(arg_44_0, arg_44_1)
	arg_44_0:SelectServant(arg_44_1)
end

function var_0_0.onFullListItemClick(arg_45_0, arg_45_1)
	arg_45_0:SelectServant(arg_45_1)
end

function var_0_0.SelectServant(arg_46_0, arg_46_1)
	if not arg_46_1 then
		return
	end

	local var_46_0 = arg_46_0.data.curServantData

	arg_46_0.data.curServantData = arg_46_1

	arg_46_0.singleton.viewDetail:OnRenderServant(arg_46_1, arg_46_0.data.heroId)

	if not arg_46_0.data.isOnFullScreenView then
		manager.heroRaiseTrack:SetWeaponServantID(arg_46_1.id)
	end

	arg_46_0.singleton.avatarView:SetAvatarSprite(arg_46_1.id)
end

function var_0_0.RefreshView(arg_47_0)
	for iter_47_0, iter_47_1 in pairs(arg_47_0.singleton.listView) do
		if arg_47_0.data.curViewIdx == iter_47_1.pageIdx then
			local var_47_0 = iter_47_1.OnRefresh

			if var_47_0 then
				var_47_0()

				break
			end
		end
	end
end

function var_0_0.RefreshHoldServantList(arg_48_0, arg_48_1)
	local var_48_0

	if arg_48_1 then
		var_48_0 = arg_48_1.uid
	end

	local var_48_1 = arg_48_0.singleton.listView.viewHold

	var_48_1.viewModule:RefreshList({
		custom = arg_48_0.data.custom,
		heroId = arg_48_0.data.heroId,
		jumpUid = var_48_0,
		emptyCallback = function(arg_49_0)
			if arg_49_0 then
				arg_48_0:SwitchControllerState(arg_48_0.controller.state.emptyView.name, arg_48_0.controller.state.emptyView.True)
				manager.heroRaiseTrack:PlayServantAnim("Fade")
			else
				arg_48_0:SwitchControllerState(arg_48_0.controller.state.emptyView.name, arg_48_0.controller.state.emptyView.False)
				manager.heroRaiseTrack:PlayServantAnim("Light")

				local var_49_0 = arg_48_0.singleton.viewDetail

				if arg_48_0.data.heroId and arg_48_0.data.heroId ~= 0 or arg_48_0.data.state == "onlybeyond" then
					var_49_0:SwitchBtnStyle(var_48_1.detailBtnStyle)
				else
					var_49_0:SwitchBtnStyle(var_48_1.detailNoHeroBtnStyle)
				end
			end
		end
	})
end

function var_0_0.RefreshCallNameServantList(arg_50_0, arg_50_1, arg_50_2)
	arg_50_0.singleton.listView.viewCallName.viewModule:EnterPage({
		heroId = arg_50_0.data.heroId,
		race = arg_50_1,
		servantID = arg_50_2
	})
	arg_50_0:SwitchControllerState(arg_50_0.controller.state.emptyView.name, arg_50_0.controller.state.emptyView.False)
	manager.heroRaiseTrack:PlayServantAnim("Light")
end

function var_0_0.RefreshFullListServantList(arg_51_0, arg_51_1)
	if arg_51_0.singleton.viewFullList.viewModule then
		local var_51_0

		if arg_51_1 then
			var_51_0 = arg_51_1.uid
		end

		arg_51_0.singleton.viewFullList.viewModule:RefreshList({
			heroId = arg_51_0.data.heroId,
			jumpUid = var_51_0
		})
	end
end

function var_0_0.EnterFullScreenView(arg_52_0, arg_52_1, arg_52_2)
	arg_52_0.data.isOnFullScreenView = arg_52_1

	if arg_52_1 then
		arg_52_0:EnterFullListOrInst()
		arg_52_0:RefreshFullListServantList(arg_52_2)
		arg_52_0:SwitchControllerState(arg_52_0.controller.state.inFullScreen.name, arg_52_0.controller.state.inFullScreen.True)
		arg_52_0.singleton.viewFullList.viewModule:OnEnter()
		manager.heroRaiseTrack:PlayServantAnim("Fade")
	else
		arg_52_0:SwitchControllerState(arg_52_0.controller.state.inFullScreen.name, arg_52_0.controller.state.inFullScreen.False)

		if arg_52_0.singleton.viewFullList.viewModule then
			arg_52_0.singleton.viewFullList.viewModule:OnExit()
		end

		manager.heroRaiseTrack:PlayServantAnim("Light")

		if arg_52_0.data.curServantData then
			manager.heroRaiseTrack:SetWeaponServantID(arg_52_0.data.curServantData.id)
			arg_52_0:OnHoldBtnClick()
			arg_52_0:RefreshTabCount()
		end
	end
end

function var_0_0.RefreshTabCount(arg_53_0)
	arg_53_0:RefreshCallNameCount()
	arg_53_0:RefreshFullServantCount()
end

function var_0_0.RefreshCallNameCount(arg_54_0)
	local var_54_0 = WeaponServantData:GetWeaponServantList()
	local var_54_1 = 0

	for iter_54_0, iter_54_1 in pairs(var_54_0) do
		local var_54_2 = WeaponServantCfg[iter_54_1.id].race

		if WeaponServantCfg[iter_54_1.id].type == 3 then
			var_54_1 = var_54_1 + 1
		end
	end

	arg_54_0.callNameNumTxt_.text = var_54_1
end

function var_0_0.RefreshFullServantCount(arg_55_0)
	local var_55_0 = ServantTools.GetServantShowCount()
	local var_55_1 = GameSetting.max_weapon_servant.value[1]

	arg_55_0.haveNumTxt_.text = table.concat({
		var_55_0,
		"/",
		var_55_1
	})
end

function var_0_0.EnterFullListOrInst(arg_56_0)
	local var_56_0 = arg_56_0.singleton.viewFullList

	arg_56_0:InstView(var_56_0, arg_56_0.fullPageContainer_)
end

function var_0_0.EnterViewOrInst(arg_57_0, arg_57_1, arg_57_2)
	arg_57_0:InstView(arg_57_1, arg_57_0.pageContainer_)

	local var_57_0 = arg_57_0.data.curViewIdx

	arg_57_0.data.curViewIdx = arg_57_1.pageIdx

	local var_57_1

	if arg_57_2 then
		for iter_57_0, iter_57_1 in pairs(arg_57_0.singleton.listView) do
			if iter_57_1.viewModule then
				if iter_57_1.pageIdx ~= arg_57_0.data.curViewIdx then
					iter_57_1.viewObj:SetActive(false)
				else
					iter_57_1.viewObj:SetActive(true)
				end

				if iter_57_1.pageIdx == var_57_0 then
					var_57_1 = iter_57_1.viewModule
				end
			end
		end

		if var_57_0 ~= arg_57_0.data.curViewIdx then
			if var_57_1 then
				var_57_1:OnExit()
			end

			arg_57_1.viewModule:OnEnter()
		end
	else
		arg_57_1.viewObj:SetActive(true)
	end
end

function var_0_0.InstView(arg_58_0, arg_58_1, arg_58_2, arg_58_3)
	if not arg_58_1.viewModule then
		local var_58_0 = Asset.Load(arg_58_1.uiRootPath)

		arg_58_1.viewObj = Object.Instantiate(var_58_0, arg_58_2)
		arg_58_1.viewModule = import(arg_58_1.viewModulePath).New(arg_58_1.viewObj)

		if arg_58_1.onServantItemClick then
			arg_58_1.viewModule:RegisterClickCallback(arg_58_1.onServantItemClick)
		end
	end
end

function var_0_0.GetServantRace(arg_59_0, arg_59_1)
	if arg_59_1 then
		return WeaponServantCfg[arg_59_1].race
	else
		return 1
	end
end

function var_0_0.EnterAvatarShow(arg_60_0, arg_60_1)
	arg_60_0.data.isInAvatarShowView = arg_60_1

	if arg_60_1 then
		manager.windowBar:HideBar()
		manager.heroRaiseTrack:PlayServantAnim("Fade")
		arg_60_0.singleton.avatarView:EnterAvatarView(true)
		arg_60_0:SwitchControllerState(arg_60_0.controller.state.avatarShow.name, arg_60_0.controller.state.avatarShow.True)
	else
		arg_60_0:ShowBar()
		manager.windowBar:RegistBackCallBack(function()
			arg_60_0:OnBackBtnClick()
		end)

		if not arg_60_0.data.isOnFullScreenView then
			manager.heroRaiseTrack:SetWeaponServantID(arg_60_0.data.curServantData.id)
			manager.heroRaiseTrack:PlayServantAnim("Light")
		end

		arg_60_0.singleton.avatarView:EnterAvatarView(false)
		arg_60_0:SwitchControllerState(arg_60_0.controller.state.avatarShow.name, arg_60_0.controller.state.avatarShow.False)
		arg_60_0:RestoreListPostion()
	end
end

function var_0_0.RestoreListPostion(arg_62_0)
	for iter_62_0, iter_62_1 in pairs(arg_62_0.singleton.listView) do
		if arg_62_0.data.curViewIdx == iter_62_1.pageIdx and iter_62_1.viewModule then
			iter_62_1.viewModule:RestoreListPostion()
		end
	end
end

return var_0_0
