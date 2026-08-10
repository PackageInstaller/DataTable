local var_0_0 = {}

manager.net:Bind(20005, function(arg_1_0)
	ShopData.SingleShopUpdate(arg_1_0.changed_shop_info)
	var_0_0.UpdateRedPoints()
	var_0_0.UpdateNewShopRedPoints()
end)
manager.net:Bind(20009, function(arg_2_0)
	ShopData.AllShopUpdate(arg_2_0.shop_item_list)
	var_0_0.UpdateRedPoints()
	var_0_0.UpdateNewShopRedPoints()
end)
manager.net:Bind(20003, function(arg_3_0)
	UpdateShopCfg(arg_3_0.shop_item_cfg_list)
	var_0_0.UpdateRedPoints()
end)
manager.net:Bind(20007, function(arg_4_0)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0.shop_item_cfg_list) do
		UpdateShopCfg(iter_4_1)
	end

	var_0_0.UpdateRedPoints()
end)

function var_0_0.LateInitLua()
	JumpTools.SetSystemOpenCheck(ViewConst.SYSTEM_ID.RECHARGE_SKIN, function(arg_6_0)
		local var_6_0 = arg_6_0.goodID
		local var_6_1 = arg_6_0.skinID
		local var_6_2 = getShopCfg(var_6_0)

		if var_6_2 and not ShopTools.IsGoodCanDisplay(var_6_2.shop_id, var_6_2.goods_id) then
			return false, GetTips("GOODS_HAS_BEEN_REMOVED")
		end

		if (ShopTools.HaveSkin(var_6_1) or HeroTools.CanChangeSkin(var_6_1)) and var_6_2.dlc and ShopTools.CheckDlcPurchased(var_6_2.dlc) then
			return false, GetTips("SOLD_OUT")
		end

		return true, ""
	end)
	JumpTools.SetSystemOpenCheck(ViewConst.SYSTEM_ID.RECHARGE_FUKUBUKURO, function(arg_7_0)
		local var_7_0 = arg_7_0.goodID
		local var_7_1 = arg_7_0.shopID
		local var_7_2 = getShopCfg(var_7_0)

		if var_7_2 and not ShopTools.IsGoodCanDisplay(var_7_2.shop_id, var_7_2.goods_id) then
			return false, GetTips("GOODS_HAS_BEEN_REMOVED")
		end

		local var_7_3 = ShopData.GetShop(var_7_1)[var_7_0]

		if var_7_3 ~= nil and var_7_2.limit_num ~= nil and var_7_2.limit_num ~= -1 and var_7_2.limit_num - (var_7_3.buy_times or 0) <= 0 then
			return false, GetTips("SOLD_OUT")
		end

		return true, ""
	end)
end

manager.notify:RegistListener(NEW_DAY, function()
	var_0_0.UpdateRedPoints()
end)

function var_0_0.UpdateRedPoints()
	if manager.time == nil or manager.time:GetServerTime() == manager.time:RealtimeSinceStartup() then
		return
	end

	for iter_9_0, iter_9_1 in ipairs(RechargeRecommendCfg.all) do
		local var_9_0 = RechargeRecommendCfg[iter_9_1]
		local var_9_1 = var_9_0.time[1]
		local var_9_2 = false

		if not var_9_1 or #var_9_1[1] < 3 or #var_9_1[2] < 3 then
			var_9_2 = true
		end

		local var_9_3 = var_9_0.time[2]

		if not var_9_3 or #var_9_3[1] < 3 or #var_9_3[2] < 3 then
			var_9_2 = true
		end

		if not var_9_2 then
			local var_9_4 = TimeMgr.GetInstance():parseTimeFromConfig(var_9_0.time[1])
			local var_9_5 = TimeMgr.GetInstance():parseTimeFromConfig(var_9_0.time[2])
			local var_9_6 = TimeMgr.GetInstance():GetServerTime()

			var_9_2 = var_9_6 < var_9_5 and var_9_4 <= var_9_6 and true or false
		end

		local var_9_7 = RedPointConst.RECHARGE_RECOMMEND .. iter_9_1

		if var_9_0.new_recommend == 0 or not var_9_2 or getData("recharge_recommend", tostring(iter_9_1)) ~= nil then
			manager.redPoint:setTip(var_9_7, 0)
		else
			manager.redPoint:setTip(var_9_7, 1)
		end
	end
end

function var_0_0.UpdateNewShopRedPoints()
	local var_10_0 = ShopData.GetRedPointData()

	manager.redPoint:setTip(RedPointConst.NEW_SHOP_RECHARGE, 0, RedPointStyle.SHOW_NEW_TAG)
	manager.redPoint:setTip(RedPointConst.NEW_SHOP_SHOP, 0, RedPointStyle.SHOW_NEW_TAG)

	for iter_10_0, iter_10_1 in pairs(ShopListCfg.all) do
		local var_10_1 = ShopListCfg[iter_10_1]

		if var_10_1.system == "2" then
			manager.redPoint:setTip(RedPointConst.NEW_SHOP_RECHARGE .. var_10_1.display_group, 0, RedPointStyle.SHOW_NEW_TAG)
		elseif var_10_1.system == "1" then
			manager.redPoint:setTip(RedPointConst.NEW_SHOP_SHOP .. var_10_1.display_group, 0, RedPointStyle.SHOW_NEW_TAG)
		end
	end

	for iter_10_2, iter_10_3 in pairs(var_10_0) do
		local var_10_2 = ShopListCfg[iter_10_2]

		if ShopTools.IsPC() and ShopConst.PC_LOCK_SHOP[iter_10_2] then
			var_10_0[iter_10_2] = false
		end
	end
end

function var_0_0.ReadRedPoint(arg_11_0)
	local var_11_0 = RedPointConst.RECHARGE_RECOMMEND .. arg_11_0

	saveData("recharge_recommend", tostring(arg_11_0), true)
	var_0_0.UpdateRedPoints()
end

function var_0_0.BuyItem(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_2 == nil then
		arg_12_2 = 0
	end

	local var_12_0 = {}
	local var_12_1

	for iter_12_0, iter_12_1 in ipairs(arg_12_0) do
		local var_12_2 = getShopCfg(iter_12_1.goodID)

		var_12_1 = var_12_2.shop_id

		if not ShopTools.IsShopOpen(var_12_1) then
			ShowTips("TIME_OVER")

			return
		end

		local var_12_3 = 0
		local var_12_4, var_12_5 = ShopTools.GetCostId(iter_12_1.goodID)
		local var_12_6, var_12_7, var_12_8, var_12_9 = ShopTools.GetPrice(iter_12_1.goodID)

		if iter_12_1.buyType == 1 then
			var_12_4 = var_12_5
			var_12_6 = var_12_9
		end

		local var_12_10 = ItemCfg[var_12_4].type

		if arg_12_1 then
			var_12_6 = arg_12_1
		end

		local var_12_11 = var_12_6 * iter_12_1.buyNum
		local var_12_12 = {}

		if var_12_2.cost_type == 2 then
			local var_12_13 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_DIAMOND)
			local var_12_14 = math.min(var_12_11, var_12_13)
			local var_12_15 = var_12_11 - var_12_14

			table.insert(var_12_12, {
				id = CurrencyConst.CURRENCY_TYPE_DIAMOND,
				num = var_12_14
			})

			if var_12_15 > 0 then
				table.insert(var_12_12, {
					id = CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE,
					num = var_12_15
				})
			end

			if var_12_15 > 0 and var_12_15 > CurrencyData:GetRechargeDiamond() then
				ShopTools.DiamondEnoughMessageBox()

				return
			end
		else
			table.insert(var_12_12, {
				id = var_12_4,
				num = var_12_11
			})

			if var_12_10 == ItemConst.ITEM_TYPE.CURRENCY then
				local var_12_16 = var_12_4
				local var_12_17 = ItemTools.getItemNum(var_12_16)

				if var_12_17 < var_12_11 then
					if var_12_16 == CurrencyConst.CURRENCY_TYPE_GOLD then
						local var_12_18 = false
						local var_12_19 = ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.PROPS_BOND]

						for iter_12_2, iter_12_3 in ipairs(var_12_19 or {}) do
							if ItemTools.getItemNum(iter_12_3) > 0 then
								var_12_18 = true

								break
							end
						end

						if CurrencyData:GetGoldBuyTimes() < GameSetting.coin_max_buy_time.value[1] or var_12_18 then
							JumpTools.OpenPopUp("currencyBuyGold", nil, ViewConst.SYSTEM_ID.BUY_GOLD)

							return
						end
					elseif var_12_16 == CurrencyConst.CURRENCY_TYPE_DIAMOND then
						if AreaDifferenceCfg[GameToSDK.CURRENT_SERVER].payment == 1 then
							ShopTools.DefaultOpenPopUp(var_12_11 - var_12_17)
						else
							ShowTips("ERROR_ITEM_NOT_ENOUGH_CURRENCY")
						end

						return
					elseif var_12_16 == CurrencyConst.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE then
						ShopTools.DiamondEnoughMessageBox()

						return
					end

					ShowTips(string.format(GetTips("CURRENCY_NO_ENOUGH"), GetI18NText(ItemCfg[var_12_16].name)))

					return
				end
			elseif var_12_10 == ItemConst.ITEM_TYPE.MATERIAL then
				local var_12_20 = var_12_4

				if var_12_11 > ItemTools.getItemNum(var_12_20) then
					ShowTips(string.format(GetTips("CURRENCY_NO_ENOUGH"), GetI18NText(ItemCfg[var_12_20].name)))

					return
				end
			else
				print("其他大类未做处理")
			end
		end

		if ItemTools.IsItemExpiredByItemId(var_12_2.cost_id) then
			ShowTips("ERROR_ITEM_TIME_INVALID")

			return
		end

		if iter_12_1.buyNum > 0 then
			table.insert(var_12_0, {
				buy_id = iter_12_1.goodID,
				buy_num = iter_12_1.buyNum,
				cost_items = var_12_12,
				buy_type = iter_12_1.buyType or 0
			})
		else
			print("shopID", var_12_1, "goodID", iter_12_1.goodID)
		end
	end

	local var_12_21 = {
		buy_goods_list = var_12_0,
		shop_id = var_12_1,
		buy_source = arg_12_2
	}

	if #var_12_0 == 0 then
		ShowTips("ERROR_BAD_ARG")

		return
	end

	SendMessageManagerToSDK("purchase_complete_GP_ONCE")
	manager.net:SendWithLoadingNew(20012, var_12_21, 20013, var_0_0.ShopItemUpdate)
end

function var_0_0.ShopItemUpdate(arg_13_0, arg_13_1)
	local var_13_0 = {}
	local var_13_1 = {}

	if arg_13_0.result == 0 then
		if var_0_0.CheckIsDlcAndSkin(arg_13_1.buy_goods_list) then
			manager.notify:CallUpdateFunc(SHOP_BUY_CALLBACK, arg_13_0.result, arg_13_1.buy_goods_list[1].buy_id, arg_13_1.shop_id, arg_13_1.buy_goods_list[1].buy_num)
			manager.notify:CallUpdateFunc(SHOP_BUY_CALLBACK, arg_13_0.result, arg_13_1.buy_goods_list[2].buy_id, arg_13_1.shop_id, arg_13_1.buy_goods_list[2].buy_num)

			local var_13_2 = var_0_0.GetSkinGiveBackList(arg_13_1.buy_goods_list)

			getReward(var_13_2, nil, nil, nil, nil, {
				isBuy = true
			})
			ShopData.ShopItemUpdate(arg_13_1.buy_goods_list[1].buy_id, arg_13_1.shop_id, arg_13_1.buy_goods_list[1].buy_num)
			ShopData.ShopItemUpdate(arg_13_1.buy_goods_list[2].buy_id, arg_13_1.shop_id, arg_13_1.buy_goods_list[2].buy_num)

			return
		end

		for iter_13_0, iter_13_1 in ipairs(arg_13_1.buy_goods_list) do
			ShopData.ShopItemUpdate(iter_13_1.buy_id, arg_13_1.shop_id, iter_13_1.buy_num)

			local var_13_3 = getShopCfg(iter_13_1.buy_id)
			local var_13_4 = var_13_3.give_id or var_13_3.description
			local var_13_5 = var_13_3.give or 1
			local var_13_6
			local var_13_7

			if var_13_3.description then
				local var_13_8 = var_13_3.description

				var_13_7 = RechargeShopDescriptionCfg[var_13_8]
			else
				var_13_7 = ItemCfg[var_13_4]
			end

			if var_13_7.sub_type == ItemConst.ITEM_SUB_TYPE.SHOP_PACKS then
				local var_13_9 = {}
				local var_13_10 = var_13_7.param

				for iter_13_2, iter_13_3 in ipairs(var_13_10) do
					table.insert(var_13_9, {
						iter_13_3[1],
						iter_13_3[2] * iter_13_1.buy_num * var_13_5
					})
				end

				var_13_0 = var_13_9
			elseif var_13_7.sub_type == ItemConst.ITEM_SUB_TYPE.SHOP_SEVEN_PACKS then
				local var_13_11 = {}
				local var_13_12 = var_13_7.param[1]

				for iter_13_4, iter_13_5 in ipairs(var_13_12) do
					table.insert(var_13_11, {
						iter_13_5[1],
						iter_13_5[2] * iter_13_1.buy_num * var_13_5
					})
				end

				var_13_0 = var_13_11
			elseif var_13_7.type == 5 and ItemConst.ITEM_SUB_TYPE.FUKUBUKURO == var_13_7.sub_type then
				var_13_0 = {
					{
						var_13_4,
						var_13_5 * iter_13_1.buy_num
					}
				}
			elseif var_13_7.type == 8 and var_13_3.description then
				var_13_0 = {}

				local var_13_13 = var_13_7.param[1]

				var_13_0 = {
					{
						var_13_13,
						1
					}
				}
			elseif var_13_7.type == ItemConst.ITEM_TYPE.SCENE then
				var_13_0 = {
					{
						var_13_7.id,
						[2] = 1
					}
				}
			elseif var_13_7.type == ItemConst.ITEM_TYPE.HERO then
				var_13_0 = {
					{
						var_13_7.id,
						[2] = 1
					}
				}
			end

			if var_13_3.give_back_list and next(var_13_3.give_back_list) ~= nil then
				local var_13_14 = {}

				for iter_13_6, iter_13_7 in ipairs(var_13_3.give_back_list) do
					table.insert(var_13_14, {
						iter_13_7.id,
						iter_13_7.num
					})
				end

				table.insertto(var_13_0, var_13_14)
			end

			var_13_0 = formatRewardCfgList(var_13_0)
			var_13_0 = ShopTools.revertGoodsReward(var_13_0)
			var_13_0 = mergeReward(var_13_0)

			manager.notify:CallUpdateFunc(SHOP_BUY_CALLBACK, arg_13_0.result, iter_13_1.buy_id, arg_13_1.shop_id, iter_13_1.buy_num)

			if var_13_3.shop_id == ShopConst.SHOP_ID.REGRESSION_SHOP then
				for iter_13_8, iter_13_9 in pairs(var_13_0 or {}) do
					table.insert(var_13_1, iter_13_9)
				end

				var_13_1 = mergeReward(var_13_1)

				if iter_13_0 == #arg_13_1.buy_goods_list then
					if #var_13_1 > 0 then
						getReward(var_13_1)
					else
						if var_13_3.shop_refresh == 1 then
							table.insert(var_13_1, {
								id = var_13_3.give_id,
								num = var_13_3.give
							})
						else
							local var_13_15 = var_13_7.param

							for iter_13_10, iter_13_11 in ipairs(var_13_15) do
								table.insert(var_13_1, {
									id = iter_13_11[1],
									num = iter_13_11[2]
								})
							end
						end

						getReward(var_13_1)
					end
				end
			elseif var_13_7.type == ItemConst.ITEM_TYPE.SCENE then
				getReward(var_13_0)
			elseif var_13_7.type == ItemConst.ITEM_TYPE.HERO then
				getReward(mergeReward(arg_13_0.give_items))
			elseif var_13_0 and #var_13_0 > 0 then
				getReward(var_13_0, nil, function()
					var_0_0:AfterShopItemUpdate(var_13_7)
				end, nil, nil, {
					isBuy = true
				})
			else
				ShowTips("TRANSACTION_SUCCESS")
			end
		end
	elseif arg_13_0.result == 899 then
		ShowMessageBox({
			content = GetTips("EQUIP_NUM_MAX"),
			OkCallback = function()
				JumpTools.GoToSystem("/bag", {
					type = "equip"
				}, ViewConst.SYSTEM_ID.BAG)
			end
		})
	elseif arg_13_0.result == 406 then
		ShowTips("ITEM_INVALID")
	elseif TipsCfg[arg_13_0.result] ~= nil then
		ShowTips(TipsCfg[arg_13_0.result].desc)
	else
		ShowTips(GetTips(tostring(arg_13_0.result)))
	end

	manager.notify:Invoke(SHOP_BUY_SUCCESS, arg_13_1.buy_goods_list[1].buy_id, arg_13_1.shop_id)
end

function var_0_0.CheckIsDlcAndSkin(arg_16_0)
	if #arg_16_0 ~= 2 then
		return false
	end

	local var_16_0 = getShopCfg(arg_16_0[1].buy_id)
	local var_16_1 = getShopCfg(arg_16_0[2].buy_id)
	local var_16_2
	local var_16_3

	if var_16_0.description then
		var_16_2 = RechargeShopDescriptionCfg[var_16_0.description]
	else
		var_16_2 = ItemCfg[var_16_0.give_id]
	end

	if var_16_1.description then
		var_16_3 = RechargeShopDescriptionCfg[var_16_1.description]
	else
		var_16_3 = ItemCfg[var_16_1.give_id]
	end

	return var_16_2.type == 8 and var_16_3.type == 21
end

function var_0_0.GetSkinGiveBackList(arg_17_0)
	local var_17_0 = {}
	local var_17_1 = getShopCfg(arg_17_0[1].buy_id)
	local var_17_2 = getShopCfg(arg_17_0[2].buy_id)
	local var_17_3
	local var_17_4

	if var_17_1.description then
		var_17_3 = RechargeShopDescriptionCfg[var_17_1.description]
	else
		var_17_3 = ItemCfg[var_17_1.give_id]
	end

	if var_17_2.description then
		var_17_4 = RechargeShopDescriptionCfg[var_17_2.description]
	else
		var_17_4 = ItemCfg[var_17_2.give_id]
	end

	local var_17_5 = var_17_3.param[1]
	local var_17_6 = {
		{
			var_17_5,
			1
		},
		{
			var_17_4.id,
			1
		}
	}

	if var_17_1.give_back_list and next(var_17_1.give_back_list) ~= nil then
		local var_17_7 = {}

		for iter_17_0, iter_17_1 in ipairs(var_17_1.give_back_list) do
			table.insert(var_17_7, {
				iter_17_1.id,
				iter_17_1.num
			})
		end

		table.insertto(var_17_6, var_17_7)
	end

	if var_17_2.give_back_list and next(var_17_2.give_back_list) ~= nil then
		local var_17_8 = {}

		for iter_17_2, iter_17_3 in ipairs(var_17_2.give_back_list) do
			table.insert(var_17_8, {
				iter_17_3.id,
				iter_17_3.num
			})
		end

		table.insertto(var_17_6, var_17_8)
	end

	local var_17_9 = formatRewardCfgList(var_17_6)

	return (mergeReward(var_17_9))
end

function var_0_0.AfterShopItemUpdate(arg_18_0, arg_18_1)
	if arg_18_1.type == 5 and ItemConst.ITEM_SUB_TYPE.FUKUBUKURO == arg_18_1.sub_type then
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("LUCKILYBAG_JUMP"),
			OkCallback = function()
				JumpTools.GoToSystem("/bag", nil, ViewConst.SYSTEM_ID.BAG)
			end
		})
	end
end

function var_0_0.RefreshSingleShop(arg_20_0, arg_20_1)
	var_0_0.diamondRequire_ = arg_20_1

	if arg_20_1 > ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_DIAMOND) then
		ShopTools.DefaultOpenPopUp(1)

		return
	end

	manager.net:SendWithLoadingNew(20014, {
		shop_id = arg_20_0
	}, 20015, var_0_0.OnRefreshSingleShop)
end

function var_0_0.OnRefreshSingleShop(arg_21_0, arg_21_1)
	if arg_21_0.result == 0 then
		var_0_0.diamondRequire_ = nil
	end

	manager.notify:CallUpdateFunc(ON_SHOP_REFRESH_ONE_SHOP, arg_21_0)
end

function var_0_0.RefreshAllShop()
	manager.net:SendWithLoadingNew(20016, {}, 20017, var_0_0.OnRefreshAllShop)
end

function var_0_0.OnRefreshAllShop(arg_23_0, arg_23_1)
	manager.notify:Invoke(SHOP_REFRESH_ALL_SHOP, arg_23_0)
end

function var_0_0.ResolveFragment()
	manager.net:SendWithLoadingNew(14032, {}, 14033, var_0_0.OnResolveFragment)
end

function var_0_0.OnResolveFragment(arg_25_0, arg_25_1)
	manager.notify:CallUpdateFunc(ON_RESOLVE_FRAGMENT, arg_25_0)
end

function var_0_0.RemoveShopRedPoint(arg_26_0)
	manager.net:SendWithLoadingNew(20020, {
		shop_id = arg_26_0
	}, 20021, var_0_0.OnRemoveShopRedPoint)
end

function var_0_0.OnRemoveShopRedPoint(arg_27_0, arg_27_1)
	if arg_27_0.result == 0 then
		ShopData.UpdateRedPoint(arg_27_1.shop_id)
		var_0_0.UpdateNewShopRedPoints()
	end
end

return var_0_0
