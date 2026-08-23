local AuctionData = class("AuctionData")
local var_0_1 = g.core.config.auction_info
local var_0_2 = g.core.config.auction_item_info
local var_0_3 = g.core.config.auction_rate_info

function AuctionData:ctor()
	self:initData()
end

function AuctionData:initData()
	self._auctionInfoList = {}
	self._ItemInfoList = {}
	self._rateInfoList = {}
	self.tabListInfo = {}

	self:_initConfigData()

	self.act_id_list = {}
end

function AuctionData:_initConfigData()
	for iter_3_0 = 1, var_0_1.getLength() do
		table.insert(self._auctionInfoList, (var_0_1.indexOf(iter_3_0)))
	end

	for iter_3_1 = 1, var_0_2.getLength() do
		table.insert(self._ItemInfoList, (var_0_2.indexOf(iter_3_1)))
	end

	for iter_3_2 = 1, var_0_3.getLength() do
		table.insert(self._rateInfoList, (var_0_3.indexOf(iter_3_2)))
	end
end

function AuctionData:getAuctionInfoById(arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(self._auctionInfoList) do
		if iter_4_1.id == arg_4_1 then
			return iter_4_1
		end
	end

	assert(false, "can not find info in _auctionInfoList id = " .. tostring(arg_4_1))
end

function AuctionData:getItemInfoById(arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(self._ItemInfoList) do
		if iter_5_1.id == arg_5_1 then
			return iter_5_1
		end
	end

	assert(false, "can not find info in _ItemInfoList id = " .. tostring(arg_5_1))
end

function AuctionData:getRateInfoById(arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(self._rateInfoList) do
		if iter_6_1.id == arg_6_1 then
			return iter_6_1
		end
	end

	assert(false, "can not find info in _rateInfoList id = " .. tostring(arg_6_1))
end

function AuctionData:getTabListInfo()
	return self.tabListInfo
end

function AuctionData:initTabListStatus()
	for iter_8_0, iter_8_1 in ipairs(self.tabListInfo) do
		if iter_8_1.has_goods then
			iter_8_1.isOpen = true
			iter_8_1.isSelect = true

			return
		else
			iter_8_1.isSelect = false
			iter_8_1.isOpen = false
		end
	end

	self.tabListInfo[1].isOpen = true
	self.tabListInfo[1].isSelect = true
end

function AuctionData:getSelTabIndex()
	for iter_9_0, iter_9_1 in ipairs(self.tabListInfo) do
		if iter_9_1.has_goods then
			return iter_9_0
		end
	end

	return 1
end

function AuctionData:getAuctionInfoBuyId(arg_10_1, arg_10_2)
	if arg_10_2 and arg_10_2 == 0 then
		return self.tabListInfo[#self.tabListInfo]
	end

	for iter_10_0, iter_10_1 in ipairs(self.tabListInfo) do
		if iter_10_1.auction_id == arg_10_1 then
			return iter_10_1
		end
	end

	print("can not find AuctionInfo by id = " .. tostring(arg_10_1))
end

function AuctionData:updateAuctionInfo(arg_11_1, arg_11_2)
	if not arg_11_1 then
		return
	end

	if arg_11_2 then
		for iter_11_0, iter_11_1 in ipairs(self.tabListInfo) do
			if iter_11_1.auction_id == arg_11_1.auction_id and iter_11_1.act_id == arg_11_1.act_id then
				iter_11_1.isOpen = not iter_11_1.isOpen
				iter_11_1.isSelect = true
			else
				iter_11_1.isSelect = false
				iter_11_1.isOpen = false
			end
		end
	end

	local var_11_0 = self:getAuctionInfoBuyId(arg_11_1.auction_id, arg_11_1.act_id)

	if not var_11_0 then
		return
	end

	if arg_11_1.goods and #arg_11_1.goods > 0 then
		local var_11_1 = {}

		arg_11_1.sonTabList = {}

		for iter_11_2, iter_11_3 in ipairs(arg_11_1.goods) do
			local var_11_2 = self:getItemInfoById(iter_11_3.auction_item_id)

			if var_11_2.tab then
				if var_11_1[var_11_2.tab] then
					table.insert(var_11_1[var_11_2.tab], iter_11_3)
				else
					var_11_1[var_11_2.tab] = {}

					table.insert(var_11_1[var_11_2.tab], iter_11_3)
				end
			end
		end

		for iter_11_4 = 1, 10 do
			if var_11_1[iter_11_4] then
				table.insert(arg_11_1.sonTabList, {
					auction_id = arg_11_1.auction_id,
					goods = var_11_1[iter_11_4]
				})
			end
		end

		var_11_0.goods = arg_11_1.goods
		var_11_0.sonTabList = arg_11_1.sonTabList
	end

	var_11_0.act_id = arg_11_1.act_id
	var_11_0.auction_id = arg_11_1.auction_id
	var_11_0.bonus = arg_11_1.bonus
	var_11_0.start_time = arg_11_1.start_time
	var_11_0.has_goods = arg_11_1.has_goods
end

function AuctionData:initListInfo()
	self.tabListInfo = {}

	for iter_12_0, iter_12_1 in ipairs(self._auctionInfoList) do
		if g.core.common.ModuleUnlock:isModuleUnlock(iter_12_1.function_id) then
			table.insert(self.tabListInfo, {
				isSelect = false,
				isOpen = false,
				act_id = -1,
				has_goods = false,
				start_time = 0,
				bonus = 0,
				auction_id = iter_12_1.id,
				goods = {},
				sonTabList = {}
			})
		end
	end

	table.sort(self.tabListInfo, function(arg_13_0, arg_13_1)
		return arg_13_0.auction_id < arg_13_1.auction_id
	end)
	table.insert(self.tabListInfo, {
		isSelect = false,
		isOpen = false,
		act_id = 0,
		has_goods = false,
		start_time = 0,
		auction_id = 0,
		bonus = 0,
		goods = {},
		sonTabList = {}
	})
end

function AuctionData:initAuctionData(arg_14_1)
	self:initListInfo()

	if arg_14_1.auctions then
		for iter_14_0, iter_14_1 in ipairs(arg_14_1.auctions) do
			self:updateAuctionInfo(iter_14_1)
		end
	end

	self:initTabListStatus()
end

function AuctionData:updateNewActId(arg_15_1)
	if not arg_15_1.act_id or not arg_15_1.auction_id then
		return
	end

	for iter_15_0, iter_15_1 in ipairs(self.tabListInfo) do
		if iter_15_1.auction_id == arg_15_1.auction_id then
			iter_15_1.act_id = arg_15_1.act_id
		end
	end
end

function AuctionData:updateRedPointActId(arg_16_1)
	if not arg_16_1.act_id then
		return
	end

	for iter_16_0, iter_16_1 in ipairs(arg_16_1.act_id) do
		self:setActId(iter_16_1)
	end
end

function AuctionData:setActId(arg_17_1)
	self.act_id_list[tostring(arg_17_1)] = arg_17_1
end

function AuctionData:getActId()
	return self.act_id_list
end

function AuctionData:setActSaveInfo()
	g.core.common.Storage:save("auction_config_1.json", {
		act_id_list = self.act_id_list
	})
end

function AuctionData:getActSaveInfo()
	local var_20_0 = g.core.common.Storage:load("auction_config_1.json") or {}

	if var_20_0.act_id_list then
		return var_20_0.act_id_list
	else
		return nil
	end
end

function AuctionData:isSaveHave(arg_21_1, arg_21_2)
	for iter_21_0, iter_21_1 in pairs(arg_21_1) do
		if iter_21_1 == arg_21_2 then
			return true
		end
	end

	return false
end

function AuctionData:getIsHaveNew()
	local var_22_0 = self:getActId()
	local var_22_1 = self:getActSaveInfo()

	if var_22_0 then
		for iter_22_0, iter_22_1 in pairs(var_22_0) do
			if var_22_1 then
				if not self:isSaveHave(var_22_1, iter_22_1) then
					return true
				end
			else
				return true
			end
		end
	end

	return false
end

function AuctionData:getIsHaveGoods()
	for iter_23_0, iter_23_1 in ipairs(self.tabListInfo) do
		if iter_23_1.has_goods then
			return true
		end
	end

	return false
end

function AuctionData:setShowMyAuction(arg_24_1)
	g.core.common.Storage:save("auction_config.json", {
		isMyAuction = arg_24_1
	})
end

function AuctionData:getShowMyAuction()
	local var_25_0 = g.core.common.Storage:load("auction_config.json") or {}

	if var_25_0.isMyAuction then
		return var_25_0.isMyAuction
	else
		return false
	end
end

function AuctionData:getAuctionTime()
	local var_26_0 = 0

	if next(self.tabListInfo) then
		local var_26_1 = self.tabListInfo[self:getSelTabIndex()].goods
		local var_26_2 = g.core.common.ServerTime:getTime()

		if var_26_1 and var_26_1[1] then
			var_26_0 = var_26_2 < var_26_1[1].start_time and math.max(0, math.floor(var_26_1[1].start_time - var_26_2)) or math.max(0, math.floor(var_26_1[1].rest_time - var_26_2))
		end
	end

	return var_26_0
end

function AuctionData:getSubTabGoodsListData(arg_27_1, arg_27_2)
	local var_27_0 = self:getAuctionInfoBuyId(arg_27_1, arg_27_2)
	local var_27_1 = {}

	table.insert(var_27_1, {
		title = g.core.lang:get(403512),
		tabInfo = {
			act_id = var_27_0.act_id
		}
	})

	for iter_27_0, iter_27_1 in ipairs(var_27_0.sonTabList) do
		local var_27_2 = self:getItemInfoById(iter_27_1.goods[1].auction_item_id)

		table.insert(var_27_1, {
			title = var_27_2.tab_name,
			tabInfo = {
				act_id = iter_27_1.goods[1].act_id,
				tab = var_27_2.tab
			}
		})
	end

	table.insert(var_27_1, {
		title = g.core.lang:get(403513),
		tabInfo = {
			act_id = var_27_0.act_id
		}
	})

	return var_27_1
end

return AuctionData
