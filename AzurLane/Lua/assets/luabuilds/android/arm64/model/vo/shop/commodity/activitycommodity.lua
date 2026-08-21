local var_0_0 = class("ActivityCommodity", import(".BaseCommodity"))

function var_0_0.bindConfigTable(arg_1_0)
	return pg.activity_shop_template
end

function var_0_0.CheckCntLimit(arg_2_0)
	if arg_2_0:getConfig("num_limit") == 0 then
		return true
	end

	return arg_2_0:GetPurchasableCnt() > 0
end

function var_0_0.CheckArgLimit(arg_3_0)
	local var_3_0 = arg_3_0:getConfig("limit_args")

	if not var_3_0 or var_3_0 == "" or #var_3_0 == 0 then
		return true
	end

	local var_3_1 = false

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		local var_3_2 = iter_3_1[1]
		local var_3_3 = iter_3_1[2]
		local var_3_4 = iter_3_1[3]

		if (iter_3_1[1] == ShopArgs.LIMIT_ARGS_META_SHIP_EXISTENCE or var_3_2 == ShopArgs.LIMIT_ARGS_TRAN_ITEM_WHEN_FULL) and (var_3_4 or 1) == 1 then
			local var_3_5 = getProxy(BayProxy)

			var_3_1 = var_3_5:getMetaShipByGroupId(var_3_3) ~= nil

			if not var_3_1 then
				return var_3_1, var_3_2, i18n("meta_shop_exchange_limit"), var_3_3
			end
		elseif var_3_2 == ShopArgs.LIMIT_ARGS_SALE_START_TIME then
			var_3_1 = pg.TimeMgr.GetInstance():passTime(var_3_3)

			if not var_3_1 then
				return var_3_1, var_3_2, i18n("meta_shop_exchange_limit_2"), var_3_3
			end
		elseif var_3_2 == ShopArgs.LIMIT_ARGS_UNIQUE_SHIP then
			local var_3_6 = getProxy(BayProxy)

			var_3_1 = var_3_6:findShipByGroup(var_3_3) == nil

			if not var_3_1 then
				return var_3_1, var_3_2, i18n("quota_shop_good_limit"), var_3_3
			end
		elseif var_3_2 == "pass" then
			local var_3_7 = getProxy(ChapterProxy):getChapterById(var_3_3)

			var_3_1 = var_3_7 and var_3_7:isClear()

			if not var_3_1 then
				return var_3_1, var_3_2, var_3_4, var_3_3
			end
		end
	end

	return var_3_1
end

local function var_0_1(arg_4_0, arg_4_1)
	local var_4_0 = getProxy(BayProxy):getMetaShipByGroupId(arg_4_1)

	if var_4_0 then
		local var_4_1 = var_4_0:getMetaCharacter():getSpecialMaterialInfoToMaxStar()

		return math.max(var_4_1.count - getProxy(BagProxy):getItemCountById(var_4_1.itemID), 0)
	else
		return arg_4_0:getConfig("num_limit") - arg_4_0.buyCount
	end

	return 0
end

function var_0_0.GetTranCntWhenFull(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:getConfig("limit_args")
	local var_5_1 = 0
	local var_5_2

	if not var_5_0 or var_5_0 == "" or #var_5_0 == 0 then
		-- block empty
	else
		for iter_5_0, iter_5_1 in ipairs(var_5_0) do
			if iter_5_1[1] == ShopArgs.LIMIT_ARGS_TRAN_ITEM_WHEN_FULL then
				local var_5_4 = var_0_1(arg_5_0, iter_5_1[2]) - arg_5_1

				if var_5_4 < 0 then
					var_5_1 = math.abs(var_5_4)
					var_5_2 = Drop.Create(iter_5_1[4])
				end
			end
		end
	end

	return var_5_1, var_5_2
end

function var_0_0.CheckTimeLimit(arg_6_0)
	local var_6_0 = false
	local var_6_1 = false
	local var_6_2 = false
	local var_6_3 = arg_6_0:getConfig("commodity_type")
	local var_6_4 = arg_6_0:getConfig("commodity_id")

	if var_6_4 == 0 then
		-- block empty
	else
		local var_6_5 = Item.getConfigData(var_6_4)

		if var_6_3 == DROP_TYPE_VITEM and var_6_5.virtual_type == 22 then
			var_6_0 = true
			var_6_2 = true

			local var_6_6 = getProxy(ActivityProxy):getActivityById(var_6_5.link_id)

			if var_6_6 and not var_6_6:isEnd() then
				var_6_1 = true
			end
		elseif var_6_3 == DROP_TYPE_ITEM and var_6_5.time_limit == 1 then
			var_6_0 = false
			var_6_1 = true
		end
	end

	return var_6_0, var_6_1, var_6_2
end

function var_0_0.canPurchase(arg_7_0)
	local var_7_0, var_7_1, var_7_2 = arg_7_0:CheckCntLimit()
	local var_7_3, var_7_4, var_7_5 = arg_7_0:CheckArgLimit()

	if not var_7_0 then
		return false, var_7_1, var_7_2
	end

	if not var_7_3 then
		return false, var_7_4, var_7_5
	end

	return true
end

function var_0_0.getSkinId(arg_8_0)
	if arg_8_0:getConfig("commodity_type") == DROP_TYPE_SKIN then
		return arg_8_0:getConfig("commodity_id")
	end

	return nil
end

function var_0_0.checkCommodityType(arg_9_0, arg_9_1)
	return arg_9_0:getConfig("commodity_type") == arg_9_1
end

function var_0_0.GetPurchasableCnt(arg_10_0)
	local var_10_0 = arg_10_0:getConfig("commodity_type")
	local var_10_1 = arg_10_0:getConfig("commodity_id")

	if var_10_0 == DROP_TYPE_SKIN then
		local var_10_2 = getProxy(ShipSkinProxy)

		return var_10_2:hasSkin(var_10_1) and 0 or 1
	elseif var_10_0 == DROP_TYPE_FURNITURE then
		return math.min(pg.furniture_data_template[var_10_1].count - getProxy(DormProxy):getRawData():GetOwnFurnitureCount(var_10_1), arg_10_0:getConfig("num_limit") - arg_10_0.buyCount)
	else
		local var_10_3 = arg_10_0:getConfig("limit_args")
		local var_10_4

		if type(var_10_3) == "table" then
			var_10_4 = _.detect(var_10_3, function(arg_11_0)
				return arg_11_0[1] == ShopArgs.LIMIT_ARGS_META_SHIP_EXISTENCE
			end)
		end

		if var_10_4 then
			return var_0_1(arg_10_0, var_10_4[2])
		else
			return arg_10_0:getConfig("num_limit") - arg_10_0.buyCount
		end
	end

	return
end

function var_0_0.GetConsume(arg_12_0)
	return Drop.New({
		type = arg_12_0:getConfig("resource_category"),
		id = arg_12_0:getConfig("resource_type"),
		count = arg_12_0:getConfig("resource_num")
	})
end

function var_0_0.Selectable(arg_13_0)
	return false
end

function var_0_0.GetDropList(arg_14_0)
	table.insert({}, Drop.New({
		count = 1,
		type = arg_14_0:getConfig("commodity_type"),
		id = arg_14_0:getConfig("commodity_id")
	}))

	return {}
end

return var_0_0
