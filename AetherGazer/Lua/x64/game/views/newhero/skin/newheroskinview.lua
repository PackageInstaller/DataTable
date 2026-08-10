local var_0_0 = class("NewHeroSkinView", ReduxView)
local var_0_1 = {
	NURSE = 1,
	DLC_ACTIVITY = 2
}

function var_0_0.isDlcOwned(arg_1_0)
	local var_1_0 = false

	if arg_1_0.dlcID_ and arg_1_0.dlcID_ ~= 0 then
		var_1_0 = ShopTools.CheckDlcPurchased(arg_1_0.dlcID_)
	else
		var_1_0 = ShopTools.CheckDlcPurchasedByItemID(arg_1_0.dlcItemID_)
	end

	return var_1_0
end

function var_0_0.isUnlock(arg_2_0, arg_2_1)
	return HeroTools.GetHasOwnedSkin(arg_2_1)
end

function var_0_0.isUnlockOrCanChange(arg_3_0, arg_3_1)
	return arg_3_0:isUnlock(arg_3_1) or HeroTools.CanChangeSkin(arg_3_1)
end

function var_0_0.isSelect(arg_4_0, arg_4_1)
	if HeroTools.HeroUsingSkinInfo(SkinCfg[arg_4_1].hero).id == arg_4_1 then
		return true
	end

	return false
end

function var_0_0.UIName(arg_5_0)
	return "Widget/System/Hero/HeroSkinUI_new"
end

function var_0_0.UIParent(arg_6_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_7_0)
	arg_7_0.skinIdList_ = {}
	arg_7_0.skinItemList_ = {}
	arg_7_0.descInfoList_ = {}
	arg_7_0.btnState_ = nil
	arg_7_0.skinID_ = 1
	arg_7_0.selectIndex_ = 1
	arg_7_0.isCanUnlock_ = false
	arg_7_0.dlcMovie_ = nil
	arg_7_0.dlcPlayer_ = nil
	arg_7_0.dlcBgMovie_ = nil
	arg_7_0.dlcBgPlayer_ = nil

	arg_7_0:InitUI()
	arg_7_0:AddUIListener()
end

function var_0_0.OnTop(arg_8_0)
	arg_8_0:UpdateBar()
	arg_8_0:RefreshUIWithOutScroll()

	if arg_8_0.showDlcState_ == 1 then
		arg_8_0:RefreshDlcMovie()
	end
end

function var_0_0.OnBehind(arg_9_0)
	if arg_9_0.showDlcState_ == 1 then
		arg_9_0:PauseDlcMovie()
	end
end

function var_0_0.CameraEnter(arg_10_0)
	if not arg_10_0.params_.isBack then
		manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
			1,
			4
		}, arg_10_0.displayGo_)
	elseif arg_10_0.showDlcState_ == 1 then
		manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.null)
	else
		manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
			1,
			4
		}, arg_10_0.displayGo_)
	end
end

function var_0_0.OnExit(arg_11_0)
	arg_11_0.dlcHideMovieController_:SetSelectedIndex(0)

	if arg_11_0.delayPlayTimer_ then
		arg_11_0.delayPlayTimer_:Stop()

		arg_11_0.delayPlayTimer_ = nil
	end

	arg_11_0:StopScrollTimer()
	arg_11_0:StopMovieStopTimer()
	arg_11_0:StopMovieTimer()
	arg_11_0:StopMoveTimer()
	arg_11_0:CleanMessage()
	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()
	arg_11_0:RemoveAllEventListener()
	arg_11_0.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	arg_11_0.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.EndDrag)

	if arg_11_0.dlcMovie_ then
		arg_11_0.dlcMovie_:Stop()
	end

	if arg_11_0.dlcBgMovie_ then
		arg_11_0.dlcBgMovie_:Stop()
	end

	if arg_11_0.dlcPlayer_ then
		arg_11_0.dlcPlayer_.statusChangeCallback = nil
	end

	if arg_11_0.dlcBgPlayer_ then
		arg_11_0.dlcBgPlayer_.statusChangeCallback = nil
	end

	arg_11_0.dlcPlayer_ = nil
	arg_11_0.dlcMovie_ = nil
	arg_11_0.dlcBgMovie_ = nil
	arg_11_0.dlcBgPlayer_ = nil
	arg_11_0.movieSkinId_ = 0

	local var_11_0 = {
		heroID = arg_11_0.heroID_,
		skinID = arg_11_0.skinID_
	}

	HeroSkinRouteData:SaveRoute(var_11_0)
end

function var_0_0.Dispose(arg_12_0)
	if arg_12_0.delayPlayTimer_ then
		arg_12_0.delayPlayTimer_:Stop()

		arg_12_0.delayPlayTimer_ = nil
	end

	if arg_12_0.battleSkinBtn_ then
		arg_12_0.battleSkinBtn_:Dispose()

		arg_12_0.battleSkinBtn_ = nil
	end

	arg_12_0:RemoveAllListeners()
	arg_12_0:CleanMessage()

	if arg_12_0.plotItemList_ then
		for iter_12_0, iter_12_1 in ipairs(arg_12_0.plotItemList_) do
			iter_12_1:Dispose()
		end

		arg_12_0.plotItemList_ = nil
	end

	if arg_12_0.skinItemList_ then
		for iter_12_2, iter_12_3 in ipairs(arg_12_0.skinItemList_) do
			iter_12_3:Dispose()
		end

		arg_12_0.skinItemList_ = nil
	end

	var_0_0.super.Dispose(arg_12_0)
end

function var_0_0.InitUI(arg_13_0)
	arg_13_0:BindCfgUI()
	arg_13_0:InitBtnState()
	arg_13_0:InitDescBtn()

	arg_13_0.battleSkinBtn_ = BattleSkinBtnView.New(arg_13_0.battleSkinBtnGo_)
	arg_13_0.haveDLCController_ = arg_13_0.controllerEx_:GetController("haveDLC")
	arg_13_0.timeController_ = arg_13_0.controllerEx_:GetController("Time")
	arg_13_0.giftController_ = arg_13_0.controllerEx_:GetController("Gift")
	arg_13_0.plotController_ = arg_13_0.controllerEx_:GetController("Plot")
	arg_13_0.infoController_ = arg_13_0.controllerEx_:GetController("Info")
	arg_13_0.statusController_ = arg_13_0.controllerEx_:GetController("Btn")
	arg_13_0.dlcController_ = arg_13_0.controllerEx_:GetController("DLC")
	arg_13_0.dlcBtnController_ = arg_13_0.controllerEx_:GetController("dlcBtn")
	arg_13_0.dlcHideMovieController_ = arg_13_0.controllerEx_:GetController("dlcMovieHide")
	arg_13_0.cvBtnController_ = arg_13_0.controllerEx_:GetController("CVtext")
	arg_13_0.toDownloadDlcController = arg_13_0.controllerEx_:GetController("toDownloadDlc")
	arg_13_0.unlockController_ = arg_13_0.lockControllerEx_:GetController("clear")
	arg_13_0.taskController_1 = arg_13_0.lockControllerEx_:GetController("task01")
	arg_13_0.taskController_2 = arg_13_0.lockControllerEx_:GetController("task02")
	arg_13_0.dlc_skinController_ = arg_13_0.dlc_skinControllerEx_:GetController("get")
	arg_13_0.dlc_oathGiftController_ = arg_13_0.dlc_skinControllerEx_:GetController("oathGift")
	arg_13_0.dlc_dlcController_ = arg_13_0.dlc_dlcControllerEx_:GetController("get")
	arg_13_0.buyBtnController_ = arg_13_0.goBtnControllerEx_:GetController("gift")
	arg_13_0.buyBtnMultiController_ = arg_13_0.goBtnControllerEx_:GetController("multiPay")
	arg_13_0.dlcBtnMultiController_ = arg_13_0.dlcBtnControllerEx_:GetController("multiPay")
end

function var_0_0.InitBtnState(arg_14_0)
	arg_14_0.btnState = {
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

function var_0_0.InitDescBtn(arg_15_0)
	arg_15_0.descBtn_ = {
		arg_15_0.descBtn_1,
		arg_15_0.descBtn_2,
		arg_15_0.descBtn_3,
		arg_15_0.descBtn_4,
		arg_15_0.descBtn_5,
		arg_15_0.descBtn_6,
		arg_15_0.descBtn_7
	}
	arg_15_0.descBtnGo_ = {}

	for iter_15_0 = 1, 7 do
		arg_15_0.descBtnGo_[iter_15_0] = arg_15_0["descBtnGo_" .. iter_15_0]
	end
end

function var_0_0.CheckIsSpecial(arg_16_0)
	if not arg_16_0.dlcID_ then
		arg_16_0:SetCurDlcID()
	end

	arg_16_0.shopDlcCfg = getShopCfg(arg_16_0.dlcID_)

	if arg_16_0.shopDlcCfg and arg_16_0.shopDlcCfg.shop_id == ShopConst.SHOP_ID.PASSPORT_SHOP then
		return 1
	end

	if not arg_16_0.shopDlcCfg and arg_16_0.dlcItemID_ and arg_16_0.showDlcState_ == 1 then
		return 2
	end

	return 0
end

function var_0_0.SwitchInfoController(arg_17_0, arg_17_1)
	arg_17_0.infoController_:SetSelectedState(arg_17_1)
end

function var_0_0.CheckIsCanPlayPlot(arg_18_0, arg_18_1)
	if arg_18_1 > 0 and not manager.story:IsStoryPlayed(arg_18_1) then
		ShowTips(GetTips("ERROR_HERO_ARCHIVES_PREVIOUS_PLOT_NOT_VIEWED"))

		return false
	end

	return true
end

function var_0_0.CheckIsShowT0MemoryCoin(arg_19_0)
	if ActivitySkinDrawData:GetSkinDrawMainActivityBySkinID(arg_19_0.skinID_) then
		ActivitySkinDrawData:ShowGetMemoryCoin(arg_19_0.skinID_)
	end
end

function var_0_0.IndexPlotItem(arg_20_0)
	if not arg_20_0.plotItemList_ then
		arg_20_0.plotItemList_ = {}
	end

	local var_20_0 = SkinCfg[arg_20_0.skinID_]
	local var_20_1 = var_20_0.plot_title
	local var_20_2 = var_20_0.plot_id

	for iter_20_0, iter_20_1 in ipairs(arg_20_0.plotItemList_) do
		SetActive(iter_20_1.gameObject_, false)
	end

	for iter_20_2 = 1, #var_20_1 do
		if not arg_20_0.plotItemList_[iter_20_2] then
			local var_20_3 = Object.Instantiate(arg_20_0.plotTalkBtn_.gameObject)
			local var_20_4 = PlotTalkItem.New(var_20_3)

			var_20_3.transform:SetParent(arg_20_0.plotTalkBasePanelGo_.transform, false)
			var_20_4:SetClickLimitFunc(function(arg_21_0)
				return arg_20_0:CheckIsCanPlayPlot(arg_21_0)
			end)
			var_20_4:SetCallBack(function()
				arg_20_0.plotController_:SetSelectedState("off")

				arg_20_0.isOpenPlotTalk = false
			end)
			var_20_4:SetStoryCallBack(function(arg_23_0)
				manager.ui:SetMainCamera("heroSkin")
				manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
					1,
					4
				}, arg_20_0.displayGo_)
				manager.heroRaiseTrack:SetModelState(arg_20_0.skinID_)
				arg_20_0:UpdateBar()
			end)
			table.insert(arg_20_0.plotItemList_, var_20_4)
		end

		arg_20_0.plotItemList_[iter_20_2]:RefreshUI(var_20_1[iter_20_2], var_20_2[iter_20_2], var_20_2[iter_20_2 - 1] or -1)
		SetActive(arg_20_0.plotItemList_[iter_20_2].gameObject_, true)
	end
end

function var_0_0.RefreshCurrencyToken(arg_24_0, arg_24_1)
	SetActive(arg_24_0.tokenGo_, arg_24_1)
	SetActive(arg_24_0.dlctokenGo_, arg_24_1)
	SetActive(arg_24_0.tokenNumGo_, arg_24_1)
end

function var_0_0.RefreshUI(arg_25_0)
	manager.redPoint:setTip(RedPointConst.HERO_SKIN_ROUTE_ID .. arg_25_0.skinID_, 0, RedPointStyle.SHOW_NEW_TAG)
	arg_25_0:RefreshInfo()
	arg_25_0:RefreshDlcBtn()
	arg_25_0:SetButtonActive(arg_25_0:SkinState(arg_25_0.skinID_))
	arg_25_0:RefreshDescBtn()
	arg_25_0:RefreshGiftBtn()
	arg_25_0:HideMessage()
	arg_25_0:RefreshItemData()
	arg_25_0:RefreshBattleSkinBtn()
	arg_25_0:RefreshSkinItemList()
	arg_25_0:RefreshOathUI()
	SetActive(arg_25_0.plotBtn_, #SkinCfg[arg_25_0.skinID_].plot_title > 0)

	for iter_25_0, iter_25_1 in ipairs(arg_25_0.skinItemList_) do
		if iter_25_1.isActive and iter_25_1:GetSkinID() == arg_25_0.skinID_ then
			arg_25_0.selectIndex_ = iter_25_0
		end
	end
end

function var_0_0.RefreshOathUI(arg_26_0)
	if OathDrawTools.CheckIsCanBuyOathSkin(arg_26_0.heroID_, arg_26_0.skinID_) and not ShopTools.HaveSkin(arg_26_0.skinID_) then
		arg_26_0.dlc_oathGiftController_:SetSelectedState("show")

		arg_26_0.oathGiftImg_.sprite = ItemTools.getItemSprite(OathDrawTools.GetCouponID())
	else
		arg_26_0.dlc_oathGiftController_:SetSelectedState("hide")
	end
end

function var_0_0.RefreshSkinItemList(arg_27_0)
	if arg_27_0.skinIdList_ and #arg_27_0.skinIdList_ > 0 then
		for iter_27_0, iter_27_1 in pairs(arg_27_0.skinItemList_) do
			iter_27_1:SetActive(false)
		end

		arg_27_0.battleSkinID_ = HeroData:GetHeroBattleUsingSkinInfo(arg_27_0.heroID_).id

		for iter_27_2, iter_27_3 in ipairs(arg_27_0.skinIdList_) do
			local var_27_0

			if arg_27_0.skinItemList_[iter_27_2] then
				var_27_0 = arg_27_0.skinItemList_[iter_27_2]
			else
				var_27_0 = arg_27_0:GetSkinItem()

				table.insert(arg_27_0.skinItemList_, var_27_0)
				var_27_0:SetDelegate(handler(arg_27_0, arg_27_0.RefreshButton))
			end

			var_27_0:Show(arg_27_0.skinIdList_[iter_27_2], iter_27_2)
			var_27_0:ShowSelect(arg_27_0.selectIndex_ == iter_27_2)
			var_27_0:CheckDLC(arg_27_0:JudgeDLC(arg_27_0.skinIdList_[iter_27_2]))
			var_27_0:ShowBattleSkin(iter_27_3 == arg_27_0.battleSkinID_)
			var_27_0:SetActive(true)
		end
	end

	arg_27_0:Scroll2SelectItem(5)
end

function var_0_0.RefreshDlcBtn(arg_28_0)
	arg_28_0.dlc_skinImage_.sprite = HeroTools.GetHeadSprite(arg_28_0.skinID_)

	if arg_28_0:JudgeDLC(arg_28_0.skinID_) then
		arg_28_0:SetCurDlcID()

		local var_28_0 = getShopCfg(arg_28_0.dlcID_)

		if var_28_0 then
			local var_28_1 = var_28_0.give_id or var_28_0.description

			if var_28_1 then
				arg_28_0.dlc_dlcImage_.sprite = ItemTools.getItemSprite(var_28_1)
			end
		else
			arg_28_0.dlc_dlcImage_.sprite = ItemTools.getItemSprite(arg_28_0.dlcItemID_)
		end
	else
		arg_28_0:SetCurDlcID()
	end
end

function var_0_0.RefreshLimitTime(arg_29_0, arg_29_1)
	local var_29_0 = HeroData:GetHeroData(arg_29_0.heroID_)
	local var_29_1 = 0
	local var_29_2 = 0

	for iter_29_0, iter_29_1 in ipairs(var_29_0.unlocked_skin) do
		if iter_29_1.skin_id == arg_29_1 then
			var_29_1 = iter_29_1.time

			if arg_29_0:JudgeDLC(arg_29_1) then
				local var_29_3 = HeroTools.GetShopIdBySkinId(arg_29_1)

				if not var_29_3 then
					return false
				end

				local var_29_4 = getShopCfg(var_29_3)
				local var_29_5 = var_29_4 and var_29_4.dlc

				if var_29_5 and var_29_5 ~= 0 then
					var_29_2 = HomeSceneSettingData:GetSceneTimeStamp(ShopCfg[var_29_5].description) or 0
				end
			end
		end
	end

	if var_29_1 ~= 0 then
		arg_29_0.skinLimitTimeText_.text = string.format(GetTips("TIME_DISPLAY_12"), os.date("%Y/%m/%d %H:%M", var_29_1) .. " ")
	else
		arg_29_0.skinLimitTimeText_.text = string.format(GetTips("TIME_DISPLAY_12"), os.date("%Y/%m/%d %H:%M", var_29_2) .. " ")
	end

	SetActive(arg_29_0.LimitTimeGo_, var_29_1 ~= 0 or var_29_2 ~= 0)
	SetActive(arg_29_0.skinLimitTimeGo_, var_29_1 ~= 0)
	SetActive(arg_29_0.dlcLimitTimeGo_, var_29_2 ~= 0)
end

function var_0_0.RefreshItemData(arg_30_0)
	arg_30_0.skinIdList_ = {}

	if arg_30_0.params_.showOnly and arg_30_0.params_.skinID then
		table.insert(arg_30_0.skinIdList_, arg_30_0.params_.skinID)
	else
		for iter_30_0, iter_30_1 in ipairs(SkinCfg.get_id_list_by_hero[arg_30_0.heroID_]) do
			if not HeroTools.GetIsSkinHide(iter_30_1) then
				if arg_30_0:isUnlock(iter_30_1) then
					table.insert(arg_30_0.skinIdList_, iter_30_1)
				elseif HeroTools.CanChangeSkin(iter_30_1) then
					table.insert(arg_30_0.skinIdList_, iter_30_1)
				elseif HeroTools.GetIsLimitTimeSkin(iter_30_1) then
					table.insert(arg_30_0.skinIdList_, iter_30_1)
				elseif SDKTools.GetIsOverSea() then
					table.insert(arg_30_0.skinIdList_, iter_30_1)
				elseif SkinCfg[iter_30_1].display_type == 1 then
					table.insert(arg_30_0.skinIdList_, iter_30_1)
				end
			end
		end

		if arg_30_0.params_.initSkinID and not table.indexof(arg_30_0.skinIdList_, arg_30_0.params_.initSkinID) then
			table.insert(arg_30_0.skinIdList_, arg_30_0.params_.initSkinID)
		end
	end
end

function var_0_0.RefreshBattleSkinBtn(arg_31_0)
	if arg_31_0.battleSkinBtn_ == nil then
		return
	end

	if HeroTools.GetSkinIsUnlock(arg_31_0.skinID_) and arg_31_0.skinID_ ~= arg_31_0.heroID_ then
		arg_31_0.battleSkinBtn_:Show(true)
		arg_31_0.battleSkinBtn_:RefreshUI(arg_31_0.heroID_, arg_31_0.skinID_)
	else
		arg_31_0.battleSkinBtn_:Show(false)
	end

	arg_31_0.isBattleSkin_, _ = arg_31_0.battleSkinBtn_:GetIsBattleSkin()
end

function var_0_0.CheckDlc(arg_32_0, arg_32_1, arg_32_2)
	arg_32_0.haveDLCController_:SetSelectedIndex(0)

	if arg_32_0:JudgeDLC(arg_32_1) then
		arg_32_0.haveDLCController_:SetSelectedIndex(1)
	end
end

function var_0_0.JudgeDLC(arg_33_0, arg_33_1)
	if arg_33_1 == nil then
		return false
	end

	local var_33_0 = HeroTools.GetShopIdBySkinId(arg_33_1)

	if not var_33_0 then
		return false
	end

	local var_33_1 = getShopCfg(var_33_0)
	local var_33_2 = var_33_1 and var_33_1.dlc

	if var_33_2 and var_33_2 ~= 0 then
		return true
	end

	local var_33_3 = CustomCenterTools.GetMatchedDLCScene(arg_33_1)

	if var_33_3 and var_33_3.special_scene_id then
		arg_33_0.dlcItemID_ = var_33_3.special_scene_id

		local var_33_4 = HomeSceneSettingCfg[var_33_3.special_scene_id]

		if var_33_4 and var_33_4.limit_display == 0 then
			return true
		end
	end

	return false
end

function var_0_0.SetCurDlcID(arg_34_0)
	local var_34_0 = HeroTools.GetShopIdBySkinId(arg_34_0.skinID_)
	local var_34_1 = getShopCfg(var_34_0)

	arg_34_0.dlcID_ = var_34_1 and var_34_1.dlc

	if arg_34_0.dlcID_ and arg_34_0.dlcID_ ~= 0 then
		local var_34_2 = ShopTools.GetDiscount(arg_34_0.dlcID_)
		local var_34_3, var_34_4, var_34_5 = ShopTools.IsOnDiscountArea(arg_34_0.dlcID_)
		local var_34_6 = ShopTools.HasMultiPay(arg_34_0.dlcID_)

		arg_34_0.buyBtnMultiController_:SetSelectedIndex(0)

		if var_34_6 then
			arg_34_0.buyBtnController_:SetSelectedIndex(2)
		elseif var_34_2 == 0 and var_34_3 and var_34_5 then
			arg_34_0.buyBtnController_:SetSelectedIndex(1)
		else
			arg_34_0.buyBtnController_:SetSelectedIndex(0)
		end

		arg_34_0.dlcBtnMultiController_:SetSelectedState(tostring(var_34_6))
	else
		arg_34_0.buyBtnController_:SetSelectedIndex(0)
	end

	local var_34_7 = CustomCenterTools.GetDLCScene(arg_34_0.skinID_)

	if var_34_7 and var_34_7.special_scene_id then
		arg_34_0.dlcItemID_ = var_34_7.special_scene_id
	end
end

function var_0_0.CheckSpecicalTable(arg_35_0, arg_35_1, arg_35_2)
	for iter_35_0 = 1, #arg_35_1 do
		if arg_35_1[iter_35_0] ~= arg_35_2[iter_35_0] then
			return false
		end
	end

	return true
end

function var_0_0.ChangeDlcBtnSpecial(arg_36_0)
	local var_36_0 = arg_36_0:isUnlock(arg_36_0.skinID_) and 1 or 0
	local var_36_1 = arg_36_0:isDlcOwned() and 1 or 0
	local var_36_2 = arg_36_0.showDlcState_
	local var_36_3 = {
		var_36_0,
		var_36_1,
		var_36_2
	}

	if arg_36_0:CheckSpecicalTable(var_36_3, {
		0,
		0,
		0
	}) then
		arg_36_0:SetButtonActive(3)
		arg_36_0.dlcBtnController_:SetSelectedIndex(0)
	elseif arg_36_0:CheckSpecicalTable(var_36_3, {
		0,
		0,
		1
	}) then
		arg_36_0:SetButtonActive(3)
		arg_36_0.dlcBtnController_:SetSelectedIndex(2)
	elseif arg_36_0:CheckSpecicalTable(var_36_3, {
		0,
		1,
		0
	}) then
		arg_36_0:SetButtonActive(3)
		arg_36_0.dlcBtnController_:SetSelectedIndex(0)
	elseif arg_36_0:CheckSpecicalTable(var_36_3, {
		0,
		1,
		1
	}) then
		arg_36_0:SetButtonActive(3)
		arg_36_0.dlcBtnController_:SetSelectedIndex(3)
	elseif arg_36_0:CheckSpecicalTable(var_36_3, {
		1,
		0,
		0
	}) then
		arg_36_0:SetButtonActive(8)
		arg_36_0.dlcBtnController_:SetSelectedIndex(2)
	elseif arg_36_0:CheckSpecicalTable(var_36_3, {
		1,
		0,
		1
	}) then
		arg_36_0:SetButtonActive(9)
		arg_36_0.dlcBtnController_:SetSelectedIndex(2)
	elseif arg_36_0:CheckSpecicalTable(var_36_3, {
		1,
		1,
		0
	}) then
		arg_36_0:SetButtonActive(8)
		arg_36_0.dlcBtnController_:SetSelectedIndex(0)
	elseif arg_36_0:CheckSpecicalTable(var_36_3, {
		1,
		1,
		1
	}) then
		arg_36_0:SetButtonActive(8)
		arg_36_0.dlcBtnController_:SetSelectedIndex(0)
	end
end

function var_0_0.HaveMaterial(arg_37_0)
	local var_37_0 = getShopCfg(HeroTools.GetShopIdBySkinId(arg_37_0.skinID_))

	return ItemCfg[var_37_0.cost_id], ItemTools.getItemNum(var_37_0.cost_id)
end

function var_0_0.RefreshDescBtn(arg_38_0)
	arg_38_0.typeNum_ = 0
	arg_38_0.typeDes_ = {}

	local var_38_0 = SkinTagCfg[arg_38_0.skinID_]

	SetActive(arg_38_0.battleBtn_.gameObject, false)

	if not var_38_0 then
		for iter_38_0, iter_38_1 in ipairs(arg_38_0.descBtnGo_) do
			SetActive(iter_38_1, false)
			arg_38_0:SwitchInfoController("description")
			SetActive(arg_38_0.switchInfoIconGo_, false)

			arg_38_0.switchInfoBtn_.interactable = false

			return
		end
	end

	local var_38_1 = var_38_0.tag

	for iter_38_2, iter_38_3 in ipairs(var_38_1) do
		local var_38_2 = SkinTagDescCfg[iter_38_3].type

		if not arg_38_0.typeDes_[var_38_2] then
			arg_38_0.typeDes_[var_38_2] = {}
			arg_38_0.typeNum_ = arg_38_0.typeNum_ + 1
		end

		table.insert(arg_38_0.typeDes_[var_38_2], iter_38_3)
	end

	for iter_38_4, iter_38_5 in ipairs(arg_38_0.descBtnGo_) do
		local var_38_3 = arg_38_0.typeDes_[iter_38_4] ~= nil

		SetActive(iter_38_5, var_38_3)
	end

	if arg_38_0.typeNum_ == 0 then
		arg_38_0:SwitchInfoController("description")
		SetActive(arg_38_0.switchInfoIconGo_, false)

		arg_38_0.switchInfoBtn_.interactable = false
	else
		arg_38_0:SwitchInfoController("tag")
		SetActive(arg_38_0.switchInfoIconGo_, true)

		arg_38_0.switchInfoBtn_.interactable = true
	end
end

function var_0_0.OnShopBuyResult(arg_39_0)
	arg_39_0:RefreshUI()
end

function var_0_0.OnGetSkinGift(arg_40_0)
	arg_40_0:RefreshUI()
end

function var_0_0.RefreshGiftBtn(arg_41_0)
	local var_41_0 = (SkinCfg[arg_41_0.skinID_] or {}).gift or {}

	if #var_41_0 > 0 and PlayerData:IsNotReceived(arg_41_0.skinID_) then
		SetActive(arg_41_0.giftBtn_, true)
	else
		SetActive(arg_41_0.giftBtn_, false)
	end

	SetActive(arg_41_0.giftRedGo_, #var_41_0 > 0 and arg_41_0:isUnlock(arg_41_0.skinID_) and PlayerData:IsNotReceived(arg_41_0.skinID_))
	arg_41_0.giftController_:SetSelectedState(arg_41_0:isUnlock(arg_41_0.skinID_) and "take" or "check")
end

function var_0_0.HideMessage(arg_42_0)
	SetActive(arg_42_0.descPanel_, false)
end

function var_0_0.ShowMessage(arg_43_0)
	local var_43_0 = 0

	for iter_43_0, iter_43_1 in pairs(arg_43_0.descInfoList_) do
		var_43_0 = var_43_0 + 1
	end

	if var_43_0 == 0 then
		for iter_43_2, iter_43_3 in pairs(arg_43_0.typeDes_) do
			local var_43_1 = Object.Instantiate(arg_43_0.descContent_, arg_43_0.descTipsContent_)

			arg_43_0.descInfoList_[iter_43_2] = SkinDescInfoItem.New(var_43_1, iter_43_3, iter_43_2)

			arg_43_0.descInfoList_[iter_43_2]:RefreshUI()
			arg_43_0.descInfoList_[iter_43_2]:Show(true)
			LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_0.descPanelRect_)
		end
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_0.descPanelRect_)
	SetActive(arg_43_0.descPanel_, true)
	SetActive(arg_43_0.hideMessageGo_, true)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_0.descPanelRect_)
end

function var_0_0.CleanMessage(arg_44_0)
	for iter_44_0, iter_44_1 in pairs(arg_44_0.descInfoList_) do
		iter_44_1:Dispose()
	end

	arg_44_0.descInfoList_ = {}
end

function var_0_0.PlayVoice(arg_45_0)
	if arg_45_0.delayPlayTimer_ then
		return
	end

	HeroTools.PlayVoice(arg_45_0.heroID_, "cloth")

	arg_45_0.delayPlayTimer_ = Timer.New(function()
		if arg_45_0.delayPlayTimer_ then
			arg_45_0.delayPlayTimer_:Stop()

			arg_45_0.delayPlayTimer_ = nil
		end
	end, 10, -1)

	arg_45_0.delayPlayTimer_:Start()
end

function var_0_0.SetReturnBtn(arg_47_0, arg_47_1)
	SetActive(arg_47_0.hideMessageGo_, true)
	arg_47_0:RemoveBtnListener(nil, arg_47_0.hideMessageBtn_.transform)
	arg_47_0:AddBtnListener(arg_47_0.hideMessageBtn_, nil, function()
		arg_47_1()
		SetActive(arg_47_0.hideMessageGo_, false)
	end)
end

function var_0_0.AdjustItem(arg_49_0)
	local var_49_0 = arg_49_0:GetNearestItem()

	arg_49_0:RefreshButton(var_49_0)
end

function var_0_0.RefreshItemScale(arg_50_0)
	for iter_50_0, iter_50_1 in pairs(arg_50_0.skinItemList_) do
		if iter_50_1.isActive then
			iter_50_1:RefreshShow()
		end
	end
end

function var_0_0.BeginDragFun(arg_51_0, arg_51_1, arg_51_2)
	arg_51_0:StopMoveTimer()
	arg_51_0:StopScrollTimer()
	arg_51_0.scrollView_:OnBeginDrag(arg_51_2)
end

function var_0_0.EndDragFun(arg_52_0, arg_52_1, arg_52_2)
	arg_52_0.scrollView_:OnEndDrag(arg_52_2)
	arg_52_0:AddScrollTimer()
end

function var_0_0.Scroll2SelectItem(arg_53_0, arg_53_1)
	for iter_53_0, iter_53_1 in ipairs(arg_53_0.skinItemList_) do
		if iter_53_1.isActive then
			local var_53_0 = iter_53_1:GetSkinID() == arg_53_0.skinID_

			if var_53_0 then
				arg_53_0:AddMoveTimer(iter_53_1, arg_53_1)
			end

			iter_53_1:ShowSelect(var_53_0)
		end
	end
end

function var_0_0.GetNearestItem(arg_54_0)
	local var_54_0 = 9999
	local var_54_1
	local var_54_2 = arg_54_0.scrollTf_.rect.width / 2

	for iter_54_0, iter_54_1 in ipairs(arg_54_0.skinItemList_) do
		if iter_54_1.isActive then
			local var_54_3 = math.abs(arg_54_0.contentTf_.localPosition.x + iter_54_1:GetLocalPosition().x - var_54_2)

			if var_54_3 < var_54_0 then
				var_54_0 = var_54_3
				var_54_1 = iter_54_1
			end
		end
	end

	return var_54_1
end

function var_0_0.AddScrollTimer(arg_55_0)
	arg_55_0:StopScrollTimer()

	arg_55_0.scrollTimer_ = nil
	arg_55_0.scrollTimer_ = FrameTimer.New(function()
		if math.abs(arg_55_0.scrollView_.velocity.x) <= 100 then
			arg_55_0.scrollTimer_:Stop()
			arg_55_0:AdjustItem()
		end
	end, 1, -1)

	arg_55_0.scrollTimer_:Start()
end

function var_0_0.StopScrollTimer(arg_57_0)
	if arg_57_0.scrollTimer_ then
		arg_57_0.scrollTimer_:Stop()

		arg_57_0.scrollTimer_ = nil
	end
end

function var_0_0.AddMoveTimer(arg_58_0, arg_58_1, arg_58_2)
	arg_58_0:StopMoveTimer()

	arg_58_0.moveTimer_ = FrameTimer.New(function()
		local var_59_0 = arg_58_0.contentTf_.rect.width / 2
		local var_59_1 = arg_58_0.scrollTf_.rect.width / 2
		local var_59_2 = arg_58_0.contentTf_.localPosition
		local var_59_3 = arg_58_1:GetLocalPosition().x * -1 + var_59_1
		local var_59_4 = arg_58_2 * math.pow(arg_58_0.scrollView_.decelerationRate, UnityEngine.Time.unscaledDeltaTime) * UnityEngine.Time.unscaledDeltaTime

		arg_58_0.contentTf_.localPosition = Vector3.Lerp(var_59_2, Vector3.New(var_59_3, var_59_2.y, var_59_2.z), var_59_4)

		if math.abs(var_59_2.x - var_59_3) <= 1 then
			arg_58_0.contentTf_.localPosition = Vector3(var_59_3, var_59_2.y, var_59_2.z)

			arg_58_0:StopMoveTimer()
		end
	end, 1, -1)

	arg_58_0.moveTimer_:Start()
end

function var_0_0.StopMoveTimer(arg_60_0)
	if arg_60_0.moveTimer_ then
		arg_60_0.moveTimer_:Stop()

		arg_60_0.moveTimer_ = nil
	end
end

function var_0_0.RefreshDlcMovie(arg_61_0)
	manager.audio:StopVoice()

	if isNil(arg_61_0.dlcMovie_) or isNil(arg_61_0.dlcPlayer_) then
		arg_61_0.dlcMovie_ = arg_61_0.dlcMovieGo_:GetComponent("CriManaMovieControllerForUI")
		arg_61_0.dlcPlayer_ = arg_61_0.dlcMovie_.player
		arg_61_0.dlcPlayer_.uiRenderMode = true
	end

	if isNil(arg_61_0.dlcBgMovie_) or isNil(arg_61_0.dlcBgPlayer_) then
		arg_61_0.dlcBgMovie_ = arg_61_0.bgMovieGo_:GetComponent("CriManaMovieControllerForUI")
		arg_61_0.dlcBgPlayer_ = arg_61_0.dlcBgMovie_.player
		arg_61_0.dlcBgPlayer_.uiRenderMode = true
	end

	if tostring(arg_61_0.dlcPlayer_.status) == "Playing" and arg_61_0.dlcPlayer_.IsPaused and tostring(arg_61_0.dlcBgPlayer_.status) == "Playing" and arg_61_0.dlcBgPlayer_.IsPaused and arg_61_0.skinID_ == arg_61_0.movieSkinId_ then
		arg_61_0.dlcMovie_:Pause(false)
		arg_61_0.dlcBgMovie_:Pause(false)
		arg_61_0.dlcHideMovieController_:SetSelectedIndex(1)

		return
	end

	if arg_61_0.movieSkinId_ and arg_61_0.movieSkinId_ ~= 0 and arg_61_0.skinID_ ~= arg_61_0.movieSkinId_ then
		arg_61_0.dlcMovie_:Stop()
		arg_61_0.dlcBgMovie_:Stop()

		arg_61_0.mainMovieRaw_.material = nil
		arg_61_0.bgMovieRaw_.material = nil

		arg_61_0:StopMovieStopTimer()

		arg_61_0.stopTimer_ = Timer.New(function()
			if tostring(arg_61_0.dlcPlayer_.status) == "Stop" and tostring(arg_61_0.dlcBgPlayer_.status) == "Stop" then
				arg_61_0:StartMovie()
				arg_61_0:StopMovieStopTimer()

				return
			end
		end, 0.033, -1)

		arg_61_0.stopTimer_:Start()
	else
		arg_61_0:StartMovie()
	end
end

function var_0_0.StartMovie(arg_63_0)
	local var_63_0 = getShopCfg(arg_63_0.dlcID_)
	local var_63_1
	local var_63_2

	if var_63_0 then
		local var_63_3

		var_63_1, var_63_3 = var_63_0.give_id or var_63_0.description, var_63_0.give or 1
	end

	local var_63_4
	local var_63_5

	if var_63_0 then
		if var_63_0.description then
			local var_63_6 = var_63_0.description

			var_63_5 = RechargeShopDescriptionCfg[var_63_6]
		else
			var_63_5 = ItemCfg[var_63_1]
		end
	else
		var_63_5 = ItemCfg[arg_63_0.dlcItemID_]
	end

	local var_63_7 = true

	for iter_63_0, iter_63_1 in ipairs(SkinSceneActionCfg.all) do
		local var_63_8 = SkinSceneActionCfg[iter_63_1]

		if var_63_8.special_scene_id == var_63_5.param[1] then
			arg_63_0.start_path = var_63_8.start_path

			if AssetDownloadManager.CheckResourcesNeedDownload({
				arg_63_0.start_path
			}) then
				arg_63_0.dlcMovie_:Stop()
				arg_63_0.dlcBgMovie_:Stop()
				arg_63_0.toDownloadDlcController:SetSelectedIndex(1)

				arg_63_0.movieSkinId_ = var_63_8.special_scene_id

				break
			end

			arg_63_0.dlcMovie_:Stop()
			arg_63_0.dlcBgMovie_:Stop()
			arg_63_0.toDownloadDlcController:SetSelectedIndex(0)
			arg_63_0:PlayDlcMovie()

			break
		end
	end
end

function var_0_0.PlayDlcMovie(arg_64_0)
	arg_64_0:Play()
	arg_64_0:StopMovieTimer()

	arg_64_0.timer_ = Timer.New(function()
		if arg_64_0.dlcPlayer_ and tostring(arg_64_0.dlcPlayer_.status) == "Stop" and arg_64_0.dlcBgPlayer_ and tostring(arg_64_0.dlcBgPlayer_.status) == "Stop" then
			arg_64_0:Play()

			return
		end

		if arg_64_0.dlcMovie_.isMaterialAvailable and arg_64_0.dlcBgMovie_.isMaterialAvailable then
			arg_64_0.dlcHideMovieController_:SetSelectedIndex(1)
			arg_64_0:StopMovieTimer()

			if not arg_64_0:IsTop() then
				arg_64_0:PauseDlcMovie()
			end

			return
		end
	end, 0.033, -1)

	arg_64_0.timer_:Start()
end

function var_0_0.PauseDlcMovie(arg_66_0)
	if arg_66_0.dlcMovie_ and arg_66_0.dlcPlayer_ and arg_66_0.dlcBgMovie_ and arg_66_0.dlcBgPlayer_ then
		arg_66_0.dlcMovie_:Pause(true)
		arg_66_0.dlcBgMovie_:Pause(true)
	end
end

function var_0_0.StopMovieTimer(arg_67_0)
	if arg_67_0.timer_ then
		arg_67_0.timer_:Stop()

		arg_67_0.timer_ = nil
	end
end

function var_0_0.StopMovieStopTimer(arg_68_0)
	if arg_68_0.stopTimer_ then
		arg_68_0.stopTimer_:Stop()

		arg_68_0.stopTimer_ = nil
	end
end

function var_0_0.Play(arg_69_0)
	SetFile(arg_69_0.dlcPlayer_, nil, arg_69_0.start_path, CriMana.Player.SetMode.New)
	arg_69_0.dlcPlayer_:Prepare()
	SetFile(arg_69_0.dlcBgPlayer_, nil, arg_69_0.start_path, CriMana.Player.SetMode.New)
	arg_69_0.dlcBgPlayer_:Prepare()

	local var_69_0 = manager.audio:GetMusicVolume()

	arg_69_0.dlcPlayer_:SetVolume(var_69_0)
	arg_69_0.dlcBgPlayer_:SetVolume(0)
	arg_69_0:SetVideoTrack(arg_69_0.dlcPlayer_, arg_69_0.start_path)
	arg_69_0:SetVideoTrack(arg_69_0.dlcBgPlayer_, arg_69_0.start_path)

	arg_69_0.movieSkinId_ = arg_69_0.skinID_

	arg_69_0.dlcMovie_:Play()
	arg_69_0.dlcBgMovie_:Play()
	arg_69_0.dlcHideMovieController_:SetSelectedIndex(1)
end

function var_0_0.SetVideoTrack(arg_70_0, arg_70_1, arg_70_2)
	local var_70_0 = manager.video:GetVedioTrackIndex(arg_70_2)

	arg_70_1:SetAudioTrack(var_70_0)
	arg_70_1:SetSubtitleChannel(var_70_0)
end

function var_0_0.RefreshShop(arg_71_0)
	arg_71_0:RefreshCurrencyToken(false)
end

function var_0_0.GetSkinItem(arg_72_0)
	return NewHeroSkinItem.New(arg_72_0.itemGo_, arg_72_0.contentTf_)
end

function var_0_0.OnSelectSkin(arg_73_0, arg_73_1, arg_73_2)
	arg_73_0:SetButtonActive(1)
end

function var_0_0.OnEnter(arg_74_0)
	ShopTools.FilterShopDataList(ShopConst.SHOP_ID.SKIN_SHOP)

	arg_74_0.descList_ = {}
	arg_74_0.showDlc_ = false

	local var_74_0 = HeroSkinRouteData:GetRoute()

	if not arg_74_0.params_.heroID then
		arg_74_0.heroID_ = var_74_0.heroID
	else
		arg_74_0.heroID_ = arg_74_0.params_.heroID
	end

	if not arg_74_0.params_.isBack then
		if not arg_74_0.params_.skinID then
			arg_74_0.skinID_ = HeroTools.HeroUsingSkinInfo(arg_74_0.heroID_).id
		else
			arg_74_0.skinID_ = arg_74_0.params_.skinID
			arg_74_0.params_.initSkinID = arg_74_0.params_.skinID
		end

		arg_74_0:ChangeShowDlcState(0)
	else
		if arg_74_0.skinID_ == 1 or arg_74_0.skinID_ == nil then
			if not arg_74_0.params_.skinID then
				arg_74_0.skinID_ = HeroTools.HeroUsingSkinInfo(arg_74_0.heroID_).id
			else
				arg_74_0.skinID_ = arg_74_0.params_.skinID
				arg_74_0.params_.initSkinID = arg_74_0.params_.skinID
			end
		end

		arg_74_0:ChangeShowDlcState(arg_74_0.showDlcState_ or 0)
	end

	arg_74_0.plotController_:SetSelectedState("off")

	arg_74_0.isOpenPlotTalk = false

	manager.heroRaiseTrack:SetModelState(arg_74_0.skinID_)
	arg_74_0:RefreshShop()
	arg_74_0:RegistEventListener(GET_SKIN_GIFT, handler(arg_74_0, arg_74_0.OnGetSkinGift))
	arg_74_0:RegistEventListener(RECHARGE_SUCCESS, function(arg_75_0)
		arg_74_0:RefreshUI()
	end)
	arg_74_0:RegistEventListener(HERO_BATTLE_SKIN_CHANGE, function(arg_76_0)
		arg_74_0:RefreshBattleSkinBtn()
		arg_74_0:RefreshBattleSkinTag(arg_76_0)
	end)
	arg_74_0:RefreshUI()

	if arg_74_0.params_.isDlc then
		arg_74_0.params_.isDlc = false

		arg_74_0:ChangeShowDlcState(1)
	elseif not arg_74_0.params_.isBack then
		arg_74_0:ChangeShowDlcState(0)
	else
		arg_74_0:ChangeShowDlcState(arg_74_0.showDlcState_)
	end

	arg_74_0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(arg_74_0, arg_74_0.BeginDragFun)))
	arg_74_0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(arg_74_0, arg_74_0.EndDragFun)))
	arg_74_0:Scroll2SelectItem(100)
	arg_74_0.cvBtnController_:SetSelectedIndex(0)
	arg_74_0:RegistEventListener(ACTIVITY_SKIN_MEMORY_COIN_POP, handler(arg_74_0, arg_74_0.OnSkinMemoryCoinPop))
	arg_74_0:RegistEventListener(CHANGE_POSTER_GIRL, handler(arg_74_0, arg_74_0.RefreshInfoOther))
	arg_74_0:CheckIsShowT0MemoryCoin()
end

function var_0_0.RefreshCV(arg_77_0)
	local var_77_0 = SettingData:GetSoundSettingData().voice_language
	local var_77_1 = VoiceLanguageCfg[var_77_0].affix
	local var_77_2 = arg_77_0.skinID_

	if SDKTools.GetIsTw() then
		arg_77_0.cvText_.text = "CV " .. (GetI18NText(SkinCfg[var_77_2]["cv_" .. var_77_1]) or "")

		if GetI18NText(SkinCfg[var_77_2]["cv_" .. var_77_1]) == "" then
			arg_77_0.cvText_.text = ""
		end
	elseif SDKTools.GetIsJapan() then
		arg_77_0.cvText_.text = "CV " .. (GetI18NText(SkinCfg[var_77_2]["cv_" .. var_77_1]) or "")

		if GetI18NText(SkinCfg[var_77_2]["cv_" .. var_77_1]) == "" then
			arg_77_0.cvText_.text = ""
		end
	elseif SDKTools.GetIsEnglish() then
		arg_77_0.cvText_.text = "CV " .. (GetI18NText(SkinCfg[var_77_2]["cv_" .. var_77_1]) or "")

		if GetI18NText(SkinCfg[var_77_2]["cv_" .. var_77_1]) == "" then
			arg_77_0.cvText_.text = ""
		end
	elseif SDKTools.GetIsKorea() then
		if var_77_1 == "en" then
			arg_77_0.cvText_.text = "CV " .. (GetI18NText(SkinCfg[var_77_2].cv_ko) or "")

			if GetI18NText(SkinCfg[var_77_2].cv_ko) == "" then
				arg_77_0.cvText_.text = ""
			end
		else
			arg_77_0.cvText_.text = "CV " .. (GetI18NText(SkinCfg[var_77_2]["cv_" .. var_77_1]) or "")

			if GetI18NText(SkinCfg[var_77_2]["cv_" .. var_77_1]) == "" then
				arg_77_0.cvText_.text = ""
			end
		end
	else
		arg_77_0.cvText_.text = "CV " .. (GetI18NText(SkinCfg[var_77_2]["cv_" .. var_77_1]) or "")

		if GetI18NText(SkinCfg[var_77_2]["cv_" .. var_77_1]) == "" then
			arg_77_0.cvText_.text = ""
		end
	end
end

function var_0_0.OnSkinMemoryCoinPop(arg_78_0)
	arg_78_0:CheckIsShowT0MemoryCoin()
end

function var_0_0.RefreshUIWithOutScroll(arg_79_0)
	arg_79_0:RefreshInfo()
	arg_79_0:SetButtonActive(arg_79_0:SkinState(arg_79_0.skinID_))
end

function var_0_0.RefreshButton(arg_80_0, arg_80_1)
	arg_80_0.selectIndex_ = arg_80_1.index_

	local var_80_0 = arg_80_1:SkinState()
	local var_80_1 = arg_80_1.skinID_
	local var_80_2 = SkinCfg[arg_80_1.skinID_].hero

	if var_80_1 == arg_80_0.skinID_ then
		arg_80_0:Scroll2SelectItem(5)

		return
	end

	OperationRecorder.RecordButtonTouch("hero_skin_" .. var_80_1)

	arg_80_0.skinID_ = var_80_1

	local var_80_3 = SkinCfg[var_80_1]

	arg_80_0:SetButtonActive(var_80_0)
	manager.heroRaiseTrack:SetModelState(arg_80_0.skinID_)
	SetActive(arg_80_0.plotBtn_, #var_80_3.plot_title > 0)
	arg_80_0.plotController_:SetSelectedState("off")

	arg_80_0.isOpenPlotTalk = false

	arg_80_0:RefreshInfo()
	arg_80_0:CheckDlc(var_80_1, var_80_0)
	arg_80_0:RefreshDlcBtn()
	arg_80_0:ChangeShowDlcState(0)
	arg_80_0:RefreshDescBtn()
	arg_80_0:RefreshGiftBtn()
	arg_80_0:HideMessage()
	arg_80_0:RefreshUI()
	arg_80_0:Scroll2SelectItem(5)
	arg_80_0:RefreshLimitTime(arg_80_0.skinID_)
end

function var_0_0.UpdateBar(arg_81_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.SetButtonActive(arg_82_0, arg_82_1)
	arg_82_0:CheckDlc(arg_82_0.skinID_, arg_82_1)

	if arg_82_0:JudgeDLC(arg_82_0.skinID_) then
		local var_82_0 = arg_82_0:isDlcOwned()

		arg_82_0.dlc_dlcController_:SetSelectedState(tostring(var_82_0))
	end

	arg_82_0.dlc_skinController_:SetSelectedState(tostring(HeroTools.GetHasOwnedSkin(arg_82_0.skinID_)))

	if arg_82_0.btnState_ == arg_82_1 then
		return
	end

	arg_82_0.statusController_:SetSelectedIndex(arg_82_1 - 1)

	arg_82_0.btnState_ = arg_82_1

	arg_82_0:UpdateBar()
end

function var_0_0.SkinState(arg_83_0, arg_83_1)
	arg_83_0:ChangeDlcBtn()

	if arg_83_0:isUnlock(arg_83_1) then
		if arg_83_0.params_.showOnly then
			return 8
		end

		if arg_83_0:isSelect(arg_83_1) then
			return 1
		end

		return 2
	else
		if HeroTools.GetIsLimitTimeSkin(arg_83_1) then
			if arg_83_0:isSelect(arg_83_1) then
				if HeroTools.IsSkinOutOfDate(arg_83_1) or arg_83_0.showDlcState_ == 1 then
					return 1
				else
					return 10
				end
			elseif HeroTools.IsSkinOutOfDate(arg_83_1) or arg_83_0.showDlcState_ == 1 then
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
			if arg_83_0.showDlcState_ == 1 and not arg_83_0:isDlcOwned() and HeroTools.IsSkinOnlySellDLC(arg_83_0.skinID_) then
				return 3
			end

			return 4
		end

		if ShopTools.IsPC() then
			local var_83_0 = HeroTools.GetShopIdBySkinId(arg_83_0.skinID_)

			if ShopTools.IsRMB(var_83_0) then
				return 12
			end
		end

		return 3
	end
end

function var_0_0.ChangeDlcBtn(arg_84_0)
	arg_84_0.dlcBtnController_:SetSelectedIndex(0)
	SetActive(arg_84_0.sourceDlcGo_, false)

	if arg_84_0:CheckIsSpecial() == 1 then
		arg_84_0:ChangeDlcBtnSpecial()

		return
	end

	if arg_84_0:CheckIsSpecial() == 2 then
		arg_84_0.sourceDlcText_.text = GetI18NText(ItemCfg[arg_84_0.dlcItemID_].desc_source) or ""

		if arg_84_0:isDlcOwned() then
			arg_84_0.dlcBtnController_:SetSelectedIndex(0)
		else
			SetActive(arg_84_0.sourceDlcGo_, true)
		end

		return
	end

	if arg_84_0.showDlcState_ == 1 then
		if arg_84_0:isUnlock(arg_84_0.skinID_) or HeroTools.GetIsLimitTimeSkin(arg_84_0.skinID_) then
			if arg_84_0:JudgeDLC(arg_84_0.skinID_) and not arg_84_0:isDlcOwned() then
				local var_84_0 = getShopCfg(arg_84_0.dlcID_)

				if ShopTools.CheckShopIsUnLock(var_84_0.shop_id) and var_84_0 and ShopTools.IsGoodCanDisplay(var_84_0.shop_id, var_84_0.goods_id) then
					arg_84_0.dlcBtnController_:SetSelectedIndex(1)
				end
			end
		elseif not arg_84_0:isDlcOwned() and HeroTools.IsSkinOnlySellDLC(arg_84_0.skinID_) then
			arg_84_0.dlcBtnController_:SetSelectedIndex(1)
		end
	end
end

function var_0_0.SaveRoute(arg_85_0)
	local var_85_0 = {
		name = "heroSkin",
		skinID = arg_85_0.skinID_,
		heroID = arg_85_0.heroID_
	}

	SkinTrialData:SaveRoute(var_85_0)
end

function var_0_0.GoToBuySkinPop(arg_86_0, arg_86_1)
	local var_86_0
	local var_86_1
	local var_86_2
	local var_86_3

	if arg_86_0.dlcID_ and arg_86_0.dlcID_ ~= 0 then
		var_86_0 = ShopTools.GetDiscount(arg_86_0.dlcID_) or nil

		local var_86_4

		var_86_1, var_86_4, var_86_3 = ShopTools.IsOnDiscountArea(arg_86_0.dlcID_)
	end

	if arg_86_0.showDlcState_ == 1 then
		if arg_86_0:CheckIsSpecial() == 0 then
			if var_86_0 and var_86_0 == 0 and var_86_1 and var_86_3 then
				JumpTools.OpenPageByJump("freeSkinBuyCheck", {
					goodID = arg_86_1,
					heroID = arg_86_0.heroID_,
					skinID = arg_86_0.skinID_,
					onlySkin = arg_86_0:isDlcOwned()
				}, ViewConst.SYSTEM_ID.RECHARGE_SKIN)
			else
				JumpTools.OpenPageByJump("newSkinBuyCheck", {
					goodID = arg_86_1,
					heroID = arg_86_0.heroID_,
					skinID = arg_86_0.skinID_,
					onlySkin = arg_86_0:isDlcOwned()
				}, ViewConst.SYSTEM_ID.RECHARGE_SKIN)
			end
		elseif arg_86_0:CheckIsSpecial() == 1 then
			JumpTools.OpenPageByJump("newSkinBuyCheck", {
				onlySkin = true,
				goodID = arg_86_1,
				heroID = arg_86_0.heroID_,
				skinID = arg_86_0.skinID_
			}, ViewConst.SYSTEM_ID.RECHARGE_SKIN)
		end
	elseif var_86_0 and var_86_0 == 0 and var_86_1 and var_86_3 then
		JumpTools.OpenPageByJump("freeSkinBuyCheck", {
			onlySkin = true,
			goodID = arg_86_1,
			heroID = arg_86_0.heroID_,
			skinID = arg_86_0.skinID_
		}, ViewConst.SYSTEM_ID.RECHARGE_SKIN)
	else
		JumpTools.OpenPageByJump("newSkinBuyCheck", {
			onlySkin = true,
			goodID = arg_86_1,
			heroID = arg_86_0.heroID_,
			skinID = arg_86_0.skinID_
		}, ViewConst.SYSTEM_ID.RECHARGE_SKIN)
	end
end

function var_0_0.AddUIListener(arg_87_0)
	arg_87_0:AddBtnListener(arg_87_0.portraitBtn_, nil, function()
		if arg_87_0.showDlcState_ == 1 then
			arg_87_0:Go("heroPortraitFull", {
				skinID = arg_87_0.skinID_
			})
		else
			arg_87_0:Go("heroPortrait", {
				skinID = arg_87_0.skinID_
			})
		end
	end)
	arg_87_0:AddBtnListener(arg_87_0.movieBtn_, nil, function()
		if arg_87_0.showDlcState_ == 1 then
			JumpTools.OpenPageByJump("/skinDlcShow", {
				goodId = arg_87_0.dlcID_,
				dlcItemID = arg_87_0.dlcItemID_
			})
		end
	end)
	arg_87_0:AddBtnListener(arg_87_0.replaceBtn_, nil, function()
		HeroAction.SelectSkin(arg_87_0.heroID_, arg_87_0.skinID_)

		if arg_87_0.showDlcState_ ~= 1 then
			arg_87_0:PlayVoice()
		end
	end)
	arg_87_0:AddBtnListener(arg_87_0.goBtn_, nil, function()
		arg_87_0.params_.skinID = arg_87_0.skinID_

		local var_91_0 = HeroTools.GetShopIdBySkinId(arg_87_0.skinID_)
		local var_91_1 = JumpTools.IsSystemLocked(501)

		if var_91_1 then
			ShowTips(JumpTools.GetSystemLockedTip(501, var_91_1))
		else
			arg_87_0:GoToBuySkinPop(var_91_0)
		end
	end)
	arg_87_0:AddBtnListener(arg_87_0.pcRmbBtn_, nil, function()
		if ShopTools.IsPC() then
			ShowTips("PC_SHOP_TIPS2")

			return
		end
	end)
	arg_87_0:AddBtnListener(arg_87_0.changeBtn_, nil, function()
		arg_87_0.params_.skinID = arg_87_0.skinID_

		CommonAction.TryToUseItem({
			{
				item_info = {
					num = 1,
					id = HeroTools.GetSkinChangeItem(arg_87_0.skinID_)
				},
				use_list = {}
			}
		})
	end)
	arg_87_0:AddBtnListener(arg_87_0.unlockBtn_, nil, function()
		if arg_87_0.isCanUnlock_ then
			HeroAction.UnLockSkin(arg_87_0.skinID_)
		end
	end)
	arg_87_0:AddBtnListener(arg_87_0.giftBtn_, nil, function()
		if arg_87_0:isUnlock(arg_87_0.skinID_) then
			PlayerAction.ReceiveSkinGift(arg_87_0.skinID_)
		else
			local var_95_0 = (SkinCfg[arg_87_0.skinID_] or {}).gift or {}

			JumpTools.OpenPageByJump("rewardPreview", {
				is_receive = false,
				rewardList = var_95_0
			}, ViewConst.SYSTEM_ID.REWARD_PREVIEW)
		end
	end)
	arg_87_0:AddBtnListener(arg_87_0.battleBtn_, nil, function()
		arg_87_0.params_.skinID = arg_87_0.skinID_

		local var_96_0 = 0
		local var_96_1 = SkinTagCfg[arg_87_0.skinID_]
		local var_96_2 = var_96_1.trial_activity
		local var_96_3 = var_96_2[1]

		for iter_96_0, iter_96_1 in ipairs(var_96_2) do
			local var_96_4 = ActivitySkinTrialCfg[iter_96_1].activity_id

			if ActivityData:GetActivityIsOpen(var_96_4) then
				var_96_0 = var_96_4
				var_96_3 = iter_96_1

				break
			end
		end

		SkinTrialData:SaveStageID(var_96_3)
		arg_87_0:SaveRoute()
		arg_87_0:Go("/sectionSelectHero", {
			activityID = var_96_0,
			section = var_96_1.trial_stage,
			sectionType = BattleConst.STAGE_TYPE_NEW.SKIN_TRIAL
		})
	end)
	arg_87_0:AddBtnListener(arg_87_0.plotBtn_, nil, function()
		if not arg_87_0.isOpenPlotTalk then
			arg_87_0:IndexPlotItem()
			arg_87_0.plotController_:SetSelectedState("on")
			UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_0.talkStateGo_.transform)

			arg_87_0.isOpenPlotTalk = true
		else
			arg_87_0.plotController_:SetSelectedState("off")

			arg_87_0.isOpenPlotTalk = false
		end
	end)
	arg_87_0:AddBtnListener(arg_87_0.plotTalkMaskBtn_, nil, function()
		arg_87_0.plotController_:SetSelectedState("off")

		arg_87_0.isOpenPlotTalk = false
	end)

	for iter_87_0, iter_87_1 in ipairs(arg_87_0.descBtn_) do
		arg_87_0:AddBtnListener(iter_87_1, nil, function()
			arg_87_0:ShowMessage()
		end)
	end

	arg_87_0:AddBtnListener(nil, arg_87_0.hideMessageBtn_, function()
		arg_87_0:HideMessage()
		SetActive(arg_87_0.hideMessageGo_, false)
	end)
	arg_87_0:AddBtnListener(nil, arg_87_0.dlc_skinBtn_, function()
		OperationRecorder.RecordButtonTouch("skin_pre_" .. arg_87_0.skinID_)

		arg_87_0.showDlc_ = false

		arg_87_0:ChangeShowDlcState(0)
	end)
	arg_87_0:AddBtnListener(nil, arg_87_0.dlc_dlcBtn_, function()
		if arg_87_0.dlcID_ then
			local var_102_0 = getShopCfg(arg_87_0.dlcID_)

			if var_102_0 then
				local var_102_1 = var_102_0.give_id or var_102_0.description

				if var_102_1 then
					OperationRecorder.RecordButtonTouch("skin_dlc_pre_" .. var_102_1)
				end
			else
				OperationRecorder.RecordButtonTouch("skin_dlc_pre_" .. arg_87_0.dlcItemID_ss)
			end
		end

		arg_87_0.showDlc_ = true

		arg_87_0:ChangeShowDlcState(1)
	end)
	arg_87_0:AddBtnListener(nil, arg_87_0.buyDlcBtn_, function()
		arg_87_0.params_.skinID = arg_87_0.skinID_

		local var_103_0 = HeroTools.GetShopIdBySkinId(arg_87_0.skinID_)
		local var_103_1 = JumpTools.IsSystemLocked(501)

		if var_103_1 then
			ShowTips(JumpTools.GetSystemLockedTip(501, var_103_1))
		else
			local var_103_2 = getShopCfg(arg_87_0.dlcID_)

			if var_103_2 == nil then
				return
			elseif ShopConst.SHOP_ID.DLC_SHOP == var_103_2.shop_id or var_103_2.shop_id == ShopConst.SHOP_ID.REPURCHASE_SHOP then
				JumpTools.OpenPageByJump("newSkinBuyCheck", {
					onlySkin = false,
					goodID = var_103_0,
					heroID = arg_87_0.heroID_,
					skinID = arg_87_0.skinID_
				}, ViewConst.SYSTEM_ID.SHOP)
			else
				local var_103_3 = getShopCfg(arg_87_0.dlcID_)

				JumpTools.GoToSystem("/shop", {
					shopId = var_103_3.shop_id
				}, ViewConst.SYSTEM_ID.SHOP)
			end
		end
	end)
	arg_87_0.scrollView_.onValueChanged:AddListener(function()
		arg_87_0:RefreshItemScale()
	end)
	arg_87_0:AddBtnListener(arg_87_0.switchInfoBtn_, nil, function()
		if arg_87_0.infoController_:GetSelectedState() == "tag" then
			arg_87_0:SwitchInfoController("description")
		else
			arg_87_0:SwitchInfoController("tag")
		end
	end)
	arg_87_0:AddBtnListener(arg_87_0.downloadDlcBtn_, nil, function()
		DownloadSingleAssetQuanquan(arg_87_0.start_path, function()
			arg_87_0.toDownloadDlcController:SetSelectedIndex(0)
			arg_87_0:PlayDlcMovie()
		end)
	end)
	arg_87_0:AddBtnListenerOther()
end

function var_0_0.AddBtnListenerOther(arg_108_0)
	arg_108_0:AddBtnListener(arg_108_0.changeBtn_, nil, function()
		arg_108_0.params_.skinID = arg_108_0.skinID_

		CommonAction.TryToUseItem({
			{
				item_info = {
					num = 1,
					id = HeroTools.GetSkinChangeItem(arg_108_0.skinID_)
				},
				use_list = {}
			}
		})
	end)
	arg_108_0:AddBtnListener(arg_108_0.btn_dlcSpecialExchangeBtn_, nil, function()
		local var_110_0 = getShopCfg(arg_108_0.dlcID_)

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

function var_0_0.OnTryToUseItem(arg_113_0, arg_113_1, arg_113_2)
	if isSuccess(arg_113_1.result) then
		local var_113_0 = arg_113_2.use_item_list[1].item_info.id
		local var_113_1 = ItemCfg[var_113_0].param[1]

		getReward({
			{
				num = 1,
				id = var_113_1
			}
		})

		local var_113_2 = SkinCfg[var_113_1].hero

		HeroAction.UpdateSkinCouponRedPoint(var_113_2)
		HeroAction.SkinAdd(arg_113_0.skinID_)
		arg_113_0:OnTryToUseItemOther(var_113_1)
	else
		ShowTips(arg_113_1.result)
	end

	arg_113_0:RefreshUI()
end

function var_0_0.OnTryToUseItemOther(arg_114_0, arg_114_1)
	arg_114_0:SetButtonActive(2)
	manager.redPoint:setTip(RedPointConst.HERO_SKIN_ROUTE_ID .. arg_114_1, 0, RedPointStyle.SHOW_NEW_TAG)
end

function var_0_0.ChangeShowDlcState(arg_115_0, arg_115_1)
	arg_115_0.dlcHideMovieController_:SetSelectedIndex(0)

	arg_115_0.showDlcState_ = arg_115_1

	arg_115_0.dlcController_:SetSelectedIndex(arg_115_1)

	if arg_115_1 == 0 then
		arg_115_0.dlc_skinBtn_.interactable = false
		arg_115_0.dlc_dlcBtn_.interactable = true

		manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
			1,
			4
		}, arg_115_0.displayGo_)
		manager.heroRaiseTrack:SetModelState(arg_115_0.skinID_)
		arg_115_0:PauseDlcMovie()
		arg_115_0.buyBtnMultiController_:SetSelectedIndex(0)
		SetActive(arg_115_0.movieBtn_.gameObject, false)
		arg_115_0.cvBtnController_:SetSelectedIndex(0)
	elseif arg_115_1 == 1 then
		local var_115_0 = ShopTools.HasMultiPay(arg_115_0.dlcID_)

		arg_115_0.dlc_skinBtn_.interactable = true
		arg_115_0.dlc_dlcBtn_.interactable = false

		manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.null)
		arg_115_0:RefreshDlcMovie()
		SetActive(arg_115_0.movieBtn_.gameObject, true)
		arg_115_0.buyBtnMultiController_:SetSelectedIndex(var_115_0 and 1 or 0)
		arg_115_0.cvBtnController_:SetSelectedIndex(1)
		arg_115_0:RefreshCV()
	end

	arg_115_0:ChangeShowDlcStateOther()
end

function var_0_0.ChangeShowDlcStateOther(arg_116_0)
	arg_116_0:ChangeDlcBtn()
	arg_116_0:SetButtonActive(arg_116_0:SkinState(arg_116_0.skinID_))
	arg_116_0:RefreshInfo()
end

function var_0_0.RefreshInfo(arg_117_0)
	if arg_117_0.showDlcState_ == 1 then
		local var_117_0 = getShopCfg(arg_117_0.dlcID_)
		local var_117_1

		if var_117_0 then
			var_117_1 = RechargeShopDescriptionCfg[var_117_0.description]
		else
			var_117_1 = RechargeShopDescriptionCfg[arg_117_0.dlcItemID_]
		end

		if var_117_1 == nil then
			if var_117_0 then
				var_117_1 = ItemCfg[var_117_0.give_id]
			else
				var_117_1 = ItemCfg[arg_117_0.dlcItemID_]
			end
		end

		local var_117_2 = string.format("%s", var_117_1.name)
		local var_117_3 = string.format("%s", var_117_1.desc)

		arg_117_0.nameText_.text = GetI18NText(var_117_2)
		arg_117_0.infoText_.text = GetI18NText(var_117_3)
	else
		arg_117_0.nameText_.text = GetI18NText(SkinCfg[arg_117_0.skinID_].name)
		arg_117_0.infoText_.text = GetI18NText(SkinCfg[arg_117_0.skinID_].desc)
	end

	arg_117_0:CleanMessage()

	local var_117_4 = HeroTools.GetSkinChangeItem(arg_117_0.skinID_)

	if var_117_4 then
		arg_117_0.sourcetextText_.text = GetI18NText(ItemCfg[var_117_4].desc_source) or ""
		arg_117_0.couponImg_.sprite = ItemTools.getItemLittleSprite(var_117_4)
	else
		arg_117_0.sourcetextText_.text = GetI18NText(ItemCfg[arg_117_0.skinID_].desc_source) or ""
	end

	if HeroTools.IsSkinOnlySellDLC(arg_117_0.skinID_) then
		arg_117_0.sourcetextText_.text = GetTips("ACTIVITY_REWARD_RECEIVE") or ""
	end

	arg_117_0:RefreshInfoOther()
end

function var_0_0.RefreshInfoOther(arg_118_0)
	if arg_118_0.btnState_ == 5 then
		if HeroTools.CanChangeSkin(arg_118_0.skinID_) then
			manager.redPoint:SetRedPointIndependent(arg_118_0.changeBtn_.transform, true)
		else
			manager.redPoint:SetRedPointIndependent(arg_118_0.changeBtn_.transform, false)
		end
	end

	if arg_118_0.btnState_ == 6 then
		arg_118_0.isCanUnlock_ = true

		for iter_118_0, iter_118_1 in pairs(SkinCfg[arg_118_0.skinID_].unlock_id_list) do
			local var_118_0, var_118_1, var_118_2 = IsConditionAchieved(iter_118_1, {
				heroId = arg_118_0.heroID_
			})

			if var_118_0 then
				arg_118_0["taskController_" .. iter_118_0]:SetSelectedState("true")
			else
				arg_118_0.isCanUnlock_ = false

				arg_118_0["taskController_" .. iter_118_0]:SetSelectedState("false")
			end

			arg_118_0["tasktext_" .. iter_118_0].text = GetI18NText(ConditionCfg[iter_118_1].desc)
		end

		arg_118_0.unlockController_:SetSelectedState(arg_118_0.isCanUnlock_ and "false" or "true")
	end

	arg_118_0:RefreshBattleSkinBtn()
	arg_118_0:RefreshBattleSkinTag()
	arg_118_0:RefreshLimitTime(arg_118_0.skinID_)
end

function var_0_0.RefreshBattleSkinTag(arg_119_0, arg_119_1)
	if arg_119_1 then
		arg_119_0.battleSkinID_ = arg_119_1
	end

	if not arg_119_0.battleSkinID_ or not arg_119_0.skinItemList_ then
		return
	end

	if arg_119_0.battleSkinID_ == 0 then
		arg_119_0.battleSkinID_ = arg_119_0.heroID_
	end

	for iter_119_0, iter_119_1 in ipairs(arg_119_0.skinItemList_) do
		iter_119_1:ShowBattleSkin(arg_119_0.battleSkinID_ == iter_119_1.skinID_)
	end
end

return var_0_0
