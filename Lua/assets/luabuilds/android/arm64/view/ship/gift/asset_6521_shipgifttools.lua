local var_0_0 = {}

function var_0_0.GetGiftList(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = {}

	for iter_1_0, iter_1_1 in ipairs(pg.item_data_statistics.get_id_list_by_type[Item.SHIP_GIFT]) do
		local var_1_2 = getProxy(BagProxy):getItemById(iter_1_1)

		if var_1_2 and var_1_2.count > 0 then
			table.insert(var_1_1, Item.New({
				id = iter_1_1,
				count = var_1_2.count
			}))
		else
			table.insert(var_1_0, Item.New({
				count = 0,
				id = iter_1_1
			}))
		end
	end

	local var_1_3 = var_0_0.SortGiftList(var_1_1, arg_1_0)

	table.insertto(var_1_3, (var_0_0.SortGiftList(var_1_0, arg_1_0)))

	return var_1_3
end

function var_0_0.SortGiftList(arg_2_0, arg_2_1)
	table.sort(arg_2_0, function(arg_3_0, arg_3_1)
		local var_3_0 = var_0_0.GetItemFavoriteState(arg_2_1, arg_3_0)
		local var_3_1 = var_0_0.GetItemFavoriteState(arg_2_1, arg_3_1)

		if var_3_0 ~= var_3_1 then
			return var_3_0 < var_3_1
		end

		if arg_3_0:getConfig("rarity") ~= arg_3_1:getConfig("rarity") then
			return arg_3_0:getConfig("rarity") > arg_3_1:getConfig("rarity")
		end

		return arg_3_0.id < arg_3_1.id
	end)

	return arg_2_0
end

function var_0_0:GetItemFavoriteState(arg_4_1)
	local var_4_0 = self:getConfig("gift_dislike")

	var_4_0 = type(var_4_0) ~= "table" and {} or var_4_0

	if table.contains(var_4_0, arg_4_1.id) then
		return ShipGiftConst.GIFT_FAVORITE_STATE.HATE
	end

	return ShipGiftConst.GIFT_FAVORITE_STATE.LIKE
end

function var_0_0.GetItemIntimacyValue(arg_5_0, arg_5_1)
	return var_0_0.GetItemFavoriteState(arg_5_0, arg_5_1) == ShipGiftConst.GIFT_FAVORITE_STATE.LIKE and arg_5_1:getConfig("usage_arg")[2] or 0
end

function var_0_0.GetItemIntimacySpriteName(arg_6_0, arg_6_1)
	local var_6_0 = var_0_0.GetItemFavoriteState(arg_6_0, arg_6_1)

	if var_6_0 == ShipGiftConst.GIFT_FAVORITE_STATE.LIKE then
		return "express_3"
	elseif var_6_0 == ShipGiftConst.GIFT_FAVORITE_STATE.HATE then
		return "express_1"
	end

	return nil
end

function var_0_0:GetShipNeedIntimacyValue()
	return self:getIntimacyMax() * 100 - self:getIntimacy()
end

function var_0_0.GetNeedMaxCnt(arg_8_0, arg_8_1)
	local var_8_0 = var_0_0.GetShipNeedIntimacyValue(arg_8_0)

	if var_8_0 <= 0 then
		return 0
	end

	local var_8_1 = math.ceil(var_8_0 / var_0_0.GetItemIntimacyValue(arg_8_0, arg_8_1))

	return var_8_1 < arg_8_1.count and var_8_1 or arg_8_1.count
end

function var_0_0.GetNeedMinCnt(arg_9_0, arg_9_1)
	local var_9_0 = var_0_0.GetItemIntimacyValue(arg_9_0, arg_9_1)

	if var_0_0.GetShipNeedIntimacyValue(arg_9_0) <= 0 then
		return 0
	end

	return arg_9_1.count > 0 and 1 or 0
end

return var_0_0
