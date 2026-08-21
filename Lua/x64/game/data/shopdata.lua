local var_0_0 = singletonClass("ShopData")
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = {}
local var_0_4 = false

function var_0_0.Init()
	var_0_1 = {}
	var_0_2 = {}
	var_0_3 = {}
end

function var_0_0.GetNextGoods(arg_2_0)
	if getShopCfg(arg_2_0).next_goods_id ~= nil and #getShopCfg(arg_2_0).next_goods_id > 0 then
		return getShopCfg(arg_2_0).next_goods_id
	end

	if ShopCfg[arg_2_0] then
		return ShopCfg.get_id_list_by_pre_goods_id[arg_2_0] or {}
	else
		return {}
	end
end

function var_0_0.ShopItemUpdate(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0
	local var_3_1 = var_0_2[arg_3_1]

	if not var_3_1[var_3_0] then
		var_3_1[var_3_0] = {}
	end

	if not var_3_1[var_3_0].buy_times then
		var_3_1[var_3_0].buy_times = 0
	end

	var_3_1[var_3_0].buy_times = var_3_1[var_3_0].buy_times + (arg_3_2 or 1)

	manager.notify:Invoke(SHOP_ITEM_UPDATE, arg_3_1, var_3_0)
end

function var_0_0.SingleShopUpdate(arg_4_0)
	local var_4_0 = var_0_2[arg_4_0.shop_id]

	if not var_4_0 then
		return
	end

	var_4_0.shopID = arg_4_0.shop_id
	var_0_3[var_4_0.shopID] = arg_4_0.is_need_tag

	local var_4_1 = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.goods_list) do
		local var_4_2 = iter_4_1.goods_id

		var_4_0[var_4_2] = iter_4_1

		table.insert(var_4_1, var_4_2)
	end

	for iter_4_2, iter_4_3 in pairs(ShopCfg.get_id_list_by_shop_id[arg_4_0.shop_id]) do
		if ShopCfg[iter_4_3].shop_refresh == 2 then
			table.insert(var_4_1, iter_4_3)
		end
	end

	for iter_4_4, iter_4_5 in ipairs(var_4_0.shopItemIDs) do
		if not table.keyof(var_4_1, iter_4_5) then
			var_4_0[iter_4_5] = nil
		end
	end

	var_4_0.shopItemIDs = var_4_1
	var_4_0.refreshCount = arg_4_0.refresh_times

	manager.notify:Invoke(SHOP_LIST_UPDATE, var_4_0.shopID)
end

function var_0_0.AllShopUpdate(arg_5_0)
	var_0_1 = {}
	var_0_3 = {}
	var_0_2 = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_0) do
		local var_5_0 = iter_5_1.shop_id

		var_0_2[var_5_0] = {}
		var_0_2[var_5_0].shopItemIDs = {}
		var_0_3[var_5_0] = iter_5_1.is_need_tag

		for iter_5_2, iter_5_3 in ipairs(iter_5_1.goods_list) do
			local var_5_1 = getShopCfg(iter_5_3.goods_id)
			local var_5_2 = iter_5_3.goods_id

			if var_5_1 then
				var_0_2[var_5_0][var_5_2] = iter_5_3

				if var_5_1.shop_refresh ~= 2 then
					var_0_2[var_5_0].refreshCount = iter_5_1.refresh_times
				end

				table.insert(var_0_2[var_5_0].shopItemIDs, var_5_2)
			end
		end

		table.insert(var_0_1, var_5_0)
	end

	for iter_5_4, iter_5_5 in pairs(ShopCfg.all) do
		local var_5_3 = ShopCfg[iter_5_5]

		if var_5_3.shop_refresh == 2 then
			if var_0_2[var_5_3.shop_id] == nil then
				var_0_2[var_5_3.shop_id] = {}
				var_0_2[var_5_3.shop_id].shopItemIDs = {}
			end

			if var_0_2[var_5_3.shop_id][var_5_3.goods_id] == nil then
				var_0_2[var_5_3.shop_id][var_5_3.goods_id] = {}

				table.insert(var_0_2[var_5_3.shop_id].shopItemIDs, var_5_3.goods_id)
			end
		end
	end

	manager.notify:Invoke(SHOP_LIST_UPDATE, 0)
end

function var_0_0.GetShop(arg_6_0)
	return var_0_2[arg_6_0]
end

function var_0_0.GetGoodInfo(arg_7_0, arg_7_1)
	return var_0_2[arg_7_0][arg_7_1]
end

function var_0_0.GetRedPointData()
	return var_0_3
end

function var_0_0.UpdateRedPoint(arg_9_0)
	var_0_3[arg_9_0] = nil
end

function var_0_0.IsGoodOutOfDate(arg_10_0)
	local var_10_0 = getShopCfg(arg_10_0)
	local var_10_1 = TimeMgr.GetInstance():GetServerTime()
	local var_10_2 = false
	local var_10_3 = false

	if #var_10_0.close_time > 0 then
		var_10_2 = var_10_1 >= TimeMgr.GetInstance():parseTimeFromConfig(var_10_0.close_time)
	else
		var_10_2 = false
	end

	if #var_10_0.open_time > 0 then
		var_10_3 = var_10_1 < TimeMgr.GetInstance():parseTimeFromConfig(var_10_0.open_time)
	else
		var_10_3 = false
	end

	if var_10_3 or var_10_2 then
		return true
	end

	return false
end

function var_0_0.IsSoldout(arg_11_0, arg_11_1)
	local var_11_0 = ShopData.GetShop(arg_11_0)[arg_11_1]
	local var_11_1 = getShopCfg(arg_11_1)

	if var_11_0 ~= nil and var_11_1.limit_num ~= nil and var_11_1.limit_num ~= -1 and var_11_1.limit_num - (var_11_0.buy_times or 0) <= 0 then
		return true
	end

	return false
end

function var_0_0.GetLockTypeAndCondition(arg_12_0)
	local var_12_0 = getShopCfg(arg_12_0)

	if #var_12_0.level_limit > 0 then
		for iter_12_0, iter_12_1 in ipairs(var_12_0.level_limit) do
			local var_12_1
			local var_12_2

			if iter_12_1.type then
				var_12_1 = iter_12_1.type
				var_12_2 = iter_12_1.num
			else
				var_12_1 = iter_12_1[1]
				var_12_2 = iter_12_1[2]
			end

			return var_12_1, var_12_2
		end
	end

	return 0, 0
end

function var_0_0.IsGoodUnlock(arg_13_0)
	local var_13_0 = getShopCfg(arg_13_0)

	if #var_13_0.level_limit > 0 then
		for iter_13_0, iter_13_1 in ipairs(var_13_0.level_limit) do
			local var_13_1
			local var_13_2

			if iter_13_1.type then
				var_13_1 = iter_13_1.type
				var_13_2 = iter_13_1.num
			else
				var_13_1 = iter_13_1[1]
				var_13_2 = iter_13_1[2]
			end

			if var_13_1 == 1 then
				if var_13_2 > PlayerData:GetPlayerInfo().userLevel then
					return 0
				end
			elseif var_13_1 == 2 then
				if var_13_2 > PassportData:GetLevel() then
					return 0
				end
			elseif var_13_1 == 3 then
				if not isOpenMission(var_13_2) then
					return 0
				end

				if BattleStageData:GetStageData()[var_13_2].clear_times <= 0 then
					return 0
				end
			elseif var_13_1 == 4 then
				if HeroData:GetHeroList()[var_13_2].unlock ~= 1 then
					return 0
				end
			elseif var_13_1 == 5 then
				if var_13_2 > AdminCatExploreData:GetDataByPara("level") then
					return 0
				end
			elseif var_13_1 == 7 and var_13_2 > GodEaterData.hubLv then
				return 0
			end
		end
	end

	return 1
end

return var_0_0
