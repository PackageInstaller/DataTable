local MainOverDueSkinDiscountItemSequence = class("MainOverDueSkinDiscountItemSequence", import(".MainOverDueAttireSequence"))

function MainOverDueSkinDiscountItemSequence:Execute(arg_1_1)
	local var_1_0, var_1_1 = self:CollectExpiredItems()
	local var_1_2

	seriesAsync({
		function(arg_2_0)
			self:RecycleItems(var_1_0, var_1_1, function(arg_3_0)
				var_1_2 = arg_3_0

				arg_2_0()

				return
			end)

			return
		end,
		function(arg_4_0)
			if not var_1_2 then
				arg_4_0()

				return
			end

			self:DisplayResult(var_1_0, arg_4_0)

			return
		end,
		function(arg_5_0)
			if not var_1_2 then
				arg_5_0()

				return
			end

			self:ShowAwardInfo(var_1_2, arg_5_0)

			return
		end,
		function(arg_6_0)
			onNextTick(arg_6_0)

			return
		end
	}, arg_1_1)

	return
end

function MainOverDueSkinDiscountItemSequence:ShowAwardInfo(arg_7_1, arg_7_2)
	pg.m02:sendNotification(NewMainMediator.ON_AWRADS, {
		items = arg_7_1,
		callback = arg_7_2
	})

	return
end

function MainOverDueSkinDiscountItemSequence:RecycleItems(arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		table.insert(var_8_0, iter_8_1)
	end

	for iter_8_2, iter_8_3 in ipairs(arg_8_2) do
		table.insert(var_8_0, iter_8_3)
	end

	pg.m02:sendNotification(GAME.SELL_ITEM, {
		items = var_8_0,
		callback = arg_8_3
	})

	return
end

function MainOverDueSkinDiscountItemSequence:DisplayResult(arg_9_1, arg_9_2)
	if #arg_9_1 > 0 then
		self:Display(SkinDiscountItemExpireDisplayPage, arg_9_1, arg_9_2)
	else
		arg_9_2()
	end

	return
end

function MainOverDueSkinDiscountItemSequence:CollectExpiredItems()
	return self:_CollectExpiredItems(ItemUsage.USAGE_SHOP_DISCOUNT), (self:_CollectExpiredItems(ItemUsage.USAGE_SKIN_EXP))
end

function MainOverDueSkinDiscountItemSequence:_CollectExpiredItems(arg_11_1)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in pairs(pg.shop_template.get_id_list_by_genre[ShopArgs.GiftPackage]) do
		if self:InTime(pg.shop_template[iter_11_1].time) then
			if pg.item_data_statistics[pg.shop_template[iter_11_1].effect_args[1] or 0] then
				self:GetExpiredItemIdFromDropList(var_11_0, pg.item_data_statistics[pg.shop_template[iter_11_1].effect_args[1] or 0].display_icon, arg_11_1)
			end
		end
	end

	return var_11_0
end

function MainOverDueSkinDiscountItemSequence:InTime(arg_12_1)
	if type(arg_12_1) == "table" then
		return pg.TimeMgr.GetInstance():passTime(arg_12_1[2])
	elseif arg_12_1 == "stop" then
		return true
	end

	return
end

function MainOverDueSkinDiscountItemSequence:GetExpiredItemIdFromDropList(arg_13_1, arg_13_2, arg_13_3)
	local function var_13_0(arg_14_0)
		assert(pg.item_data_statistics[arg_14_0], arg_14_0)

		return pg.item_data_statistics[arg_14_0] and pg.item_data_statistics[arg_14_0].usage == arg_13_3
	end

	local var_13_1 = getProxy(BagProxy)

	local function var_13_2(arg_15_0)
		return var_13_1:getItemCountById(arg_15_0) > 0
	end

	for iter_13_0, iter_13_1 in pairs(arg_13_2) do
		local var_13_3 = iter_13_1[2]

		if iter_13_1[1] == DROP_TYPE_ITEM and var_13_2(iter_13_1[2]) and var_13_0(iter_13_1[2]) then
			local var_13_4 = var_13_1:RawGetItemById(iter_13_1[2])

			if not _.any(arg_13_1, function(arg_16_0)
				return arg_16_0.id == var_13_3
			end) then
				table.insert(arg_13_1, {
					id = var_13_4.id,
					count = var_13_4.count
				})
			end
		end
	end

	return
end

return MainOverDueSkinDiscountItemSequence
