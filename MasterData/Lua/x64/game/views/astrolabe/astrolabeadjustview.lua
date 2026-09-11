local AstrolabeAdjustView = class("AstrolabeAdjustView", ReduxView)

function AstrolabeAdjustView:UIName()
	return "Widget/System/Hero_god/HeroGodDetailUI"
end

function AstrolabeAdjustView:UIParent()
	return manager.ui.uiMain.transform
end

function AstrolabeAdjustView:OnCtor()
	return
end

function AstrolabeAdjustView:Init()
	self:InitUI()
	self:AddListeners()
end

function AstrolabeAdjustView:InitUI()
	self:BindCfgUI()

	self.stateController_ = ControllerUtil.GetController(self.transform_, "state")
	self.infoSGo_ = {}
	self.astrolabeMessageView_ = AstrolabeInfoView.New(self, self.messageGo_)
	self.astrolabeUnlockView_ = AstrolabeUnlockView.New(self, self.unlockinfoGo_)
end

function AstrolabeAdjustView:AddListeners()
	self:AddBtnListener(self.loadBtn_, nil, "ClickBtn")
	self:AddBtnListener(self.equipallBtn_, nil, "ClickBtn")
	self:AddBtnListener(self.canequipBtn_, nil, "ClickBtn")
	self:AddBtnListener(self.unloadBtn_, nil, "ClickBtn")
	self:AddBtnListener(self.hasequipedBtn_, nil, "ClickBtn")
	self:AddBtnListener(self.unequipBtn_, nil, "ClickBtn")
	self:AddBtnListener(self.unlock2Btn_, nil, "ClickBtn")
	self:AddBtnListener(self.spcanequipBtn_, nil, "ClickBtn")
	self:AddBtnListener(self.btn_twoBtn_, nil, function()
		self.heroProxy:AstrolabeUnloadAll(self.params_.heroId)
	end)
end

function AstrolabeAdjustView:ClickEquipallBtn()
	return
end

function AstrolabeAdjustView:ClickHasEquipedBtn()
	return
end

function AstrolabeAdjustView:ClickBtn()
	local var_10_0 = self.lastSelectItem_:GetItemInfo()
	local var_10_1 = HeroAstrolabeCfg[var_10_0.id]

	if self.lastSelectItem_.nodeState == AstrolabeConst.NODE_STATE.LOCK then
		if var_10_1.unlock[1] and not checkGold(var_10_1.unlock[1][2], true) then
			return
		end

		ShowTips("ERROR_ASTROLABE_UNLOCK_CONDITION_NOT_MATCH")
	elseif self.lastSelectItem_.nodeState == AstrolabeConst.NODE_STATE.CANLOCK then
		AstrolabeAction.AstrolabeUnlock(var_10_0.heroId, var_10_0.id)
	elseif self.lastSelectItem_.nodeState == AstrolabeConst.NODE_STATE.UNLOCK then
		if self.isSp then
			local var_10_2 = AstrolabeConst.SPASTROLABE_MAX_NUM or AstrolabeConst.ASTROLABE_MAX_NUM

			if var_10_1.pos == 3 and not self.isSp then
				self.heroProxy:AstrolabeEquipAll(var_10_0.heroId, var_10_1.hero_astrolabe_suit_id)
			else
				if var_10_2 <= self.equipNum_ then
					ShowTips("TIP_ASTROLABE_NUM_MAX")

					return
				end

				if not self.heroProxy:GetLastIsEquiped(var_10_0.id, var_10_0.heroId) then
					ShowTips(string.format(GetTips("TIP_ASTROLABE_FRONT"), GetI18NText(HeroAstrolabeCfg[HeroAstrolabeCfg[var_10_0.id].pre_astrolabe_id].suit_name), GetI18NText(HeroAstrolabeCfg[HeroAstrolabeCfg[var_10_0.id].pre_astrolabe_id].name)))

					return
				end
			end
		end

		self.heroProxy:AstrolabeEquip(var_10_0.heroId, var_10_0.id)
	elseif self.lastSelectItem_.nodeState == AstrolabeConst.NODE_STATE.EQUIPED then
		if self.heroProxy:GetNextIsEquiped(var_10_0.id, var_10_0.heroId) then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("TIP_ASTROLABE_UNINSTALL"),
				OkCallback = function()
					self.heroProxy:AstrolabeUnload(var_10_0.heroId, var_10_0.id)
				end
			})
		else
			self.heroProxy:AstrolabeUnload(var_10_0.heroId, var_10_0.id)
		end
	end
end

function AstrolabeAdjustView:SelectItem(arg_12_1)
	if self.lastSelectItem_ then
		self.lastSelectItem_:ShowSelect(false)
	end

	local var_12_0 = arg_12_1:GetItemInfo()

	arg_12_1:ShowSelect(true)
	self.astrolabeMessageView_:RefreshUI(var_12_0, self.extra_)

	self.lastSelectItem_ = arg_12_1

	self:RefreshState(var_12_0)

	if self.panelAni_ then
		self.panelAni_:Play("Fx_Common_right_cx", 0, 0)
	end
end

function AstrolabeAdjustView:RefreshUI()
	self.heroInfo_ = self.heroProxy:GetHeroData(self.params_.heroId)
	self.isSp = HeroTools.IsSpHero(self.params_.heroId)

	SetActive(self.resetBtnGo_, self:Adjustable())
	self:RefreshAstrolabeInfo()
end

function AstrolabeAdjustView:RefreshAstrolabeInfo()
	if self.heroInfo_ then
		local var_14_0 = self.isSp or self.heroProxy and self.heroProxy.isHideAstrolabeReset

		SetActive(self.btn_twoBtn_.gameObject, not var_14_0)
		SetActive(self.numText_.gameObject, not var_14_0)

		self.equipNum_ = #self.heroInfo_.using_astrolabe

		if not self.isSp then
			self.numText_.text = string.format(GetTips("ASTROLABE_NUM_MAX"), self.equipNum_, AstrolabeConst.ASTROLABE_MAX_NUM)
		end

		self.titleText_.text = self.heroProxy:GetViewDataType() == HeroConst.HERO_DATA_TYPE.PREVIEW and GetTips("ASTROLABE_TITLE_PREVIEW") or GetTips("ASTROLABE_TITLE_COMMON")

		self:RefreshAstrolabeView()
	end
end

function AstrolabeAdjustView:RefreshAstrolabeView()
	if self.heroInfo_ and self.astrolabeInfoView_ then
		if self.params_ and self.params_.isEnter then
			self.astrolabeInfoView_:LoadAstrolabeByPath(AstrolabeTools.GetAstrolabePrafabName(self.heroInfo_.id), self.heroInfo_.id)
			manager.heroRaiseTrack:SetAstrolableAtive(true)
			self.astrolabeInfoView_:PlayAni("TX_GodHood_02", 0, 1)

			self.params_.isEnter = false
		end

		self.astrolabeInfoView_:RefreshAnimationState(AstrolabeConst.AnimationState.AdjustView)
		self.astrolabeInfoView_:RegistCallBack(handler(self, self.SelectItem))
		self.astrolabeInfoView_:SetProxy(self.heroProxy)
		self.astrolabeInfoView_:SetNodeNameIsHide(false)
		self.astrolabeInfoView_:RefreshData(self.heroInfo_, (self:GetAstrolabeInfo(self.heroInfo_.id)))
	end
end

function AstrolabeAdjustView:GetHeroAstrolabeInfoView()
	return HeroAstrolabeInfoView
end

function AstrolabeAdjustView:GetAstrolabeInfo(arg_17_1)
	if self.heroProxy then
		return self.heroProxy:GetHeroAstrolabeS(arg_17_1, self.viewDataType)
	end

	return {}
end

function AstrolabeAdjustView:CanLock()
	if self.viewDataType == HeroConst.HERO_DATA_TYPE.POLYHEDRON then
		return false
	end

	return true
end

function AstrolabeAdjustView:RefreshState(arg_19_1)
	if not self:Adjustable() then
		self.stateController_:SetSelectedState("none")
		self:ChangeBar(false)

		return
	end

	local var_19_0 = HeroAstrolabeCfg[arg_19_1.id]

	if arg_19_1.isUnlock or arg_19_1.isEquiped then
		if arg_19_1.isEquiped then
			if self.isSp then
				if var_19_0.astrolabe_type == 2 then
					self.stateController_:SetSelectedState("sphasEquiped")
				else
					self.stateController_:SetSelectedState("spEquiped")
				end
			else
				self.stateController_:SetSelectedState("unEquip")
			end
		elseif var_19_0.pos == 3 and not self.isSp then
			self.stateController_:SetSelectedState("equipAll")
		elseif var_19_0.astrolabe_type == 2 then
			self.stateController_:SetSelectedState("spcanEquip")
		else
			self.stateController_:SetSelectedState("canEquip")
		end

		self:ChangeBar(false)
	else
		if self.isSp then
			self.stateController_:SetSelectedState("splock")
		elseif self:Adjustable() then
			if arg_19_1.isCanLock then
				self.stateController_:SetSelectedState("lock")
			else
				self.stateController_:SetSelectedState("lock2")
			end

			self.astrolabeUnlockView_:RefreshUI(arg_19_1)
		else
			self.stateController_:SetSelectedState("none")
		end

		self.astrolabeUnlockView_:RefreshUI(arg_19_1)
		self:ChangeBar(true)
	end
end

function AstrolabeAdjustView:PlayHeroTalk(arg_20_1)
	if self.isTalkCD_ then
		return
	end

	HeroTools.PlayTalk(arg_20_1, "echo")

	self.isTalkCD_ = true
	self.talkCDTimer_ = Timer.New(function()
		self.isTalkCD_ = false
	end, 10, 1)

	self.talkCDTimer_:Start()
end

function AstrolabeAdjustView:OnAstrolabeUnlock(arg_22_1, arg_22_2)
	if isSuccess(arg_22_1.result) then
		self:RefreshUI()
		self.astrolabeMessageView_:RefreshUI(self.lastSelectItem_:GetItemInfo())
		self:RefreshState(self.lastSelectItem_:GetItemInfo())
		self.astrolabeUnlockView_:OnAstrolabeUnlock(arg_22_1, arg_22_2)

		if self.astrolabeInfoView_ then
			self.astrolabeInfoView_:RefreshRedPoint()
		end
	else
		ShowTips(arg_22_1.result)
	end
end

function AstrolabeAdjustView:OnAstrolabeEquip(arg_23_1, arg_23_2)
	if isSuccess(arg_23_1.result) then
		if arg_23_2.astrolabe_id and HeroAstrolabeCfg[arg_23_2.astrolabe_id] and HeroAstrolabeCfg[arg_23_2.astrolabe_id].astrolabe_type == 2 then
			ShowTips("SP_ASTROLABE_BIND")
		else
			ShowTips("ASTROLABE_BIND")
		end

		self:RefreshUI()
		self.astrolabeMessageView_:RefreshUI(self.lastSelectItem_:GetItemInfo())
		self:RefreshState(self.lastSelectItem_:GetItemInfo())
		self:PlayHeroTalk(self.heroInfo_.id)

		if self.astrolabeInfoView_ then
			self.astrolabeInfoView_:RefreshRedPoint()
		end
	else
		ShowTips(arg_23_1.result)
	end
end

function AstrolabeAdjustView:OnAstrolabeUnload(arg_24_1, arg_24_2)
	if isSuccess(arg_24_1.result) then
		if arg_24_2.astrolabe_id then
			ShowTips("ASTROLABE_UNBIND")
		else
			ShowTips("ASTROLABE_RESET")
		end

		self:RefreshUI()
		self.astrolabeMessageView_:RefreshUI(self.lastSelectItem_:GetItemInfo())
		self:RefreshState(self.lastSelectItem_:GetItemInfo())

		if self.astrolabeInfoView_ then
			self.astrolabeInfoView_:RefreshRedPoint()
		end
	else
		ShowTips(arg_24_1.result)
	end
end

function AstrolabeAdjustView:ChangeBar(arg_25_1)
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

function AstrolabeAdjustView:OnBehind()
	if self.astrolabeInfoView_ then
		self.astrolabeInfoView_:SetAdjustHide(true)
	end
end

function AstrolabeAdjustView:OnTop()
	if self.astrolabeInfoView_ then
		self.astrolabeInfoView_:CheckadjustHide()
	end

	if self.lastSelectItem_ then
		if self.heroInfo_ and self.astrolabeInfoView_ then
			self.astrolabeInfoView_:RefreshData(self.heroInfo_, (self:GetAstrolabeInfo(self.heroInfo_.id)))
		end

		local var_27_0 = self.lastSelectItem_:GetItemInfo()

		if var_27_0 ~= nil and not var_27_0.isUnlock then
			self.astrolabeUnlockView_:RefreshCost()
			self:RefreshState(var_27_0)
		end
	end

	if self.astrolabeInfoView_ then
		self.astrolabeInfoView_:CheckadjustHide()
		self.astrolabeInfoView_:RefreshRedPoint()
	end
end

function AstrolabeAdjustView:OnEnter()
	self.heroProxy = self.params_.heroProxy or HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
	self.viewDataType = self.heroProxy.viewDataType or HeroConst.HERO_DATA_TYPE.DEFAULT
	self.astrolabeInfoView_ = manager.heroRaiseTrack.astrolableController

	if self.panelAni_ then
		self.panelAni_:Play("Fx_Common_right_cx", 0, 0)
	end

	self:ShowDefaultBar()
	self:RefreshUI()

	if self.astrolabeUnlockView_ then
		self.astrolabeUnlockView_:SetProxy(self.heroProxy)
	end

	if self.astrolabeMessageView_ then
		self.astrolabeMessageView_:SetProxy(self.heroProxy)
	end

	local var_28_0 = self.params_.selectPos

	if self.params_.selectPos and var_28_0[1] ~= 0 then
		self:SelectItem(self.astrolabeInfoView_:GetItem(var_28_0[1], var_28_0[2]))
	else
		self:SelectItem(self.astrolabeInfoView_:GetFirstSelectItem())
	end
end

function AstrolabeAdjustView:CameraEnter()
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		5,
		1
	}, false)
end

function AstrolabeAdjustView:OnExit()
	manager.windowBar:HideBar()

	if self.lastSelectItem_ then
		self.lastSelectItem_:ShowSelect(false)

		self.lastSelectItem_ = nil
	end

	if self.astrolabeUnlockView_ then
		self.astrolabeUnlockView_:OnExit()
	end

	if self.talkCDTimer_ then
		self.talkCDTimer_:Stop()

		self.talkCDTimer_ = nil
	end

	self.isTalkCD_ = nil
end

function AstrolabeAdjustView:Adjustable()
	if self.viewDataType == HeroConst.HERO_DATA_TYPE.PREVIEW then
		return false
	end

	if self.viewDataType == HeroConst.HERO_DATA_TYPE.FOREIGN then
		return false
	end

	if self.viewDataType == HeroConst.HERO_DATA_TYPE.ADVANCETEST then
		return false
	end

	return true
end

function AstrolabeAdjustView:Dispose()
	AstrolabeAdjustView.super.Dispose(self)

	if self.astrolabeMessageView_ then
		self.astrolabeMessageView_:Dispose()

		self.astrolabeMessageView_ = nil
	end

	if self.astrolabeUnlockView_ then
		self.astrolabeUnlockView_:Dispose()

		self.astrolabeUnlockView_ = nil
	end
end

return AstrolabeAdjustView
