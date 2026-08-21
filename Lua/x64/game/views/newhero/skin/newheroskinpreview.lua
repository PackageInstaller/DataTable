local var_0_0 = import("game.views.newHero.skin.NewHeroSkinView")
local var_0_1 = class("NewHeroSkinPreview", var_0_0)

function var_0_1.RefreshShop(arg_1_0)
	arg_1_0:RefreshCurrencyToken(true)
end

function var_0_1.GetSkinItem(arg_2_0)
	return NewHeroSkinPreviewItem.New(arg_2_0.itemGo_, arg_2_0.contentTf_)
end

function var_0_1.OnSelectSkin(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:SetButtonActive(8)
end

function var_0_1.OnEnter(arg_4_0)
	ShopTools.FilterShopDataList(ShopConst.SHOP_ID.SKIN_SHOP)

	arg_4_0.descList_ = {}
	arg_4_0.showDlc_ = false

	local var_4_0 = HeroSkinRouteData:GetRoute()

	if not arg_4_0.params_.heroID then
		arg_4_0.heroID_ = var_4_0.heroID
	else
		arg_4_0.heroID_ = arg_4_0.params_.heroID
	end

	if not arg_4_0.params_.isBack then
		if not arg_4_0.params_.skinID then
			arg_4_0.skinID_ = HeroTools.HeroUsingSkinInfo(arg_4_0.heroID_).id
		else
			arg_4_0.skinID_ = arg_4_0.params_.skinID

			if not arg_4_0.params_.initSkinID then
				arg_4_0.params_.initSkinID = arg_4_0.params_.skinID
			end
		end
	elseif arg_4_0.skinID_ == 1 or arg_4_0.skinID_ == nil then
		if not arg_4_0.params_.skinID then
			arg_4_0.skinID_ = HeroTools.HeroUsingSkinInfo(arg_4_0.heroID_).id
		else
			arg_4_0.skinID_ = arg_4_0.params_.skinID
			arg_4_0.params_.initSkinID = arg_4_0.params_.skinID
		end
	end

	arg_4_0.plotController_:SetSelectedState("off")

	arg_4_0.isOpenPlotTalk = false

	manager.heroRaiseTrack:SetModelState(arg_4_0.skinID_)
	arg_4_0:RefreshShop()
	arg_4_0:RegistEventListener(GET_SKIN_GIFT, handler(arg_4_0, arg_4_0.OnGetSkinGift))
	arg_4_0:RegistEventListener(RECHARGE_SUCCESS, function(arg_5_0)
		arg_4_0:RefreshUI()
	end)
	arg_4_0:RegistEventListener(HERO_BATTLE_SKIN_CHANGE, function(arg_6_0)
		arg_4_0:RefreshBattleSkinBtn()
		arg_4_0:RefreshBattleSkinTag(arg_6_0)
	end)
	arg_4_0:RefreshUI()

	if arg_4_0.params_.isDlc then
		arg_4_0.params_.isDlc = false

		arg_4_0:ChangeShowDlcState(1)
	elseif not arg_4_0.params_.isBack then
		arg_4_0:ChangeShowDlcState(0)
	else
		arg_4_0:ChangeShowDlcState(arg_4_0.showDlcState_ or 0)
	end

	manager.notify:RegistListener(CHANGE_POSTER_GIRL, handler(arg_4_0, arg_4_0.RefreshInfoOther))
	arg_4_0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(arg_4_0, arg_4_0.BeginDragFun)))
	arg_4_0.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(arg_4_0, arg_4_0.EndDragFun)))
	arg_4_0:Scroll2SelectItem(100)
end

function var_0_1.RefreshUIWithOutScroll(arg_7_0)
	arg_7_0:RefreshInfo()
	arg_7_0:RefreshCost()
	arg_7_0:SetButtonActive(arg_7_0:SkinState(arg_7_0.skinID_))
end

function var_0_1.RefreshButton(arg_8_0, arg_8_1)
	arg_8_0.selectIndex_ = arg_8_1.index_

	local var_8_0 = arg_8_1:SkinState()
	local var_8_1 = arg_8_1.skinID_

	manager.redPoint:setTip(RedPointConst.HERO_SKIN_ROUTE_ID .. arg_8_1.skinID_, 0, RedPointStyle.SHOW_NEW_TAG)

	if var_8_1 == arg_8_0.skinID_ then
		arg_8_0:Scroll2SelectItem(5)

		return
	end

	OperationRecorder.RecordButtonTouch("hero_skin_" .. var_8_1)

	arg_8_0.skinID_ = var_8_1

	local var_8_2 = SkinCfg[var_8_1]

	arg_8_0:SetButtonActive(var_8_0)
	manager.heroRaiseTrack:SetModelState(arg_8_0.skinID_)
	SetActive(arg_8_0.plotBtn_, #var_8_2.plot_title > 0)
	arg_8_0.plotController_:SetSelectedState("off")

	arg_8_0.isOpenPlotTalk = false

	arg_8_0:RefreshInfo()
	arg_8_0:RefreshCost()
	arg_8_0:CheckDlc(var_8_1, var_8_0)
	arg_8_0:RefreshDlcBtn()
	arg_8_0:ChangeShowDlcState(0)
	arg_8_0:RefreshDescBtn()
	arg_8_0:RefreshGiftBtn()
	arg_8_0:HideMessage()
	arg_8_0:RefreshUI()
	arg_8_0:Scroll2SelectItem(5)
end

function var_0_1.UpdateBar(arg_9_0)
	if arg_9_0.btnState_ == 3 or arg_9_0.dlcBtnController_:GetSelectedState() == "buyDlc" then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR,
			CurrencyConst.CURRENCY_TYPE_DIAMOND,
			CurrencyConst.GetPlatformDiamondId(),
			CurrencyConst.CURRENCY_TYPE_SKIN
		})
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
		manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)
		manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_SKIN, true)
		manager.windowBar:SetBarCanClick(CurrencyConst.CURRENCY_TYPE_SKIN, true)
	else
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	end
end

function var_0_1.SetButtonActive(arg_10_0, arg_10_1)
	arg_10_0:CheckDlc(arg_10_0.skinID_, arg_10_1)

	if arg_10_0:JudgeDLC(arg_10_0.skinID_) then
		if not arg_10_0:isDlcOwned() then
			arg_10_0.dlc_dlcController_:SetSelectedIndex(0)
		else
			arg_10_0.dlc_dlcController_:SetSelectedIndex(1)
		end
	end

	if arg_10_1 == 8 and HeroTools.GetHasOwnedSkin(arg_10_0.skinID_) or arg_10_1 == 7 and arg_10_0.skinID_ ~= arg_10_0.heroID_ or arg_10_1 == 9 and HeroTools.GetHasOwnedSkin(arg_10_0.skinID_) then
		arg_10_0.dlc_skinController_:SetSelectedIndex(1)
	else
		arg_10_0.dlc_skinController_:SetSelectedIndex(0)
	end

	if arg_10_0.btnState_ == arg_10_1 then
		return
	end

	arg_10_0.statusController_:SetSelectedIndex(arg_10_1 - 1)

	arg_10_0.btnState_ = arg_10_1

	arg_10_0:UpdateBar()
end

function var_0_1.SkinState(arg_11_0, arg_11_1)
	arg_11_0:ChangeDlcBtn()

	if arg_11_0:isUnlockOrCanChange(arg_11_1) then
		if HeroTools.GetHeroIsUnlock(SkinCfg[arg_11_0.skinID_].hero) == false and arg_11_0.skinID_ == SkinCfg[arg_11_0.skinID_].hero then
			return 7
		end

		if arg_11_0.showDlcState_ == 1 and not arg_11_0:isDlcOwned() then
			return 9
		end

		return 8
	else
		if HeroTools.IsSkinOutOfDate(arg_11_1) then
			if arg_11_0.showDlcState_ == 1 and not arg_11_0:isDlcOwned() and HeroTools.IsSkinOnlySellDLC(arg_11_0.skinID_) then
				return 9
			end

			if arg_11_0.showDlcState_ == 1 and arg_11_0:isDlcOwned() and HeroTools.IsSkinOnlySellDLC(arg_11_0.skinID_) then
				return 8
			end

			return 4
		end

		if ShopTools.IsPC() then
			local var_11_0 = HeroTools.GetShopIdBySkinId(arg_11_0.skinID_)

			if ShopTools.IsRMB(var_11_0) then
				return 12
			end
		end

		return 3
	end
end

function var_0_1.ChangeDlcBtn(arg_12_0)
	local var_12_0 = 0

	if arg_12_0:JudgeDLC(arg_12_0.skinID_) then
		local var_12_1 = arg_12_0:CheckIsSpecial()

		if var_12_1 == 1 then
			arg_12_0:ChangeDlcBtnSpecial()

			return
		elseif var_12_1 == 2 then
			arg_12_0.sourceDlcText_.text = GetI18NText(ItemCfg[arg_12_0.dlcItemID_].desc_source) or ""

			if not arg_12_0:isDlcOwned() then
				var_12_0 = 4
			end
		else
			local var_12_2 = getShopCfg(arg_12_0.dlcID_)

			if arg_12_0.showDlcState_ == 1 and ShopTools.CheckShopIsUnLock(var_12_2.shop_id) and ShopTools.IsGoodCanDisplay(var_12_2.shop_id, var_12_2.goods_id) then
				local var_12_3 = arg_12_0:isUnlock(arg_12_0.skinID_)
				local var_12_4 = arg_12_0:isDlcOwned()

				if var_12_3 and not var_12_4 then
					var_12_0 = 1
				elseif not var_12_3 and var_12_4 then
					var_12_0 = 3
				end
			end
		end
	end

	arg_12_0.dlcBtnController_:SetSelectedIndex(var_12_0)
end

function var_0_1.SaveRoute(arg_13_0)
	local var_13_0 = {
		name = "heroSkinPreview",
		skinID = arg_13_0.skinID_,
		heroID = arg_13_0.heroID_,
		initSkinID = arg_13_0.params_.initSkinID
	}

	SkinTrialData:SaveRoute(var_13_0)
end

function var_0_1.AddBtnListenerOther(arg_14_0)
	arg_14_0:AddBtnListener(arg_14_0.btn_dlcSpecialExchangeBtn_, nil, function()
		local var_15_0 = getShopCfg(arg_14_0.dlcID_)

		ShowMessageBox({
			content = string.format(GetTips("SHOP_DLC_LINK"), ItemTools.getItemName(var_15_0.give_id)),
			OkCallback = function()
				if var_15_0 then
					JumpTools.GoToSystem("/shop", {
						shopId = var_15_0.shop_id
					}, ViewConst.SYSTEM_ID.SHOP)
				end
			end,
			CancelCallback = function()
				return
			end
		})
	end)
end

function var_0_1.OnTryToUseItemOther(arg_18_0, arg_18_1)
	arg_18_0:SetButtonActive(8)
end

function var_0_1.ChangeShowDlcStateOther(arg_19_0)
	arg_19_0:RefreshCost()
	arg_19_0:ChangeDlcBtn()
	arg_19_0:SetButtonActive(arg_19_0:SkinState(arg_19_0.skinID_))
	arg_19_0:RefreshInfo()
end

function var_0_1.RefreshInfoOther(arg_20_0)
	arg_20_0:RefreshLimitTime(arg_20_0.skinID_)
	arg_20_0:RefreshBattleSkinBtn(arg_20_0.skinID_)
	arg_20_0:RefreshBattleSkinTag(arg_20_0.battleSkinID_)
end

function var_0_1.RefreshCost(arg_21_0)
	local var_21_0 = getShopCfg(HeroTools.GetShopIdBySkinId(arg_21_0.skinID_))

	SetActive(arg_21_0.tokenPlusGo_, false)

	if var_21_0 then
		local var_21_1 = 0
		local var_21_2 = 0
		local var_21_3
		local var_21_4
		local var_21_5
		local var_21_6 = var_21_0.dlc or nil
		local var_21_7 = false

		if var_21_6 and var_21_6 ~= 0 then
			var_21_3 = getShopCfg(var_21_6)

			if var_21_3 then
				var_21_1, _, _, var_21_4 = ShopTools.GetPrice(var_21_6)
			end

			var_21_7 = ShopTools.HasMultiPay(var_21_6)
		end

		local var_21_8 = ShopTools.GetPrice(var_21_0.goods_id, var_21_0.shop_id)
		local var_21_9 = var_21_8

		if arg_21_0:CheckIsSpecial() == 0 and arg_21_0.showDlcState_ == 1 and not arg_21_0:isDlcOwned() then
			SetActive(arg_21_0.tokenPlusGo_, true)

			var_21_9 = var_21_8 + var_21_1
		end

		if var_21_0.cost_type == 1 then
			arg_21_0.currencyImage_.sprite = nil
			arg_21_0.currencyText_.text = ShopTools.GetMoneySymbol(var_21_0.goods_id) .. var_21_8

			SetActive(arg_21_0.currencyGo_, false)
		else
			arg_21_0.currencyImage_.sprite = ItemTools.getItemLittleSprite(var_21_0.cost_id)
			arg_21_0.currencyText_.text = var_21_9

			if var_21_7 then
				arg_21_0.goodDlcCurrencyImg_.sprite = ItemTools.getItemLittleSprite(var_21_0.cost_id)
				arg_21_0.goodDlcCurrencyText_.text = var_21_8
				arg_21_0.goodDlcSecondCurrencyImg_.sprite = ItemTools.getItemLittleSprite(var_21_3.cost_id_2)
				arg_21_0.goodDlcSecondCurrencyText_.text = var_21_4
			end

			SetActive(arg_21_0.currencyGo_, true)
		end

		if var_21_1 and var_21_1 ~= 0 then
			SetActive(arg_21_0.dlctokenGo_, true)

			if ShopTools.IsRMB(var_21_6) then
				arg_21_0.dlccurrencyImage_.sprite = nil
				arg_21_0.dlccurrencyText_.text = ShopTools.GetMoneySymbol(var_21_6) .. var_21_1

				SetActive(arg_21_0.dlccurrencyGo_, false)
			else
				arg_21_0.dlccurrencyImage_.sprite = ItemTools.getItemLittleSprite(var_21_0.cost_id)
				arg_21_0.dlccurrencyText_.text = var_21_1

				if var_21_7 then
					arg_21_0.dlcSecondCurrencyImg_.sprite = ItemTools.getItemLittleSprite(var_21_3.cost_id_2)
					arg_21_0.dlcSecnondCurrencyText_.text = var_21_4
				end

				SetActive(arg_21_0.dlccurrencyGo_, true)
			end
		elseif var_21_6 and var_21_6 ~= 0 and var_21_1 == 0 then
			local var_21_10

			_, var_21_10 = ShopTools.GetPrice(var_21_6)
			arg_21_0.dlccurrencyImage_.sprite = ItemTools.getItemLittleSprite(var_21_3.cost_id)
			arg_21_0.dlccurrencyText_.text = var_21_10
		end

		SetActive(arg_21_0.dlcSecondCurrencyGo_, var_21_7)
	end

	arg_21_0:RefreshTokenNumText()
end

local function var_0_2(arg_22_0)
	local var_22_0 = 0
	local var_22_1 = arg_22_0.skinID_

	if ShopTools.IsPC() then
		return 0
	end

	if arg_22_0:CheckIsSpecial() == 1 then
		return 0
	end

	if not arg_22_0:isUnlockOrCanChange(var_22_1) and not HeroTools.IsSkinOnlySellDLC(var_22_1) then
		var_22_0 = var_22_0 + 1
	end

	if arg_22_0.showDlcState_ == 1 and not arg_22_0:isDlcOwned() then
		var_22_0 = var_22_0 + 1
	end

	return var_22_0
end

function var_0_1.RefreshTokenNumText(arg_23_0)
	local var_23_0 = var_0_2(arg_23_0)

	SetActive(arg_23_0.tokenNum1Go_, var_23_0 == 1)
	SetActive(arg_23_0.tokenNum2Go_, var_23_0 == 2)
end

return var_0_1
