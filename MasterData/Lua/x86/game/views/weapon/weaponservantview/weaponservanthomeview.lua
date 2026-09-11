local WeaponServantHomeView = class("WeaponServantHomeView", ReduxView)

function WeaponServantHomeView:CameraEnter()
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		HeroRaiseTrackConst.HeroRaiseType.weapon,
		2,
		HeroRaiseTrackConst.HeroServantType.servant
	})
	manager.heroRaiseTrack:PlayServantAnim("Fade")
end

function WeaponServantHomeView:UIName()
	return "Widget/System/Hero_servant/HeroServantUI"
end

function WeaponServantHomeView:UIParent()
	return manager.ui.uiMain.transform
end

function WeaponServantHomeView:BuildContext()
	self.controller = {
		comps = self.gameObject_:GetComponent("ControllerExCollection"),
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
	self.singleton = {
		viewDetail = WeaponServantMainDetailModule.New(self.mainDetailsObj_),
		listView = {
			viewHold = {
				viewModulePath = "game.views.weapon.WeaponServantView.ServantHoldListViewModule",
				detailBtnStyle = 1,
				uiRootPath = "Widget/System/Hero_servant/Module/HoldListViewModule",
				pageIdx = 1,
				detailNoHeroBtnStyle = 3,
				onServantItemClick = function(arg_5_0)
					self:onHoldItemClick(arg_5_0)
				end,
				OnRefresh = function()
					self:OnHoldBtnClick()
				end
			},
			viewCallName = {
				viewModulePath = "game.views.weapon.WeaponServantView.ServantCallNameListViewModule",
				detailBtnStyle = 2,
				uiRootPath = "Widget/System/Hero_servant/Module/CallNameListViewModule",
				pageIdx = 2,
				detailNoHeroBtnStyle = 2,
				onServantItemClick = function(arg_7_0)
					self:onCallNameItemClick(arg_7_0)
				end,
				OnRefresh = function()
					self:OnCallNameBtnClick()
				end
			}
		},
		viewFullList = {
			detailBtnStyle = 1,
			detailNoHeroBtnStyle = 3,
			uiRootPath = "Widget/System/Hero_servant/Module/FullScreenServantView",
			viewModulePath = "game.views.weapon.WeaponServantView.WeaponServantFullListViewModule",
			onServantItemClick = function(arg_9_0)
				self:onFullListItemClick(arg_9_0)
			end
		},
		avatarView = ServantAvatarViewModule.New(self.scaleImageObj_)
	}

	self.singleton.viewDetail:RegisteCallNameClickCallback(handler(self, self.onCallNameClick))
end

function WeaponServantHomeView:InitContext()
	local var_10_0 = {
		curViewIdx = 0,
		heroId = 0,
		isOpen = true,
		isOnFullScreenView = false,
		isInAvatarShowView = false,
		isTalkCD = false
	}

	var_10_0.state = self.params_.state or "onlydetail"

	local var_10_1 = {}

	var_10_1.isCustom = self.params_.customServant or false
	var_10_1.data = self.params_.customServant
	var_10_0.custom = var_10_1
	self.data = var_10_0
end

function WeaponServantHomeView:Init()
	self:BindCfgUI()
	self:BuildContext()
	self:AddUIListener()
end

function WeaponServantHomeView:OnEnter()
	self:InitContext()
	self:AddEventListeners()

	if self.data.custom.isCustom then
		self:EnterCustomPage()
		self:SwitchControllerState(self.controller.state.customPage.name, self.controller.state.customPage.On)
		SetActive(self.contentObj_, false)
		self:ShowBar()

		return
	else
		self:SwitchControllerState(self.controller.state.customPage.name, self.controller.state.customPage.Off)
		SetActive(self.contentObj_, true)

		self.data.heroId = self.params_.HeroID

		self:OnPreOpenPage()
		self:RefreshTabCount()
		self:ShowBar()
	end
end

function WeaponServantHomeView:ShowBar()
	if not self.data.isOpen then
		return
	end

	if self.data.custom.isCustom then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	else
		local var_13_0 = {
			BACK_BAR,
			HOME_BAR,
			INFO_BAR
		}

		if self.data and self.data.curViewIdx == 2 then
			table.insert(var_13_0, CurrencyConst.CURRENCY_TYPE_GOLD)
			manager.windowBar:SwitchBar(var_13_0)
			manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_GOLD, true)
		else
			manager.windowBar:SwitchBar(var_13_0)
			manager.windowBar:RegistBackCallBack(function()
				self:OnBackBtnClick()
			end)
		end

		manager.windowBar:SetGameHelpKey("SERVANT_AWAKE_DESC_1")
	end
end

function WeaponServantHomeView:EnterCustomPage()
	self:OnHoldBtnClick()
end

function WeaponServantHomeView:OnPreOpenPage()
	if not self.params_.tempParams then
		if self.params_.race and self.params_.race ~= 0 then
			self:OnCallNameBtnClick(self.params_.race, self.params_.servantID)
		else
			local var_16_1

			if self.data.heroId then
				var_16_1 = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT):GetHeroServantInfo(self.data.heroId)

				self:OnHoldBtnClick(var_16_1)
			else
				if self.params_.uid then
					var_16_1 = WeaponServantData:GetServantDataByUID(self.params_.uid)
				end

				self:OnHoldBtnClick(var_16_1)
			end
		end
	else
		local var_16_2 = self.params_.tempParams

		self.data.heroId = self.params_.tempParams.HeroID or nil

		if var_16_2.isFullScreen ~= nil then
			if var_16_2.isFullScreen then
				if var_16_2.servantData.uid then
					if WeaponServantData:GetServantDataByUID(var_16_2.servantData.uid) then
						self:OnFullScreenBtnClick(var_16_2.servantData)
					elseif not self.data.heroId then
						if WeaponServantData:GetServantNum() == 0 then
							self:OnHoldBtnClick()
						else
							self:OnFullScreenBtnClick()
						end
					else
						self:OnFullScreenBtnClick()
					end
				else
					self:OnFullScreenBtnClick(var_16_2.servantData)
				end
			elseif var_16_2.viewIdx == 1 then
				self:OnHoldBtnClick(var_16_2.servantData)
			elseif var_16_2.servantData.id and var_16_2.servantData.id ~= 0 then
				self:OnCallNameBtnClick(self:GetServantRace(var_16_2.servantData.id), var_16_2.servantData.id)
			else
				self:OnCallNameBtnClick()
			end
		else
			self:OnHoldBtnClick((self.data.heroId or nil) and HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT):GetHeroServantInfo(self.data.heroId))
		end
	end

	self.params_.tempParams = nil
end

function WeaponServantHomeView:RecordPageStatus()
	local var_17_0 = {
		isFullScreen = self.data.isOnFullScreenView,
		HeroID = self.data.heroId
	}

	var_17_0.servantData = clone(self.data.curServantData or {})
	var_17_0.viewIdx = self.data.curViewIdx
	self.params_.tempParams = var_17_0
end

function WeaponServantHomeView:OnExit()
	self.data.isOpen = false

	self:RecordPageStatus()

	if self.data.isOnFullScreenView then
		self:EnterFullScreenView(false)
	end

	self:RemoveAllEventListener()

	if self.data.talkCDTimer_ then
		self.data.talkCDTimer_:Stop()

		self.data.talkCDTimer_ = nil
	end

	for iter_18_0, iter_18_1 in pairs(self.singleton.listView) do
		if self.data.curViewIdx == iter_18_1.pageIdx and iter_18_1.viewModule then
			iter_18_1.viewModule:OnExit()
		end
	end

	self.singleton.viewDetail:OnExit()
	manager.windowBar:HideBar()
	self:RemoveNotifyListeners()
end

function WeaponServantHomeView:Dispose()
	self:RemoveAllListeners()
	self:RemoveAllEventListener()
	self.singleton.viewDetail:Dispose()

	if self.singleton.viewFullList.viewModule then
		self.singleton.viewFullList.viewModule:Dispose()
	end

	for iter_19_0, iter_19_1 in pairs(self.singleton.listView) do
		if iter_19_1 and iter_19_1.viewModule then
			iter_19_1.viewObj = nil

			iter_19_1.viewModule:Dispose()

			iter_19_1.viewModule = nil
		end
	end

	self.singleton.avatarView:Dispose()

	self.singleton.avatarView = nil

	if self.data.talkCDTimer_ then
		self.data.talkCDTimer_:Stop()

		self.data.talkCDTimer_ = nil
	end

	WeaponServantHomeView.super.Dispose(self)
end

function WeaponServantHomeView:OnServantReplaced(arg_20_1, arg_20_2, arg_20_3)
	if arg_20_2.servant_id == 0 then
		ShowTips("SUCCESS_REMOVE_SERVANT")
	else
		ShowTips("SUCCESS_EQUIP_SERVANT")
		self:PlayHeroTalk()
	end
end

function WeaponServantHomeView:OnSwitchTo(arg_21_1)
	if self.data.isOnFullScreenView then
		self:EnterFullScreenView(false)
		self:ShowBar()
	end

	local var_21_0 = arg_21_1.openTab

	if arg_21_1.HeroID then
		self.data.heroId = arg_21_1.HeroID
	end

	if arg_21_1.race and arg_21_1.race ~= 0 then
		self:OnCallNameBtnClick(arg_21_1.race, arg_21_1.servantID)
	elseif var_21_0 == "hold" then
		self:OnHoldBtnClick({
			uid = arg_21_1.servantUID
		})
	end
end

function WeaponServantHomeView:AddUIListener()
	self:AddBtnListener(self.holdBtn_, nil, function()
		if self.data.curViewIdx == self.singleton.listView.viewHold.pageIdx then
			return
		end

		self:OnHoldBtnClick()
	end)
	self:AddBtnListener(self.callNameBtn_, nil, function()
		if self.data.curViewIdx == self.singleton.listView.viewCallName.pageIdx then
			return
		end

		self:OnCallNameBtnClick()
	end)
	self:AddBtnListener(self.showIconBtn_, nil, function()
		self:ControlIconScaleClick()
	end)
	self:AddBtnListener(self.showPathBtn_, nil, function()
		self:OnPathClick()
	end)
	self.singleton.avatarView:RegisterCloseCallback(function()
		self:EnterAvatarShow(false)
	end)
end

function WeaponServantHomeView:AddEventListeners()
	self:RegistEventListener(SERVANT_REPLACE, handler(self, self.OnServantReplaced))
	self:RegistEventListener(SERVANT_SWITCH_TO_CALLNAME, handler(self, self.OnSwitchTo))
end

function WeaponServantHomeView:RemoveNotifyListeners()
	return
end

function WeaponServantHomeView:OnHoldBtnClick(arg_30_1)
	self:EnterViewOrInst(self.singleton.listView.viewHold, true)

	if self:IsCustomPage() then
		self.singleton.viewDetail:SwitchBtnStyle(self.singleton.listView.viewHold.detailNoHeroBtnStyle)
		self.singleton.listView.viewHold.viewModule:HideFilter(true)
		self:RefreshHoldServantList()
	else
		self:SwitchControllerState(self.controller.state.selectTab.name, self.controller.state.selectTab.hold)
		self.singleton.listView.viewHold.viewModule:HideFilter(false)
		self.singleton.listView.viewHold.viewModule:RegisterFullScreenCallback(function()
			self:OnFullScreenBtnClick()
		end)
		self:RefreshHoldServantList(arg_30_1)
		self:ShowBar()
	end
end

function WeaponServantHomeView:OnCallNameBtnClick(arg_32_1, arg_32_2)
	self:SwitchControllerState(self.controller.state.selectTab.name, self.controller.state.selectTab.callName)
	self:EnterViewOrInst(self.singleton.listView.viewCallName, true)
	self:RefreshCallNameServantList(arg_32_1, arg_32_2)
	self.singleton.viewDetail:SwitchBtnStyle(self.singleton.listView.viewCallName.detailBtnStyle)
	self:ShowBar()
end

function WeaponServantHomeView:OnBackBtnClick()
	if self.data.isOnFullScreenView then
		self:EnterFullScreenView(false)
		self:RefreshView()
		self:ShowBar()
	else
		self:Back()
	end
end

function WeaponServantHomeView:OnFullScreenBtnClick(arg_34_1)
	self:EnterFullScreenView(true, arg_34_1)

	if self.data.heroId then
		self.singleton.viewDetail:SwitchBtnStyle(self.singleton.viewFullList.detailBtnStyle)
	else
		self.singleton.viewDetail:SwitchBtnStyle(self.singleton.viewFullList.detailNoHeroBtnStyle)
	end
end

function WeaponServantHomeView:ControlIconScaleClick()
	self:EnterAvatarShow(true)
end

function WeaponServantHomeView:OnPathClick()
	local var_36_0

	if not self.data.curServantData then
		do return end

		var_36_0 = {
			nil,
			"servant"
		}
	end

	var_36_0[1] = self.data.curServantData.id

	ShowPopItemOnly(POP_SOURCE_ITEM, var_36_0)
end

function WeaponServantHomeView:onCallNameClick()
	self:OnCallNameBtnClick()
end

function WeaponServantHomeView:onShowEmptyView()
	return
end

function WeaponServantHomeView:PlayHeroTalk()
	if self.data.heroId and self.data.heroId ~= 0 then
		if self.data.isTalkCD then
			return
		end

		HeroTools.PlayTalk(self.data.heroId, "equip")

		self.data.isTalkCD = true
		self.data.talkCDTimer_ = Timer.New(function()
			self.data.isTalkCD = false
		end, 10, 1)

		self.data.talkCDTimer_:Start()
	end
end

function WeaponServantHomeView:SwitchControllerState(arg_41_1, arg_41_2)
	local var_41_0 = self.controller.comps:GetController(arg_41_1)

	if var_41_0 then
		var_41_0:SetSelectedState(arg_41_2)
	end
end

function WeaponServantHomeView:IsCustomPage()
	return self.data.custom.isCustom
end

function WeaponServantHomeView:onHoldItemClick(arg_43_1)
	self:SelectServant(arg_43_1)
end

function WeaponServantHomeView:onCallNameItemClick(arg_44_1)
	self:SelectServant(arg_44_1)
end

function WeaponServantHomeView:onFullListItemClick(arg_45_1)
	self:SelectServant(arg_45_1)
end

function WeaponServantHomeView:SelectServant(arg_46_1)
	if not arg_46_1 then
		return
	end

	self.data.curServantData = arg_46_1

	self.singleton.viewDetail:OnRenderServant(arg_46_1, self.data.heroId)

	if not self.data.isOnFullScreenView then
		manager.heroRaiseTrack:SetWeaponServantID(arg_46_1.id)
	end

	self.singleton.avatarView:SetAvatarSprite(arg_46_1.id)
end

function WeaponServantHomeView:RefreshView()
	for iter_47_0, iter_47_1 in pairs(self.singleton.listView) do
		if self.data.curViewIdx == iter_47_1.pageIdx then
			if iter_47_1.OnRefresh then
				iter_47_1.OnRefresh()

				break
			end
		end
	end
end

function WeaponServantHomeView:RefreshHoldServantList(arg_48_1)
	local var_48_0

	if arg_48_1 then
		var_48_0 = arg_48_1.uid
	end

	local var_48_1 = self.singleton.listView.viewHold

	self.singleton.listView.viewHold.viewModule:RefreshList({
		custom = self.data.custom,
		heroId = self.data.heroId,
		jumpUid = var_48_0,
		emptyCallback = function(arg_49_0)
			if arg_49_0 then
				self:SwitchControllerState(self.controller.state.emptyView.name, self.controller.state.emptyView.True)
				manager.heroRaiseTrack:PlayServantAnim("Fade")
			else
				self:SwitchControllerState(self.controller.state.emptyView.name, self.controller.state.emptyView.False)
				manager.heroRaiseTrack:PlayServantAnim("Light")

				local var_49_0 = self.singleton.viewDetail

				if self.data.heroId and self.data.heroId ~= 0 or self.data.state == "onlybeyond" then
					var_49_0:SwitchBtnStyle(var_48_1.detailBtnStyle)
				else
					var_49_0:SwitchBtnStyle(var_48_1.detailNoHeroBtnStyle)
				end
			end
		end
	})
end

function WeaponServantHomeView:RefreshCallNameServantList(arg_50_1, arg_50_2)
	self.singleton.listView.viewCallName.viewModule:EnterPage({
		heroId = self.data.heroId,
		race = arg_50_1,
		servantID = arg_50_2
	})
	self:SwitchControllerState(self.controller.state.emptyView.name, self.controller.state.emptyView.False)
	manager.heroRaiseTrack:PlayServantAnim("Light")
end

function WeaponServantHomeView:RefreshFullListServantList(arg_51_1)
	if self.singleton.viewFullList.viewModule then
		self.singleton.viewFullList.viewModule:RefreshList({
			heroId = self.data.heroId,
			jumpUid = (arg_51_1 or nil) and arg_51_1.uid
		})
	end
end

function WeaponServantHomeView:EnterFullScreenView(arg_52_1, arg_52_2)
	self.data.isOnFullScreenView = arg_52_1

	if arg_52_1 then
		self:EnterFullListOrInst()
		self:RefreshFullListServantList(arg_52_2)
		self:SwitchControllerState(self.controller.state.inFullScreen.name, self.controller.state.inFullScreen.True)
		self.singleton.viewFullList.viewModule:OnEnter()
		manager.heroRaiseTrack:PlayServantAnim("Fade")
	else
		self:SwitchControllerState(self.controller.state.inFullScreen.name, self.controller.state.inFullScreen.False)

		if self.singleton.viewFullList.viewModule then
			self.singleton.viewFullList.viewModule:OnExit()
		end

		manager.heroRaiseTrack:PlayServantAnim("Light")

		if self.data.curServantData then
			manager.heroRaiseTrack:SetWeaponServantID(self.data.curServantData.id)
			self:OnHoldBtnClick()
			self:RefreshTabCount()
		end
	end
end

function WeaponServantHomeView:RefreshTabCount()
	self:RefreshCallNameCount()
	self:RefreshFullServantCount()
end

function WeaponServantHomeView:RefreshCallNameCount()
	local var_54_0 = 0

	for iter_54_0, iter_54_1 in pairs((WeaponServantData:GetWeaponServantList())) do
		if WeaponServantCfg[iter_54_1.id].type == 3 then
			var_54_0 = var_54_0 + 1
		end
	end

	self.callNameNumTxt_.text = var_54_0
end

function WeaponServantHomeView:RefreshFullServantCount()
	self.haveNumTxt_.text = table.concat({
		ServantTools.GetServantShowCount(),
		"/",
		GameSetting.max_weapon_servant.value[1]
	})
end

function WeaponServantHomeView:EnterFullListOrInst()
	self:InstView(self.singleton.viewFullList, self.fullPageContainer_)
end

function WeaponServantHomeView:EnterViewOrInst(arg_57_1, arg_57_2)
	self:InstView(arg_57_1, self.pageContainer_)

	local var_57_0 = self.data.curViewIdx

	self.data.curViewIdx = arg_57_1.pageIdx

	local var_57_1

	if arg_57_2 then
		for iter_57_0, iter_57_1 in pairs(self.singleton.listView) do
			if iter_57_1.viewModule then
				if iter_57_1.pageIdx ~= self.data.curViewIdx then
					iter_57_1.viewObj:SetActive(false)
				else
					iter_57_1.viewObj:SetActive(true)
				end

				if iter_57_1.pageIdx == var_57_0 then
					var_57_1 = iter_57_1.viewModule
				end
			end
		end

		if var_57_0 ~= self.data.curViewIdx then
			if var_57_1 then
				var_57_1:OnExit()
			end

			arg_57_1.viewModule:OnEnter()
		end
	else
		arg_57_1.viewObj:SetActive(true)
	end
end

function WeaponServantHomeView:InstView(arg_58_1, arg_58_2, arg_58_3)
	if not arg_58_1.viewModule then
		arg_58_1.viewObj = Object.Instantiate(Asset.Load(arg_58_1.uiRootPath), arg_58_2)
		arg_58_1.viewModule = import(arg_58_1.viewModulePath).New(arg_58_1.viewObj)

		if arg_58_1.onServantItemClick then
			arg_58_1.viewModule:RegisterClickCallback(arg_58_1.onServantItemClick)
		end
	end
end

function WeaponServantHomeView:GetServantRace(arg_59_1)
	if arg_59_1 then
		return WeaponServantCfg[arg_59_1].race
	else
		return 1
	end
end

function WeaponServantHomeView:EnterAvatarShow(arg_60_1)
	self.data.isInAvatarShowView = arg_60_1

	if arg_60_1 then
		manager.windowBar:HideBar()
		manager.heroRaiseTrack:PlayServantAnim("Fade")
		self.singleton.avatarView:EnterAvatarView(true)
		self:SwitchControllerState(self.controller.state.avatarShow.name, self.controller.state.avatarShow.True)
	else
		self:ShowBar()
		manager.windowBar:RegistBackCallBack(function()
			self:OnBackBtnClick()
		end)

		if not self.data.isOnFullScreenView then
			manager.heroRaiseTrack:SetWeaponServantID(self.data.curServantData.id)
			manager.heroRaiseTrack:PlayServantAnim("Light")
		end

		self.singleton.avatarView:EnterAvatarView(false)
		self:SwitchControllerState(self.controller.state.avatarShow.name, self.controller.state.avatarShow.False)
		self:RestoreListPostion()
	end
end

function WeaponServantHomeView:RestoreListPostion()
	for iter_62_0, iter_62_1 in pairs(self.singleton.listView) do
		if self.data.curViewIdx == iter_62_1.pageIdx and iter_62_1.viewModule then
			iter_62_1.viewModule:RestoreListPostion()
		end
	end
end

return WeaponServantHomeView
