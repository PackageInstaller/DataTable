local var_0_0 = g.core.const.ConstMgr.PushGiftConst
local HotSaleGMGiftData = class("HotSaleGMGiftData")

function HotSaleGMGiftData:ctor()
	self:initData()
end

function HotSaleGMGiftData:initData()
	self._hotSaleGiftMap = {}
	self._gmGiftInfo = {}
	self._gmGiftContentInfo = {}
end

function HotSaleGMGiftData:initHotSaleGiftInfo(arg_3_1)
	self._hotSaleGiftMap = {}

	if arg_3_1 and arg_3_1.gifts then
		for iter_3_0, iter_3_1 in pairs(arg_3_1.gifts) do
			if iter_3_1.push_type == var_0_0.PUSH_TYPE.NEW then
				self._hotSaleGiftMap[iter_3_1.id] = self._hotSaleGiftMap[iter_3_1.id] or {}
				self._hotSaleGiftMap[iter_3_1.id] = iter_3_1
			end
		end
	end
end

function HotSaleGMGiftData:updateGMGiftInfoByOp(arg_4_1)
	for iter_4_0, iter_4_1 in pairs(arg_4_1.data or {}) do
		if iter_4_1.push_type == var_0_0.PUSH_TYPE.NEW then
			self._hotSaleGiftMap[iter_4_1.id] = self._hotSaleGiftMap[iter_4_1.id] or {}
			self._hotSaleGiftMap[iter_4_1.id] = iter_4_1
		end
	end

	g.core.network.GameNetProxy:send_C2S_PushGift_GetGmActInfo({})
end

function HotSaleGMGiftData:updateHotSaleGiftGMInfo(arg_5_1)
	if arg_5_1.infos then
		for iter_5_0, iter_5_1 in pairs(arg_5_1.infos) do
			if iter_5_1.info then
				self._gmGiftInfo[iter_5_1.info.id] = self._gmGiftInfo[iter_5_1.info.id] or {}
				self._gmGiftInfo[iter_5_1.info.id] = iter_5_1.info
			end

			if iter_5_1.content_infos then
				for iter_5_2, iter_5_3 in pairs(iter_5_1.content_infos) do
					self._gmGiftContentInfo[iter_5_3.id] = self._gmGiftContentInfo[iter_5_3.id] or {}
					self._gmGiftContentInfo[iter_5_3.id] = iter_5_3
				end
			end
		end
	end
end

function HotSaleGMGiftData:removeGetAwardsGMGifts(arg_6_1)
	if arg_6_1 then
		if self._hotSaleGiftMap[arg_6_1.id] then
			self._hotSaleGiftMap[arg_6_1.id] = nil
		end
	end
end

function HotSaleGMGiftData:updateGMGiftInfoByBuyRec(arg_7_1)
	if self._hotSaleGiftMap[arg_7_1.id] then
		self._hotSaleGiftMap[arg_7_1.id] = nil
	end
end

function HotSaleGMGiftData:checkValidGifts()
	local var_8_0 = g.core.common.ServerTime:getTime()

	for iter_8_0, iter_8_1 in pairs(self._hotSaleGiftMap) do
		local var_8_1 = self:getPushGiftInfo(iter_8_1.push_gift_id)

		if var_8_1 then
			if var_8_0 > var_8_1.activity_end_time then
				self._hotSaleGiftMap[iter_8_0] = nil
			end
		else
			self._hotSaleGiftMap[iter_8_0] = nil
		end
	end
end

function HotSaleGMGiftData:getPushGiftInfo(arg_9_1)
	if self._gmGiftInfo[arg_9_1] then
		return self._gmGiftInfo[arg_9_1]
	end
end

function HotSaleGMGiftData:getPushGiftContentInfo(arg_10_1)
	if self._gmGiftContentInfo[arg_10_1] then
		return self._gmGiftContentInfo[arg_10_1]
	end
end

function HotSaleGMGiftData:isShowHotSaleGMGiftTab()
	self:checkValidGifts()

	return table.nums(self._hotSaleGiftMap) > 0
end

function HotSaleGMGiftData:getGMPushGiftArray()
	self:checkValidGifts()

	local var_12_0 = table.values(self._hotSaleGiftMap)

	table.sort(var_12_0, function(arg_13_0, arg_13_1)
		local var_13_0 = self:getPushGiftInfo(arg_13_0.push_gift_id)
		local var_13_1 = self:getPushGiftInfo(arg_13_1.push_gift_id)

		if not var_13_0 or not var_13_1 then
			return false
		end

		if var_13_0.activity_end_time ~= var_13_1.activity_end_time then
			return var_13_0.activity_end_time < var_13_1.activity_end_time
		end

		if arg_13_0.gift_id ~= arg_13_1.gift_id then
			return arg_13_0.gift_id > arg_13_1.gift_id
		end

		return false
	end)

	return var_12_0
end

function HotSaleGMGiftData:getGiftDiscountById(arg_14_1)
	local var_14_0 = 0
	local var_14_1 = self:getPushGiftContentInfo(arg_14_1)

	if var_14_1 then
		local var_14_2 = var_14_1.original_price

		if var_14_1.original_price == 0 then
			var_14_2 = 1
		end

		if var_14_1.price == 0 then
			return 0
		end

		var_14_0 = math.ceil(string.format("%.1f", var_14_2 / var_14_1.price * 10)) * 10
	end

	return var_14_0
end

function HotSaleGMGiftData:getGiftAwardsByGiftId(arg_15_1)
	local var_15_0 = {}
	local var_15_1 = self:getPushGiftContentInfo(arg_15_1)

	if var_15_1 then
		for iter_15_0 = 1, var_0_0.AWARDS_COUNT do
			if var_15_1["gift_type_" .. iter_15_0] > 0 then
				table.insert(var_15_0, {
					type = var_15_1["gift_type_" .. iter_15_0],
					value = var_15_1["gift_value_" .. iter_15_0],
					size = var_15_1["gift_size_" .. iter_15_0]
				})
			end
		end
	end

	return var_15_0
end

function HotSaleGMGiftData:isHaveFreeGMGift(arg_16_1)
	if arg_16_1 and arg_16_1.id then
		if self._hotSaleGiftMap[arg_16_1.id] then
			local var_16_0 = self:getPushGiftContentInfo(self._hotSaleGiftMap[arg_16_1.id].gift_id)

			if var_16_0 and var_16_0.price == 0 then
				return true
			end
		end
	else
		for iter_16_0, iter_16_1 in pairs(self._hotSaleGiftMap) do
			local var_16_1 = self:getPushGiftContentInfo(iter_16_1.gift_id)

			if var_16_1 and var_16_1.price == 0 then
				return true
			end
		end
	end

	return false
end

function HotSaleGMGiftData:clearGMGiftNew(arg_17_1)
	local var_17_0 = g.core.common.Storage:load("NewHotSaleGMGift.json") or {}

	var_17_0["GMGift_" .. arg_17_1] = true

	g.core.common.Storage:save("NewHotSaleGMGift.json", var_17_0)
end

function HotSaleGMGiftData:isHaveNewGMPushGift(arg_18_1)
	self:checkValidGifts()

	local var_18_0 = g.core.common.Storage:load("NewHotSaleGMGift.json") or {}

	if arg_18_1 and arg_18_1.id then
		if not var_18_0["GMGift_" .. arg_18_1.id] then
			return true
		end
	else
		for iter_18_0, iter_18_1 in pairs(self._hotSaleGiftMap) do
			if not var_18_0["GMGift_" .. iter_18_0] then
				return true
			end
		end
	end

	return false
end

return HotSaleGMGiftData
