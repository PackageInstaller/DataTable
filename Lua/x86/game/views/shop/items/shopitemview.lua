local var_0_0 = class("ShopItemView", ShopItemBase)

function var_0_0.InitUI(arg_1_0)
	arg_1_0:BindCfgUI()

	arg_1_0.limitController_ = arg_1_0.controller_:GetController("lock")
	arg_1_0.commonItem_ = CommonItemView.New(arg_1_0.commonGo_)
	arg_1_0.commonData = clone(ItemTemplateData)
end

function var_0_0.AddUIListener(arg_2_0)
	arg_2_0:AddBtnListener(nil, nil, "OnClick")
end

function var_0_0.UpdateTimerView(arg_3_0)
	if arg_3_0.isExchange or arg_3_0.isLock then
		return
	end

	local var_3_0 = arg_3_0.shopCfg.refresh_cycle

	if var_3_0 == 1 then
		return
	end

	local var_3_1

	if not arg_3_0.isExchange then
		if var_3_0 == 2 then
			var_3_1 = _G.gameTimer:GetNextMonthFreshTime()
		elseif var_3_0 == 3 then
			var_3_1 = _G.gameTimer:GetNextWeekFreshTime()
		elseif var_3_0 == 4 then
			var_3_1 = _G.gameTimer:GetNextDayFreshTime()
		elseif var_3_0 == 5 then
			var_3_1 = arg_3_0.data.next_refresh_timestamp
		end

		arg_3_0.countdownText_.text = string.format(GetTips("TIME_DISPLAY_5"), manager.time:DescCdTime3(var_3_1 - manager.time:GetServerTime()))
	end
end

function var_0_0.OnClick(arg_4_0)
	if not ShopTools.CheckShopIsUnLock(arg_4_0.shopID) then
		if arg_4_0.shopCfg then
			ShowPopItem(POP_ITEM, {
				arg_4_0.shopCfg.give_id
			})
		end

		return
	end

	arg_4_0:ClickFunction()
end

function var_0_0.UpdateView(arg_5_0)
	arg_5_0:SetCommonItem()

	arg_5_0.nameText_.text = string.format("%s x%d", ItemTools.getItemName(arg_5_0.itemCfg.id), arg_5_0.shopCfg.give)
	arg_5_0.isLock = ShopData.IsGoodUnlock(arg_5_0.goodID, arg_5_0.shopID) == 0

	if arg_5_0.isLock then
		local var_5_0, var_5_1 = ShopData.GetLockTypeAndCondition(arg_5_0.goodID, arg_5_0.shopID)

		SetActive(arg_5_0.null_, true)
		SetActive(arg_5_0.countdownText_.gameObject, true)

		if var_5_0 == 5 then
			arg_5_0.nullText_.text = GetTips("EXPLORE_SHOP_TIPS_1")
			arg_5_0.countdownText_.text = string.format(GetTips("EXPLORE_SHOP_TIPS_2"), var_5_1)
		end
	elseif arg_5_0.shopCfg.limit_num == -1 or arg_5_0.shopCfg.limit_num == nil then
		SetActive(arg_5_0.limitGo_, false)
		SetActive(arg_5_0.null_, false)
	else
		local var_5_2 = arg_5_0.shopCfg.limit_num - arg_5_0.data.buyTime

		if arg_5_0.itemCfg.type == ItemConst.ITEM_TYPE.HERO_SKIN and ShopTools.HaveSkin(arg_5_0.itemCfg.id) then
			var_5_2 = 0
		end

		if var_5_2 > 0 then
			SetActive(arg_5_0.limitGo_, true)
			SetActive(arg_5_0.null_, false)

			arg_5_0.limitNum_.text = string.format("<color=#0d89bf>%d</color>/%d", var_5_2, arg_5_0.shopCfg.limit_num)
			arg_5_0.limitText_.text = GetTips(ShopConst.SHOP_LIMIT_TEXT[arg_5_0.shopCfg.refresh_cycle or 7])
		else
			if arg_5_0.isExchange then
				arg_5_0.limitController_:SetSelectedState("empty1")

				arg_5_0.nullText_.text = GetTips("SOLD_OUT")
			else
				local var_5_3 = arg_5_0.shopCfg.refresh_cycle

				if var_5_3 == 1 then
					arg_5_0.nullText_.text = GetTips("SOLD_OUT")
				elseif var_5_3 == 2 then
					arg_5_0.nullText_.text = GetTips("MONTHLY_SOLD_OUT")
				elseif var_5_3 == 3 then
					arg_5_0.nullText_.text = GetTips("WEEKLY_SOLD_OUT")
				elseif var_5_3 == 4 then
					arg_5_0.nullText_.text = GetTips("DAILY_SOLD_OUT")
				elseif var_5_3 == 5 then
					arg_5_0.nullText_.text = GetTips("ACTIVITY_SOLD_OUT")
				end
			end

			SetActive(arg_5_0.limitGo_, false)
			SetActive(arg_5_0.null_, true)
		end
	end

	if arg_5_0.shopCfg.limit_num == 0 then
		SetActive(arg_5_0.limitGo_, false)
	end

	local var_5_4 = arg_5_0.shopCfg.cost

	arg_5_0:SetCostIcon()

	local var_5_5
	local var_5_6
	local var_5_7
	local var_5_8 = ShopTools.GetDiscount(arg_5_0.goodID, arg_5_0.shopID)
	local var_5_9 = ShopTools.GetDiscountLabel(arg_5_0.goodID, arg_5_0.shopID)
	local var_5_10 = ShopTools.GetOriPrice(arg_5_0.goodID, arg_5_0.shopID)

	if var_5_8 ~= 100 then
		local var_5_11 = arg_5_0.shopCfg.cheap_cost

		SetActive(arg_5_0.discountGo_, true)

		arg_5_0.discountText_.text = var_5_9

		SetActive(arg_5_0.oldPriceGo_, true)

		arg_5_0.oldPriceText_.text = tostring(var_5_10)
	else
		SetActive(arg_5_0.oldPriceGo_, false)

		if arg_5_0.shopCfg.tag == 2 then
			SetActive(arg_5_0.discountGo_, true)

			arg_5_0.discountText_.text = GetTips("NEW_ADD")
		else
			SetActive(arg_5_0.discountGo_, false)
		end
	end

	arg_5_0:SetPriceText()
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
