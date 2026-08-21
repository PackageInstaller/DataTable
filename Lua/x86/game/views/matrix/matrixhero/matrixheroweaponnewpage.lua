local var_0_0 = import("game.views.newHero.HeroPageBase")
local var_0_1 = class("MatrixHeroWeaponNewPage", var_0_0)

function var_0_1.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.handler_ = arg_1_1
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_2.transform

	arg_1_0:Init()
end

function var_0_1.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_1.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:BuildContext()
end

function var_0_1.BuildContext(arg_4_0)
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

function var_0_1.InitContext(arg_10_0)
	arg_10_0.data = {
		isInAvatarShowView = false,
		heroId = 0,
		curViewIdx = 0,
		isOnFullScreenView = false,
		isOpen = true,
		isTalkCD = false,
		custom = {
			isCustom = arg_10_0.servantData or false,
			data = arg_10_0.servantData
		}
	}
end

function var_0_1.OnEnter(arg_11_0, arg_11_1)
	arg_11_0.heroViewProxy_ = arg_11_1

	arg_11_0:InitContext()
end

function var_0_1.SwitchControllerState(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.controller.comps:GetController(arg_12_1)

	if var_12_0 then
		var_12_0:SetSelectedState(arg_12_2)
	end
end

function var_0_1.SetHeroInfo(arg_13_0, arg_13_1)
	arg_13_0.heroInfo_ = arg_13_1
	arg_13_0.servantData = StrategyMatrixData:GetHeroData(arg_13_1.id).servantInfo
end

function var_0_1.UpdateView(arg_14_0)
	if arg_14_0.servantData.id > 0 then
		arg_14_0.portrait_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/WeaponServant/Portrait/" .. arg_14_0.servantData.id)

		arg_14_0.singleton.viewDetail:OnRenderServant(arg_14_0.servantData, arg_14_0.heroInfo_.id)
	else
		arg_14_0:SwitchControllerState(arg_14_0.controller.state.emptyView.name, arg_14_0.controller.state.emptyView.True)
	end

	if arg_14_0.data.custom.isCustom then
		arg_14_0:SwitchControllerState(arg_14_0.controller.state.customPage.name, arg_14_0.controller.state.customPage.On)
		SetActive(arg_14_0.contentObj_, false)

		return
	else
		arg_14_0:SwitchControllerState(arg_14_0.controller.state.customPage.name, arg_14_0.controller.state.customPage.Off)
		SetActive(arg_14_0.contentObj_, true)

		arg_14_0.data.heroId = arg_14_0.heroInfo_.id
	end
end

function var_0_1.CameraEnter(arg_15_0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		4,
		0
	})
end

function var_0_1.Show(arg_16_0)
	SetActive(arg_16_0.gameObject_, true)
	arg_16_0:UpdateView()
end

function var_0_1.Dispose(arg_17_0)
	arg_17_0:RemoveAllListeners()
	arg_17_0.singleton.viewDetail:Dispose()

	if arg_17_0.singleton.viewFullList.viewModule then
		arg_17_0.singleton.viewFullList.viewModule:Dispose()
	end

	for iter_17_0, iter_17_1 in pairs(arg_17_0.singleton.listView) do
		if iter_17_1 and iter_17_1.viewModule then
			iter_17_1.viewObj = nil

			iter_17_1.viewModule:Dispose()

			iter_17_1.viewModule = nil
		end
	end

	arg_17_0.singleton.avatarView:Dispose()

	arg_17_0.singleton.avatarView = nil

	if arg_17_0.data.talkCDTimer_ then
		arg_17_0.data.talkCDTimer_:Stop()

		arg_17_0.data.talkCDTimer_ = nil
	end

	var_0_1.super.Dispose(arg_17_0)
end

function var_0_1.OnExit(arg_18_0)
	arg_18_0.data.isOpen = false

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
end

return var_0_1
