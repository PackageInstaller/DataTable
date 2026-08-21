local var_0_0 = class("WeaponServantDetailsView", ReduxView)

function var_0_0.CameraEnter(arg_1_0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		HeroRaiseTrackConst.HeroRaiseType.weapon,
		2,
		HeroRaiseTrackConst.HeroServantType.servant
	})
	manager.heroRaiseTrack:PlayServantAnim("Light")
end

function var_0_0.OnTop(arg_2_0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		HeroRaiseTrackConst.HeroRaiseType.weapon,
		2,
		HeroRaiseTrackConst.HeroServantType.servant
	})
	manager.heroRaiseTrack:PlayServantAnim("Light")
end

function var_0_0.UIName(arg_3_0)
	return "Widget/System/Hero_servant/HeroServantDetailUI"
end

function var_0_0.UIParent(arg_4_0)
	return manager.ui.uiMain.transform
end

function var_0_0.BuildContext(arg_5_0)
	arg_5_0.controller = {
		comps = arg_5_0.gameObject_:GetComponent("ControllerExCollection"),
		state = {
			tabDetails = {
				False = "False",
				name = "tabDetails",
				True = "True"
			},
			tabBeyond = {
				False = "False",
				name = "tabBeyond",
				True = "True"
			},
			tabStory = {
				False = "False",
				name = "tabStory",
				True = "True"
			},
			avatarShow = {
				False = "false",
				name = "avatarShow",
				True = "true"
			}
		}
	}
	arg_5_0.tabGroup = {
		{
			btnState = "tabDetails",
			OnEnter = handler(arg_5_0, arg_5_0.SwitchToDetailPage)
		},
		{
			btnState = "tabBeyond",
			OnEnter = handler(arg_5_0, arg_5_0.SwitchToBeyondPage)
		},
		{
			btnState = "tabStory",
			OnEnter = handler(arg_5_0, arg_5_0.SwitchToStory)
		}
	}
	arg_5_0.page = {
		detailView = {
			name = "detailView",
			uiRootPath = "Widget/System/Hero_servant/Module/MainServantDetailModule",
			pageIdx = 1,
			stateName = "Detail",
			viewPath = WeaponServantDetailModule
		},
		beyondView = {
			name = "beyondView",
			barCurrency = true,
			uiRootPath = "Widget/System/Hero_servant/Module/MainBeyondView",
			pageIdx = 2,
			stateName = "beyond",
			viewPath = WeaponServantBeyondModule
		},
		storyView = {
			name = "storyView",
			uiRootPath = "Widget/System/Hero_servant/Module/MainStoryView",
			pageIdx = 3,
			stateName = "Story",
			viewPath = WeaponServantStoryModule
		}
	}
	arg_5_0.constVar = {
		tabPrefix = "tabObj%d_",
		avatarView = ServantAvatarViewModule.New(arg_5_0.scaleImageObj_)
	}
end

function var_0_0.InitContext(arg_6_0)
	arg_6_0.data = {
		isInAvatarShowView = false,
		curPageIdx = 0,
		servantId = 0,
		heroId = 0,
		servantData = {}
	}
end

function var_0_0.Init(arg_7_0)
	arg_7_0:BindCfgUI()
	arg_7_0:BuildContext()
	arg_7_0:AddUIListener()
	arg_7_0:AddEventListeners()
end

function var_0_0.AddUIListener(arg_8_0)
	for iter_8_0 = 1, 3 do
		arg_8_0:AddToggleListener(arg_8_0[string.format("tabToggle%d_", iter_8_0)], function(arg_9_0)
			if arg_9_0 then
				arg_8_0:SwitchToTab(iter_8_0, true)
			end
		end)
	end

	arg_8_0:AddBtnListener(arg_8_0.showBtn_, nil, function()
		arg_8_0:OnShowBtnClick()
	end)
	arg_8_0:AddBtnListener(arg_8_0.gachaBtn_, nil, function()
		arg_8_0:OnGachaBtnClick()
	end)
	arg_8_0.constVar.avatarView:RegisterCloseCallback(function()
		arg_8_0:EnterAvatarShow(false)
	end)

	arg_8_0.eventHandler = {
		promoteHandler = handler(arg_8_0, arg_8_0.OnBeyondSuccess)
	}

	arg_8_0:RegistEventListener(SERVANT_PROMOTE, arg_8_0.eventHandler.promoteHandler)
end

function var_0_0.AddEventListeners(arg_13_0)
	return
end

function var_0_0.OnBeyondSuccess(arg_14_0)
	arg_14_0:ChangeBar()
end

function var_0_0.ChangeBeyondBarShow(arg_15_0)
	local var_15_0 = not arg_15_0:CheckIsArriveMax(arg_15_0:GetServantData())
	local var_15_1 = {
		BACK_BAR,
		HOME_BAR
	}

	if var_15_0 then
		table.insert(var_15_1, CurrencyConst.CURRENCY_TYPE_GOLD)
		manager.windowBar:SwitchBar(var_15_1)
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	else
		manager.windowBar:SwitchBar(var_15_1)
	end
end

function var_0_0.CheckIsArriveMax(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1.stage
	local var_16_1 = WeaponServantCfg[arg_16_1.id].starlevel

	return var_16_0 >= GameSetting.weapon_promote_max.value[var_16_1] + 1
end

function var_0_0.ChangeBar(arg_17_0, arg_17_1)
	if not arg_17_0.params_.id then
		if not arg_17_1 then
			for iter_17_0, iter_17_1 in pairs(arg_17_0.page) do
				if iter_17_1.view and iter_17_1.pageIdx == arg_17_0.data.curPageIdx then
					arg_17_1 = iter_17_1

					break
				end
			end
		end

		if arg_17_1 and arg_17_1.pageIdx == 2 then
			arg_17_0:ChangeBeyondBarShow()
		else
			local var_17_0 = {
				BACK_BAR,
				HOME_BAR
			}

			manager.windowBar:SwitchBar(var_17_0)
		end
	else
		manager.windowBar:SwitchBar({
			BACK_BAR
		})
	end
end

function var_0_0.OnEnter(arg_18_0)
	arg_18_0:InitContext()

	local var_18_0 = arg_18_0.params_.servantData or {
		locked = false,
		id = arg_18_0.params_.id,
		stage = arg_18_0.params_.stage or 1
	}

	arg_18_0.data.servantData = var_18_0
	arg_18_0.data.heroId = arg_18_0.params_.heroId

	arg_18_0:PreOpenLogic()
	arg_18_0:RenderView()
end

function var_0_0.PreOpenLogic(arg_19_0)
	local var_19_0 = arg_19_0.params_.openContext
	local var_19_1 = arg_19_0.data.servantData.uid == nil

	if var_19_0 then
		local var_19_2 = var_19_0.disableTabList

		if var_19_2 then
			for iter_19_0 = 1, 3 do
				local var_19_3 = arg_19_0[string.format(arg_19_0.constVar.tabPrefix, iter_19_0)]

				if var_19_3 then
					SetActive(var_19_3, not var_19_2[iter_19_0])
				end
			end
		else
			for iter_19_1 = 1, 3 do
				local var_19_4 = arg_19_0[string.format(arg_19_0.constVar.tabPrefix, iter_19_1)]

				if var_19_4 then
					SetActive(var_19_4, true)
				end
			end
		end

		arg_19_0:SwitchToTab(var_19_0.tabIndex or 1, true)

		if var_19_0.disableOrigin then
			SetActive(arg_19_0.gachaBtn_.gameObject, false)
		else
			SetActive(arg_19_0.gachaBtn_.gameObject, true)
		end
	else
		if var_19_1 then
			local var_19_5 = arg_19_0[string.format(arg_19_0.constVar.tabPrefix, 2)]

			if var_19_5 then
				SetActive(var_19_5, false)
			end
		else
			local var_19_6 = arg_19_0[string.format(arg_19_0.constVar.tabPrefix, 2)]

			if var_19_6 then
				SetActive(var_19_6, true)
			end
		end

		arg_19_0:SwitchToTab(1, true)
	end

	arg_19_0:EnterAvatarShow(false)
end

function var_0_0.OnExit(arg_20_0)
	for iter_20_0, iter_20_1 in pairs(arg_20_0.page) do
		if iter_20_1 and iter_20_1.view then
			iter_20_1.view:OnExit()
		end
	end

	arg_20_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_21_0)
	arg_21_0:RemoveAllEventListener()
	arg_21_0:RemoveAllListeners()

	for iter_21_0, iter_21_1 in pairs(arg_21_0.page) do
		if iter_21_1 and iter_21_1.view then
			iter_21_1.viewObj = nil

			iter_21_1.view:Dispose()

			iter_21_1.view = nil
		end
	end

	arg_21_0.constVar.avatarView:Dispose()

	arg_21_0.constVar.avatarView = nil

	var_0_0.super.Dispose(arg_21_0)
end

function var_0_0.RenderView(arg_22_0)
	manager.heroRaiseTrack:SetWeaponServantID(arg_22_0.data.servantData.id)
	arg_22_0.constVar.avatarView:SetAvatarSprite(arg_22_0.data.servantData.id)
end

function var_0_0.SwitchToTab(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_0.tabGroup

	for iter_23_0, iter_23_1 in pairs(var_23_0) do
		if iter_23_0 == arg_23_1 then
			arg_23_0:SwitchControllerState(var_23_0[iter_23_0].btnState, "True")

			if arg_23_2 then
				var_23_0[iter_23_0].OnEnter(true)
			end
		else
			arg_23_0:SwitchControllerState(var_23_0[iter_23_0].btnState, "False")
		end
	end
end

function var_0_0.SwitchToBeyondPage(arg_24_0, arg_24_1)
	arg_24_0:SwitchToView(arg_24_0.page.beyondView, arg_24_1)
end

function var_0_0.SwitchToStory(arg_25_0, arg_25_1)
	arg_25_0:SwitchToView(arg_25_0.page.storyView, arg_25_1)
end

function var_0_0.SwitchToDetailPage(arg_26_0, arg_26_1)
	arg_26_0:SwitchToView(arg_26_0.page.detailView, arg_26_1)
end

function var_0_0.SwitchToView(arg_27_0, arg_27_1, arg_27_2)
	if arg_27_1 then
		local var_27_0 = arg_27_0.data.curPageIdx

		arg_27_0:ChangeBar(arg_27_1)

		if var_27_0 ~= arg_27_1.pageIdx then
			arg_27_0.data.curPageIdx = arg_27_1.pageIdx

			arg_27_0:EnterViewOrInst(arg_27_1, true)
			arg_27_0:RefreshPageView(arg_27_1.view)
		elseif arg_27_2 then
			arg_27_0.data.curPageIdx = arg_27_1.pageIdx

			arg_27_0:EnterViewOrInst(arg_27_1, false)
			arg_27_0:RefreshPageView(arg_27_1.view)
		end
	end
end

function var_0_0.RefreshPageView(arg_28_0, arg_28_1)
	arg_28_1:OnRenderModule({
		servantData = arg_28_0:GetServantData(),
		heroId = arg_28_0:GetHeroId()
	})
end

function var_0_0.EnterViewOrInst(arg_29_0, arg_29_1, arg_29_2)
	if not arg_29_1.view then
		local var_29_0 = Asset.Load(arg_29_1.uiRootPath)

		arg_29_1.viewObj = Object.Instantiate(var_29_0, arg_29_0.pageContainer_)
		arg_29_1.view = arg_29_1.viewPath.New(arg_29_1.viewObj)
	end

	if arg_29_2 then
		for iter_29_0, iter_29_1 in pairs(arg_29_0.page) do
			if iter_29_1.view then
				if iter_29_1.pageIdx ~= arg_29_0.data.curPageIdx then
					iter_29_1.view:OnExit()
					iter_29_1.viewObj:SetActive(false)
				else
					iter_29_1.view:OnEnter()
					iter_29_1.viewObj:SetActive(true)
				end
			end
		end
	else
		arg_29_1.viewObj:SetActive(true)
	end
end

function var_0_0.SwitchControllerState(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = arg_30_0.controller.comps:GetController(arg_30_1)

	if var_30_0 then
		var_30_0:SetSelectedState(arg_30_2)
	end
end

function var_0_0.GetServantData(arg_31_0)
	return arg_31_0.data.servantData
end

function var_0_0.GetHeroId(arg_32_0)
	return arg_32_0.data.heroId
end

function var_0_0.OnShowBtnClick(arg_33_0)
	arg_33_0:EnterAvatarShow(true)
end

function var_0_0.OnGachaBtnClick(arg_34_0)
	local var_34_0 = arg_34_0:GetServantData()

	if not var_34_0 then
		return
	end

	local var_34_1 = var_34_0.id

	ShowPopItemOnly(POP_SOURCE_ITEM, {
		var_34_1,
		"servant"
	})
end

function var_0_0.EnterAvatarShow(arg_35_0, arg_35_1)
	arg_35_0.data.isInAvatarShowView = arg_35_1

	if arg_35_1 then
		manager.windowBar:HideBar()
		manager.heroRaiseTrack:PlayServantAnim("Fade")
		arg_35_0.constVar.avatarView:EnterAvatarView(true)
		arg_35_0:SwitchControllerState(arg_35_0.controller.state.avatarShow.name, arg_35_0.controller.state.avatarShow.True)
	else
		arg_35_0:ChangeBar()
		manager.heroRaiseTrack:SetWeaponServantID(arg_35_0:GetServantData().id)
		manager.heroRaiseTrack:PlayServantAnim("Light")
		arg_35_0.constVar.avatarView:EnterAvatarView(false)
		arg_35_0:SwitchControllerState(arg_35_0.controller.state.avatarShow.name, arg_35_0.controller.state.avatarShow.False)
	end
end

return var_0_0
