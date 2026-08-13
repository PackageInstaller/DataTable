local var_0_0 = {}

function var_0_0.GetGiftList(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = {}

	ipairs = var_1_10003
	pg = var_1_10005

	local var_1_2 = var_1_10005.item_data_statistics.get_id_list_by_type

	Item = var_1_10006

	for iter_1_0, iter_1_1 in var_1_10003(var_1_2[var_1_10006.SHIP_GIFT]) do
		getProxy = var_1_10008
		BagProxy = var_1_10010
		var_1_10010 = var_1_10008(var_1_10010)

		if var_1_10008.getItemById(var_1_10010, iter_1_1) then
			var_1_10009 = var_1_10008.count

			if 0 < var_1_10009 then
				table = var_1_10009
				var_1_10009 = var_1_10009.insert

				local var_1_3 = var_1_1

				Item = var_1_10012

				var_1_10009(var_1_3, var_1_10012.New({
					id = iter_1_1,
					count = var_1_10008.count
				}))

				goto label_1_0
			end
		end

		table = var_1_10009
		var_1_10009 = var_1_10009.insert

		do
			local var_1_4 = var_1_0

			Item = var_1_10012

			var_1_10009(var_1_4, var_1_10012.New({
				count = 0,
				id = iter_1_1
			}))
		end

		::label_1_0::
	end

	local var_1_5 = var_0_0.SortGiftList(var_1_1, arg_1_0)
	local var_1_6 = var_0_0.SortGiftList(var_1_0, arg_1_0)

	table = var_3

	var_3.insertto(var_1_5, var_1_6)

	return var_1_5
end

function var_0_0.SortGiftList(arg_2_0, arg_2_1)
	table = var_1_10002

	var_1_10002.sort(arg_2_0, function(arg_3_0, arg_3_1)
		if var_0_0.GetItemFavoriteState(arg_2_1, arg_3_0) ~= var_0_0.GetItemFavoriteState(arg_2_1, arg_3_1) then
			return var_2 < var_3
		end

		if arg_3_0:getConfig("rarity") ~= arg_3_1:getConfig("rarity") then
			return arg_3_0:getConfig("rarity") > arg_3_1:getConfig("rarity")
		end

		return arg_3_0.id < arg_3_1.id
	end)

	return arg_2_0
end

function var_0_0.GetItemFavoriteState(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:getConfig("gift_dislike")

	type = var_1_10003
	var_4_0 = var_1_10003(var_4_0) ~= "table" and {} or var_4_0
	table = var_3

	if var_3.contains(var_4_0, arg_4_1.id) then
		ShipGiftConst = var_3

		return var_3.GIFT_FAVORITE_STATE.HATE
	end

	ShipGiftConst = var_3

	return var_3.GIFT_FAVORITE_STATE.LIKE
end

function var_0_0.GetItemIntimacyValue(arg_5_0, arg_5_1)
	local var_5_0 = var_0_0.GetItemFavoriteState(arg_5_0, arg_5_1)

	ShipGiftConst = var_1_10003

	local var_5_1

	if var_5_0 ~= var_1_10003.GIFT_FAVORITE_STATE.LIKE or not arg_5_1:getConfig("usage_arg")[2] then
		var_5_1 = 0
	end

	return var_5_1
end

function var_0_0.GetItemIntimacySpriteName(arg_6_0, arg_6_1)
	local var_6_0 = var_0_0.GetItemFavoriteState(arg_6_0, arg_6_1)

	ShipGiftConst = var_1_10003

	if var_6_0 == var_1_10003.GIFT_FAVORITE_STATE.LIKE then
		return "express_3"
	else
		ShipGiftConst = var_3

		if var_6_0 == var_3.GIFT_FAVORITE_STATE.HATE then
			return "express_1"
		end
	end

	return nil
end

function var_0_0.GetShipNeedIntimacyValue(arg_7_0)
	local var_7_0 = arg_7_0:getIntimacy()

	return arg_7_0:getIntimacyMax() * 100 - var_7_0
end

function var_0_0.GetNeedMaxCnt(arg_8_0, arg_8_1)
	local var_8_0 = var_0_0.GetItemIntimacyValue(arg_8_0, arg_8_1)

	if var_0_0.GetShipNeedIntimacyValue(arg_8_0) <= 0 then
		return 0
	end

	math = var_4

	return var_4.ceil(var_3 / var_8_0) < arg_8_1.count and var_4 or arg_8_1.count
end

function var_0_0.GetNeedMinCnt(arg_9_0, arg_9_1)
	local var_9_0 = var_0_0.GetItemIntimacyValue(arg_9_0, arg_9_1)

	if var_0_0.GetShipNeedIntimacyValue(arg_9_0) <= 0 then
		return 0
	end

	return arg_9_1.count > 0 and 1 or 0
end

return var_0_0
