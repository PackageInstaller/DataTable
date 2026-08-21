local var_0_0 = import("game.views.shop.base.ShopItemBase")
local var_0_1 = class("RechargeGiftItem", var_0_0)

function var_0_1.InitUI(arg_1_0)
	arg_1_0:BindCfgUI()

	arg_1_0.haveTimeLimitController_ = ControllerUtil.GetController(arg_1_0.gameObject_.transform, "haveTimeLimit")
	arg_1_0.costTypeController_ = ControllerUtil.GetController(arg_1_0.gameObject_.transform, "costType")
	arg_1_0.tipController_ = ControllerUtil.GetController(arg_1_0.gameObject_.transform, "tip")
	arg_1_0.statusController_ = ControllerUtil.GetController(arg_1_0.gameObject_.transform, "status")

	if arg_1_0.rechargeskinticketitemuiControllerexcollection_ then
		arg_1_0.remommendController_ = arg_1_0.rechargeskinticketitemuiControllerexcollection_:GetController("sp")
	end
end

function var_0_1.GoToBuyGood(arg_2_0, arg_2_1)
	local var_2_0 = getShopCfg(arg_2_1)
	local var_2_1 = {}

	if var_2_0.description then
		var_2_1 = RechargeShopDescriptionCfg[var_2_0.description]
	else
		var_2_1 = ItemCfg[var_2_0.give_id]
	end

	if ShopTools.IsPC() and ShopTools.IsRMB(arg_2_1) and not SDKTools.GetIsOverSea() then
		ShowTips("PC_SHOP_TIPS2")

		return
	end

	local var_2_2 = ShopTools.CheckSoldOut(arg_2_1)
	local var_2_3 = ShopTools.CheckLevelEnough(arg_2_1)
	local var_2_4 = var_2_0.shop_id

	if ShopTools.CheckGiftSkinOwn(arg_2_1) then
		-- block empty
	elseif var_2_2 then
		-- block empty
	elseif not var_2_3 then
		-- block empty
	else
		SendMessageManagerToSDK("purchase_click_gp_once")

		if arg_2_0.statusController_:GetSelectedState() == "normal" then
			if var_2_1.type == ItemConst.ITEM_TYPE.GIFT and arg_2_0.itemCfg.sub_type == ItemConst.ITEM_SUB_TYPE.FUKUBUKURO then
				JumpTools.OpenPageByJump("rechargeFukubukuro", {
					goodID = arg_2_1,
					shopID = var_2_0.shop_id
				})
			else
				JumpTools.OpenPageByJump("rechargeGiftPop", {
					goodId = arg_2_1,
					buyTime = arg_2_0.buyTime,
					itemCfg = ItemCfg[var_2_0.give_id],
					shopId = var_2_4,
					shopCfg = var_2_0,
					itemDesCfg_ = var_2_1
				})
			end
		end

		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_giftbox = arg_2_1
		})
	end
end

function var_0_1.GoToBuyBoxWithTips(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	if arg_3_0:IsRecommend(arg_3_3) then
		ShowMessageBox({
			isTop = true,
			title = GetTips("PROMPT"),
			content = GetTips("RECHARGE_SHOP_POP_TIP"),
			OkCallback = function()
				local var_4_0 = RechargeShopDescriptionCfg[arg_3_3.description]

				arg_3_0:GotoRecommendBox(var_4_0.recommend_item)
			end,
			CancelCallback = function()
				arg_3_0:GotoBuyBox(arg_3_1, arg_3_4, arg_3_2, arg_3_3, arg_3_5)
			end
		})
	else
		arg_3_0:GotoBuyBox(arg_3_1, arg_3_4, arg_3_2, arg_3_3, arg_3_5)
	end
end

function var_0_1.GotoBuyBox(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
	if arg_6_2.type == ItemConst.ITEM_TYPE.GIFT and arg_6_0.itemCfg.sub_type == ItemConst.ITEM_SUB_TYPE.FUKUBUKURO then
		JumpTools.OpenPageByJump("rechargeFukubukuro", {
			goodID = arg_6_1,
			shopID = arg_6_4.shop_id
		})
	else
		JumpTools.OpenPageByJump("rechargeGiftPop", {
			goodId = arg_6_1,
			buyTime = arg_6_3,
			itemCfg = ItemCfg[arg_6_4.give_id],
			shopId = arg_6_5,
			shopCfg = arg_6_4,
			itemDesCfg_ = arg_6_2
		})
	end
end

function var_0_1.GotoRecommendBox(arg_7_0, arg_7_1)
	local var_7_0 = getShopCfg(arg_7_1)
	local var_7_1 = ShopListCfg[var_7_0.shop_id]
	local var_7_2 = var_7_1 and var_7_1.display_group or 1

	childShopIndex = var_7_1 and var_7_1.display_index or 1

	JumpTools.GoToSystem("/rechargeMain", {
		page = var_7_2,
		childShopIndex = childShopIndex
	}, ViewConst.SYSTEM_ID.RECHARGE_MAIN)
	arg_7_0:GoToBuyGood(arg_7_1)
end

function var_0_1.AddUIListener(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.bgBtn_, nil, function()
		if ShopTools.IsPC() and ShopTools.IsRMB(arg_8_0.goodID) and not SDKTools.GetIsOverSea() then
			if ShopTools.IsLimitRecharge() and ShopConst.PC_LOCK_SHOP[arg_8_0.shopID] ~= true then
				ShowTips("PC_SHOP_TIPS2")

				return
			end

			if arg_8_0.shopID == ShopConst.SHOP_ID.LIMIT_SUPPLY then
				ShowTips("PC_SHOP_TIPS2")

				return
			end

			if not SDKTools.GetIsOverSea() then
				ShopTools.OpenWebRecharge()

				return
			end
		end

		SendMessageManagerToSDK("purchase_click_gp_once")

		if arg_8_0.statusController_:GetSelectedState() == "normal" then
			arg_8_0:GoToBuyBoxWithTips(arg_8_0.goodID, arg_8_0.buyTime, arg_8_0.shopCfg, arg_8_0.itemCfg, arg_8_0.shopID)
		end

		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_giftbox = arg_8_0.goodID
		})
	end)

	if arg_8_0.buttonBtn_ then
		arg_8_0:AddBtnListener(arg_8_0.buttonBtn_, nil, function()
			if ShopTools.IsPC() and ShopTools.IsRMB(arg_8_0.goodID) and not SDKTools.GetIsOverSea() then
				if ShopTools.IsLimitRecharge() and ShopConst.PC_LOCK_SHOP[arg_8_0.shopID] ~= true then
					ShowTips("PC_SHOP_TIPS2")

					return
				end

				if arg_8_0.shopID == ShopConst.SHOP_ID.LIMIT_SUPPLY then
					ShowTips("PC_SHOP_TIPS2")

					return
				end

				if not SDKTools.GetIsOverSea() then
					ShopTools.OpenWebRecharge()

					return
				end
			end

			SendMessageManagerToSDK("purchase_click_gp_once")

			if arg_8_0.statusController_:GetSelectedState() == "normal" then
				arg_8_0:GoToBuyBoxWithTips(arg_8_0.goodID, arg_8_0.buyTime, arg_8_0.shopCfg, arg_8_0.itemCfg, arg_8_0.shopID)
			end

			SDKTools.SendPaymentMessageToSDK("payment_touch", {
				payment_giftbox = arg_8_0.goodID
			})
		end)
	end

	if arg_8_0.specialBtn_ then
		arg_8_0:AddBtnListener(arg_8_0.specialBtn_, nil, function()
			if arg_8_0.shopCfg and arg_8_0.shopCfg.description then
				local var_11_0 = RechargeShopDescriptionCfg[arg_8_0.shopCfg.description]

				if var_11_0 and var_11_0.recommend_item ~= 0 then
					arg_8_0:GotoRecommendBox(var_11_0.recommend_item)
				end
			end
		end)
	end
end

function var_0_1.UpdateTimerView(arg_12_0)
	if #arg_12_0.shopCfg.close_time > 0 and arg_12_0.restNum ~= 0 then
		arg_12_0.haveTimeLimitController_:SetSelectedState("true")

		local var_12_0 = TimeMgr.GetInstance():GetServerTime()
		local var_12_1 = TimeMgr.GetInstance():parseTimeFromConfig(arg_12_0.shopCfg.close_time)

		if var_12_1 <= var_12_0 then
			arg_12_0.lastTimeLabel_.text = GetTips("TIP_EXPIRED")

			if arg_12_0.outOfDateHandler_ ~= nil then
				arg_12_0.outOfDateHandler_(arg_12_0.goodID)
			end
		else
			arg_12_0.lastTimeLabel_.text = string.format(GetTips("TIME_DISPLAY_5"), manager.time:GetLostTimeStr(var_12_1))
		end
	else
		arg_12_0.haveTimeLimitController_:SetSelectedState("false")

		arg_12_0.lastTimeLabel_.text = ""
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_0.countdownTransform_)
	arg_12_0:UpdatePrice(arg_12_0.goodID)
	arg_12_0:UpdateRecommend()
end

function var_0_1.SetOutOfDateHandler(arg_13_0, arg_13_1)
	arg_13_0.outOfDateHandler_ = arg_13_1
end

function var_0_1.UpdatePrice(arg_14_0)
	local var_14_0, var_14_1, var_14_2 = ShopTools.GetPrice(arg_14_0.goodID)

	arg_14_0.moneyTxt_.text = ShopTools.GetMoneySymbol(arg_14_0.goodID)
	arg_14_0.oldPriceLabel_.text = var_14_1

	if var_14_0 <= 0 then
		arg_14_0.costTypeController_:SetSelectedState("free")
		SetActive(arg_14_0.oldPriceLabel_.gameObject, false)
	else
		if ShopTools.IsRMB(arg_14_0.goodID) then
			arg_14_0.priceText_.text = var_14_0
		else
			arg_14_0:SetCostIcon()
			arg_14_0:SetPriceText(arg_14_0.goodID)
		end

		arg_14_0.costTypeController_:SetSelectedState(ShopTools.IsRMB(arg_14_0.goodID) and "money" or "currency")
	end

	SetActive(arg_14_0.superValueGo_, arg_14_0.shopCfg.tag == ShopConst.TAGS.SUPER_VALUE and arg_14_0.restNum ~= 0)

	local var_14_3, var_14_4, var_14_5 = ShopTools.IsOnDiscountArea(arg_14_0.goodID)

	if var_14_3 and var_14_5 and arg_14_0.restNum ~= 0 then
		SetActive(arg_14_0.limitDiscountGo_, arg_14_0.shopCfg.is_limit_time_discount == 1)
		SetActive(arg_14_0.oldPriceLabel_.gameObject, var_14_0 ~= var_14_1 and var_14_4)

		arg_14_0.discountLabel_.text = ShopTools.GetDiscountLabel(arg_14_0.goodID)

		SetActive(arg_14_0.discountGo_, true)
	else
		SetActive(arg_14_0.limitDiscountGo_, false)
		SetActive(arg_14_0.oldPriceLabel_.gameObject, false)
		SetActive(arg_14_0.discountGo_, false)
	end

	if ShopTools.IsRMB(arg_14_0.goodID) and ShopTools.IsPC() and ShopConst.PC_LOCK_SHOP[arg_14_0.shopID] ~= true and not SDKTools.GetIsOverSea() then
		arg_14_0.priceText_.text = GetTips("PC_SHOP_TIPS3")
		arg_14_0.moneyTxt_.text = ""
	end
end

function var_0_1.IsRecommend(arg_15_0, arg_15_1)
	if arg_15_1 and arg_15_1.description then
		local var_15_0 = RechargeShopDescriptionCfg[arg_15_1.description]

		if var_15_0 and var_15_0.recommend_item ~= 0 and not ShopTools.CheckSoldOut(var_15_0.recommend_item) then
			local var_15_1 = getShopCfg(var_15_0.recommend_item)

			if ShopTools.IsGoodCanBuy(var_15_1.shop_id, var_15_0.recommend_item) then
				return true
			end
		end
	end

	return false
end

function var_0_1.UpdateRecommend(arg_16_0)
	if arg_16_0.remommendController_ then
		arg_16_0.remommendController_:SetSelectedState("false")

		if arg_16_0:IsRecommend(arg_16_0.shopCfg) then
			arg_16_0.remommendController_:SetSelectedState("true")
		end
	end
end

function var_0_1.UpdateView(arg_17_0)
	arg_17_0.nameLabel_.text = string.format("%s", GetI18NText(arg_17_0.itemCfg.name))
	arg_17_0.icon_.spriteSync = "TextureConfig/PrizeItem/" .. arg_17_0.itemCfg.icon

	local var_17_0 = ShopTools.CheckSoldOut(arg_17_0.goodID)
	local var_17_1 = ShopTools.CheckLevelEnough(arg_17_0.goodID)
	local var_17_2 = false

	if arg_17_0.shopCfg.limit_num ~= nil and arg_17_0.shopCfg.limit_num ~= -1 then
		local var_17_3 = arg_17_0.shopCfg.limit_num - arg_17_0.buyTime

		arg_17_0.limitLabel_.text = string.format("%d/%d", var_17_3, arg_17_0.shopCfg.limit_num)
		arg_17_0.limitTitle_.text = GetTips(ShopConst.SHOP_LIMIT_TEXT[arg_17_0.shopCfg.refresh_cycle])
	else
		arg_17_0.limitLabel_.text = " "
		arg_17_0.limitTitle_.text = ""
	end

	if ShopTools.CheckGiftSkinOwn(arg_17_0.goodID) then
		arg_17_0.statusController_:SetSelectedState("soldout")

		arg_17_0.soldTxt_.text = GetTips("ALREADY_GET")
	elseif var_17_0 then
		arg_17_0.statusController_:SetSelectedState("soldout")

		arg_17_0.soldTxt_.text = GetTips("SELL_OUT")
	elseif not var_17_1 then
		arg_17_0.statusController_:SetSelectedState("locked")

		local var_17_4 = arg_17_0.shopCfg.level_limit[1][2] or arg_17_0.shopCfg.level_limit[1].num

		arg_17_0.lockLabel_.text = string.format(GetTips("PLAYER_LEVEL_UNLOCK_SHOP_GOODS"), var_17_4)
	else
		arg_17_0.statusController_:SetSelectedState("normal")
	end

	arg_17_0:UpdatePrice()

	local var_17_5, var_17_6, var_17_7 = ShopTools.GetPrice(arg_17_0.goodID)

	if var_17_5 <= 0 and not var_17_0 and var_17_1 then
		var_17_2 = true
	end

	local var_17_8 = arg_17_0.shopCfg.operation_stop_id
	local var_17_9 = OperationData:IsFunctionStoped(var_17_8)

	SetActive(arg_17_0.redPointGo_, var_17_2 and not var_17_9)
	SetActive(arg_17_0.ownGo_, ShopTools.CheckGoodsOwen(arg_17_0.goodID))
end

return var_0_1
