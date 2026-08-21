local var_0_0 = class("AuctionGameSettlementData")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.bidUserID = arg_1_1.bid_user_id
	arg_1_0.bidValue = arg_1_1.bid_price
	arg_1_0.proceeds = arg_1_1.change_gold
	arg_1_0.bidItemList = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.item_list) do
		arg_1_0.bidItemList[iter_1_0] = AuctionGameStoreItemData.New(iter_1_1)
	end

	return
end

function var_0_0.GetItemList(arg_2_0)
	return arg_2_0.bidItemList
end

function var_0_0.GetSortItemList(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0.bidItemList) do
		table.insert({}, iter_3_1)
	end

	table.sort({}, function(arg_4_0, arg_4_1)
		if arg_4_0.position.y == arg_4_1.position.y then
			return arg_4_0.position.x < arg_4_1.position.x
		end

		return arg_4_0.position.y < arg_4_1.position.y
	end)

	return {}
end

return var_0_0
