local IslandTradegency = class("IslandTradegency", import(".IslandBaseAgency"))

IslandTradegency.WEEK_NUM_UPDATE = "IslandTradegency:WEEK_NUM_UPDATE"
IslandTradegency.RESET_PRICE = "IslandTradegency:RESET_PRICE"
IslandTradegency.INVITE_LIST_UPDATE = "IslandTradegency:INVITE_LIST_UPDATE"

function IslandTradegency:OnInit(arg_1_1)
	local var_1_0 = arg_1_1.treasure or {}

	self.weekNum = var_1_0.week_buy_num or 0
	self.weekNumMax = pg.island_set.treasure_week_limit.key_value_varchar[1]
	self.sellNumMax = pg.island_set.treasure_week_limit.key_value_varchar[2]
	self.coefficient = pg.island_set.treasure_price_buy.key_value_int * 0.01
	self.sellList = {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0.sell_list or {}) do
		self.sellList[iter_1_1.island_id] = iter_1_1.num
	end

	self.priceList = {}

	for iter_1_2, iter_1_3 in ipairs(var_1_0.price_list or {}) do
		self.priceList[iter_1_3.timestamp] = iter_1_3.price
	end

	self.ranks = {}
	self.inviteList = {}

	for iter_1_4, iter_1_5 in ipairs(var_1_0.invite_list or {}) do
		table.insert(self.inviteList, iter_1_5)
	end

	self.cacheRankTime = 0

	return
end

function IslandTradegency:IsInvited(arg_2_1)
	return table.contains(self.inviteList, arg_2_1)
end

function IslandTradegency:UpdateInviteList(arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		table.insert(self.inviteList, iter_3_1)
	end

	self:DispatchEvent(IslandTradegency.INVITE_LIST_UPDATE)

	return
end

function IslandTradegency:ClearInviteList()
	self.inviteList = {}

	self:DispatchEvent(IslandTradegency.INVITE_LIST_UPDATE)

	return
end

function IslandTradegency:GetSellLimit(arg_5_1)
	return self.sellList[arg_5_1] or 0
end

function IslandTradegency:UpdateSellLimit(arg_6_1, arg_6_2)
	self.sellList[arg_6_1] = self.sellList[arg_6_1] or 0
	self.sellList[arg_6_1] = self.sellList[arg_6_1] + arg_6_2

	return
end

function IslandTradegency:GetSellLimitMax()
	return self.sellNumMax
end

function IslandTradegency:GetCanSellCnt(arg_8_1)
	local var_8_0 = getProxy(IslandProxy):GetIsland()
	local var_8_1 = var_8_0:GetInventoryAgency():GetOwnCount(IslandItem.PEARL_ID)

	if var_8_0.id == arg_8_1 then
		return var_8_1
	end

	return math.min(var_8_1, self.sellNumMax - self:GetSellLimit(arg_8_1))
end

function IslandTradegency:GetCanPurchaseCnt()
	return math.min(math.floor(getProxy(IslandProxy):GetIsland():GetInventoryAgency():GetOwnCount(IslandItem.GOLD_ID) / self:GetTodayPrice()), self.weekNumMax - self.weekNum)
end

function IslandTradegency:GetWeekNum()
	return self.weekNum
end

function IslandTradegency:GetWeekNumMax()
	return self.weekNumMax
end

function IslandTradegency:UpdateWeekNum(arg_12_1)
	self.weekNum = self.weekNum + arg_12_1

	self:DispatchEvent(IslandTradegency.WEEK_NUM_UPDATE)

	return
end

function IslandTradegency:ResetWeekNum()
	self.weekNum = 0

	self:DispatchEvent(IslandTradegency.WEEK_NUM_UPDATE)

	return
end

function IslandTradegency:ShouldRefreshRank()
	local var_14_0

	if #self.ranks <= 0 then
		do return true end

		var_14_0 = pg.TimeMgr.GetInstance()
	end

	return self.cacheRankTime < var_14_0:GetServerTime()
end

function IslandTradegency:SetRanks(arg_15_1, arg_15_2)
	self.ranks = arg_15_1
	self.cacheRankTime = arg_15_2

	return
end

function IslandTradegency:GetRanks()
	local var_16_0 = self:GetSelfRank()

	var_16_0:SetValue(math.floor(var_16_0.value * self.coefficient))

	return _.map(self.ranks, function(arg_17_0)
		local var_17_0 = Clone(arg_17_0)

		var_17_0:SetValue(math.floor(arg_17_0.value * self.coefficient))

		return var_17_0
	end), var_16_0
end

function IslandTradegency:GetSelfRank()
	local var_18_0 = getProxy(PlayerProxy):getRawData()
	local var_18_1 = getProxy(IslandProxy)
	local var_18_2 = var_18_1:GetIsland()
	local var_18_3 = {
		id = var_18_0.id,
		value = var_18_2:GetTradeAgency().GetTodaySellPrice(var_18_1),
		skinId = var_18_0.skinId,
		islandLevel = var_18_2:GetLevel()
	}

	var_18_3.name = var_18_0.name or ""

	return (IslandTradeRank.New(var_18_3))
end

function IslandTradegency:GetSellRanks()
	return self.ranks, (self:GetSelfRank())
end

function IslandTradegency:GetLatestTime()
	local var_20_0 = {}

	for iter_20_0, iter_20_1 in pairs(self.priceList) do
		table.insert(var_20_0, iter_20_0)
	end

	table.sort(var_20_0, function(arg_21_0, arg_21_1)
		return arg_21_1 < arg_21_0
	end)

	return var_20_0[1] or -1
end

function IslandTradegency:CanPurchase()
	return pg.TimeMgr.GetInstance():GetServerTime() <= self:GetLatestTime()
end

function IslandTradegency:GetTodayPrice()
	return math.floor(self:GetTodaySellPrice() * self.coefficient)
end

function IslandTradegency:GetTodaySellPrice()
	return self.priceList[self:GetLatestTime()] or 0
end

function IslandTradegency:UpdateTodayPrice(arg_25_1, arg_25_2)
	self.priceList[arg_25_1] = arg_25_2

	self:ClearInviteList()

	self.sellList = {}

	self:DispatchEvent(IslandTradegency.RESET_PRICE)

	return
end

function IslandTradegency:GetPriceTrend()
	local var_26_0 = {}

	for iter_26_0, iter_26_1 in pairs(self.priceList) do
		var_26_0[iter_26_0 - 0] = math.floor(iter_26_1 * self.coefficient)
	end

	return var_26_0
end

function IslandTradegency:GetSellPriceTrend()
	local var_27_0 = {}

	for iter_27_0, iter_27_1 in pairs(self.priceList) do
		var_27_0[iter_27_0 - 0] = iter_27_1
	end

	return var_27_0
end

function IslandTradegency:ExistTrade(arg_28_1)
	return self:GetPriceTrend()[arg_28_1] ~= nil
end

function IslandTradegency:UpdatePerHour(arg_29_1)
	if pg.TimeMgr.GetInstance():GetServerWeek() == 1 and arg_29_1 == 3 then
		self:ResetWeekNum()
	end

	if arg_29_1 == 3 then
		-- block empty
	end

	return
end

return IslandTradegency
