local WeaponServantDetailsView = class("WeaponServantDetailsView", ReduxView)

function WeaponServantDetailsView:CameraEnter()
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		HeroRaiseTrackConst.HeroRaiseType.weapon,
		2,
		HeroRaiseTrackConst.HeroServantType.servant
	})
	manager.heroRaiseTrack:PlayServantAnim("Light")
end

function WeaponServantDetailsView:OnTop()
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		HeroRaiseTrackConst.HeroRaiseType.weapon,
		2,
		HeroRaiseTrackConst.HeroServantType.servant
	})
	manager.heroRaiseTrack:PlayServantAnim("Light")
end

function WeaponServantDetailsView:UIName()
	return "Widget/System/Hero_servant/HeroServantDetailUI"
end

function WeaponServantDetailsView:UIParent()
	return manager.ui.uiMain.transform
end

function WeaponServantDetailsView:BuildContext()
	self.controller = {
		comps = self.gameObject_:GetComponent("ControllerExCollection"),
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
	self.tabGroup = {
		{
			btnState = "tabDetails",
			OnEnter = handler(self, self.SwitchToDetailPage)
		},
		{
			btnState = "tabBeyond",
			OnEnter = handler(self, self.SwitchToBeyondPage)
		},
		{
			btnState = "tabStory",
			OnEnter = handler(self, self.SwitchToStory)
		}
	}
	self.page = {
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
	self.constVar = {
		tabPrefix = "tabObj%d_",
		avatarView = ServantAvatarViewModule.New(self.scaleImageObj_)
	}
end

function WeaponServantDetailsView:InitContext()
	self.data = {
		isInAvatarShowView = false,
		curPageIdx = 0,
		servantId = 0,
		heroId = 0,
		servantData = {}
	}
end

function WeaponServantDetailsView:Init()
	self:BindCfgUI()
	self:BuildContext()
	self:AddUIListener()
	self:AddEventListeners()
end

function WeaponServantDetailsView:AddUIListener()
	for iter_8_0 = 1, 3 do
		self:AddToggleListener(self[string.format("tabToggle%d_", iter_8_0)], function(arg_9_0)
			if arg_9_0 then
				self:SwitchToTab(iter_8_0, true)
			end
		end)
	end

	self:AddBtnListener(self.showBtn_, nil, function()
		self:OnShowBtnClick()
	end)
	self:AddBtnListener(self.gachaBtn_, nil, function()
		self:OnGachaBtnClick()
	end)
	self.constVar.avatarView:RegisterCloseCallback(function()
		self:EnterAvatarShow(false)
	end)

	self.eventHandler = {
		promoteHandler = handler(self, self.OnBeyondSuccess)
	}

	self:RegistEventListener(SERVANT_PROMOTE, self.eventHandler.promoteHandler)
end

function WeaponServantDetailsView:AddEventListeners()
	return
end

function WeaponServantDetailsView:OnBeyondSuccess()
	self:ChangeBar()
end

function WeaponServantDetailsView:ChangeBeyondBarShow()
	local var_15_0 = {
		BACK_BAR,
		HOME_BAR
	}

	if not self:CheckIsArriveMax(self:GetServantData()) then
		table.insert(var_15_0, CurrencyConst.CURRENCY_TYPE_GOLD)
		manager.windowBar:SwitchBar(var_15_0)
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
	else
		manager.windowBar:SwitchBar(var_15_0)
	end
end

function WeaponServantDetailsView:CheckIsArriveMax(arg_16_1)
	return arg_16_1.stage >= GameSetting.weapon_promote_max.value[WeaponServantCfg[arg_16_1.id].starlevel] + 1
end

function WeaponServantDetailsView:ChangeBar(arg_17_1)
	if not self.params_.id then
		if not arg_17_1 then
			for iter_17_0, iter_17_1 in pairs(self.page) do
				if iter_17_1.view and iter_17_1.pageIdx == self.data.curPageIdx then
					arg_17_1 = iter_17_1

					break
				end
			end
		end

		if arg_17_1 and arg_17_1.pageIdx == 2 then
			self:ChangeBeyondBarShow()
		else
			manager.windowBar:SwitchBar({
				BACK_BAR,
				HOME_BAR
			})
		end
	else
		manager.windowBar:SwitchBar({
			BACK_BAR
		})
	end
end

function WeaponServantDetailsView:OnEnter()
	self:InitContext()

	local var_18_0 = self.params_.servantData

	if not self.params_.servantData then
		local var_18_1 = {
			locked = false,
			id = self.params_.id
		}

		var_18_1.stage = self.params_.stage or 1
		var_18_0 = var_18_1
	end

	self.data.servantData = var_18_0
	self.data.heroId = self.params_.heroId

	self:PreOpenLogic()
	self:RenderView()
end

function WeaponServantDetailsView:PreOpenLogic()
	local var_19_0 = self.params_.openContext
	local var_19_1 = self.data.servantData.uid == nil

	if self.params_.openContext then
		if var_19_0.disableTabList then
			for iter_19_0 = 1, 3 do
				local var_19_2 = self[string.format(self.constVar.tabPrefix, iter_19_0)]

				if var_19_2 then
					SetActive(var_19_2, not var_19_0.disableTabList[iter_19_0])
				end
			end
		else
			for iter_19_1 = 1, 3 do
				local var_19_3 = self[string.format(self.constVar.tabPrefix, iter_19_1)]

				if var_19_3 then
					SetActive(var_19_3, true)
				end
			end
		end

		self:SwitchToTab(var_19_0.tabIndex or 1, true)

		if var_19_0.disableOrigin then
			SetActive(self.gachaBtn_.gameObject, false)
		else
			SetActive(self.gachaBtn_.gameObject, true)
		end
	else
		if var_19_1 then
			local var_19_4 = self[string.format(self.constVar.tabPrefix, 2)]

			if var_19_4 then
				SetActive(var_19_4, false)
			end
		else
			local var_19_5 = self[string.format(self.constVar.tabPrefix, 2)]

			if var_19_5 then
				SetActive(var_19_5, true)
			end
		end

		self:SwitchToTab(1, true)
	end

	self:EnterAvatarShow(false)
end

function WeaponServantDetailsView:OnExit()
	for iter_20_0, iter_20_1 in pairs(self.page) do
		if iter_20_1 and iter_20_1.view then
			iter_20_1.view:OnExit()
		end
	end

	self:RemoveAllEventListener()
end

function WeaponServantDetailsView:Dispose()
	self:RemoveAllEventListener()
	self:RemoveAllListeners()

	for iter_21_0, iter_21_1 in pairs(self.page) do
		if iter_21_1 and iter_21_1.view then
			iter_21_1.viewObj = nil

			iter_21_1.view:Dispose()

			iter_21_1.view = nil
		end
	end

	self.constVar.avatarView:Dispose()

	self.constVar.avatarView = nil

	WeaponServantDetailsView.super.Dispose(self)
end

function WeaponServantDetailsView:RenderView()
	manager.heroRaiseTrack:SetWeaponServantID(self.data.servantData.id)
	self.constVar.avatarView:SetAvatarSprite(self.data.servantData.id)
end

function WeaponServantDetailsView:SwitchToTab(arg_23_1, arg_23_2)
	for iter_23_0, iter_23_1 in pairs(self.tabGroup) do
		if iter_23_0 == arg_23_1 then
			self:SwitchControllerState(self.tabGroup[iter_23_0].btnState, "True")

			if arg_23_2 then
				self.tabGroup[iter_23_0].OnEnter(true)
			end
		else
			self:SwitchControllerState(self.tabGroup[iter_23_0].btnState, "False")
		end
	end
end

function WeaponServantDetailsView:SwitchToBeyondPage(arg_24_1)
	self:SwitchToView(self.page.beyondView, arg_24_1)
end

function WeaponServantDetailsView:SwitchToStory(arg_25_1)
	self:SwitchToView(self.page.storyView, arg_25_1)
end

function WeaponServantDetailsView:SwitchToDetailPage(arg_26_1)
	self:SwitchToView(self.page.detailView, arg_26_1)
end

function WeaponServantDetailsView:SwitchToView(arg_27_1, arg_27_2)
	if arg_27_1 then
		self:ChangeBar(arg_27_1)

		if self.data.curPageIdx ~= arg_27_1.pageIdx then
			self.data.curPageIdx = arg_27_1.pageIdx

			self:EnterViewOrInst(arg_27_1, true)
			self:RefreshPageView(arg_27_1.view)
		elseif arg_27_2 then
			self.data.curPageIdx = arg_27_1.pageIdx

			self:EnterViewOrInst(arg_27_1, false)
			self:RefreshPageView(arg_27_1.view)
		end
	end
end

function WeaponServantDetailsView:RefreshPageView(arg_28_1)
	arg_28_1:OnRenderModule({
		servantData = self:GetServantData(),
		heroId = self:GetHeroId()
	})
end

function WeaponServantDetailsView:EnterViewOrInst(arg_29_1, arg_29_2)
	if not arg_29_1.view then
		arg_29_1.viewObj = Object.Instantiate(Asset.Load(arg_29_1.uiRootPath), self.pageContainer_)
		arg_29_1.view = arg_29_1.viewPath.New(arg_29_1.viewObj)
	end

	if arg_29_2 then
		for iter_29_0, iter_29_1 in pairs(self.page) do
			if iter_29_1.view then
				if iter_29_1.pageIdx ~= self.data.curPageIdx then
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

function WeaponServantDetailsView:SwitchControllerState(arg_30_1, arg_30_2)
	local var_30_0 = self.controller.comps:GetController(arg_30_1)

	if var_30_0 then
		var_30_0:SetSelectedState(arg_30_2)
	end
end

function WeaponServantDetailsView:GetServantData()
	return self.data.servantData
end

function WeaponServantDetailsView:GetHeroId()
	return self.data.heroId
end

function WeaponServantDetailsView:OnShowBtnClick()
	self:EnterAvatarShow(true)
end

function WeaponServantDetailsView:OnGachaBtnClick()
	local var_34_0 = self:GetServantData()
	local var_34_1

	if not var_34_0 then
		do return end

		var_34_1 = {
			nil,
			"servant"
		}
	end

	var_34_1[1] = var_34_0.id

	ShowPopItemOnly(POP_SOURCE_ITEM, var_34_1)
end

function WeaponServantDetailsView:EnterAvatarShow(arg_35_1)
	self.data.isInAvatarShowView = arg_35_1

	if arg_35_1 then
		manager.windowBar:HideBar()
		manager.heroRaiseTrack:PlayServantAnim("Fade")
		self.constVar.avatarView:EnterAvatarView(true)
		self:SwitchControllerState(self.controller.state.avatarShow.name, self.controller.state.avatarShow.True)
	else
		self:ChangeBar()
		manager.heroRaiseTrack:SetWeaponServantID(self:GetServantData().id)
		manager.heroRaiseTrack:PlayServantAnim("Light")
		self.constVar.avatarView:EnterAvatarView(false)
		self:SwitchControllerState(self.controller.state.avatarShow.name, self.controller.state.avatarShow.False)
	end
end

return WeaponServantDetailsView
