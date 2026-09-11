local RechargeGiftItem = class("RechargeGiftItem", (import("game.views.shop.base.ShopItemBase")))

function RechargeGiftItem:InitUI()
	self:BindCfgUI()

	self.haveTimeLimitController_ = ControllerUtil.GetController(self.gameObject_.transform, "haveTimeLimit")
	self.costTypeController_ = ControllerUtil.GetController(self.gameObject_.transform, "costType")
	self.tipController_ = ControllerUtil.GetController(self.gameObject_.transform, "tip")
	self.statusController_ = ControllerUtil.GetController(self.gameObject_.transform, "status")

	if self.rechargeskinticketitemuiControllerexcollection_ then
		self.remommendController_ = self.rechargeskinticketitemuiControllerexcollection_:GetController("sp")
	end
end

function RechargeGiftItem:GoToBuyGood(arg_2_1)
	local var_2_0 = getShopCfg(arg_2_1)
	local var_2_1 = {}

	var_2_1 = var_2_0.description and RechargeShopDescriptionCfg[var_2_0.description] or ItemCfg[var_2_0.give_id]

	if ShopTools.IsPC() and ShopTools.IsRMB(arg_2_1) and not SDKTools.GetIsOverSea() then
		ShowTips("PC_SHOP_TIPS2")

		return
	end

	local var_2_2 = ShopTools.CheckSoldOut(arg_2_1)

	if ShopTools.CheckGiftSkinOwn(arg_2_1) then
		-- block empty
	elseif var_2_2 then
		-- block empty
	elseif not ShopTools.CheckLevelEnough(arg_2_1) then
		-- block empty
	else
		SendMessageManagerToSDK("purchase_click_gp_once")

		if self.statusController_:GetSelectedState() == "normal" then
			if var_2_1.type == ItemConst.ITEM_TYPE.GIFT and self.itemCfg.sub_type == ItemConst.ITEM_SUB_TYPE.FUKUBUKURO then
				JumpTools.OpenPageByJump("rechargeFukubukuro", {
					goodID = arg_2_1,
					shopID = var_2_0.shop_id
				})
			else
				JumpTools.OpenPageByJump("rechargeGiftPop", {
					goodId = arg_2_1,
					buyTime = self.buyTime,
					itemCfg = ItemCfg[var_2_0.give_id],
					shopId = var_2_0.shop_id,
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

function RechargeGiftItem:GoToBuyBoxWithTips(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	if self:IsRecommend(arg_3_3) then
		ShowMessageBox({
			isTop = true,
			title = GetTips("PROMPT"),
			content = GetTips("RECHARGE_SHOP_POP_TIP"),
			OkCallback = function()
				self:GotoRecommendBox(RechargeShopDescriptionCfg[arg_3_3.description].recommend_item)
			end,
			CancelCallback = function()
				self:GotoBuyBox(arg_3_1, arg_3_4, arg_3_2, arg_3_3, arg_3_5)
			end
		})
	else
		self:GotoBuyBox(arg_3_1, arg_3_4, arg_3_2, arg_3_3, arg_3_5)
	end
end

function RechargeGiftItem:GotoBuyBox(arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
	if arg_6_2.type == ItemConst.ITEM_TYPE.GIFT and self.itemCfg.sub_type == ItemConst.ITEM_SUB_TYPE.FUKUBUKURO then
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

function RechargeGiftItem:GotoRecommendBox(arg_7_1)
	local var_7_0 = ShopListCfg[getShopCfg(arg_7_1).shop_id]
	local var_7_1

	if var_7_0 then
		var_7_1 = var_7_0.display_group or 1

		local var_7_2

		if var_7_0 then
			var_7_2 = var_7_0.display_index or 1
		end
	end

	childShopIndex = var_7_2

	JumpTools.GoToSystem("/rechargeMain", {
		page = var_7_1,
		childShopIndex = childShopIndex
	}, ViewConst.SYSTEM_ID.RECHARGE_MAIN)
	self:GoToBuyGood(arg_7_1)
end

function RechargeGiftItem:AddUIListener()
	self:AddBtnListener(self.bgBtn_, nil, function()
		if ShopTools.IsPC() and ShopTools.IsRMB(self.goodID) and not SDKTools.GetIsOverSea() then
			if ShopTools.IsLimitRecharge() and ShopConst.PC_LOCK_SHOP[self.shopID] ~= true then
				ShowTips("PC_SHOP_TIPS2")

				return
			end

			if self.shopID == ShopConst.SHOP_ID.LIMIT_SUPPLY then
				ShowTips("PC_SHOP_TIPS2")

				return
			end

			if not SDKTools.GetIsOverSea() then
				ShopTools.OpenWebRecharge()

				return
			end
		end

		SendMessageManagerToSDK("purchase_click_gp_once")

		if self.statusController_:GetSelectedState() == "normal" then
			self:GoToBuyBoxWithTips(self.goodID, self.buyTime, self.shopCfg, self.itemCfg, self.shopID)
		end

		SDKTools.SendPaymentMessageToSDK("payment_touch", {
			payment_giftbox = self.goodID
		})
	end)

	if self.buttonBtn_ then
		self:AddBtnListener(self.buttonBtn_, nil, function()
			if ShopTools.IsPC() and ShopTools.IsRMB(self.goodID) and not SDKTools.GetIsOverSea() then
				if ShopTools.IsLimitRecharge() and ShopConst.PC_LOCK_SHOP[self.shopID] ~= true then
					ShowTips("PC_SHOP_TIPS2")

					return
				end

				if self.shopID == ShopConst.SHOP_ID.LIMIT_SUPPLY then
					ShowTips("PC_SHOP_TIPS2")

					return
				end

				if not SDKTools.GetIsOverSea() then
					ShopTools.OpenWebRecharge()

					return
				end
			end

			SendMessageManagerToSDK("purchase_click_gp_once")

			if self.statusController_:GetSelectedState() == "normal" then
				self:GoToBuyBoxWithTips(self.goodID, self.buyTime, self.shopCfg, self.itemCfg, self.shopID)
			end

			SDKTools.SendPaymentMessageToSDK("payment_touch", {
				payment_giftbox = self.goodID
			})
		end)
	end

	if self.specialBtn_ then
		self:AddBtnListener(self.specialBtn_, nil, function()
			if self.shopCfg and self.shopCfg.description then
				if RechargeShopDescriptionCfg[self.shopCfg.description] and RechargeShopDescriptionCfg[self.shopCfg.description].recommend_item ~= 0 then
					self:GotoRecommendBox(RechargeShopDescriptionCfg[self.shopCfg.description].recommend_item)
				end
			end
		end)
	end
end

function RechargeGiftItem:UpdateTimerView()
	if #self.shopCfg.close_time > 0 and self.restNum ~= 0 then
		self.haveTimeLimitController_:SetSelectedState("true")

		local var_12_0 = TimeMgr.GetInstance():parseTimeFromConfig(self.shopCfg.close_time)

		if var_12_0 <= TimeMgr.GetInstance():GetServerTime() then
			self.lastTimeLabel_.text = GetTips("TIP_EXPIRED")

			if self.outOfDateHandler_ ~= nil then
				self.outOfDateHandler_(self.goodID)
			end
		else
			self.lastTimeLabel_.text = string.format(GetTips("TIME_DISPLAY_5"), manager.time:GetLostTimeStr(var_12_0))
		end
	else
		self.haveTimeLimitController_:SetSelectedState("false")

		self.lastTimeLabel_.text = ""
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.countdownTransform_)
	self:UpdatePrice(self.goodID)
	self:UpdateRecommend()
end

function RechargeGiftItem:SetOutOfDateHandler(arg_13_1)
	self.outOfDateHandler_ = arg_13_1
end

function RechargeGiftItem:UpdatePrice()
	local var_14_0, var_14_1, var_14_2 = ShopTools.GetPrice(self.goodID)

	self.moneyTxt_.text = ShopTools.GetMoneySymbol(self.goodID)
	self.oldPriceLabel_.text = var_14_1

	if var_14_0 <= 0 then
		self.costTypeController_:SetSelectedState("free")
		SetActive(self.oldPriceLabel_.gameObject, false)
	else
		if ShopTools.IsRMB(self.goodID) then
			self.priceText_.text = var_14_0
		else
			self:SetCostIcon()
			self:SetPriceText(self.goodID)
		end

		self.costTypeController_:SetSelectedState(ShopTools.IsRMB(self.goodID) and "money" or "currency")
	end

	SetActive(self.superValueGo_, self.shopCfg.tag == ShopConst.TAGS.SUPER_VALUE and self.restNum ~= 0)

	local var_14_3, var_14_4, var_14_5 = ShopTools.IsOnDiscountArea(self.goodID)

	if var_14_3 and var_14_5 and self.restNum ~= 0 then
		SetActive(self.limitDiscountGo_, self.shopCfg.is_limit_time_discount == 1)
		SetActive(self.oldPriceLabel_.gameObject, var_14_0 ~= var_14_1 and var_14_4)

		self.discountLabel_.text = ShopTools.GetDiscountLabel(self.goodID)

		SetActive(self.discountGo_, true)
	else
		SetActive(self.limitDiscountGo_, false)
		SetActive(self.oldPriceLabel_.gameObject, false)
		SetActive(self.discountGo_, false)
	end

	if ShopTools.IsRMB(self.goodID) and ShopTools.IsPC() and ShopConst.PC_LOCK_SHOP[self.shopID] ~= true and not SDKTools.GetIsOverSea() then
		self.priceText_.text = GetTips("PC_SHOP_TIPS3")
		self.moneyTxt_.text = ""
	end
end

function RechargeGiftItem:IsRecommend(arg_15_1)
	if arg_15_1 and arg_15_1.description then
		if RechargeShopDescriptionCfg[arg_15_1.description] and RechargeShopDescriptionCfg[arg_15_1.description].recommend_item ~= 0 and not ShopTools.CheckSoldOut(RechargeShopDescriptionCfg[arg_15_1.description].recommend_item) and ShopTools.IsGoodCanBuy(getShopCfg(RechargeShopDescriptionCfg[arg_15_1.description].recommend_item).shop_id, RechargeShopDescriptionCfg[arg_15_1.description].recommend_item) then
			return true
		end
	end

	return false
end

function RechargeGiftItem:UpdateRecommend()
	if self.remommendController_ then
		self.remommendController_:SetSelectedState("false")

		if self:IsRecommend(self.shopCfg) then
			self.remommendController_:SetSelectedState("true")
		end
	end
end

function RechargeGiftItem:UpdateView()
	self.nameLabel_.text = string.format("%s", GetI18NText(self.itemCfg.name))
	self.icon_.spriteSync = "TextureConfig/PrizeItem/" .. self.itemCfg.icon

	local var_17_0 = ShopTools.CheckSoldOut(self.goodID)
	local var_17_1 = ShopTools.CheckLevelEnough(self.goodID)

	if self.shopCfg.limit_num ~= nil and self.shopCfg.limit_num ~= -1 then
		self.limitLabel_.text = string.format("%d/%d", self.shopCfg.limit_num - self.buyTime, self.shopCfg.limit_num)
		self.limitTitle_.text = GetTips(ShopConst.SHOP_LIMIT_TEXT[self.shopCfg.refresh_cycle])
	else
		self.limitLabel_.text = " "
		self.limitTitle_.text = ""
	end

	if ShopTools.CheckGiftSkinOwn(self.goodID) then
		self.statusController_:SetSelectedState("soldout")

		self.soldTxt_.text = GetTips("ALREADY_GET")
	elseif var_17_0 then
		self.statusController_:SetSelectedState("soldout")

		self.soldTxt_.text = GetTips("SELL_OUT")
	elseif not var_17_1 then
		self.statusController_:SetSelectedState("locked")

		self.lockLabel_.text = string.format(GetTips("PLAYER_LEVEL_UNLOCK_SHOP_GOODS"), self.shopCfg.level_limit[1][2] or self.shopCfg.level_limit[1].num)
	else
		self.statusController_:SetSelectedState("normal")
	end

	self:UpdatePrice()

	local var_17_3, var_17_4, var_17_5 = ShopTools.GetPrice(self.goodID)

	SetActive(self.redPointGo_, (var_17_3 <= 0 and not var_17_0 and var_17_1 or nil) and true and not OperationData:IsFunctionStoped(self.shopCfg.operation_stop_id))
	SetActive(self.ownGo_, ShopTools.CheckGoodsOwen(self.goodID))
end

return RechargeGiftItem
