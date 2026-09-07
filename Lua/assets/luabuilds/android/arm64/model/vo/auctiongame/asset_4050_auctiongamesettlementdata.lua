local AuctionGameSettlementData = class("AuctionGameSettlementData")

function AuctionGameSettlementData:Ctor(arg_1_1)
	self.bidUserID = arg_1_1.bid_user_id
	self.bidValue = arg_1_1.bid_price
	self.proceeds = arg_1_1.change_gold
	self.bidItemList = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.item_list) do
		self.bidItemList[iter_1_0] = AuctionGameStoreItemData.New(iter_1_1)
	end

	return
end

function AuctionGameSettlementData:GetItemList()
	return self.bidItemList
end

function AuctionGameSettlementData:GetSortItemList()
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(self.bidItemList) do
		table.insert(var_3_0, iter_3_1)
	end

	table.sort(var_3_0, function(arg_4_0, arg_4_1)
		if arg_4_0.position.y == arg_4_1.position.y then
			return arg_4_0.position.x < arg_4_1.position.x
		end

		return arg_4_0.position.y < arg_4_1.position.y
	end)

	return var_3_0
end

return AuctionGameSettlementData
