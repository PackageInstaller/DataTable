class = var_0_10000

local var_0_0 = "ActivityCommodity"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BaseCommodity"))

function var_0_1.bindConfigTable(arg_1_0)
	pg = var_1_10001

	return var_1_10001.activity_shop_template
end

function var_0_1.CheckCntLimit(arg_2_0)
	if arg_2_0:getConfig("num_limit") == 0 then
		return true
	end

	return arg_2_0:GetPurchasableCnt() > 0
end

function var_0_1.CheckArgLimit(arg_3_0)
	if not arg_3_0:getConfig("limit_args") or var_1 == "" or #var_1 == 0 then
		return true
	end

	local var_3_0 = false

	ipairs = var_3

	for iter_3_0, iter_3_1 in var_3(var_1) do
		local var_3_1 = iter_3_1[1]
		local var_3_2 = iter_3_1[2]
		local var_3_3 = iter_3_1[3]

		ShopArgs = var_1_10011

		if var_3_1 ~= var_1_10011.LIMIT_ARGS_META_SHIP_EXISTENCE then
			ShopArgs = var_1_10011

			if var_3_1 == var_1_10011.LIMIT_ARGS_TRAN_ITEM_WHEN_FULL then
				var_1_10011 = var_3_3 or 1

				if var_1_10011 == 1 then
					getProxy = var_1_10011
					BayProxy = var_1_10012
					var_1_10012 = var_1_10011(var_1_10012)
					var_3_0 = var_1_10011.getMetaShipByGroupId(var_1_10012, var_3_2) ~= nil

					if not var_3_0 then
						var_1_10012 = var_3_0

						local var_3_4 = var_3_1

						i18n = var_1_10014

						return var_1_10012, var_3_4, var_1_10014("meta_shop_exchange_limit"), var_3_2
					end

					goto label_3_0
				end
			end

			ShopArgs = var_1_10011

			if var_3_1 == var_1_10011.LIMIT_ARGS_SALE_START_TIME then
				pg = var_1_10011
				var_1_10012 = var_1_10011.TimeMgr.GetInstance()

				if not var_1_10011.passTime(var_1_10012, var_3_2) then
					var_1_10011 = var_3_0
					var_1_10012 = var_3_1
					i18n = var_13

					return var_1_10011, var_1_10012, var_13("meta_shop_exchange_limit_2"), var_3_2
				end
			else
				ShopArgs = var_1_10011

				if var_3_1 == var_1_10011.LIMIT_ARGS_UNIQUE_SHIP then
					getProxy = var_1_10011
					BayProxy = var_1_10012
					var_1_10012 = var_1_10011(var_1_10012)
					var_3_0 = var_1_10011.findShipByGroup(var_1_10012, var_3_2) == nil

					if not var_3_0 then
						var_1_10012 = var_3_0

						local var_3_5 = var_3_1

						i18n = var_1_10014

						return var_1_10012, var_3_5, var_1_10014("quota_shop_good_limit"), var_3_2
					end
				elseif var_3_1 == "pass" then
					getProxy = var_1_10011
					ChapterProxy = var_1_10012
					var_1_10012 = var_1_10011(var_1_10012)
					var_3_0 = var_1_10011.getChapterById(var_1_10012, var_3_2) and var_1_10011:isClear()

					if not var_3_0 then
						return var_3_0, var_3_1, var_3_3, var_3_2
					end
				end
			end

			::label_3_0::
		end
	end

	return var_3_0
end

local function var_0_2(arg_4_0, arg_4_1)
	getProxy = var_1_10002
	BayProxy = var_1_10003

	local var_4_0 = var_1_10002(var_1_10003)

	if var_2.getMetaShipByGroupId(var_4_0, arg_4_1) then
		local var_4_1 = var_2:getMetaCharacter()
		local var_4_2 = var_3.getSpecialMaterialInfoToMaxStar(var_4_1)

		getProxy = var_4_1
		BagProxy = var_1_10006

		local var_4_3 = var_4_1(var_1_10006)
		local var_4_4 = var_5.getItemCountById(var_4_3, var_4_2.itemID)

		math = var_4_3

		return var_4_3.max(var_4_2.count - var_4_4, 0)
	else
		return arg_4_0:getConfig("num_limit") - arg_4_0.buyCount
	end

	return 0
end

function var_0_1.GetTranCntWhenFull(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:getConfig("limit_args")
	local var_5_1 = 0
	local var_5_2

	if not var_5_0 or var_5_0 == "" or #var_5_0 == 0 then
		-- block empty
	else
		ipairs = var_5

		for iter_5_0, iter_5_1 in var_5(var_5_0) do
			local var_5_3 = iter_5_1[1]
			local var_5_4 = iter_5_1[2]
			local var_5_5 = iter_5_1[3]
			local var_5_6 = iter_5_1[4]

			ShopArgs = var_1_10014

			if var_5_3 == var_1_10014.LIMIT_ARGS_TRAN_ITEM_WHEN_FULL and var_0_2(arg_5_0, var_5_4) - arg_5_1 < 0 then
				math = var_16
				var_5_1 = var_16.abs(var_15)
				Drop = var_16
				var_5_2 = var_16.Create(var_5_6)
			end
		end
	end

	return var_5_1, var_5_2
end

function var_0_1.CheckTimeLimit(arg_6_0)
	local var_6_0 = false
	local var_6_1 = false
	local var_6_2 = false
	local var_6_3 = arg_6_0:getConfig("commodity_type")
	local var_6_4 = arg_6_0

	if arg_6_0.getConfig(var_6_4, "commodity_id") == 0 then
		-- block empty
	else
		Item = var_6_4

		local var_6_5 = var_6_4.getConfigData(var_5)

		DROP_TYPE_VITEM = var_7

		if var_6_3 == var_7 and var_6_5.virtual_type == 22 then
			var_6_0 = true
			var_6_2 = true
			getProxy = var_7
			ActivityProxy = var_1_10008

			local var_6_6 = var_7(var_1_10008)

			if var_7.getActivityById(var_6_6, var_6_5.link_id) and not var_8:isEnd() then
				var_6_1 = true
			end
		else
			DROP_TYPE_ITEM = var_7

			if var_6_3 == var_7 and var_6_5.time_limit == 1 then
				var_6_0 = false
				var_6_1 = true
			end
		end
	end

	return var_6_0, var_6_1, var_6_2
end

function var_0_1.canPurchase(arg_7_0)
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

function var_0_1.getSkinId(arg_8_0)
	local var_8_0 = arg_8_0
	local var_8_1 = arg_8_0.getConfig(var_8_0, "commodity_type")

	DROP_TYPE_SKIN = var_8_0

	if var_8_1 == var_8_0 then
		return arg_8_0:getConfig("commodity_id")
	end

	return nil
end

function var_0_1.checkCommodityType(arg_9_0, arg_9_1)
	return arg_9_0:getConfig("commodity_type") == arg_9_1
end

function var_0_1.GetPurchasableCnt(arg_10_0)
	local var_10_0 = arg_10_0:getConfig("commodity_type")
	local var_10_1 = arg_10_0
	local var_10_2 = arg_10_0.getConfig(var_10_1, "commodity_id")

	DROP_TYPE_SKIN = var_10_1

	local var_10_3

	if var_10_0 == var_10_1 then
		getProxy = var_10_1
		ShipSkinProxy = var_10_3
		var_10_3 = var_10_1(var_10_3)
		var_10_1 = var_10_1.hasSkin(var_10_3, var_10_2) and 0 or 1

		return var_10_1
	else
		DROP_TYPE_FURNITURE = var_10_1

		if var_10_0 == var_10_1 then
			getProxy = var_10_1
			DormProxy = var_10_3

			local var_10_4 = var_10_1(var_10_3)
			local var_10_5 = var_3.getRawData(var_10_4)
			local var_10_6 = var_3.GetOwnFurnitureCount(var_10_5, var_10_2)

			pg = var_10_5

			local var_10_7 = var_10_5.furniture_data_template[var_10_2]

			math = var_5

			return var_5.min(var_10_7.count - var_10_6, arg_10_0:getConfig("num_limit") - arg_10_0.buyCount)
		else
			local var_10_8 = arg_10_0:getConfig("limit_args")
			local var_10_9

			type = var_5

			if var_5(var_10_8) == "table" then
				_ = var_5
				var_10_9 = var_5.detect(var_10_8, function(arg_11_0)
					local var_11_0 = arg_11_0[1]

					ShopArgs = var_2_10002

					return var_11_0 == var_2_10002.LIMIT_ARGS_META_SHIP_EXISTENCE
				end)
			end

			if var_10_9 then
				return var_0_2(arg_10_0, var_10_9[2])
			else
				return arg_10_0:getConfig("num_limit") - arg_10_0.buyCount
			end
		end
	end

	return
end

function var_0_1.GetConsume(arg_12_0)
	Drop = var_1_10001

	return var_1_10001.New({
		type = arg_12_0:getConfig("resource_category"),
		id = arg_12_0:getConfig("resource_type"),
		count = arg_12_0:getConfig("resource_num")
	})
end

function var_0_1.Selectable(arg_13_0)
	return false
end

function var_0_1.GetDropList(arg_14_0)
	local var_14_0 = {}

	table = var_1_10002

	local var_14_1 = var_1_10002.insert
	local var_14_2 = var_14_0

	Drop = var_1_10004

	var_14_1(var_14_2, var_1_10004.New({
		count = 1,
		type = arg_14_0:getConfig("commodity_type"),
		id = arg_14_0:getConfig("commodity_id")
	}))

	return var_14_0
end

return var_0_1
