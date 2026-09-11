local WeaponView = class("WeaponView", ReduxView)

function WeaponView:UIName()
	return "Widget/System/Hero_key/HeroKeyDetailsUI"
end

function WeaponView:UIParent()
	return manager.ui.uiMain.transform
end

function WeaponView:buildContext()
	self.context = {
		controllerWrap = {
			comps = self.gameObject_:GetComponent("ControllerExCollection"),
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
				OnEnter = handler(self, self.SwitchToDetailTab)
			},
			{
				btnState = "selectUp",
				OnEnter = handler(self, self.SwitchToLvUpTab)
			}
		},
		data = {
			heroId = 0,
			curPageIdx = 0,
			proxyTag = 0,
			weaponInfo = {}
		},
		syntheiseHandle = handler(self, self.OnSynthesiseSuccess)
	}
	self.pageView = {
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

function WeaponView:InitContext()
	local var_4_0 = self.params_.type or HeroConst.HERO_DATA_TYPE.DEFAULT

	self.data = {
		heroId = 0,
		curPageIdx = 0,
		proxyTag = 0,
		curTabIdx = -1,
		weaponInfo = {},
		type = var_4_0,
		dataPorxy = HeroViewDataProxy.New(var_4_0)
	}
end

function WeaponView:Init()
	self:BindCfgUI()
	self:buildContext()
	self:AddUIListener()
	self:AddEventListeners()
end

function WeaponView:OnEnter()
	manager.notify:RegistListener(ON_SYNTHESISE_USE_ITEM_SUCCESS, self.context.syntheiseHandle)

	for iter_6_0, iter_6_1 in pairs(self.pageView) do
		if iter_6_1.view then
			iter_6_1.view:OnEnter()
		end
	end

	local var_6_0 = 1

	if self.params_.state and self.params_.state == "strength" then
		var_6_0 = 2
	end

	self:InitContext()
	self:SetHeroId(self.params_.HeroID)
	self:UpdateWeaponInfo()
	self:ResetWeaponView()
	self:BuildTabDesc()
	self:SwitchToTab(var_6_0, true)
end

function WeaponView:CameraEnter()
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		HeroRaiseTrackConst.HeroRaiseType.weapon,
		1,
		HeroRaiseTrackConst.HeroServantType.weapon
	}, self.displayGo_)
end

function WeaponView:OnExit()
	manager.notify:RemoveListener(ON_SYNTHESISE_USE_ITEM_SUCCESS, self.context.syntheiseHandle)

	for iter_8_0, iter_8_1 in pairs(self.pageView) do
		if iter_8_1.view then
			iter_8_1.view:OnExit()
		end
	end

	manager.windowBar:HideBar()
end

function WeaponView:DisposeContext()
	self.context.controllerWrap.comps = nil

	for iter_9_0, iter_9_1 in pairs(self.pageView) do
		iter_9_1.viewObj = nil

		if iter_9_1.view then
			iter_9_1.view:Dispose()

			iter_9_1.view = nil
		end
	end
end

function WeaponView:Dispose()
	self:DisposeContext()
	self:RemoveAllListeners()
	WeaponView.super.Dispose(self)
end

function WeaponView:AddEventListeners()
	self:RegistEventListener(CURRENCY_UPDATE, function(arg_12_0)
		if arg_12_0 == CurrencyConst.CURRENCY_TYPE_GOLD then
			self:OnGoldChange()
		end
	end)
	self:RegistEventListener(WEAPON_BREAK, function()
		self:OnWeaponBreak()
		self:ChangeWindowBar()
	end)
	self:RegistEventListener(WEAPON_STR, function()
		self:OnWeaponLvUp()
		self:ChangeWindowBar()
	end)
	self:RegistEventListener(WEAPON_QUICK, function(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
		self:OnWeaponQuick(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
		self:ChangeWindowBar()
	end)
end

function WeaponView:AddUIListener()
	for iter_16_0 = 1, 2 do
		self:AddToggleListener(self[string.format("tabToggle%d_", iter_16_0)], function(arg_17_0)
			if self.data.curTabIdx == iter_16_0 then
				return
			end

			self:OnTabSwitch(iter_16_0, arg_17_0)
		end)
	end
end

function WeaponView:OnTabSwitch(arg_18_1, arg_18_2)
	if arg_18_2 then
		self:SwitchToTab(arg_18_1, true)
		OperationRecorder.Record("hero", string.format("weaponPage2%d", arg_18_1))
	end
end

function WeaponView:SwitchToTab(arg_19_1, arg_19_2)
	self.data.curTabIdx = arg_19_1

	for iter_19_0, iter_19_1 in pairs(self.context.tabGroup) do
		if iter_19_0 == arg_19_1 then
			self:SwitchControllerState(self.context.tabGroup[iter_19_0].btnState, "true")

			if arg_19_2 then
				self.context.tabGroup[iter_19_0].OnEnter(true)
			end
		else
			self:SwitchControllerState(self.context.tabGroup[iter_19_0].btnState, "false")
		end
	end
end

function WeaponView:OnWeaponBreak()
	self:ShowBreakTips()
	self:UpdateWeaponInfo()
	self:SwitchToTab(2, false)
	self:SwitchToView(self.pageView.lvupView, true)
	self:BuildTabDesc()
end

function WeaponView:OnWeaponLvUp()
	self:UpdateWeaponInfo()

	local var_21_0 = self.data.weaponInfo
	local var_21_1 = GameSetting.weapon_exp_limit.value[self.data.weaponInfo.breakthrough + 1]

	if self.data.weaponInfo.level == HeroConst.WEAPON_LV_MAX then
		self:SwitchToTab(1, true)
	elseif var_21_0.level == var_21_1 then
		self:SwitchToTab(2, false)
		self:SwitchToView(self.pageView.breakView, true)
	end

	self:BuildTabDesc()
end

function WeaponView:OnWeaponQuick(arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	if arg_22_2.breakthrough_times > 0 then
		self:ShowQuickBreakTips(arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	else
		self:OpenLvUpPop(arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	end

	self:UpdateWeaponInfo()

	local var_22_0 = self.data.weaponInfo
	local var_22_1 = GameSetting.weapon_exp_limit.value[self.data.weaponInfo.breakthrough + 1]

	if self.data.weaponInfo.level == HeroConst.WEAPON_LV_MAX then
		self:SwitchToTab(1, true)
	elseif var_22_0.level == var_22_1 then
		self:SwitchToTab(2, false)
		self:SwitchToView(self.pageView.breakView, true)
	else
		self:SwitchToTab(2, false)
		self:SwitchToView(self.pageView.lvupView, true)
	end

	self:BuildTabDesc()
end

function WeaponView:ShowQuickBreakTips(arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	JumpTools.OpenPageByJump("weaponOneKeyStr", {
		isBreak = true,
		oriLv = arg_23_4,
		afterLv = arg_23_2.target_level,
		heroID = self.data.heroId,
		beforeBreak = arg_23_3,
		afterBreak = arg_23_3 + arg_23_2.breakthrough_times,
		beforeLevel = arg_23_4,
		afterLevel = arg_23_2.target_level,
		callback = function()
			getReward(formatRewardCfgList(arg_23_1.mat_list))
		end
	})
end

function WeaponView:OpenLvUpPop(arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	JumpTools.OpenPageByJump("weaponOneKeyStr", {
		isBreak = false,
		oriLv = arg_25_4,
		afterLv = arg_25_2.target_level,
		beforeBreak = arg_25_3,
		afterBreak = arg_25_3 + arg_25_2.breakthrough_times,
		callback = function()
			getReward(formatRewardCfgList(arg_25_1.mat_list))
		end
	})
end

function WeaponView:ShowBreakTips()
	JumpTools.OpenPageByJump("weaponBreak", {
		heroID = self.data.heroId,
		breakthrough = self.data.weaponInfo.breakthrough
	})
end

function WeaponView:OnSynthesiseSuccess()
	self:OnGoldChange()
end

function WeaponView:SwitchControllerState(arg_29_1, arg_29_2)
	local var_29_0 = self.context.controllerWrap.comps:GetController(arg_29_1)

	if var_29_0 then
		var_29_0:SetSelectedState(arg_29_2)
	end
end

function WeaponView:ResetWeaponView()
	local var_30_0 = self:GetHeroId()

	if var_30_0 and var_30_0 ~= 0 then
		manager.heroRaiseTrack:SetModelState(HeroTools.HeroUsingSkinInfo(var_30_0).id)
	end
end

function WeaponView:BuildTabDesc()
	self.tab2Txt_.text = self:CheckWeaponCanBreakUp() and GetTips("TIP_BREAK") or GetTips("TIP_STRENGTH")
end

function WeaponView:OnGoldChange()
	if self.data.curPageIdx == self.pageView.lvupView.pageIdx then
		self.pageView.lvupView.view:OnGoldChange()
	elseif self.data.curPageIdx == self.pageView.breakView.pageIdx then
		self.pageView.breakView.view:OnGoldChange()
	end
end

function WeaponView:SwitchToDetailTab(arg_33_1)
	self:SwitchToView(self.pageView.detailView, arg_33_1)
end

function WeaponView:SwitchToLvUpTab(arg_34_1)
	if self:CheckWeaponCanBreakUp() then
		self:SwitchToView(self.pageView.breakView, arg_34_1)
	else
		self:SwitchToView(self.pageView.lvupView, arg_34_1)
	end
end

function WeaponView:IsMeetShowBar(arg_35_1)
	if not arg_35_1 or not arg_35_1.barCurrency then
		return false
	end

	if arg_35_1.pageIdx == 2 then
		local var_35_0 = self:GetWeaponInfo()

		if var_35_0 then
			return var_35_0.level ~= HeroConst.WEAPON_LV_MAX
		else
			return false
		end
	end

	return true
end

function WeaponView:OnTop()
	self:ChangeWindowBar()
end

function WeaponView:ChangeWindowBar(arg_37_1)
	if not arg_37_1 then
		for iter_37_0, iter_37_1 in pairs(self.pageView) do
			if iter_37_1.view and iter_37_1.pageIdx == self.data.curPageIdx then
				arg_37_1 = iter_37_1

				break
			end
		end
	end

	local var_37_0 = {
		BACK_BAR,
		HOME_BAR
	}

	if self:IsMeetShowBar(arg_37_1) then
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

function WeaponView:SwitchToView(arg_38_1, arg_38_2)
	if arg_38_1 then
		self:ChangeWindowBar(arg_38_1)

		if self.data.curPageIdx ~= arg_38_1.pageIdx then
			self.data.curPageIdx = arg_38_1.pageIdx

			self:EnterViewOrInst(arg_38_1, true)
			self:RefreshPageView(arg_38_1.view)
		elseif arg_38_2 then
			self.data.curPageIdx = arg_38_1.pageIdx

			self:EnterViewOrInst(arg_38_1, false)
			self:RefreshPageView(arg_38_1.view)
		end
	end
end

function WeaponView:RefreshPageView(arg_39_1)
	arg_39_1:ShowWeaponInfo(self:GetHeroId(), self:GetWeaponInfo(), self.data.type)
end

function WeaponView:EnterViewOrInst(arg_40_1, arg_40_2)
	if not arg_40_1.view then
		arg_40_1.viewObj = Object.Instantiate(Asset.Load(arg_40_1.uiRootPath), self.pageContainer_)
		arg_40_1.view = import(arg_40_1.viewPath).New(arg_40_1.viewObj)

		arg_40_1.view:OnEnter()
	end

	if arg_40_2 then
		for iter_40_0, iter_40_1 in pairs(self.pageView) do
			if iter_40_1.view then
				if iter_40_1.pageIdx ~= self.data.curPageIdx then
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

function WeaponView:UpdateWeaponInfo()
	local var_41_0 = self:GetHeroId()

	if var_41_0 and var_41_0 ~= 0 then
		self.data.weaponInfo = deepClone(self.data.dataPorxy:GetHeroWeaponInfo(var_41_0))
	end
end

function WeaponView:GetWeaponInfo()
	return self.data.weaponInfo
end

function WeaponView:SetHeroId(arg_43_1)
	self.data.heroId = arg_43_1
end

function WeaponView:GetHeroId()
	return self.data.heroId
end

function WeaponView:GetControllerState()
	return self.context.controllerWrap.state
end

function WeaponView:CheckWeaponCanBreakUp()
	local var_46_0 = self:GetWeaponInfo()

	if var_46_0 then
		if GameSetting.weapon_exp_limit.value[var_46_0.breakthrough + 1] == var_46_0.level and var_46_0.level ~= HeroConst.WEAPON_LV_MAX then
			return true
		end
	else
		return false
	end

	return false
end

return WeaponView
