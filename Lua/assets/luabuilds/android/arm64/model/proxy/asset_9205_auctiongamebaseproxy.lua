local AuctionGameBaseProxy = class("AuctionGameBaseProxy", import(".NetProxy"))

function AuctionGameBaseProxy:register()
	self:UpdateData({})

	self.needInitFlag = true

	return
end

function AuctionGameBaseProxy:UpdateData(arg_2_1)
	self.gold = arg_2_1.gold or 0
	self.matchNum = arg_2_1.game_num or 0
	self.bidSuccessCnt = arg_2_1.buy_num or 0
	self.highestProfit = arg_2_1.max_profit or 0
	self.totalProfit = arg_2_1.acc_profit or 0

	if arg_2_1.item_list then
		self.unlockCollectionCnt = #arg_2_1.item_list or 0
	end

	self.unlockCollectionList = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.item_list or {}) do
		table.insert(self.unlockCollectionList, iter_2_1)
	end

	self.totalBidPrice = arg_2_1.acc_buy_price or 0
	self.totalCollectionPrice = arg_2_1.acc_item_price or 0
	self.preorderState = arg_2_1.pre_buy_state or 0
	self.preorderTimestamp = arg_2_1.pre_timestamp or 0
	self.forbiddenTime = arg_2_1.match_time or 0
	self.isForbidden = arg_2_1.is_forbidden or 0
	self.inactiveNum = arg_2_1.inactive_num or 0
	self.isMatchWarning = arg_2_1.inactive_state or 0
	self.serverForbidden = arg_2_1.back_forbidden or 0
	self.reliefCnt = arg_2_1.get_relief_num or 0

	return
end

function AuctionGameBaseProxy:AddGold(arg_3_1)
	self.gold = self.gold + arg_3_1

	if pg.gameset.auction_currency_ceiling.key_value < self.gold then
		self.gold = pg.gameset.auction_currency_ceiling.key_value
	end

	return
end

function AuctionGameBaseProxy:GetPreorderState()
	return self.preorderState
end

function AuctionGameBaseProxy:GetPreorderTimestamp()
	return self.preorderTimestamp
end

function AuctionGameBaseProxy:SetOrderTimestamp(arg_6_1)
	self.preorderTimestamp = arg_6_1
	self.preorderState = 1

	return
end

function AuctionGameBaseProxy:SetMatchWarning()
	self.isMatchWarning = 1

	return
end

function AuctionGameBaseProxy:GetNeedInitFlag()
	return self.needInitFlag
end

function AuctionGameBaseProxy:SetNeedInitFlag(arg_9_1)
	self.needInitFlag = arg_9_1

	return
end

function AuctionGameBaseProxy:GetUnlockCollectionList()
	return self.unlockCollectionList
end

function AuctionGameBaseProxy:AddReliefCnt()
	self.reliefCnt = self.reliefCnt + 1

	return
end

function AuctionGameBaseProxy:UpdateSettlementData(arg_12_1)
	self.storeLine = arg_12_1.line or 10
	self.bidItemList = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_1.item_list) do
		self.bidItemList[iter_12_0] = AuctionGameStoreItemData.New(iter_12_1)
	end

	return
end

function AuctionGameBaseProxy:GetItemList()
	return self.bidItemList
end

function AuctionGameBaseProxy:GetMaxLineCnt()
	return (self.storeLine > 10 or nil) and (self.storeLine or 10)
end

return AuctionGameBaseProxy
