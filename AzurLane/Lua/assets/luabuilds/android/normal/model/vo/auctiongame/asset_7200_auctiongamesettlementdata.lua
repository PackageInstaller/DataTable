class = var_0_10000

local var_0_0 = var_0_10000("AuctionGameSettlementData")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.bidUserID = arg_1_1.bid_user_id
	arg_1_0.bidValue = arg_1_1.bid_price
	arg_1_0.proceeds = arg_1_1.change_gold
	arg_1_0.bidItemList = {}
	ipairs = var_2

	for iter_1_0, iter_1_1 in var_2(arg_1_1.item_list) do
		local var_1_0 = arg_1_0.bidItemList

		AuctionGameStoreItemData = var_1_10008
		var_1_0[iter_1_0] = var_1_10008.New(iter_1_1)
	end

	return
end

function var_0_0.GetItemList(arg_2_0)
	return arg_2_0.bidItemList
end

function var_0_0.GetSortItemList(arg_3_0)
	local var_3_0 = {}

	ipairs = var_1_10002

	for iter_3_0, iter_3_1 in var_1_10002(arg_3_0.bidItemList) do
		table = var_1_10007

		var_1_10007.insert(var_3_0, iter_3_1)
	end

	table = var_2

	var_2.sort(var_3_0, function(arg_4_0, arg_4_1)
		if arg_4_0.position.y == arg_4_1.position.y then
			return arg_4_0.position.x < arg_4_1.position.x
		end

		return arg_4_0.position.y < arg_4_1.position.y
	end)

	return var_3_0
end

return var_0_0
