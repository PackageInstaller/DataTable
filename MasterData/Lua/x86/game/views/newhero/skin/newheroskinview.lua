local NewHeroSkinView = class("NewHeroSkinView", ReduxView)

function NewHeroSkinView:isDlcOwned()
	return self.dlcID_ and self.dlcID_ ~= 0 and ShopTools.CheckDlcPurchased(self.dlcID_) or ShopTools.CheckDlcPurchasedByItemID(self.dlcItemID_)
end

function NewHeroSkinView:isUnlock(arg_2_1)
	return HeroTools.GetHasOwnedSkin(arg_2_1)
end

function NewHeroSkinView:isUnlockOrCanChange(arg_3_1)
	return self:isUnlock(arg_3_1) or HeroTools.CanChangeSkin(arg_3_1)
end

function NewHeroSkinView:isSelect(arg_4_1)
	if HeroTools.HeroUsingSkinInfo(SkinCfg[arg_4_1].hero).id == arg_4_1 then
		return true
	end

	return false
end

function NewHeroSkinView:UIName()
	return "Widget/System/Hero/HeroSkinUI_new"
end

function NewHeroSkinView:UIParent()
	return manager.ui.uiMain.transform
end

function NewHeroSkinView:Init()
	self.skinIdList_ = {}
	self.skinItemList_ = {}
	self.descInfoList_ = {}
	self.btnState_ = nil
	self.skinID_ = 1
	self.selectIndex_ = 1
	self.isCanUnlock_ = false
	self.dlcMovie_ = nil
	self.dlcPlayer_ = nil
	self.dlcBgMovie_ = nil
	self.dlcBgPlayer_ = nil

	self:InitUI()
	self:AddUIListener()
end

function NewHeroSkinView:OnTop()
	self:UpdateBar()
	self:RefreshUIWithOutScroll()

	if self.showDlcState_ == 1 then
		self:RefreshDlcMovie()
	end
end

function NewHeroSkinView:OnBehind()
	if self.showDlcState_ == 1 then
		self:PauseDlcMovie()
	end
end

function NewHeroSkinView:CameraEnter()
	if not self.params_.isBack then
		manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
			1,
			4
		}, self.displayGo_)
	elseif self.showDlcState_ == 1 then
		manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.null)
	else
		manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
			1,
			4
		}, self.displayGo_)
	end
end

function NewHeroSkinView:OnExit()
	self.dlcHideMovieController_:SetSelectedIndex(0)

	if self.delayPlayTimer_ then
		self.delayPlayTimer_:Stop()

		self.delayPlayTimer_ = nil
	end

	self:StopScrollTimer()
	self:StopMovieStopTimer()
	self:StopMovieTimer()
	self:StopMoveTimer()
	self:CleanMessage()
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()
	self:RemoveAllEventListener()
	self.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	self.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.EndDrag)

	if self.dlcMovie_ then
		self.dlcMovie_:Stop()
	end

	if self.dlcBgMovie_ then
		self.dlcBgMovie_:Stop()
	end

	if self.dlcPlayer_ then
		self.dlcPlayer_.statusChangeCallback = nil
	end

	if self.dlcBgPlayer_ then
		self.dlcBgPlayer_.statusChangeCallback = nil
	end

	self.dlcPlayer_ = nil
	self.dlcMovie_ = nil
	self.dlcBgMovie_ = nil
	self.dlcBgPlayer_ = nil
	self.movieSkinId_ = 0

	HeroSkinRouteData:SaveRoute({
		heroID = self.heroID_,
		skinID = self.skinID_
	})
end

function NewHeroSkinView:Dispose()
	if self.delayPlayTimer_ then
		self.delayPlayTimer_:Stop()

		self.delayPlayTimer_ = nil
	end

	if self.battleSkinBtn_ then
		self.battleSkinBtn_:Dispose()

		self.battleSkinBtn_ = nil
	end

	self:RemoveAllListeners()
	self:CleanMessage()

	if self.plotItemList_ then
		for iter_12_0, iter_12_1 in ipairs(self.plotItemList_) do
			iter_12_1:Dispose()
		end

		self.plotItemList_ = nil
	end

	if self.skinItemList_ then
		for iter_12_2, iter_12_3 in ipairs(self.skinItemList_) do
			iter_12_3:Dispose()
		end

		self.skinItemList_ = nil
	end

	NewHeroSkinView.super.Dispose(self)
end

function NewHeroSkinView:InitUI()
	self:BindCfgUI()
	self:InitBtnState()
	self:InitDescBtn()

	self.battleSkinBtn_ = BattleSkinBtnView.New(self.battleSkinBtnGo_)
	self.haveDLCController_ = self.controllerEx_:GetController("haveDLC")
	self.timeController_ = self.controllerEx_:GetController("Time")
	self.giftController_ = self.controllerEx_:GetController("Gift")
	self.plotController_ = self.controllerEx_:GetController("Plot")
	self.infoController_ = self.controllerEx_:GetController("Info")
	self.statusController_ = self.controllerEx_:GetController("Btn")
	self.dlcController_ = self.controllerEx_:GetController("DLC")
	self.dlcBtnController_ = self.controllerEx_:GetController("dlcBtn")
	self.dlcHideMovieController_ = self.controllerEx_:GetController("dlcMovieHide")
	self.cvBtnController_ = self.controllerEx_:GetController("CVtext")
	self.toDownloadDlcController = self.controllerEx_:GetController("toDownloadDlc")
	self.unlockController_ = self.lockControllerEx_:GetController("clear")
	self.taskController_1 = self.lockControllerEx_:GetController("task01")
	self.taskController_2 = self.lockControllerEx_:GetController("task02")
	self.dlc_skinController_ = self.dlc_skinControllerEx_:GetController("get")
	self.dlc_oathGiftController_ = self.dlc_skinControllerEx_:GetController("oathGift")
	self.dlc_dlcController_ = self.dlc_dlcControllerEx_:GetController("get")
	self.buyBtnController_ = self.goBtnControllerEx_:GetController("gift")
	self.buyBtnMultiController_ = self.goBtnControllerEx_:GetController("multiPay")
	self.dlcBtnMultiController_ = self.dlcBtnControllerEx_:GetController("multiPay")
end

function NewHeroSkinView:InitBtnState()
	self.btnState = {
		"btn_now",
		"btn_replace",
		"btn_go",
		"sourcetext",
		"btn_change",
		"unlockinfo",
		"hero_donthave",
		"btn_now_shop",
		"hide",
		"limit_equipped",
		"limit_unequipped",
		"pc_cant_rmb"
	}
end

function NewHeroSkinView:InitDescBtn()
	self.descBtn_ = {
		self.descBtn_1,
		self.descBtn_2,
		self.descBtn_3,
		self.descBtn_4,
		self.descBtn_5,
		self.descBtn_6,
		self.descBtn_7
	}
	self.descBtnGo_ = {}

	for iter_15_0 = 1, 7 do
		self.descBtnGo_[iter_15_0] = self["descBtnGo_" .. iter_15_0]
	end
end

function NewHeroSkinView:CheckIsSpecial()
	if not self.dlcID_ then
		self:SetCurDlcID()
	end

	self.shopDlcCfg = getShopCfg(self.dlcID_)

	if self.shopDlcCfg and self.shopDlcCfg.shop_id == ShopConst.SHOP_ID.PASSPORT_SHOP then
		return 1
	end

	if not self.shopDlcCfg and self.dlcItemID_ and self.showDlcState_ == 1 then
		return 2
	end

	return 0
end

function NewHeroSkinView:SwitchInfoController(arg_17_1)
	self.infoController_:SetSelectedState(arg_17_1)
end

function NewHeroSkinView:CheckIsCanPlayPlot(arg_18_1)
	if arg_18_1 > 0 and not manager.story:IsStoryPlayed(arg_18_1) then
		ShowTips(GetTips("ERROR_HERO_ARCHIVES_PREVIOUS_PLOT_NOT_VIEWED"))

		return false
	end

	return true
end

function NewHeroSkinView:CheckIsShowT0MemoryCoin()
	if ActivitySkinDrawData:GetSkinDrawMainActivityBySkinID(self.skinID_) then
		ActivitySkinDrawData:ShowGetMemoryCoin(self.skinID_)
	end
end

function NewHeroSkinView:IndexPlotItem()
	self.plotItemList_ = self.plotItemList_ or {}

	local var_20_0 = SkinCfg[self.skinID_].plot_id

	for iter_20_0, iter_20_1 in ipairs(self.plotItemList_) do
		SetActive(iter_20_1.gameObject_, false)
	end

	for iter_20_2 = 1, #SkinCfg[self.skinID_].plot_title do
		if not self.plotItemList_[iter_20_2] then
			local var_20_1 = Object.Instantiate(self.plotTalkBtn_.gameObject)
			local var_20_2 = PlotTalkItem.New(var_20_1)

			var_20_1.transform:SetParent(self.plotTalkBasePanelGo_.transform, false)
			var_20_2:SetClickLimitFunc(function(arg_21_0)
				return self:CheckIsCanPlayPlot(arg_21_0)
			end)
			var_20_2:SetCallBack(function()
				self.plotController_:SetSelectedState("off")

				self.isOpenPlotTalk = false
			end)
			var_20_2:SetStoryCallBack(function(arg_23_0)
				manager.ui:SetMainCamera("heroSkin")
				manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
					1,
					4
				}, self.displayGo_)
				manager.heroRaiseTrack:SetModelState(self.skinID_)
				self:UpdateBar()
			end)
			table.insert(self.plotItemList_, var_20_2)
		end

		self.plotItemList_[iter_20_2]:RefreshUI(SkinCfg[self.skinID_].plot_title[iter_20_2], var_20_0[iter_20_2], var_20_0[iter_20_2 - 1] or -1)
		SetActive(self.plotItemList_[iter_20_2].gameObject_, true)
	end
end

function NewHeroSkinView:RefreshCurrencyToken(arg_24_1)
	SetActive(self.tokenGo_, arg_24_1)
	SetActive(self.dlctokenGo_, arg_24_1)
	SetActive(self.tokenNumGo_, arg_24_1)
end

function NewHeroSkinView:RefreshUI()
	manager.redPoint:setTip(RedPointConst.HERO_SKIN_ROUTE_ID .. self.skinID_, 0, RedPointStyle.SHOW_NEW_TAG)
	self:RefreshInfo()
	self:RefreshDlcBtn()
	self:SetButtonActive(self:SkinState(self.skinID_))
	self:RefreshDescBtn()
	self:RefreshGiftBtn()
	self:HideMessage()
	self:RefreshItemData()
	self:RefreshBattleSkinBtn()
	self:RefreshSkinItemList()
	self:RefreshOathUI()
	SetActive(self.plotBtn_, #SkinCfg[self.skinID_].plot_title > 0)

	for iter_25_0, iter_25_1 in ipairs(self.skinItemList_) do
		if iter_25_1.isActive and iter_25_1:GetSkinID() == self.skinID_ then
			self.selectIndex_ = iter_25_0
		end
	end
end

function NewHeroSkinView:RefreshOathUI()
	if OathDrawTools.CheckIsCanBuyOathSkin(self.heroID_, self.skinID_) and not ShopTools.HaveSkin(self.skinID_) then
		self.dlc_oathGiftController_:SetSelectedState("show")

		self.oathGiftImg_.sprite = ItemTools.getItemSprite(OathDrawTools.GetCouponID())
	else
		self.dlc_oathGiftController_:SetSelectedState("hide")
	end
end

function NewHeroSkinView:RefreshSkinItemList()
	if self.skinIdList_ and #self.skinIdList_ > 0 then
		for iter_27_0, iter_27_1 in pairs(self.skinItemList_) do
			iter_27_1:SetActive(false)
		end

		self.battleSkinID_ = HeroData:GetHeroBattleUsingSkinInfo(self.heroID_).id

		for iter_27_2, iter_27_3 in ipairs(self.skinIdList_) do
			local var_27_0

			if self.skinItemList_[iter_27_2] then
				var_27_0 = self.skinItemList_[iter_27_2]
			else
				var_27_0 = self:GetSkinItem()

				table.insert(self.skinItemList_, var_27_0)
				var_27_0:SetDelegate(handler(self, self.RefreshButton))
			end

			var_27_0:Show(self.skinIdList_[iter_27_2], iter_27_2)
			var_27_0:ShowSelect(self.selectIndex_ == iter_27_2)
			var_27_0:CheckDLC(self:JudgeDLC(self.skinIdList_[iter_27_2]))
			var_27_0:ShowBattleSkin(iter_27_3 == self.battleSkinID_)
			var_27_0:SetActive(true)
		end
	end

	self:Scroll2SelectItem(5)
end

function NewHeroSkinView:RefreshDlcBtn()
	self.dlc_skinImage_.sprite = HeroTools.GetHeadSprite(self.skinID_)

	if self:JudgeDLC(self.skinID_) then
		self:SetCurDlcID()

		local var_28_0 = getShopCfg(self.dlcID_)

		if var_28_0 then
			local var_28_1 = var_28_0.give_id or var_28_0.description

			if var_28_1 then
				self.dlc_dlcImage_.sprite = ItemTools.getItemSprite(var_28_1)
			end
		else
			self.dlc_dlcImage_.sprite = ItemTools.getItemSprite(self.dlcItemID_)
		end
	else
		self:SetCurDlcID()
	end
end

function NewHeroSkinView:RefreshLimitTime(arg_29_1)
	local var_29_0 = 0
	local var_29_1 = 0

	for iter_29_0, iter_29_1 in ipairs(HeroData:GetHeroData(self.heroID_).unlocked_skin) do
		if iter_29_1.skin_id == arg_29_1 then
			var_29_0 = iter_29_1.time

			if self:JudgeDLC(arg_29_1) then
				local var_29_2 = HeroTools.GetShopIdBySkinId(arg_29_1)

				if not var_29_2 then
					return false
				end

				local var_29_3 = getShopCfg(var_29_2)
				local var_29_4 = var_29_3 and var_29_3.dlc

				if var_29_3 and var_29_3.dlc and var_29_4 ~= 0 then
					var_29_1 = HomeSceneSettingData:GetSceneTimeStamp(ShopCfg[var_29_4].description) or 0
				end
			end
		end
	end

	self.skinLimitTimeText_.text = var_29_0 ~= 0 and string.format(GetTips("TIME_DISPLAY_12"), os.date("%Y/%m/%d %H:%M", var_29_0) .. " ") or string.format(GetTips("TIME_DISPLAY_12"), os.date("%Y/%m/%d %H:%M", var_29_1) .. " ")

	SetActive(self.LimitTimeGo_, var_29_0 ~= 0 or var_29_1 ~= 0)
	SetActive(self.skinLimitTimeGo_, var_29_0 ~= 0)
	SetActive(self.dlcLimitTimeGo_, var_29_1 ~= 0)
end

function NewHeroSkinView:RefreshItemData()
	self.skinIdList_ = {}

	if self.params_.showOnly and self.params_.skinID then
		table.insert(self.skinIdList_, self.params_.skinID)
	else
		for iter_30_0, iter_30_1 in ipairs(SkinCfg.get_id_list_by_hero[self.heroID_]) do
			if not HeroTools.GetIsSkinHide(iter_30_1) then
				if self:isUnlock(iter_30_1) then
					table.insert(self.skinIdList_, iter_30_1)
				elseif HeroTools.CanChangeSkin(iter_30_1) then
					table.insert(self.skinIdList_, iter_30_1)
				elseif HeroTools.GetIsLimitTimeSkin(iter_30_1) then
					table.insert(self.skinIdList_, iter_30_1)
				elseif SDKTools.GetIsOverSea() then
					table.insert(self.skinIdList_, iter_30_1)
				elseif SkinCfg[iter_30_1].display_type == 1 then
					table.insert(self.skinIdList_, iter_30_1)
				end
			end
		end

		if self.params_.initSkinID and not table.indexof(self.skinIdList_, self.params_.initSkinID) then
			table.insert(self.skinIdList_, self.params_.initSkinID)
		end
	end
end

function NewHeroSkinView:RefreshBattleSkinBtn()
	if self.battleSkinBtn_ == nil then
		return
	end

	if HeroTools.GetSkinIsUnlock(self.skinID_) and self.skinID_ ~= self.heroID_ then
		self.battleSkinBtn_:Show(true)
		self.battleSkinBtn_:RefreshUI(self.heroID_, self.skinID_)
	else
		self.battleSkinBtn_:Show(false)
	end

	self.isBattleSkin_, _ = self.battleSkinBtn_:GetIsBattleSkin()
end

function NewHeroSkinView:CheckDlc(arg_32_1, arg_32_2)
	self.haveDLCController_:SetSelectedIndex(0)

	if self:JudgeDLC(arg_32_1) then
		self.haveDLCController_:SetSelectedIndex(1)
	end
end

function NewHeroSkinView:JudgeDLC(arg_33_1)
	if arg_33_1 == nil then
		return false
	end

	local var_33_0 = HeroTools.GetShopIdBySkinId(arg_33_1)

	if not var_33_0 then
		return false
	end

	local var_33_1 = getShopCfg(var_33_0)

	if var_33_1 and var_33_1.dlc and (var_33_1 and var_33_1.dlc) ~= 0 then
		return true
	end

	local var_33_2 = CustomCenterTools.GetMatchedDLCScene(arg_33_1)

	if var_33_2 and var_33_2.special_scene_id then
		self.dlcItemID_ = var_33_2.special_scene_id

		if HomeSceneSettingCfg[var_33_2.special_scene_id] and HomeSceneSettingCfg[var_33_2.special_scene_id].limit_display == 0 then
			return true
		end
	end

	return false
end

function NewHeroSkinView:SetCurDlcID()
	local var_34_0 = getShopCfg((HeroTools.GetShopIdBySkinId(self.skinID_)))

	self.dlcID_ = var_34_0 and var_34_0.dlc

	if self.dlcID_ and self.dlcID_ ~= 0 then
		local var_34_1, var_34_2, var_34_3 = ShopTools.IsOnDiscountArea(self.dlcID_)
		local var_34_4 = ShopTools.HasMultiPay(self.dlcID_)

		self.buyBtnMultiController_:SetSelectedIndex(0)

		if var_34_4 then
			self.buyBtnController_:SetSelectedIndex(2)
		elseif ShopTools.GetDiscount(self.dlcID_) == 0 and var_34_1 and var_34_3 then
			self.buyBtnController_:SetSelectedIndex(1)
		else
			self.buyBtnController_:SetSelectedIndex(0)
		end

		self.dlcBtnMultiController_:SetSelectedState(tostring(var_34_4))
	else
		self.buyBtnController_:SetSelectedIndex(0)
	end

	local var_34_5 = CustomCenterTools.GetDLCScene(self.skinID_)

	if var_34_5 and var_34_5.special_scene_id then
		self.dlcItemID_ = var_34_5.special_scene_id
	end
end

function NewHeroSkinView:CheckSpecicalTable(arg_35_1, arg_35_2)
	for iter_35_0 = 1, #arg_35_1 do
		if arg_35_1[iter_35_0] ~= arg_35_2[iter_35_0] then
			return false
		end
	end

	return true
end

function NewHeroSkinView:ChangeDlcBtnSpecial()
	local var_36_0 = {
		self:isUnlock(self.skinID_) and 1 or 0,
		self:isDlcOwned() and 1 or 0,
		self.showDlcState_
	}

	if self:CheckSpecicalTable(var_36_0, {
		0,
		0,
		0
	}) then
		self:SetButtonActive(3)
		self.dlcBtnController_:SetSelectedIndex(0)
	elseif self:CheckSpecicalTable(var_36_0, {
		0,
		0,
		1
	}) then
		self:SetButtonActive(3)
		self.dlcBtnController_:SetSelectedIndex(2)
	elseif self:CheckSpecicalTable(var_36_0, {
		0,
		1,
		0
	}) then
		self:SetButtonActive(3)
		self.dlcBtnController_:SetSelectedIndex(0)
	elseif self:CheckSpecicalTable(var_36_0, {
		0,
		1,
		1
	}) then
		self:SetButtonActive(3)
		self.dlcBtnController_:SetSelectedIndex(3)
	elseif self:CheckSpecicalTable(var_36_0, {
		1,
		0,
		0
	}) then
		self:SetButtonActive(8)
		self.dlcBtnController_:SetSelectedIndex(2)
	elseif self:CheckSpecicalTable(var_36_0, {
		1,
		0,
		1
	}) then
		self:SetButtonActive(9)
		self.dlcBtnController_:SetSelectedIndex(2)
	elseif self:CheckSpecicalTable(var_36_0, {
		1,
		1,
		0
	}) then
		self:SetButtonActive(8)
		self.dlcBtnController_:SetSelectedIndex(0)
	elseif self:CheckSpecicalTable(var_36_0, {
		1,
		1,
		1
	}) then
		self:SetButtonActive(8)
		self.dlcBtnController_:SetSelectedIndex(0)
	end
end

function NewHeroSkinView:HaveMaterial()
	local var_37_0 = getShopCfg(HeroTools.GetShopIdBySkinId(self.skinID_))

	return ItemCfg[var_37_0.cost_id], ItemTools.getItemNum(var_37_0.cost_id)
end

function NewHeroSkinView:RefreshDescBtn()
	self.typeNum_ = 0
	self.typeDes_ = {}

	SetActive(self.battleBtn_.gameObject, false)

	if not SkinTagCfg[self.skinID_] then
		for iter_38_0, iter_38_1 in ipairs(self.descBtnGo_) do
			SetActive(iter_38_1, false)
			self:SwitchInfoController("description")
			SetActive(self.switchInfoIconGo_, false)

			self.switchInfoBtn_.interactable = false

			return
		end
	end

	for iter_38_2, iter_38_3 in ipairs(SkinTagCfg[self.skinID_].tag) do
		if not self.typeDes_[SkinTagDescCfg[iter_38_3].type] then
			self.typeDes_[SkinTagDescCfg[iter_38_3].type] = {}
			self.typeNum_ = self.typeNum_ + 1
		end

		table.insert(self.typeDes_[SkinTagDescCfg[iter_38_3].type], iter_38_3)
	end

	for iter_38_4, iter_38_5 in ipairs(self.descBtnGo_) do
		SetActive(iter_38_5, self.typeDes_[iter_38_4] ~= nil)
	end

	if self.typeNum_ == 0 then
		self:SwitchInfoController("description")
		SetActive(self.switchInfoIconGo_, false)

		self.switchInfoBtn_.interactable = false
	else
		self:SwitchInfoController("tag")
		SetActive(self.switchInfoIconGo_, true)

		self.switchInfoBtn_.interactable = true
	end
end

function NewHeroSkinView:OnShopBuyResult()
	self:RefreshUI()
end

function NewHeroSkinView:OnGetSkinGift()
	self:RefreshUI()
end

function NewHeroSkinView:RefreshGiftBtn()
	local var_41_1 = (SkinCfg[self.skinID_] or {}).gift or {}

	if #var_41_1 > 0 and PlayerData:IsNotReceived(self.skinID_) then
		SetActive(self.giftBtn_, true)
	end

	local var_41_2

	do
		SetActive(self.giftBtn_, false)

		var_41_2 = #var_41_1 > 0 and self:isUnlock(self.skinID_) and PlayerData:IsNotReceived(self.skinID_)
	end

	SetActive(self.giftRedGo_, var_41_2)
	self.giftController_:SetSelectedState(self:isUnlock(self.skinID_) and "take" or "check")
end

function NewHeroSkinView:HideMessage()
	SetActive(self.descPanel_, false)
end

function NewHeroSkinView:ShowMessage()
	local var_43_0 = 0

	for iter_43_0, iter_43_1 in pairs(self.descInfoList_) do
		var_43_0 = var_43_0 + 1
	end

	if var_43_0 == 0 then
		for iter_43_2, iter_43_3 in pairs(self.typeDes_) do
			self.descInfoList_[iter_43_2] = SkinDescInfoItem.New(Object.Instantiate(self.descContent_, self.descTipsContent_), iter_43_3, iter_43_2)

			self.descInfoList_[iter_43_2]:RefreshUI()
			self.descInfoList_[iter_43_2]:Show(true)
			LayoutRebuilder.ForceRebuildLayoutImmediate(self.descPanelRect_)
		end
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(self.descPanelRect_)
	SetActive(self.descPanel_, true)
	SetActive(self.hideMessageGo_, true)
	LayoutRebuilder.ForceRebuildLayoutImmediate(self.descPanelRect_)
end

function NewHeroSkinView:CleanMessage()
	for iter_44_0, iter_44_1 in pairs(self.descInfoList_) do
		iter_44_1:Dispose()
	end

	self.descInfoList_ = {}
end

function NewHeroSkinView:PlayVoice()
	if self.delayPlayTimer_ then
		return
	end

	HeroTools.PlayVoice(self.heroID_, "cloth")

	self.delayPlayTimer_ = Timer.New(function()
		if self.delayPlayTimer_ then
			self.delayPlayTimer_:Stop()

			self.delayPlayTimer_ = nil
		end
	end, 10, -1)

	self.delayPlayTimer_:Start()
end

function NewHeroSkinView:SetReturnBtn(arg_47_1)
	SetActive(self.hideMessageGo_, true)
	self:RemoveBtnListener(nil, self.hideMessageBtn_.transform)
	self:AddBtnListener(self.hideMessageBtn_, nil, function()
		arg_47_1()
		SetActive(self.hideMessageGo_, false)
	end)
end

function NewHeroSkinView:AdjustItem()
	self:RefreshButton((self:GetNearestItem()))
end

function NewHeroSkinView:RefreshItemScale()
	for iter_50_0, iter_50_1 in pairs(self.skinItemList_) do
		if iter_50_1.isActive then
			iter_50_1:RefreshShow()
		end
	end
end

function NewHeroSkinView:BeginDragFun(arg_51_1, arg_51_2)
	self:StopMoveTimer()
	self:StopScrollTimer()
	self.scrollView_:OnBeginDrag(arg_51_2)
end

function NewHeroSkinView:EndDragFun(arg_52_1, arg_52_2)
	self.scrollView_:OnEndDrag(arg_52_2)
	self:AddScrollTimer()
end

function NewHeroSkinView:Scroll2SelectItem(arg_53_1)
	for iter_53_0, iter_53_1 in ipairs(self.skinItemList_) do
		if iter_53_1.isActive then
			local var_53_0 = iter_53_1:GetSkinID() == self.skinID_

			if var_53_0 then
				self:AddMoveTimer(iter_53_1, arg_53_1)
			end

			iter_53_1:ShowSelect(var_53_0)
		end
	end
end

function NewHeroSkinView:GetNearestItem()
	local var_54_0

	for iter_54_0, iter_54_1 in ipairs(self.skinItemList_) do
		if iter_54_1.isActive then
			if math.abs(self.contentTf_.localPosition.x + iter_54_1:GetLocalPosition().x - self.scrollTf_.rect.width / 2) < 9999 then
				var_54_0 = iter_54_1
			end
		end
	end

	return var_54_0
end

function NewHeroSkinView:AddScrollTimer()
	self:StopScrollTimer()

	self.scrollTimer_ = nil
	self.scrollTimer_ = FrameTimer.New(function()
		if math.abs(self.scrollView_.velocity.x) <= 100 then
			self.scrollTimer_:Stop()
			self:AdjustItem()
		end
	end, 1, -1)

	self.scrollTimer_:Start()
end

function NewHeroSkinView:StopScrollTimer()
	if self.scrollTimer_ then
		self.scrollTimer_:Stop()

		self.scrollTimer_ = nil
	end
end

function NewHeroSkinView:AddMoveTimer(arg_58_1, arg_58_2)
	self:StopMoveTimer()

	self.moveTimer_ = FrameTimer.New(function()
		local var_59_1 = arg_58_1:GetLocalPosition().x * -1 + self.scrollTf_.rect.width / 2

		self.contentTf_.localPosition = Vector3.Lerp(self.contentTf_.localPosition, Vector3.New(var_59_1, self.contentTf_.localPosition.y, self.contentTf_.localPosition.z), arg_58_2 * math.pow(self.scrollView_.decelerationRate, UnityEngine.Time.unscaledDeltaTime) * UnityEngine.Time.unscaledDeltaTime)

		if math.abs(self.contentTf_.localPosition.x - var_59_1) <= 1 then
			self.contentTf_.localPosition = Vector3(var_59_1, self.contentTf_.localPosition.y, self.contentTf_.localPosition.z)

			self:StopMoveTimer()
		end
	end, 1, -1)

	self.moveTimer_:Start()
end

function NewHeroSkinView:StopMoveTimer()
	if self.moveTimer_ then
		self.moveTimer_:Stop()

		self.moveTimer_ = nil
	end
end

function NewHeroSkinView:RefreshDlcMovie()
	manager.audio:StopVoice()

	if isNil(self.dlcMovie_) or isNil(self.dlcPlayer_) then
		self.dlcMovie_ = self.dlcMovieGo_:GetComponent("CriManaMovieControllerForUI")
		self.dlcPlayer_ = self.dlcMovie_.player
		self.dlcPlayer_.uiRenderMode = true
	end

	if isNil(self.dlcBgMovie_) or isNil(self.dlcBgPlayer_) then
		self.dlcBgMovie_ = self.bgMovieGo_:GetComponent("CriManaMovieControllerForUI")
		self.dlcBgPlayer_ = self.dlcBgMovie_.player
		self.dlcBgPlayer_.uiRenderMode = true
	end

	if tostring(self.dlcPlayer_.status) == "Playing" and self.dlcPlayer_.IsPaused and tostring(self.dlcBgPlayer_.status) == "Playing" and self.dlcBgPlayer_.IsPaused and self.skinID_ == self.movieSkinId_ then
		self.dlcMovie_:Pause(false)
		self.dlcBgMovie_:Pause(false)
		self.dlcHideMovieController_:SetSelectedIndex(1)

		return
	end

	if self.movieSkinId_ and self.movieSkinId_ ~= 0 and self.skinID_ ~= self.movieSkinId_ then
		self.dlcMovie_:Stop()
		self.dlcBgMovie_:Stop()

		self.mainMovieRaw_.material = nil
		self.bgMovieRaw_.material = nil

		self:StopMovieStopTimer()

		self.stopTimer_ = Timer.New(function()
			if tostring(self.dlcPlayer_.status) == "Stop" and tostring(self.dlcBgPlayer_.status) == "Stop" then
				self:StartMovie()
				self:StopMovieStopTimer()

				return
			end
		end, 0.033, -1)

		self.stopTimer_:Start()
	else
		self:StartMovie()
	end
end

function NewHeroSkinView:StartMovie()
	local var_63_0 = getShopCfg(self.dlcID_)
	local var_63_1

	if var_63_0 then
		var_63_1 = var_63_0.give_id or var_63_0.description
	end

	local var_63_6 = var_63_0 and (var_63_0.description and RechargeShopDescriptionCfg[var_63_0.description] or ItemCfg[var_63_1]) or ItemCfg[self.dlcItemID_]

	for iter_63_0, iter_63_1 in ipairs(SkinSceneActionCfg.all) do
		if SkinSceneActionCfg[iter_63_1].special_scene_id == var_63_6.param[1] then
			self.start_path = SkinSceneActionCfg[iter_63_1].start_path

			if AssetDownloadManager.CheckResourcesNeedDownload({
				self.start_path
			}) then
				self.dlcMovie_:Stop()
				self.dlcBgMovie_:Stop()
				self.toDownloadDlcController:SetSelectedIndex(1)

				self.movieSkinId_ = SkinSceneActionCfg[iter_63_1].special_scene_id

				break
			end

			self.dlcMovie_:Stop()
			self.dlcBgMovie_:Stop()
			self.toDownloadDlcController:SetSelectedIndex(0)
			self:PlayDlcMovie()

			break
		end
	end
end

function NewHeroSkinView:PlayDlcMovie()
	self:Play()
	self:StopMovieTimer()

	self.timer_ = Timer.New(function()
		if self.dlcPlayer_ and tostring(self.dlcPlayer_.status) == "Stop" and self.dlcBgPlayer_ and tostring(self.dlcBgPlayer_.status) == "Stop" then
			self:Play()

			return
		end

		if self.dlcMovie_.isMaterialAvailable and self.dlcBgMovie_.isMaterialAvailable then
			self.dlcHideMovieController_:SetSelectedIndex(1)
			self:StopMovieTimer()

			if not self:IsTop() then
				self:PauseDlcMovie()
			end

			return
		end
	end, 0.033, -1)

	self.timer_:Start()
end

function NewHeroSkinView:PauseDlcMovie()
	if self.dlcMovie_ and self.dlcPlayer_ and self.dlcBgMovie_ and self.dlcBgPlayer_ then
		self.dlcMovie_:Pause(true)
		self.dlcBgMovie_:Pause(true)
	end
end

function NewHeroSkinView:StopMovieTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

function NewHeroSkinView:StopMovieStopTimer()
	if self.stopTimer_ then
		self.stopTimer_:Stop()

		self.stopTimer_ = nil
	end
end

function NewHeroSkinView:Play()
	SetFile(self.dlcPlayer_, nil, self.start_path, CriMana.Player.SetMode.New)
	self.dlcPlayer_:Prepare()
	SetFile(self.dlcBgPlayer_, nil, self.start_path, CriMana.Player.SetMode.New)
	self.dlcBgPlayer_:Prepare()
	self.dlcPlayer_:SetVolume((manager.audio:GetMusicVolume()))
	self.dlcBgPlayer_:SetVolume(0)
	self:SetVideoTrack(self.dlcPlayer_, self.start_path)
	self:SetVideoTrack(self.dlcBgPlayer_, self.start_path)

	self.movieSkinId_ = self.skinID_

	self.dlcMovie_:Play()
	self.dlcBgMovie_:Play()
	self.dlcHideMovieController_:SetSelectedIndex(1)
end

function NewHeroSkinView:SetVideoTrack(arg_70_1, arg_70_2)
	local var_70_0 = manager.video:GetVedioTrackIndex(arg_70_2)

	arg_70_1:SetAudioTrack(var_70_0)
	arg_70_1:SetSubtitleChannel(var_70_0)
end

function NewHeroSkinView:RefreshShop()
	self:RefreshCurrencyToken(false)
end

function NewHeroSkinView:GetSkinItem()
	return NewHeroSkinItem.New(self.itemGo_, self.contentTf_)
end

function NewHeroSkinView:OnSelectSkin(arg_73_1, arg_73_2)
	self:SetButtonActive(1)
end

function NewHeroSkinView:OnEnter()
	ShopTools.FilterShopDataList(ShopConst.SHOP_ID.SKIN_SHOP)

	self.descList_ = {}
	self.showDlc_ = false
	self.heroID_ = not self.params_.heroID and HeroSkinRouteData:GetRoute().heroID or self.params_.heroID

	if not self.params_.isBack then
		if not self.params_.skinID then
			self.skinID_ = HeroTools.HeroUsingSkinInfo(self.heroID_).id
		else
			self.skinID_ = self.params_.skinID
			self.params_.initSkinID = self.params_.skinID
		end

		self:ChangeShowDlcState(0)
	else
		if self.skinID_ == 1 or self.skinID_ == nil then
			if not self.params_.skinID then
				self.skinID_ = HeroTools.HeroUsingSkinInfo(self.heroID_).id
			else
				self.skinID_ = self.params_.skinID
				self.params_.initSkinID = self.params_.skinID
			end
		end

		self:ChangeShowDlcState(self.showDlcState_ or 0)
	end

	self.plotController_:SetSelectedState("off")

	self.isOpenPlotTalk = false

	manager.heroRaiseTrack:SetModelState(self.skinID_)
	self:RefreshShop()
	self:RegistEventListener(GET_SKIN_GIFT, handler(self, self.OnGetSkinGift))
	self:RegistEventListener(RECHARGE_SUCCESS, function(arg_75_0)
		self:RefreshUI()
	end)
	self:RegistEventListener(HERO_BATTLE_SKIN_CHANGE, function(arg_76_0)
		self:RefreshBattleSkinBtn()
		self:RefreshBattleSkinTag(arg_76_0)
	end)
	self:RefreshUI()

	if self.params_.isDlc then
		self.params_.isDlc = false

		self:ChangeShowDlcState(1)
	elseif not self.params_.isBack then
		self:ChangeShowDlcState(0)
	else
		self:ChangeShowDlcState(self.showDlcState_)
	end

	self.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(self, self.BeginDragFun)))
	self.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(self, self.EndDragFun)))
	self:Scroll2SelectItem(100)
	self.cvBtnController_:SetSelectedIndex(0)
	self:RegistEventListener(ACTIVITY_SKIN_MEMORY_COIN_POP, handler(self, self.OnSkinMemoryCoinPop))
	self:RegistEventListener(CHANGE_POSTER_GIRL, handler(self, self.RefreshInfoOther))
	self:CheckIsShowT0MemoryCoin()
end

function NewHeroSkinView:RefreshCV()
	local var_77_0 = VoiceLanguageCfg[SettingData:GetSoundSettingData().voice_language].affix

	if SDKTools.GetIsTw() then
		self.cvText_.text = "CV " .. (GetI18NText(SkinCfg[self.skinID_]["cv_" .. var_77_0]) or "")

		if GetI18NText(SkinCfg[self.skinID_]["cv_" .. var_77_0]) == "" then
			self.cvText_.text = ""
		end
	elseif SDKTools.GetIsJapan() then
		self.cvText_.text = "CV " .. (GetI18NText(SkinCfg[self.skinID_]["cv_" .. var_77_0]) or "")

		if GetI18NText(SkinCfg[self.skinID_]["cv_" .. var_77_0]) == "" then
			self.cvText_.text = ""
		end
	elseif SDKTools.GetIsEnglish() then
		self.cvText_.text = "CV " .. (GetI18NText(SkinCfg[self.skinID_]["cv_" .. var_77_0]) or "")

		if GetI18NText(SkinCfg[self.skinID_]["cv_" .. var_77_0]) == "" then
			self.cvText_.text = ""
		end
	elseif SDKTools.GetIsKorea() then
		if var_77_0 == "en" then
			self.cvText_.text = "CV " .. (GetI18NText(SkinCfg[self.skinID_].cv_ko) or "")

			if GetI18NText(SkinCfg[self.skinID_].cv_ko) == "" then
				self.cvText_.text = ""
			end
		else
			self.cvText_.text = "CV " .. (GetI18NText(SkinCfg[self.skinID_]["cv_" .. var_77_0]) or "")

			if GetI18NText(SkinCfg[self.skinID_]["cv_" .. var_77_0]) == "" then
				self.cvText_.text = ""
			end
		end
	else
		self.cvText_.text = "CV " .. (GetI18NText(SkinCfg[self.skinID_]["cv_" .. var_77_0]) or "")

		if GetI18NText(SkinCfg[self.skinID_]["cv_" .. var_77_0]) == "" then
			self.cvText_.text = ""
		end
	end
end

function NewHeroSkinView:OnSkinMemoryCoinPop()
	self:CheckIsShowT0MemoryCoin()
end

function NewHeroSkinView:RefreshUIWithOutScroll()
	self:RefreshInfo()
	self:SetButtonActive(self:SkinState(self.skinID_))
end

function NewHeroSkinView:RefreshButton(arg_80_1)
	self.selectIndex_ = arg_80_1.index_

	local var_80_0 = arg_80_1:SkinState()
	local var_80_1 = arg_80_1.skinID_

	if arg_80_1.skinID_ == self.skinID_ then
		self:Scroll2SelectItem(5)

		return
	end

	OperationRecorder.RecordButtonTouch("hero_skin_" .. var_80_1)

	self.skinID_ = var_80_1

	local var_80_3 = SkinCfg[var_80_1]

	self:SetButtonActive(var_80_0)
	manager.heroRaiseTrack:SetModelState(self.skinID_)
	SetActive(self.plotBtn_, #var_80_3.plot_title > 0)
	self.plotController_:SetSelectedState("off")

	self.isOpenPlotTalk = false

	self:RefreshInfo()
	self:CheckDlc(var_80_1, var_80_0)
	self:RefreshDlcBtn()
	self:ChangeShowDlcState(0)
	self:RefreshDescBtn()
	self:RefreshGiftBtn()
	self:HideMessage()
	self:RefreshUI()
	self:Scroll2SelectItem(5)
	self:RefreshLimitTime(self.skinID_)
end

function NewHeroSkinView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function NewHeroSkinView:SetButtonActive(arg_82_1)
	self:CheckDlc(self.skinID_, arg_82_1)

	if self:JudgeDLC(self.skinID_) then
		self.dlc_dlcController_:SetSelectedState(tostring((self:isDlcOwned())))
	end

	self.dlc_skinController_:SetSelectedState(tostring(HeroTools.GetHasOwnedSkin(self.skinID_)))

	if self.btnState_ == arg_82_1 then
		return
	end

	self.statusController_:SetSelectedIndex(arg_82_1 - 1)

	self.btnState_ = arg_82_1

	self:UpdateBar()
end

function NewHeroSkinView:SkinState(arg_83_1)
	self:ChangeDlcBtn()

	if self:isUnlock(arg_83_1) then
		if self.params_.showOnly then
			return 8
		end

		if self:isSelect(arg_83_1) then
			return 1
		end

		return 2
	else
		if HeroTools.GetIsLimitTimeSkin(arg_83_1) then
			if self:isSelect(arg_83_1) then
				if HeroTools.IsSkinOutOfDate(arg_83_1) or self.showDlcState_ == 1 then
					return 1
				else
					return 10
				end
			elseif HeroTools.IsSkinOutOfDate(arg_83_1) or self.showDlcState_ == 1 then
				return 2
			else
				return 11
			end
		end

		if HeroTools.CanChangeSkin(arg_83_1) then
			return 5
		end

		if HeroTools.GetSkinIsCanUnLock(arg_83_1) then
			return 6
		end

		if HeroTools.IsSkinOutOfDate(arg_83_1) then
			if self.showDlcState_ == 1 and not self:isDlcOwned() and HeroTools.IsSkinOnlySellDLC(self.skinID_) then
				return 3
			end

			return 4
		end

		if ShopTools.IsPC() and ShopTools.IsRMB((HeroTools.GetShopIdBySkinId(self.skinID_))) then
			return 12
		end

		return 3
	end
end

function NewHeroSkinView:ChangeDlcBtn()
	self.dlcBtnController_:SetSelectedIndex(0)
	SetActive(self.sourceDlcGo_, false)

	if self:CheckIsSpecial() == 1 then
		self:ChangeDlcBtnSpecial()

		return
	end

	if self:CheckIsSpecial() == 2 then
		self.sourceDlcText_.text = GetI18NText(ItemCfg[self.dlcItemID_].desc_source) or ""

		if self:isDlcOwned() then
			self.dlcBtnController_:SetSelectedIndex(0)
		else
			SetActive(self.sourceDlcGo_, true)
		end

		return
	end

	if self.showDlcState_ == 1 then
		if self:isUnlock(self.skinID_) or HeroTools.GetIsLimitTimeSkin(self.skinID_) then
			if self:JudgeDLC(self.skinID_) and not self:isDlcOwned() then
				local var_84_0 = getShopCfg(self.dlcID_)

				if ShopTools.CheckShopIsUnLock(var_84_0.shop_id) and var_84_0 and ShopTools.IsGoodCanDisplay(var_84_0.shop_id, var_84_0.goods_id) then
					self.dlcBtnController_:SetSelectedIndex(1)
				end
			end
		elseif not self:isDlcOwned() and HeroTools.IsSkinOnlySellDLC(self.skinID_) then
			self.dlcBtnController_:SetSelectedIndex(1)
		end
	end
end

function NewHeroSkinView:SaveRoute()
	SkinTrialData:SaveRoute({
		name = "heroSkin",
		skinID = self.skinID_,
		heroID = self.heroID_
	})
end

function NewHeroSkinView:GoToBuySkinPop(arg_86_1)
	local var_86_0
	local var_86_1
	local var_86_3

	if self.dlcID_ and self.dlcID_ ~= 0 then
		var_86_0 = ShopTools.GetDiscount(self.dlcID_) or nil

		local var_86_4

		var_86_1, var_86_4, var_86_3 = ShopTools.IsOnDiscountArea(self.dlcID_)
	end

	if self.showDlcState_ == 1 then
		if self:CheckIsSpecial() == 0 then
			if var_86_0 and var_86_0 == 0 and var_86_1 and var_86_3 then
				JumpTools.OpenPageByJump("freeSkinBuyCheck", {
					goodID = arg_86_1,
					heroID = self.heroID_,
					skinID = self.skinID_,
					onlySkin = self:isDlcOwned()
				}, ViewConst.SYSTEM_ID.RECHARGE_SKIN)
			else
				JumpTools.OpenPageByJump("newSkinBuyCheck", {
					goodID = arg_86_1,
					heroID = self.heroID_,
					skinID = self.skinID_,
					onlySkin = self:isDlcOwned()
				}, ViewConst.SYSTEM_ID.RECHARGE_SKIN)
			end
		elseif self:CheckIsSpecial() == 1 then
			JumpTools.OpenPageByJump("newSkinBuyCheck", {
				onlySkin = true,
				goodID = arg_86_1,
				heroID = self.heroID_,
				skinID = self.skinID_
			}, ViewConst.SYSTEM_ID.RECHARGE_SKIN)
		end
	elseif var_86_0 and var_86_0 == 0 and var_86_1 and var_86_3 then
		JumpTools.OpenPageByJump("freeSkinBuyCheck", {
			onlySkin = true,
			goodID = arg_86_1,
			heroID = self.heroID_,
			skinID = self.skinID_
		}, ViewConst.SYSTEM_ID.RECHARGE_SKIN)
	else
		JumpTools.OpenPageByJump("newSkinBuyCheck", {
			onlySkin = true,
			goodID = arg_86_1,
			heroID = self.heroID_,
			skinID = self.skinID_
		}, ViewConst.SYSTEM_ID.RECHARGE_SKIN)
	end
end

function NewHeroSkinView:AddUIListener()
	self:AddBtnListener(self.portraitBtn_, nil, function()
		if self.showDlcState_ == 1 then
			self:Go("heroPortraitFull", {
				skinID = self.skinID_
			})
		else
			self:Go("heroPortrait", {
				skinID = self.skinID_
			})
		end
	end)
	self:AddBtnListener(self.movieBtn_, nil, function()
		if self.showDlcState_ == 1 then
			JumpTools.OpenPageByJump("/skinDlcShow", {
				goodId = self.dlcID_,
				dlcItemID = self.dlcItemID_
			})
		end
	end)
	self:AddBtnListener(self.replaceBtn_, nil, function()
		HeroAction.SelectSkin(self.heroID_, self.skinID_)

		if self.showDlcState_ ~= 1 then
			self:PlayVoice()
		end
	end)
	self:AddBtnListener(self.goBtn_, nil, function()
		self.params_.skinID = self.skinID_

		local var_91_0 = JumpTools.IsSystemLocked(501)

		if var_91_0 then
			ShowTips(JumpTools.GetSystemLockedTip(501, var_91_0))
		else
			self:GoToBuySkinPop((HeroTools.GetShopIdBySkinId(self.skinID_)))
		end
	end)
	self:AddBtnListener(self.pcRmbBtn_, nil, function()
		if ShopTools.IsPC() then
			ShowTips("PC_SHOP_TIPS2")

			return
		end
	end)
	self:AddBtnListener(self.changeBtn_, nil, function()
		self.params_.skinID = self.skinID_

		CommonAction.TryToUseItem({
			{
				item_info = {
					num = 1,
					id = HeroTools.GetSkinChangeItem(self.skinID_)
				},
				use_list = {}
			}
		})
	end)
	self:AddBtnListener(self.unlockBtn_, nil, function()
		if self.isCanUnlock_ then
			HeroAction.UnLockSkin(self.skinID_)
		end
	end)
	self:AddBtnListener(self.giftBtn_, nil, function()
		if self:isUnlock(self.skinID_) then
			PlayerAction.ReceiveSkinGift(self.skinID_)
		else
			local var_95_1 = (SkinCfg[self.skinID_] or {}).gift or {}

			JumpTools.OpenPageByJump("rewardPreview", {
				is_receive = false,
				rewardList = var_95_1
			}, ViewConst.SYSTEM_ID.REWARD_PREVIEW)
		end
	end)
	self:AddBtnListener(self.battleBtn_, nil, function()
		self.params_.skinID = self.skinID_

		local var_96_0 = 0
		local var_96_1 = SkinTagCfg[self.skinID_].trial_activity[1]

		for iter_96_0, iter_96_1 in ipairs(SkinTagCfg[self.skinID_].trial_activity) do
			if ActivityData:GetActivityIsOpen(ActivitySkinTrialCfg[iter_96_1].activity_id) then
				var_96_0 = ActivitySkinTrialCfg[iter_96_1].activity_id
				var_96_1 = iter_96_1

				break
			end
		end

		SkinTrialData:SaveStageID(var_96_1)
		self:SaveRoute()
		self:Go("/sectionSelectHero", {
			activityID = var_96_0,
			section = SkinTagCfg[self.skinID_].trial_stage,
			sectionType = BattleConst.STAGE_TYPE_NEW.SKIN_TRIAL
		})
	end)
	self:AddBtnListener(self.plotBtn_, nil, function()
		if not self.isOpenPlotTalk then
			self:IndexPlotItem()
			self.plotController_:SetSelectedState("on")
			UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.talkStateGo_.transform)

			self.isOpenPlotTalk = true
		else
			self.plotController_:SetSelectedState("off")

			self.isOpenPlotTalk = false
		end
	end)
	self:AddBtnListener(self.plotTalkMaskBtn_, nil, function()
		self.plotController_:SetSelectedState("off")

		self.isOpenPlotTalk = false
	end)

	for iter_87_0, iter_87_1 in ipairs(self.descBtn_) do
		self:AddBtnListener(iter_87_1, nil, function()
			self:ShowMessage()
		end)
	end

	self:AddBtnListener(nil, self.hideMessageBtn_, function()
		self:HideMessage()
		SetActive(self.hideMessageGo_, false)
	end)
	self:AddBtnListener(nil, self.dlc_skinBtn_, function()
		OperationRecorder.RecordButtonTouch("skin_pre_" .. self.skinID_)

		self.showDlc_ = false

		self:ChangeShowDlcState(0)
	end)
	self:AddBtnListener(nil, self.dlc_dlcBtn_, function()
		if self.dlcID_ then
			local var_102_0 = getShopCfg(self.dlcID_)

			if var_102_0 then
				local var_102_1 = var_102_0.give_id or var_102_0.description

				if var_102_1 then
					OperationRecorder.RecordButtonTouch("skin_dlc_pre_" .. var_102_1)
				end
			else
				OperationRecorder.RecordButtonTouch("skin_dlc_pre_" .. self.dlcItemID_ss)
			end
		end

		self.showDlc_ = true

		self:ChangeShowDlcState(1)
	end)
	self:AddBtnListener(nil, self.buyDlcBtn_, function()
		self.params_.skinID = self.skinID_

		local var_103_0 = JumpTools.IsSystemLocked(501)

		if var_103_0 then
			ShowTips(JumpTools.GetSystemLockedTip(501, var_103_0))
		else
			local var_103_1 = getShopCfg(self.dlcID_)

			if var_103_1 == nil then
				return
			elseif ShopConst.SHOP_ID.DLC_SHOP == var_103_1.shop_id or var_103_1.shop_id == ShopConst.SHOP_ID.REPURCHASE_SHOP then
				JumpTools.OpenPageByJump("newSkinBuyCheck", {
					onlySkin = false,
					goodID = HeroTools.GetShopIdBySkinId(self.skinID_),
					heroID = self.heroID_,
					skinID = self.skinID_
				}, ViewConst.SYSTEM_ID.SHOP)
			else
				local var_103_2 = {}

				var_103_2.shopId = getShopCfg(self.dlcID_).shop_id

				JumpTools.GoToSystem("/shop", var_103_2, ViewConst.SYSTEM_ID.SHOP)
			end
		end
	end)
	self.scrollView_.onValueChanged:AddListener(function()
		self:RefreshItemScale()
	end)
	self:AddBtnListener(self.switchInfoBtn_, nil, function()
		if self.infoController_:GetSelectedState() == "tag" then
			self:SwitchInfoController("description")
		else
			self:SwitchInfoController("tag")
		end
	end)
	self:AddBtnListener(self.downloadDlcBtn_, nil, function()
		DownloadSingleAssetQuanquan(self.start_path, function()
			self.toDownloadDlcController:SetSelectedIndex(0)
			self:PlayDlcMovie()
		end)
	end)
	self:AddBtnListenerOther()
end

function NewHeroSkinView:AddBtnListenerOther()
	self:AddBtnListener(self.changeBtn_, nil, function()
		self.params_.skinID = self.skinID_

		CommonAction.TryToUseItem({
			{
				item_info = {
					num = 1,
					id = HeroTools.GetSkinChangeItem(self.skinID_)
				},
				use_list = {}
			}
		})
	end)
	self:AddBtnListener(self.btn_dlcSpecialExchangeBtn_, nil, function()
		local var_110_0 = getShopCfg(self.dlcID_)

		ShowMessageBox({
			content = string.format(GetTips("SHOP_DLC_LINK"), ItemTools.getItemName(var_110_0.give_id)),
			OkCallback = function()
				if var_110_0 then
					JumpTools.GoToSystem("/shop", {
						shopId = var_110_0.shop_id
					}, ViewConst.SYSTEM_ID.SHOP)
				end
			end,
			CancelCallback = function()
				return
			end
		})
	end)
end

function NewHeroSkinView:OnTryToUseItem(arg_113_1, arg_113_2)
	if isSuccess(arg_113_1.result) then
		getReward({
			{
				num = 1,
				id = ItemCfg[arg_113_2.use_item_list[1].item_info.id].param[1]
			}
		})
		HeroAction.UpdateSkinCouponRedPoint(SkinCfg[ItemCfg[arg_113_2.use_item_list[1].item_info.id].param[1]].hero)
		HeroAction.SkinAdd(self.skinID_)
		self:OnTryToUseItemOther(ItemCfg[arg_113_2.use_item_list[1].item_info.id].param[1])
	else
		ShowTips(arg_113_1.result)
	end

	self:RefreshUI()
end

function NewHeroSkinView:OnTryToUseItemOther(arg_114_1)
	self:SetButtonActive(2)
	manager.redPoint:setTip(RedPointConst.HERO_SKIN_ROUTE_ID .. arg_114_1, 0, RedPointStyle.SHOW_NEW_TAG)
end

function NewHeroSkinView:ChangeShowDlcState(arg_115_1)
	self.dlcHideMovieController_:SetSelectedIndex(0)

	self.showDlcState_ = arg_115_1

	self.dlcController_:SetSelectedIndex(arg_115_1)

	if arg_115_1 == 0 then
		self.dlc_skinBtn_.interactable = false
		self.dlc_dlcBtn_.interactable = true

		manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
			1,
			4
		}, self.displayGo_)
		manager.heroRaiseTrack:SetModelState(self.skinID_)
		self:PauseDlcMovie()
		self.buyBtnMultiController_:SetSelectedIndex(0)
		SetActive(self.movieBtn_.gameObject, false)
		self.cvBtnController_:SetSelectedIndex(0)
	elseif arg_115_1 == 1 then
		local var_115_0 = ShopTools.HasMultiPay(self.dlcID_)

		self.dlc_skinBtn_.interactable = true
		self.dlc_dlcBtn_.interactable = false

		manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.null)
		self:RefreshDlcMovie()
		SetActive(self.movieBtn_.gameObject, true)
		self.buyBtnMultiController_:SetSelectedIndex(var_115_0 and 1 or 0)
		self.cvBtnController_:SetSelectedIndex(1)
		self:RefreshCV()
	end

	self:ChangeShowDlcStateOther()
end

function NewHeroSkinView:ChangeShowDlcStateOther()
	self:ChangeDlcBtn()
	self:SetButtonActive(self:SkinState(self.skinID_))
	self:RefreshInfo()
end

function NewHeroSkinView:RefreshInfo()
	if self.showDlcState_ == 1 then
		local var_117_0 = getShopCfg(self.dlcID_)
		local var_117_1 = var_117_0 and RechargeShopDescriptionCfg[var_117_0.description] or RechargeShopDescriptionCfg[self.dlcItemID_]

		if var_117_1 == nil then
			var_117_1 = var_117_0 and ItemCfg[var_117_0.give_id] or ItemCfg[self.dlcItemID_]
		end

		self.nameText_.text = GetI18NText((string.format("%s", var_117_1.name)))
		self.infoText_.text = GetI18NText((string.format("%s", var_117_1.desc)))
	else
		self.nameText_.text = GetI18NText(SkinCfg[self.skinID_].name)
		self.infoText_.text = GetI18NText(SkinCfg[self.skinID_].desc)
	end

	self:CleanMessage()

	local var_117_2 = HeroTools.GetSkinChangeItem(self.skinID_)

	if var_117_2 then
		self.sourcetextText_.text = GetI18NText(ItemCfg[var_117_2].desc_source) or ""
		self.couponImg_.sprite = ItemTools.getItemLittleSprite(var_117_2)
	else
		self.sourcetextText_.text = GetI18NText(ItemCfg[self.skinID_].desc_source) or ""
	end

	if HeroTools.IsSkinOnlySellDLC(self.skinID_) then
		self.sourcetextText_.text = GetTips("ACTIVITY_REWARD_RECEIVE") or ""
	end

	self:RefreshInfoOther()
end

function NewHeroSkinView:RefreshInfoOther()
	if self.btnState_ == 5 then
		if HeroTools.CanChangeSkin(self.skinID_) then
			manager.redPoint:SetRedPointIndependent(self.changeBtn_.transform, true)
		else
			manager.redPoint:SetRedPointIndependent(self.changeBtn_.transform, false)
		end
	end

	if self.btnState_ == 6 then
		self.isCanUnlock_ = true

		for iter_118_0, iter_118_1 in pairs(SkinCfg[self.skinID_].unlock_id_list) do
			local var_118_0, var_118_1, var_118_2 = IsConditionAchieved(iter_118_1, {
				heroId = self.heroID_
			})

			if var_118_0 then
				self["taskController_" .. iter_118_0]:SetSelectedState("true")
			else
				self.isCanUnlock_ = false

				self["taskController_" .. iter_118_0]:SetSelectedState("false")
			end

			self["tasktext_" .. iter_118_0].text = GetI18NText(ConditionCfg[iter_118_1].desc)
		end

		self.unlockController_:SetSelectedState(self.isCanUnlock_ and "false" or "true")
	end

	self:RefreshBattleSkinBtn()
	self:RefreshBattleSkinTag()
	self:RefreshLimitTime(self.skinID_)
end

function NewHeroSkinView:RefreshBattleSkinTag(arg_119_1)
	if arg_119_1 then
		self.battleSkinID_ = arg_119_1
	end

	if not self.battleSkinID_ or not self.skinItemList_ then
		return
	end

	if self.battleSkinID_ == 0 then
		self.battleSkinID_ = self.heroID_
	end

	for iter_119_0, iter_119_1 in ipairs(self.skinItemList_) do
		iter_119_1:ShowBattleSkin(self.battleSkinID_ == iter_119_1.skinID_)
	end
end

return NewHeroSkinView
