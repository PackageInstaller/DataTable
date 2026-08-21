local var_0_0 = {}
local var_0_1 = import("game.const.ShopConst")
local var_0_2 = 10

function var_0_0.GetShopRedPointKey(arg_1_0)
	return "SHOP_" .. tostring(arg_1_0)
end

function var_0_0.CollectShopInGroup(arg_2_0)
	local var_2_0 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_0) do
		var_2_0[iter_2_1] = true
	end

	local var_2_1 = {}

	if next(var_2_0) then
		for iter_2_2, iter_2_3 in ipairs(ShopListCfg.all) do
			if var_2_0[ShopListCfg[iter_2_3].display_group] then
				table.insert(var_2_1, iter_2_3)
			end
		end
	end

	return var_2_1
end

function var_0_0.FilterShopDataList(arg_3_0, arg_3_1)
	arg_3_1 = arg_3_1 or false

	local var_3_0 = {}
	local var_3_1 = ShopData.GetShop(arg_3_0).shopItemIDs

	for iter_3_0, iter_3_1 in pairs(var_3_1) do
		if var_0_0.IsGoodCanDisplay(arg_3_0, iter_3_1, arg_3_1) then
			local var_3_2 = ShopData.GetShop(arg_3_0)[iter_3_1]

			table.insert(var_3_0, {
				id = iter_3_1,
				shopId = arg_3_0,
				buyTime = var_3_2 ~= nil and var_3_2.buy_times or 0,
				next_refresh_timestamp = var_3_2 ~= nil and var_3_2.next_refresh_timestamp or 0
			})
		end
	end

	if arg_3_0 == var_0_1.SHOP_ID.DLC_SHOP then
		var_3_0 = var_0_0.GetFakeShopDataList(var_3_0)
	end

	table.sort(var_3_0, function(arg_4_0, arg_4_1)
		return getShopCfg(arg_4_0.id).shop_sort > getShopCfg(arg_4_1.id).shop_sort
	end)

	return var_3_0
end

function var_0_0.CommonSort(arg_5_0)
	table.sort(arg_5_0, function(arg_6_0, arg_6_1)
		local var_6_0 = getShopCfg(arg_6_0.id)
		local var_6_1 = getShopCfg(arg_6_1.id)
		local var_6_2 = var_0_0.GetGoodStatus(arg_6_0.id)
		local var_6_3 = var_0_0.GetGoodStatus(arg_6_1.id)

		if var_6_2 ~= var_6_3 then
			return var_6_2 < var_6_3
		end

		if var_6_0.shop_sort ~= var_6_1.shop_sort then
			return var_6_0.shop_sort > var_6_1.shop_sort
		end

		return var_6_0.goods_id > var_6_1.goods_id
	end)

	return arg_5_0
end

function var_0_0.GetGoodStatus(arg_7_0)
	local var_7_0 = false
	local var_7_1 = getShopCfg(arg_7_0)
	local var_7_2 = ShopData.GetShop(var_7_1.shop_id)[arg_7_0]

	if ShopData.IsGoodOutOfDate(arg_7_0) then
		return 3
	end

	if var_7_2 ~= nil and var_7_1.limit_num ~= nil and var_7_1.limit_num ~= -1 then
		local var_7_3

		if var_7_1.description then
			var_7_3 = RechargeShopDescriptionCfg[var_7_1.description]
		else
			var_7_3 = ItemCfg[var_7_1.give_id]
		end

		if var_7_3.type == ItemConst.ITEM_TYPE.HERO_SKIN then
			if var_0_0.HaveSkin(var_7_3.id) or HeroTools.CanChangeSkin(var_7_3.id) then
				var_7_0 = true
			end
		elseif var_7_1.limit_num - (var_7_2.buy_times or 0) <= 0 then
			var_7_0 = true
		end
	end

	if var_7_0 then
		return 3
	end

	if ShopData.IsGoodUnlock(arg_7_0) == 0 then
		return 1
	end

	return 0
end

function var_0_0.CheckLevelEnough(arg_8_0)
	local var_8_0 = getShopCfg(arg_8_0)

	if #var_8_0.level_limit > 0 then
		if var_8_0.level_limit[1][1] ~= nil then
			if var_8_0.level_limit[1][1] == 1 and PlayerData:GetPlayerInfo().userLevel < var_8_0.level_limit[1][2] then
				return false
			end
		elseif var_8_0.level_limit[1].type and var_8_0.level_limit[1].type == 1 and PlayerData:GetPlayerInfo().userLevel < var_8_0.level_limit[1].num then
			return false
		end
	end

	return true
end

function var_0_0.IsShopSuspended(arg_9_0)
	local var_9_0 = ShopListCfg[arg_9_0]

	if OperationData:IsFunctionStoped(var_9_0.operation_stop_id) then
		return true, "ERROR_FUNCTION_STOP"
	end

	return false
end

function var_0_0.IsGoodCanDisplay(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = getShopCfg(arg_10_1)
	local var_10_1 = true
	local var_10_2 = true
	local var_10_3 = true
	local var_10_4 = true
	local var_10_5 = var_0_0.CheckSoldOut(arg_10_1)

	if #var_0_0.GetNextGoods(arg_10_1) > 0 and var_10_5 then
		var_10_2 = false
	end

	if var_10_0.pre_goods_id ~= nil and #var_10_0.pre_goods_id > 0 then
		for iter_10_0, iter_10_1 in ipairs(var_10_0.pre_goods_id) do
			local var_10_6 = getShopCfg(iter_10_1)
			local var_10_7 = ShopData.GetShop(arg_10_0)[iter_10_1]

			if var_10_7 ~= nil and var_10_6.limit_num ~= nil and var_10_6.limit_num ~= -1 and var_10_6.limit_num - (var_10_7.buy_times or 0) > 0 then
				var_10_1 = false

				break
			end
		end

		if #var_0_0.GetNextGoods(arg_10_1) == 0 and var_10_5 and not arg_10_2 then
			var_10_3 = false
		end
	end

	local var_10_8 = var_0_0.CheckInSoldTime(arg_10_1)
	local var_10_9 = (not var_0_0.GetIsTakenDown(var_10_0) or false) and (var_10_0.limit_display == 1 or ShopData.IsGoodUnlock(var_10_0.goods_id, arg_10_0) == 1)
	local var_10_10 = false
	local var_10_11 = HideInfoData:GetSkinHideList()[arg_10_1] or false

	if var_10_0.taken_down == 0 and var_10_1 and var_10_2 and var_10_3 and var_10_8 and var_10_9 and not var_10_11 then
		if ShopTools.GetPrice(var_10_0.goods_id) == 0 then
			ShopData.IsGoodUnlock(var_10_0.goods_id)
		end

		return true
	end

	if var_10_0.shop_id == var_0_1.SHOP_ID.REGRESSION_SHOP then
		return true
	end

	return false
end

function var_0_0.CheckInSoldTime(arg_11_0)
	local var_11_0 = getShopCfg(arg_11_0)
	local var_11_1 = TimeMgr.GetInstance():GetServerTime()
	local var_11_2 = true
	local var_11_3 = true
	local var_11_4 = #var_11_0.open_time < 2 and true or var_11_1 >= TimeMgr.GetInstance():parseTimeFromConfig(var_11_0.open_time)
	local var_11_5 = #var_11_0.close_time < 2 and true or var_11_1 < TimeMgr.GetInstance():parseTimeFromConfig(var_11_0.close_time)

	return var_11_4 and var_11_5
end

function var_0_0.GetIsTakenDown(arg_12_0)
	if arg_12_0.taken_down == 0 then
		local var_12_0 = ItemCfg[arg_12_0.give_id]

		if var_12_0 and var_12_0.type == ItemConst.ITEM_TYPE.HERO_PIECE and HeroTools.GetIsHide(var_12_0.hero_id) then
			return true
		end

		if var_12_0 and var_12_0.type == ItemConst.ITEM_TYPE.WEAPON_SERVANT and ServantTools.GetIsHide(var_12_0.id) then
			return true
		end

		if var_12_0 and var_12_0.type == ItemConst.ITEM_TYPE.EQUIP and EquipTools.GetIsHide(var_12_0.id) then
			return true
		end
	else
		return true
	end

	return false
end

function var_0_0.CheckSoldOut(arg_13_0)
	local var_13_0 = getShopCfg(arg_13_0)
	local var_13_1 = ShopData.GetShop(var_13_0.shop_id)

	if var_13_1 == nil then
		return true
	end

	local var_13_2 = var_13_1[arg_13_0]

	if var_13_2 ~= nil and var_13_0.limit_num ~= nil and var_13_0.limit_num ~= -1 and var_13_0.limit_num - (var_13_2.buy_times or 0) <= 0 then
		return true
	end

	return false
end

function var_0_0.CheckShopSoldOut(arg_14_0)
	local var_14_0 = getShopIDListByShopID(arg_14_0)

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		local var_14_1 = getShopCfg(iter_14_1)
		local var_14_2 = var_14_1.give_id and ItemCfg[var_14_1.give_id] or RechargeShopDescriptionCfg[var_14_1.description]

		if not var_0_0.CheckSoldOut(iter_14_1) then
			if var_14_2.type == var_14_2.HERO_SKIN then
				if not ShopTools.HaveSkin(self.itemCfg.id) then
					return false
				end
			else
				return false
			end
		end
	end

	return true
end

function var_0_0.IsGoodCanBuyInShop(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = getShopCfg(arg_15_1)
	local var_15_1 = true
	local var_15_2 = true
	local var_15_3 = true
	local var_15_4 = true
	local var_15_5 = var_0_0.CheckSoldOut(arg_15_1)

	if #var_0_0.GetNextGoods(arg_15_1) > 0 and var_15_5 then
		var_15_2 = false
	end

	if var_15_0.pre_goods_id ~= nil and #var_15_0.pre_goods_id > 0 then
		for iter_15_0, iter_15_1 in ipairs(var_15_0.pre_goods_id) do
			local var_15_6 = getShopCfg(iter_15_1)
			local var_15_7 = ShopData.GetShop(arg_15_0)[iter_15_1]

			if var_15_7 ~= nil and var_15_6.limit_num ~= nil and var_15_6.limit_num ~= -1 and var_15_6.limit_num - (var_15_7.buy_times or 0) > 0 then
				var_15_1 = false

				break
			end
		end

		if #var_0_0.GetNextGoods(arg_15_1) == 0 and var_15_5 and not arg_15_2 then
			var_15_3 = false
		end
	end

	local var_15_8 = var_0_0.CheckInSoldTime(arg_15_1)
	local var_15_9 = var_15_0.limit_display == 1 or ShopData.IsGoodUnlock(var_15_0.goods_id, arg_15_0) == 1

	if var_15_0.taken_down == 0 and var_15_1 and var_15_2 and var_15_3 and var_15_8 and var_15_9 then
		if ShopTools.GetPrice(var_15_0.goods_id) == 0 then
			ShopData.IsGoodUnlock(var_15_0.goods_id)
		end

		return true
	end

	return false
end

function var_0_0.IsGoodCanBuy(arg_16_0, arg_16_1, arg_16_2)
	return ShopData.GetShop(arg_16_0)[arg_16_1] and var_0_0.IsGoodCanBuyInShop(arg_16_0, arg_16_1, arg_16_2) and not var_0_0.CheckSoldOut(arg_16_1)
end

function var_0_0.GetNextGoods(arg_17_0)
	return ShopData.GetNextGoods(arg_17_0)
end

function var_0_0.JudgeIsLvLimit(arg_18_0)
	local var_18_0 = PlayerData:GetPlayerInfo().userLevel

	for iter_18_0, iter_18_1 in ipairs(arg_18_0) do
		if var_0_1.SHOP_LIMIT.PLAYER_LV == iter_18_1[1] and var_18_0 < iter_18_1[2] then
			return true, iter_18_1
		end
	end

	return false
end

function var_0_0.HaveSkin(arg_19_0)
	local var_19_0 = SkinCfg[arg_19_0].hero
	local var_19_1 = HeroData:GetHeroData(var_19_0)
	local var_19_2 = {}

	for iter_19_0, iter_19_1 in ipairs(var_19_1.unlocked_skin) do
		if iter_19_1.skin_id == arg_19_0 and iter_19_1.time == 0 then
			return true
		end
	end

	return false
end

function var_0_0.GetCostLevel(arg_20_0, arg_20_1)
	local var_20_0 = getShopCfg(arg_20_0)
	local var_20_1 = var_0_0.GetCostCfg(arg_20_0)

	if arg_20_1 then
		var_20_1 = ItemCfg[arg_20_1]
	end

	if var_20_1.type == ItemConst.ITEM_TYPE.CURRENCY then
		if var_20_1.id == CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE or var_20_1.id == CurrencyConst.GetPlatformDiamondId() then
			return var_0_1.COST_LEVEL.FREE_DIAMOND
		elseif var_20_1.id == CurrencyConst.CURRENCY_TYPE_SKIN then
			return var_0_1.COST_LEVEL.CURRENCY_TYPE_SKIN
		else
			return var_0_1.COST_LEVEL.RECHARGE_DIAMOND
		end
	else
		return var_0_1.COST_LEVEL.MATERIAL
	end
end

function var_0_0.SkinIsdeficiency(arg_21_0)
	ShowMessageBox({
		content = string.format(GetTips("ERROR_ITEM_NOT_SKIN_TICKET_C")),
		OkCallback = function()
			JumpTools.GoToSystem("/rechargeMain", {
				childShopIndex = 4,
				page = 2
			}, ViewConst.SYSTEM_ID.RECHARGE_MAIN)
		end,
		CancelCallback = function()
			gameContext:Back()
		end
	})
end

function var_0_0.DiamondEnoughMessageBox()
	ShowMessageBox({
		isTop = true,
		title = GetTips("PROMPT"),
		content = GetTips("ERROR_RECHARGE_DIAMOND_NOT_ENOUGH"),
		OkCallback = function()
			SDKTools.SendPaymentMessageToSDK("payment_touch", {
				payment_pay_flower_check = 0
			})
			JumpTools.GoToSystem("/rechargeMain", {
				childShopIndex = 2,
				page = 3
			}, ViewConst.SYSTEM_ID.RECHARGE_MAIN)
		end,
		CancelCallback = function()
			SDKTools.SendPaymentMessageToSDK("payment_touch", {
				payment_pay_flower_check = 1
			})
		end
	})
end

function var_0_0.DefaultOpenPopUp(arg_27_0)
	JumpTools.OpenPopUp("rechargeDiamondExchange", {
		getBaseNum = 1,
		useBaseNum = 1,
		useId = CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE,
		getId = CurrencyConst.CURRENCY_TYPE_DIAMOND,
		defaultNum = arg_27_0
	}, ViewConst.SYSTEM_ID.RECHARGE_DIAMOND_EXCHANGE)
end

function var_0_0.CostEnoughJump(arg_28_0)
	if arg_28_0 == var_0_1.COST_LEVEL.FREE_DIAMOND then
		var_0_0.DiamondEnoughMessageBox()
	elseif arg_28_0 == var_0_1.COST_LEVEL.RECHARGE_DIAMOND then
		var_0_0.DefaultOpenPopUp(0)
	elseif arg_28_0 == var_0_1.COST_LEVEL.MATERIAL then
		ShowTips("ERROR_ITEM_NOT_ENOUGH_MATERIAL")
	elseif arg_28_0 == var_0_1.COST_LEVEL.CURRENCY_TYPE_SKIN then
		var_0_0.SkinIsdeficiency()
	end
end

function var_0_0.ConfirmBuyItem(arg_29_0, arg_29_1, arg_29_2, arg_29_3, arg_29_4, arg_29_5)
	local var_29_0 = getShopCfg(arg_29_0)
	local var_29_1 = var_29_0.give_id and ItemCfg[var_29_0.give_id] or RechargeShopDescriptionCfg[var_29_0.description]
	local var_29_2, var_29_3 = var_0_0.GetCostCfg(arg_29_0)
	local var_29_4, var_29_5 = var_0_0.GetCostCount(arg_29_0)
	local var_29_6, var_29_7, var_29_8, var_29_9, var_29_10 = var_0_0.GetPrice(arg_29_0)
	local var_29_11 = var_0_0.GetCostLevel(arg_29_0)

	if arg_29_5 == 1 then
		var_29_6 = var_29_9
		var_29_4 = var_29_5
		var_29_2 = var_29_3
		var_29_11 = var_0_0.GetCostLevel(arg_29_0, var_29_2.id)
	end

	local var_29_12 = ""
	local var_29_13 = string.format(GetTips("CONFIRM_BUY"), GetI18NText(var_29_2.name), var_29_6 * arg_29_1, GetI18NText(var_29_1.name), arg_29_1)

	ShowMessageBox({
		title = GetTips("PROMPT"),
		content = var_29_13,
		OkCallback = function()
			if var_29_4 < var_29_6 * arg_29_1 then
				var_0_0.CostEnoughJump(var_29_11)
			else
				if ShopData.IsGoodOutOfDate(arg_29_0) then
					ShowTips("GOODS_HAS_BEEN_REMOVED")

					return
				end

				if arg_29_2 then
					arg_29_2(arg_29_0)
				end

				ShopAction.BuyItem({
					{
						goodID = arg_29_0,
						buyNum = arg_29_1,
						buyType = arg_29_5
					}
				}, var_29_6, arg_29_4)
			end
		end,
		CancelCallback = arg_29_3
	})
end

function var_0_0.ConfirmBuySkin(arg_31_0, arg_31_1, arg_31_2, arg_31_3, arg_31_4, arg_31_5)
	local var_31_0 = {}
	local var_31_1
	local var_31_2 = ""
	local var_31_3 = var_0_0.GetGoodsCostCountMap(arg_31_0)
	local var_31_4 = {}

	for iter_31_0, iter_31_1 in ipairs(arg_31_0) do
		local var_31_5 = getShopCfg(iter_31_1)
		local var_31_6 = var_31_5.give_id and ItemCfg[var_31_5.give_id] or RechargeShopDescriptionCfg[var_31_5.description]
		local var_31_7, var_31_8 = var_0_0.GetCostCfg(iter_31_1)
		local var_31_9, var_31_10, var_31_11, var_31_12, var_31_13 = var_0_0.GetPrice(iter_31_1)

		if arg_31_5 == 1 and var_31_6.type == ItemConst.ITEM_TYPE.SCENE then
			var_31_9 = var_31_12
			var_31_7 = var_31_8
		end

		if not var_31_0[var_31_7.id] then
			var_31_0[var_31_7.id] = 0
		end

		var_31_0[var_31_7.id] = var_31_0[var_31_7.id] + var_31_9 * arg_31_1[iter_31_0]

		if iter_31_0 == 1 then
			var_31_2 = GetI18NText(var_31_6.name)
		else
			var_31_2 = var_31_2 .. "+" .. GetI18NText(var_31_6.name)
		end

		table.insert(var_31_4, {
			goodID = iter_31_1,
			buyNum = arg_31_1[iter_31_0],
			buyType = var_31_6.type == ItemConst.ITEM_TYPE.SCENE and arg_31_5 or 0
		})
	end

	local var_31_14 = {}

	for iter_31_2, iter_31_3 in pairs(var_31_0) do
		table.insert(var_31_14, {
			costID = iter_31_2,
			costNum = iter_31_3
		})
	end

	table.sort(var_31_14, function(arg_32_0, arg_32_1)
		return arg_32_0.costID > arg_32_1.costID
	end)

	local var_31_15 = "[" .. GetI18NText(ItemCfg[var_31_14[1].costID].name) .. "]" .. "x" .. var_31_14[1].costNum

	for iter_31_4, iter_31_5 in ipairs(var_31_14) do
		if iter_31_4 > 1 then
			var_31_15 = var_31_15 .. "+" .. "[" .. GetI18NText(ItemCfg[var_31_14[iter_31_4].costID].name) .. "]" .. "x" .. var_31_14[iter_31_4].costNum
		end
	end

	ShowMessageBox({
		title = GetTips("PROMPT"),
		content = string.format(GetTips("CONFIRM_BUY_MULTI_PAY"), var_31_15, var_31_2, arg_31_1[1]),
		OkCallback = function()
			local var_33_0 = true
			local var_33_1 = 0

			for iter_33_0, iter_33_1 in pairs(var_31_14) do
				if var_31_3[iter_33_1.costID] < iter_33_1.costNum then
					var_33_0 = false
					var_33_1 = iter_33_1.costID

					break
				end
			end

			if not var_33_0 then
				var_0_0.CostEnoughJump(var_0_0.GetCostLevel(arg_31_0[1], var_33_1))
			else
				for iter_33_2, iter_33_3 in ipairs(arg_31_0) do
					if ShopData.IsGoodOutOfDate(iter_33_3) then
						ShowTips("GOODS_HAS_BEEN_REMOVED")

						return
					end
				end

				if arg_31_2 then
					arg_31_2(arg_31_0)
				end

				ShopAction.BuyItem(var_31_4, nil, arg_31_4)
			end
		end,
		CancelCallback = arg_31_3
	})
end

function var_0_0.GetCostCount(arg_34_0, arg_34_1)
	local var_34_0 = getShopCfg(arg_34_0)
	local var_34_1 = var_34_0.cost_id
	local var_34_2 = var_34_0.cost_id_2

	if arg_34_1 and var_34_0.cost_id_2 > var_34_0.cost_id then
		var_34_1, var_34_2 = var_34_0.cost_id_2, var_34_0.cost_id
	end

	if var_34_2 ~= 0 then
		return ItemTools.getItemNum(var_34_1), ItemTools.getItemNum(var_34_2)
	else
		return ItemTools.getItemNum(var_34_1), 0
	end
end

function var_0_0.GetGoodsCostCountMap(arg_35_0)
	local var_35_0 = {}

	for iter_35_0, iter_35_1 in ipairs(arg_35_0) do
		local var_35_1, var_35_2 = var_0_0.GetCostId(iter_35_1)

		if var_35_1 ~= 0 then
			if not var_35_0[var_35_1] then
				var_35_0[var_35_1] = 0
			end

			var_35_0[var_35_1] = ItemTools.getItemNum(var_35_1)
		end

		if var_35_2 ~= 0 then
			if not var_35_0[var_35_2] then
				var_35_0[var_35_2] = 0
			end

			var_35_0[var_35_2] = ItemTools.getItemNum(var_35_2)
		end
	end

	return var_35_0
end

function var_0_0.GetCostCfg(arg_36_0)
	local var_36_0 = getShopCfg(arg_36_0)

	if var_36_0.cost_id_2 and var_36_0.cost_id_2 ~= 0 then
		return ItemCfg[var_36_0.cost_id], ItemCfg[var_36_0.cost_id_2]
	else
		return ItemCfg[var_36_0.cost_id], {}
	end
end

function var_0_0.GetCostId(arg_37_0)
	local var_37_0, var_37_1, var_37_2, var_37_3 = ShopTools.IsOnDiscountArea(arg_37_0)
	local var_37_4
	local var_37_5

	if var_37_0 and var_37_2 then
		if var_37_3 == 1 then
			var_37_4 = getShopCfg(arg_37_0).cheap_cost_id
			var_37_5 = getShopCfg(arg_37_0).cost_id_2
		elseif var_37_3 == 2 then
			var_37_4 = getShopCfg(arg_37_0).cost_id
			var_37_5 = getShopCfg(arg_37_0).cheap_cost_id_2
		elseif var_37_3 == 3 then
			var_37_4 = getShopCfg(arg_37_0).cost_id
			var_37_5 = getShopCfg(arg_37_0).cost_id_2
		else
			Debug.LogError("ShopTools.GetCostID 打折信息有误goodID:" .. "goodID")
		end
	else
		var_37_4 = getShopCfg(arg_37_0).cost_id
		var_37_5 = getShopCfg(arg_37_0).cost_id_2
	end

	return var_37_4, var_37_5
end

function CheckGoodsTime(arg_38_0, arg_38_1)
	if not arg_38_0 or not arg_38_1 then
		return
	end

	if #arg_38_1 > 0 and #arg_38_0 > 0 then
		local var_38_0 = manager.time:GetServerTime()
		local var_38_1 = TimeMgr.GetInstance():parseTimeFromConfig(arg_38_0)
		local var_38_2 = TimeMgr.GetInstance():parseTimeFromConfig(arg_38_1)

		return var_38_1 <= var_38_0 and var_38_0 <= var_38_2
	end

	return false
end

function var_0_0.IsOnDiscountArea(arg_39_0)
	local var_39_0 = getShopCfg(arg_39_0)
	local var_39_1 = ShopListCfg[var_39_0.shop_id]
	local var_39_2, var_39_3 = var_0_0.GetDiscount(arg_39_0)

	if var_39_2 ~= 100 or var_39_3 ~= 100 then
		local var_39_4 = CheckGoodsTime(var_39_0.cheap_open_time, var_39_0.cheap_close_time)
		local var_39_5 = CheckGoodsTime(var_39_0.cheap_open_time_2, var_39_0.cheap_close_time_2)
		local var_39_6 = CheckGoodsTime(var_39_1.cheap_open_time, var_39_1.cheap_close_time)
		local var_39_7 = var_39_0.is_limit_time_discount == 1
		local var_39_8 = var_39_0.is_limit_time_discount_2 == 1
		local var_39_9 = var_39_1.is_limit_time_discount == 1

		if #var_39_0.cheap_close_time > 0 or var_39_0.cheap_close_time_2 and #var_39_0.cheap_close_time_2 > 0 then
			if var_39_4 and var_39_5 then
				return true, true, true, 3, var_39_7, var_39_8, var_39_9
			elseif var_39_5 then
				return true, true, true, 2, var_39_7, var_39_8, var_39_9
			elseif var_39_4 then
				return true, true, true, 1, var_39_7, var_39_8, var_39_9
			elseif var_39_6 then
				return true, true, true, var_39_7, var_39_8, var_39_9
			else
				return true, true, false, 0, var_39_7, var_39_8, var_39_9
			end
		else
			if var_39_6 then
				return true, true, true, 3, var_39_7, var_39_8, var_39_9
			end

			return true, false, true, 3, var_39_7, var_39_8, var_39_9
		end
	else
		return false, false, false, 0, isLimitTimeDiscount1, isLimitTimeDiscount2, isShopLimitTimeDiscount
	end
end

function var_0_0.GetIsLimitDisount(arg_40_0)
	if not getShopCfg(arg_40_0) then
		return false, false, false
	end

	local var_40_0 = ShopListCfg[shopCfg.shop_id]
	local var_40_1 = shopCfg.is_limit_time_discount == 1
	local var_40_2 = shopCfg.is_limit_time_discount_2 == 1
	local var_40_3 = var_40_0.is_limit_time_discount == 1

	return var_40_1, var_40_2, var_40_3
end

function var_0_0.HasMultiPay(arg_41_0)
	local var_41_0 = getShopCfg(arg_41_0)

	if not var_41_0 then
		return false
	end

	if var_41_0.cost_id_2 ~= nil and var_41_0.cost_id_2 ~= 0 then
		return true
	end

	return var_41_0.cost_id_2 and var_41_0.cost_id_2 ~= 0
end

function var_0_0.GetPrice(arg_42_0)
	local var_42_0, var_42_1 = var_0_0.GetDiscountPrice(arg_42_0)
	local var_42_2, var_42_3 = var_0_0.GetOriPrice(arg_42_0)
	local var_42_4, var_42_5, var_42_6, var_42_7, var_42_8, var_42_9, var_42_10 = var_0_0.IsOnDiscountArea(arg_42_0)
	local var_42_11 = var_42_0 == var_42_2 and 1 or var_42_0 / var_42_2
	local var_42_12 = SettingData:GetCurrentLanguage()

	if var_42_12 == "fr" or var_42_12 == "de" then
		var_42_0 = string.gsub(tostring(var_42_0), "%.", ",")
	end

	if var_42_4 and var_42_6 then
		if var_42_5 and not var_42_10 then
			if not var_42_8 or var_42_7 == 0 or var_42_7 == 2 then
				var_42_0 = var_42_2
			end

			if not var_42_9 or var_42_7 == 0 or var_42_7 == 1 then
				var_42_1 = var_42_3
			end
		end

		return var_42_0, var_42_2, var_42_11, var_42_1, var_42_3
	else
		local var_42_13 = var_42_2
		local var_42_14 = var_42_3

		return var_42_13, var_42_2, 1, var_42_14, var_42_3
	end
end

function var_0_0.IsRMB(arg_43_0)
	return getShopCfg(arg_43_0).cost_type == 1
end

function var_0_0.IsSkin(arg_44_0)
	return getShopCfg(arg_44_0).cost_type == 3
end

function var_0_0.GetDiscountLabel(arg_45_0)
	local var_45_0, var_45_1 = var_0_0.GetDiscount(arg_45_0)
	local var_45_2 = math.min(var_45_0, var_45_1)

	return var_0_0.GetDiscountLabelByPercent(var_45_2)
end

function var_0_0.GetDiscountLabelByPercent(arg_46_0)
	if SDKTools.GetIsThisServer({
		"jp"
	}) then
		return GetTips("LABEL_DISCOUNT_EXTRA")
	elseif SDKTools.GetIsThisServer({
		"kr",
		"en"
	}) then
		return string.format("%d%%%s", 100 - arg_46_0, GetTips("LABEL_DISCOUNT"))
	end

	return string.format("%.1f%s", arg_46_0 / 10, GetTips("LABEL_DISCOUNT"))
end

function var_0_0.GetDiscount(arg_47_0)
	local var_47_0 = getShopCfg(arg_47_0)

	if not var_47_0 then
		Debug.LogError("ShopTools.GetDiscount 没有配置goodID:" .. arg_47_0)
	end

	local var_47_1 = ShopListCfg[var_47_0.shop_id]
	local var_47_2
	local var_47_3
	local var_47_4
	local var_47_5

	if var_47_0 and var_47_0.is_limit_time_discount and var_47_0.is_limit_time_discount == 1 then
		if var_0_0.IsRMB(arg_47_0) then
			local var_47_6 = PaymentCfg[var_47_0.cost_id].cost
			local var_47_7 = PaymentCfg[var_47_0.cheap_cost_id].cost

			var_47_2 = math.ceil(100 * var_47_7 / var_47_6)
		else
			var_47_2 = math.ceil(100 * var_47_0.cheap_cost / var_47_0.cost)
		end
	elseif var_47_0 and var_47_0.discount and var_47_0.discount ~= 0 then
		var_47_2 = var_47_0.discount
	else
		var_47_2 = 100
	end

	if var_47_0 and var_47_0.is_limit_time_discount_2 and var_47_0.is_limit_time_discount_2 == 1 then
		var_47_3 = math.ceil(100 * var_47_0.cheap_cost_2 / var_47_0.cost_2)
	elseif var_47_0 and var_47_0.discount and var_47_0.discount ~= 0 then
		var_47_3 = var_47_0.discount
	else
		var_47_3 = 100
	end

	if var_47_2 == 100 then
		var_47_4 = var_47_0.cost_id
	else
		var_47_4 = var_47_0.cheap_cost_id
	end

	if var_47_3 == 100 then
		local var_47_8 = var_47_0.cost_id_2
	else
		local var_47_9 = var_47_0.cheap_cost_id_2
	end

	local var_47_10 = var_47_1.cheap_open_time
	local var_47_11 = var_47_1.cheap_close_time
	local var_47_12 = CheckGoodsTime(var_47_10, var_47_11)

	if var_47_1 and var_47_1.is_limit_time_discount == 1 and var_47_12 then
		if var_47_1.is_limit_buy_discount == 0 and var_47_0.limit_num ~= nil and var_47_0.limit_num ~= -1 then
			return var_47_2, var_47_3
		end

		if var_47_1.cheap_limit_currency[1] == 1 then
			if table.indexof(var_47_1.cheap_limit_currency[2], var_47_4) then
				var_47_2 = math.min(var_47_1.discount, var_47_2)
				var_47_3 = math.min(var_47_1.discount, var_47_3)
			end
		elseif var_47_1.cheap_limit_currency[1] == 2 then
			if not table.indexof(var_47_1.cheap_limit_currency[2], var_47_4) then
				var_47_2 = math.min(var_47_1.discount, var_47_2)
				var_47_3 = math.min(var_47_1.discount, var_47_3)
			end
		else
			var_47_2 = math.min(var_47_1.discount, var_47_2)
			var_47_3 = math.min(var_47_1.discount, var_47_3)
		end
	end

	return var_47_2, var_47_3
end

function var_0_0.GetOriPrice(arg_48_0)
	local var_48_0 = getShopCfg(arg_48_0)
	local var_48_1 = ShopListCfg[var_48_0.shop_id]
	local var_48_2, var_48_3 = var_0_0.CalculateOriPriceFromDiscountPrice(var_48_0)

	return var_48_2, var_48_3
end

function var_0_0.CalculateOriPriceFromDiscountPrice(arg_49_0)
	local var_49_0 = arg_49_0.cost or 0
	local var_49_1 = arg_49_0.cost_2 or 0

	if var_0_0.IsRMB(arg_49_0.goods_id) then
		if arg_49_0.cheap_cost and arg_49_0.cheap_cost ~= 0 and arg_49_0.discount < 100 and arg_49_0.discount > 0 then
			var_49_0, var_49_1 = math.ceil(PaymentCfg[arg_49_0.cheap_cost].cost / 100 * 100 / arg_49_0.discount), arg_49_0.cost_2
		else
			var_49_0, var_49_1 = PaymentCfg[arg_49_0.cost_id].cost / 100, arg_49_0.cost_2
		end
	end

	if arg_49_0.discount < 100 and arg_49_0.discount > 0 then
		if arg_49_0.cheap_cost and arg_49_0.cheap_cost ~= 0 then
			var_49_0 = math.ceil(arg_49_0.cheap_cost * 100 / arg_49_0.discount)
		end

		if arg_49_0.cheap_cost_2 and arg_49_0.cheap_cost_2 ~= 0 and arg_49_0.cheap_cost_2 and arg_49_0.cheap_cost_2 ~= 0 then
			var_49_1 = math.ceil(arg_49_0.cheap_cost_2 * 100 / arg_49_0.discount)
		end
	end

	return var_49_0, var_49_1
end

function var_0_0.GetMoneySymbol(arg_50_0)
	local var_50_0 = getShopCfg(arg_50_0)

	if var_0_0.IsRMB(arg_50_0) and PaymentCfg[var_50_0.cost_id] then
		return PaymentCfg[var_50_0.cost_id].currency_symbol
	end

	return ""
end

function var_0_0.GetDiscountPrice(arg_51_0)
	local var_51_0 = getShopCfg(arg_51_0)
	local var_51_1, var_51_2 = var_0_0.GetOriPrice(arg_51_0)
	local var_51_3 = ShopListCfg[var_51_0.shop_id]
	local var_51_4, var_51_5 = var_0_0.GetDiscount(arg_51_0)

	if var_51_4 ~= 100 or var_51_5 ~= 100 then
		if var_0_0.IsRMB(arg_51_0) then
			if var_51_0.cheap_cost_id == 0 then
				return PaymentCfg[var_51_0.cost_id].cost / 100
			else
				return PaymentCfg[var_51_0.cheap_cost_id].cost / 100
			end
		else
			if var_51_3 and var_51_3.discount ~= 0 then
				local var_51_6 = var_51_3.discount * var_51_1 * 100 / 10000
				local var_51_7 = var_51_3.discount * var_51_2 * 100 / 10000
				local var_51_8 = math.floor(var_51_6)
				local var_51_9 = math.floor(var_51_7)
				local var_51_10

				var_51_10 = var_51_8 == var_51_6

				local var_51_11 = var_51_9 == var_51_7

				if var_51_0.cheap_cost == 0 then
					return flag and math.max(var_51_8, 1) or var_51_8
				elseif var_51_3.is_limit_buy_discount == 0 and var_51_0.limit_num > 0 then
					return var_51_0.cheap_cost, var_51_0.cheap_cost_2 == 0 and 0 or var_51_2
				else
					return math.min(flag and math.max(var_51_8, 1) or var_51_8, var_51_0.cheap_cost), math.min(var_51_11 and math.max(var_51_9, 1) or var_51_8, var_51_0.cheap_cost_2)
				end
			end

			return var_51_0.cheap_cost, var_51_0.cheap_cost_2 ~= 0 and var_51_0.cheap_cost_2 or var_51_2
		end
	else
		return var_51_1, var_51_2
	end
end

function var_0_0.IsShopOpen(arg_52_0)
	local var_52_0 = ShopListCfg[arg_52_0]

	if var_52_0.activity_id == 0 then
		return true, 0
	elseif ActivityData:GetActivityIsOpen(var_52_0.activity_id) then
		return true, 1
	else
		local var_52_1 = ActivityData:GetActivityData(var_52_0.activity_id)
		local var_52_2 = manager.time:GetServerTime()

		if var_52_1 and var_52_2 < var_52_1.startTime then
			return false, 3
		else
			return false, 2
		end
	end
end

function var_0_0.GetGoodsIDListByItemID(arg_53_0, arg_53_1)
	local var_53_0 = {}

	if #getShopIDListByShopID(arg_53_0) > 0 then
		local var_53_1 = getShopIDListByShopID(arg_53_0)

		for iter_53_0, iter_53_1 in ipairs(var_53_1) do
			if getShopCfg(iter_53_1).give_id == arg_53_1 then
				table.insert(var_53_0, iter_53_1)
			end
		end
	end

	return var_53_0
end

function var_0_0.IsGoodCanExchange(arg_54_0, arg_54_1)
	for iter_54_0, iter_54_1 in ipairs(arg_54_1) do
		if var_0_0.IsGoodCanDisplay(arg_54_0, iter_54_1) then
			return true
		end
	end

	return false
end

function var_0_0.CheckShopIsUnLock(arg_55_0)
	if arg_55_0 then
		local var_55_0 = ShopListCfg[arg_55_0].open_condition

		if var_55_0 and var_55_0 > 0 and (ShopListCfg[arg_55_0].display_group == 18 or ShopListCfg[arg_55_0].display_group == 24) then
			return IsConditionAchieved(var_55_0)
		end
	end

	return true
end

function var_0_0.GetShopIsUnLockDesc(arg_56_0)
	local var_56_0 = ShopListCfg[arg_56_0].open_condition

	if var_56_0 and var_56_0 > 0 and ShopListCfg[arg_56_0].display_group == 18 then
		local var_56_1, var_56_2, var_56_3 = IsConditionAchieved(var_56_0)
		local var_56_4 = string.format(GetTips("ACTIVITY_CLUB_SP_SHOP_UNLOCK_PROGRESS"), tostring(var_56_2), tostring(var_56_3))

		return GuildActivityTools.GetGuildSpConditionDesc(var_56_0) .. GetTips("DORM_CANTEEN_LEVEL_UNLOCK") .. var_56_4
	end
end

function var_0_0.CheckDlcPurchased(arg_57_0)
	local var_57_0 = getShopCfg(arg_57_0)

	if not var_57_0 then
		return true
	end

	local var_57_1 = var_57_0.give_id or var_57_0.description

	if not var_57_0.give then
		local var_57_2 = 1
	end

	local var_57_3
	local var_57_4

	if var_57_0.description then
		local var_57_5 = var_57_0.description

		var_57_4 = RechargeShopDescriptionCfg[var_57_5]
	else
		var_57_4 = ItemCfg[var_57_1]
	end

	if var_57_4 and var_57_4.type == ItemConst.ITEM_TYPE.SCENE and (SceneConst.HOME_SCENE_TYPE.LOCK == HomeSceneSettingData:GetUsedState(var_57_4.id) or SceneConst.HOME_SCENE_TYPE.TRIAL == HomeSceneSettingData:GetUsedState(var_57_4.id)) then
		return false
	end

	return true
end

function var_0_0.CheckDlcPurchasedByItemID(arg_58_0)
	local var_58_0 = ItemCfg[arg_58_0]

	if var_58_0 and var_58_0.type == ItemConst.ITEM_TYPE.SCENE and (SceneConst.HOME_SCENE_TYPE.LOCK == HomeSceneSettingData:GetUsedState(var_58_0.id) or SceneConst.HOME_SCENE_TYPE.TRIAL == HomeSceneSettingData:GetUsedState(var_58_0.id)) then
		return false
	end

	return true
end

function var_0_0.CheckDlcTrialByItemID(arg_59_0)
	local var_59_0 = ItemCfg[arg_59_0]

	if var_59_0 and var_59_0.type == ItemConst.ITEM_TYPE.SCENE and SceneConst.HOME_SCENE_TYPE.TRIAL == HomeSceneSettingData:GetUsedState(var_59_0.id) then
		return true
	end

	return false
end

function var_0_0.GetFragmentList()
	local var_60_0 = {}
	local var_60_1 = HeroTools.GetCanExchangeHero()

	for iter_60_0 = 1, #var_60_1 do
		local var_60_2 = var_60_1[iter_60_0]
		local var_60_3 = ItemCfg[var_60_2.id].rare - 2
		local var_60_4 = GameSetting.fragment_break_num.value[var_60_3]

		var_60_0[var_60_4[1]] = (var_60_0[var_60_4[1]] or 0) + var_60_2.number * var_60_4[2]
	end

	local var_60_5 = {}

	for iter_60_1, iter_60_2 in pairs(var_60_0) do
		if iter_60_2 > 0 then
			table.insert(var_60_5, {
				id = iter_60_1,
				num = iter_60_2
			})
		end
	end

	return var_60_5
end

function var_0_0.CheckGiftSkinOwn(arg_61_0)
	local var_61_0 = getShopCfg(arg_61_0)
	local var_61_1 = RechargeShopDescriptionCfg[var_61_0.description]

	if var_61_1.sub_type == ItemConst.ITEM_SUB_TYPE.SHOP_PACKS then
		for iter_61_0, iter_61_1 in ipairs(var_61_1.param) do
			if iter_61_1[1] then
				local var_61_2 = ItemCfg[iter_61_1[1]]

				if ItemTools.getItemNum(iter_61_1[1]) == 1 and var_61_2.type == ItemConst.ITEM_TYPE.HERO_SKIN and ShopTools.HaveSkin(iter_61_1[1]) then
					return true
				end
			end
		end
	end

	return false
end

function var_0_0.SplitDataByShopID(arg_62_0, arg_62_1)
	local var_62_0 = ShopListCfg[arg_62_1]
	local var_62_1 = {
		{},
		{},
		{},
		{},
		{}
	}
	local var_62_2 = {}

	for iter_62_0, iter_62_1 in ipairs(arg_62_0) do
		local var_62_3 = getShopCfg(iter_62_1.id)
		local var_62_4 = ItemCfg[var_62_3.give_id]

		if var_62_3.shop_refresh == 4 and var_62_4.type == ItemConst.ITEM_TYPE.HERO_PIECE then
			table.insert(var_62_1[5], iter_62_1)
		elseif var_62_4.type == ItemConst.ITEM_TYPE.HERO_PIECE then
			table.insert(var_62_1[4], iter_62_1)
		elseif var_62_4.type == ItemConst.ITEM_TYPE.EQUIP then
			table.insert(var_62_1[3], iter_62_1)
		elseif var_62_4.type == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
			table.insert(var_62_1[2], iter_62_1)
		else
			table.insert(var_62_1[1], iter_62_1)
		end
	end

	local var_62_5 = {
		false,
		false,
		false,
		false,
		false
	}

	for iter_62_2, iter_62_3 in ipairs(var_62_0.shop_label) do
		var_62_5[iter_62_3] = true
	end

	for iter_62_4, iter_62_5 in ipairs(var_62_1) do
		if var_62_5[iter_62_4] == false then
			for iter_62_6, iter_62_7 in ipairs(var_62_1[iter_62_4]) do
				table.insert(var_62_1[1], iter_62_5)
			end

			var_62_1[iter_62_4] = {}
		end
	end

	for iter_62_8, iter_62_9 in ipairs(var_62_1) do
		if #iter_62_9 > 0 then
			var_0_0.CommonSort(iter_62_9)
		end
	end

	local var_62_6 = {}

	for iter_62_10, iter_62_11 in ipairs(var_62_1[3]) do
		local var_62_7 = getShopCfg(iter_62_11.id)
		local var_62_8 = EquipCfg[var_62_7.give_id]

		if var_62_6[var_62_8.suit] == nil then
			var_62_6[var_62_8.suit] = {}
		end

		if var_62_6[var_62_8.suit][var_62_8.starlevel] == nil then
			var_62_6[var_62_8.suit][var_62_8.starlevel] = {}
		end

		table.insert(var_62_6[var_62_8.suit][var_62_8.starlevel], iter_62_11)
	end

	local var_62_9 = {}

	for iter_62_12, iter_62_13 in pairs(var_62_6) do
		table.insert(var_62_9, iter_62_12)
	end

	local var_62_10 = {}

	for iter_62_14, iter_62_15 in ipairs(EquipSuitCfg.all) do
		if var_62_6[iter_62_15] then
			for iter_62_16, iter_62_17 in pairs(var_62_6[iter_62_15]) do
				table.insert(var_62_10, iter_62_17)
			end
		end
	end

	if #var_62_10 == 0 or #var_62_10[1] == 6 then
		var_62_1[3] = var_62_10
	end

	local var_62_11 = {}

	for iter_62_18, iter_62_19 in ipairs(var_62_1) do
		if #iter_62_19 ~= 0 then
			table.insert(var_62_2, iter_62_18)
		end
	end

	for iter_62_20, iter_62_21 in ipairs(var_62_0.shop_label) do
		if #var_62_1[iter_62_21] ~= 0 then
			table.insert(var_62_11, var_62_1[iter_62_21])
		end
	end

	return var_62_11, var_62_2, var_62_9
end

function var_0_0.IsPC()
	return GameToSDK.IsPCPlatform()
end

function var_0_0.IsLimitRecharge()
	return var_0_0.IsPC() and _G.CHANNEL_MASTER_ID ~= 1
end

function var_0_0.CheckDlcCanBuy(arg_65_0)
	if arg_65_0 == nil or arg_65_0 == 0 then
		return false
	end

	local var_65_0 = getShopCfg(arg_65_0)

	if not var_65_0 then
		return false
	end

	return var_0_1.SHOP_ID.DLC_SHOP == var_65_0.shop_id or var_0_1.SHOP_ID.REPURCHASE_SHOP == var_65_0.shop_id
end

function var_0_0.JumpToSkinShop(arg_66_0, arg_66_1, arg_66_2, arg_66_3)
	local var_66_0 = 0
	local var_66_1

	if not arg_66_1 then
		var_66_0 = var_0_0.GetGoodsIdBySkinId(arg_66_0)
	else
		var_66_0, var_66_1 = var_0_0.GetGoodsIdByDlcId(arg_66_3)
	end

	if var_66_0 == 0 then
		ShowTips(GetTips("ERROR_SHOP_GOODS_OPEN_TIME"))

		return
	end

	local var_66_2 = getShopCfg(var_66_0)

	if not var_66_2 then
		ShowTips(GetTips("ERROR_SHOP_GOODS_OPEN_TIME"))

		return
	end

	local var_66_3 = false

	if ShopTools.CheckShopIsUnLock(var_66_2.shop_id) and ShopTools.IsGoodCanDisplay(var_66_2.shop_id, var_66_2.goods_id) then
		var_66_3 = true
	end

	if var_66_3 then
		local var_66_4 = ShopListCfg[var_66_2.shop_id]

		JumpTools.GoToSystem("/rechargeMain", {
			page = var_66_4.display_group,
			shopListId = var_66_4.id
		}, var_66_4.system)

		local var_66_5 = SkinCfg[arg_66_0]

		if var_66_1 == var_0_1.SHOP_ID.PASSPORT_SHOP then
			JumpTools.OpenPageByJump("shop", {
				goodID = var_66_2.goods_id,
				heroID = var_66_5.hero,
				skinID = arg_66_0,
				shopID = var_66_2.shop_id
			})
		else
			JumpTools.OpenPageByJump("/heroSkinPreview", {
				isShop = true,
				heroID = var_66_5.hero,
				skinID = var_66_5.id,
				goodId = var_66_2.goods_id,
				shopID = var_66_2.shop_id,
				isDlc = arg_66_1
			})
		end
	else
		ShowTips(GetTips("ERROR_SHOP_GOODS_OPEN_TIME"))
	end
end

function var_0_0.CheckGiveIsOwn(arg_67_0, arg_67_1)
	local function var_67_0(arg_68_0, arg_68_1)
		arg_68_1 = arg_68_1 or 0

		local var_68_0 = ItemCfg[arg_68_0]

		if ItemTools.getItemNum(arg_68_0) + arg_68_1 >= var_68_0.limit then
			return false
		end

		return true
	end

	local var_67_1 = getShopCfg(arg_67_0)

	if var_67_1.description then
		local var_67_2 = RechargeShopDescriptionCfg[var_67_1.description]

		if var_67_2.sub_type == ItemConst.ITEM_SUB_TYPE.SHOP_PACKS then
			for iter_67_0, iter_67_1 in ipairs(var_67_2.param) do
				if var_67_0(iter_67_1[1], iter_67_1[2] * arg_67_1) == false then
					return false
				end
			end

			return true
		else
			return var_67_0(var_67_1.description, arg_67_1)
		end
	else
		return var_67_0(var_67_1.give_id, arg_67_1)
	end

	return false
end

function var_0_0.GetGoodsIdBySkinId(arg_69_0)
	local var_69_0 = var_0_0.FilterShopDataList(var_0_1.SHOP_ID.SKIN_SHOP)

	for iter_69_0, iter_69_1 in pairs(var_69_0) do
		if getShopCfg(iter_69_1.id).description == arg_69_0 then
			return iter_69_1.id
		end
	end
end

function var_0_0.GetGoodsIdByDlcId(arg_70_0)
	local var_70_0 = var_0_0.FilterShopDataList(var_0_1.SHOP_ID.SKIN_SHOP)

	for iter_70_0, iter_70_1 in pairs(var_70_0) do
		if getShopCfg(iter_70_1.id).description == arg_70_0 then
			return iter_70_1.id, var_0_1.SHOP_ID.SKIN_SHOP
		end
	end

	local var_70_1 = var_0_0.FilterShopDataList(var_0_1.SHOP_ID.PASSPORT_SHOP)

	for iter_70_2, iter_70_3 in pairs(var_70_1) do
		if getShopCfg(iter_70_3.id).give_id == arg_70_0 then
			return iter_70_3.id, var_0_1.SHOP_ID.PASSPORT_SHOP
		end
	end
end

function var_0_0.CheckGoodsOwen(arg_71_0)
	local var_71_0 = getShopCfg(arg_71_0)

	if var_71_0.shop_refresh ~= 3 then
		local var_71_1 = ItemCfg[var_71_0.give_id]

		if var_71_1.num_exchange_item then
			return ItemTools.getItemNum(var_71_0.give_id) >= var_71_1.limit
		end
	else
		local var_71_2 = RechargeShopDescriptionCfg[var_71_0.description]

		if var_71_2.sub_type == ItemConst.ITEM_SUB_TYPE.SHOP_PACKS then
			for iter_71_0, iter_71_1 in ipairs(RechargeShopDescriptionCfg[var_71_0.description].param) do
				local var_71_3 = ItemCfg[iter_71_1[1]]

				if var_71_3.num_exchange_item and ItemTools.getItemNum(iter_71_1[1]) >= var_71_3.limit then
					return true
				end
			end
		elseif var_71_2.sub_type == ItemConst.ITEM_SUB_TYPE.SHOP_SEVEN_PACKS then
			for iter_71_2, iter_71_3 in pairs(var_71_2.param[2]) do
				local var_71_4 = ItemCfg[iter_71_3[1]]

				if var_71_4.num_exchange_item and ItemTools.getItemNum(iter_71_3[1]) >= var_71_4.limit then
					return true
				end
			end
		end
	end

	return false
end

function var_0_0.rewertReward(arg_72_0, arg_72_1)
	local var_72_0 = {}
	local var_72_1 = getShopCfg(arg_72_0)

	if var_72_1.description then
		local var_72_2 = RechargeShopDescriptionCfg[var_72_1.description]

		if var_72_2.sub_type == ItemConst.ITEM_SUB_TYPE.SHOP_PACKS then
			for iter_72_0, iter_72_1 in pairs(var_72_2.param) do
				table.insert(var_72_0, {
					id = iter_72_1[1],
					num = iter_72_1[2] * arg_72_1
				})
			end
		elseif var_72_2.sub_type == ItemConst.ITEM_SUB_TYPE.SHOP_SEVEN_PACKS then
			for iter_72_2, iter_72_3 in pairs(var_72_2.param[2]) do
				table.insert(var_72_0, {
					id = iter_72_3[1],
					num = iter_72_3[2] * arg_72_1 * var_72_2.param[3]
				})
			end
		end
	else
		table.insert(var_72_0, {
			id = var_72_1.give_id,
			num = var_72_1.give * arg_72_1
		})
	end

	local var_72_3 = {}
	local var_72_4 = {}

	for iter_72_4, iter_72_5 in ipairs(var_72_0) do
		local var_72_5 = ItemCfg[iter_72_5.id]

		if var_72_5.num_exchange_item and ItemTools.getItemNum(iter_72_5.id) + iter_72_5.num > var_72_5.limit then
			if ItemTools.getItemNum(iter_72_5.id) > var_72_5.limit then
				table.insert(var_72_3, {
					id = iter_72_5.id,
					num = iter_72_5.num
				})
				table.insert(var_72_4, {
					id = var_72_5.num_exchange_item[1][1],
					num = iter_72_5.num * var_72_5.num_exchange_item[1][2]
				})
			else
				table.insert(var_72_3, {
					id = iter_72_5.id,
					num = ItemTools.getItemNum(iter_72_5.id) + iter_72_5.num - var_72_5.limit
				})
				table.insert(var_72_4, {
					id = var_72_5.num_exchange_item[1][1],
					num = (ItemTools.getItemNum(iter_72_5.id) + iter_72_5.num - var_72_5.limit) * var_72_5.num_exchange_item[1][2]
				})
			end
		end
	end

	local var_72_6 = formatRewardCfgList(var_72_4)
	local var_72_7 = mergeReward(var_72_6)

	return var_72_3, var_72_7
end

function var_0_0.revertGoodsReward(arg_73_0)
	local var_73_0 = {}

	for iter_73_0, iter_73_1 in ipairs(arg_73_0) do
		local var_73_1 = iter_73_1.id
		local var_73_2 = iter_73_1.num
		local var_73_3 = ItemCfg[var_73_1]
		local var_73_4 = ItemTools.getItemNum(var_73_1)

		if var_73_3.num_exchange_item and ItemTools.getItemNum(var_73_1) > var_73_3.limit then
			local var_73_5 = var_73_3.limit
			local var_73_6 = var_73_3.num_exchange_item[1]
			local var_73_7 = var_73_4 - var_73_2
			local var_73_8 = var_73_4 - var_73_5

			var_73_2 = math.max(var_73_5 - var_73_7, 0)

			if var_73_2 > 0 then
				table.insert(var_73_0, {
					id = var_73_1,
					num = var_73_2
				})
			end

			table.insert(var_73_0, {
				id = var_73_6[1],
				num = var_73_8 * var_73_6[2],
				convert_from = {
					id = var_73_1,
					num = var_73_8
				}
			})
		else
			table.insert(var_73_0, {
				id = var_73_1,
				num = var_73_2
			})
		end
	end

	return var_73_0
end

function var_0_0.IsShopDiscount(arg_74_0)
	local var_74_0 = ShopListCfg[arg_74_0]

	if #var_74_0.cheap_close_time > 0 then
		local var_74_1 = TimeMgr.GetInstance():GetServerTime()
		local var_74_2 = TimeMgr.GetInstance():parseTimeFromConfig(var_74_0.cheap_open_time)
		local var_74_3 = TimeMgr.GetInstance():parseTimeFromConfig(var_74_0.cheap_close_time)

		if var_74_2 <= var_74_1 and var_74_1 <= var_74_3 then
			return true
		end

		return false
	end
end

function var_0_0.IsAnyShopDiscount(arg_75_0)
	for iter_75_0, iter_75_1 in ipairs(arg_75_0) do
		if var_0_0.IsShopDiscount(iter_75_1) then
			return true
		end
	end

	return false
end

function var_0_0.GetSceneIdByDlcGoodsId(arg_76_0)
	return RechargeShopDescriptionCfg[getShopCfg(arg_76_0).description].param[1]
end

function var_0_0.GetSkinIdByDlcGoodsId(arg_77_0)
	local var_77_0 = RechargeShopDescriptionCfg[getShopCfg(arg_77_0).description].param[1]
	local var_77_1 = SkinSceneActionCfg.get_id_list_by_special_scene_id[var_77_0][1]

	return nullable(SkinSceneActionCfg, var_77_1, "skin_id")
end

function var_0_0.GetFakeShopDataList(arg_78_0)
	local var_78_0 = clone(arg_78_0)

	for iter_78_0, iter_78_1 in ipairs(arg_78_0) do
		local var_78_1 = getShopCfg(iter_78_1.id)
		local var_78_2 = RechargeShopDescriptionCfg[var_78_1.description or 0]

		if var_78_2 and var_78_2.type == ItemConst.ITEM_TYPE.SCENE then
			local var_78_3 = var_0_0.GetSkinIdByDlcGoodsId(iter_78_1.id)

			if HeroTools.GetShopIdBySkinId(var_78_3) <= 0 then
				table.insert(var_78_0, {
					next_refresh_timestamp = 0,
					buyTime = 0,
					id = -iter_78_1.id,
					shopId = var_0_1.SHOP_ID.DLC_SHOP
				})

				ShopCfg[-iter_78_1.id] = {
					taken_down = 0,
					position = 0,
					shop_refresh = 3,
					is_limit_time_discount = 0,
					goods_id = -var_78_1.goods_id,
					shop_id = var_0_1.SHOP_ID.DLC_SHOP,
					shop_sort = var_78_1.shop_sort,
					give_id = var_78_3,
					description = var_78_3,
					give = var_78_1.give,
					cost_type = var_78_1.cost_type,
					cost_id = var_78_1.cost_id,
					cost = var_78_1.cost,
					cheap_cost_id = var_78_1.cheap_cost_id,
					cheap_cost = var_78_1.cheap_cost,
					cost_id_2 = var_78_1.cost_id_2,
					cost_2 = var_78_1.cost_2,
					cheap_cost_id_2 = var_78_1.cheap_cost_id_2,
					cheap_cost_2 = var_78_1.cheap_cost_2,
					is_limit_time_discount_2 = var_78_1.is_limit_time_discount_2,
					cheap_open_time_2 = {},
					cheap_close_time_2 = {},
					discount = var_78_1.discount,
					limit_num = var_78_1.limit_num,
					level_limit = {},
					limit_display = {},
					pre_goods_id = {},
					refresh_cycle = var_78_1.refresh_cycle,
					open_time = {},
					close_time = {},
					cheap_open_time = {},
					cheap_close_time = {},
					tag = var_78_1.tag,
					backhome_tag = var_78_1.backhome_tag,
					next_goods_id = cleanProtoTable(var_78_1.next_goods_id),
					give_back_list = {},
					dlc = iter_78_1.id
				}
				SkinIDToGoodIDCfg[var_78_3] = {
					id = -iter_78_1.id,
					goods_id = {
						-iter_78_1.id
					}
				}
				RechargeShopDescriptionCfg[var_78_3] = clone(ItemCfg[var_78_3])
				RechargeShopDescriptionCfg[var_78_3].param[1] = var_78_3
			end
		end
	end

	return var_78_0
end

function var_0_0.OpenWebRecharge()
	ShowMessageBox({
		isTop = true,
		title = GetTips("PROMPT"),
		content = GetTips("ERROR_PC_SHOP_TIPS3"),
		BtnText = {
			[3] = GetTips("ERROR_PC_SHOP_JUMP")
		},
		OkCallback = function()
			local var_80_0 = {
				userId = PlayerData:GetPlayerInfo().userID,
				signUserId = PlayerData:GetPlayerInfo().signUserId,
				gameAppId = _G.ChannelLoginInfo.channelAppId,
				token = _G.ChannelLoginInfo.channelToken
			}

			OperationAction.OpenOperationUrl("PC_SHOP", var_80_0)
		end
	})
end

return var_0_0
