local var_0_0 = g.core.config.push_gift_info
local var_0_1 = g.core.config.push_gift_content_info
local var_0_2 = g.core.const.ConstMgr.PushGiftConst
local PushGiftData = class("PushGiftData")

function PushGiftData:ctor()
	self:initData()
end

function PushGiftData:initData()
	self._pushGiftList = {}
	self._giftGroupMap = {}
	self._gmGiftInfo = {}
	self._gmGiftContentInfo = {}
	self._isTriggerIcon = false
end

function PushGiftData:initPushGiftInfo(arg_3_1)
	if arg_3_1.gifts then
		self._pushGiftList = {}
		self._giftGroupMap = {}

		for iter_3_0, iter_3_1 in ipairs(arg_3_1.gifts) do
			if iter_3_1.push_type == var_0_2.PUSH_TYPE.OLD then
				self._pushGiftList[iter_3_1.id] = self._pushGiftList[iter_3_1.id] or {}
				self._pushGiftList[iter_3_1.id] = iter_3_1
				self._giftGroupMap[iter_3_1.push_gift_id] = self._giftGroupMap[iter_3_1.push_gift_id] or {}

				table.insert(self._giftGroupMap[iter_3_1.push_gift_id], iter_3_1)
			end
		end
	end
end

function PushGiftData:updateGiftInfoByOp(arg_4_1)
	if arg_4_1.data then
		for iter_4_0, iter_4_1 in ipairs(arg_4_1.data) do
			if iter_4_1.push_type == var_0_2.PUSH_TYPE.OLD then
				self._pushGiftList[iter_4_1.id] = self._pushGiftList[iter_4_1.id] or {}
				self._pushGiftList[iter_4_1.id] = iter_4_1
				self._giftGroupMap[iter_4_1.push_gift_id] = self._giftGroupMap[iter_4_1.push_gift_id] or {}

				table.insert(self._giftGroupMap[iter_4_1.push_gift_id], iter_4_1)

				local var_4_0 = g.core.common.Storage:load("pushGift_new.json") or {}

				if var_4_0["pushGift_" .. iter_4_1.push_gift_id] then
					var_4_0["pushGift_" .. iter_4_1.push_gift_id] = nil
				end

				g.core.common.Storage:save("pushGift_new.json", var_4_0)
			end
		end
	end

	self:setTriggerIconState(true)
end

function PushGiftData:updatePushGiftGMInfo(arg_5_1)
	if arg_5_1.infos then
		self._gmGiftContentInfo = self._gmGiftContentInfo or {}

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

function PushGiftData:updateGiftInfoByBuyRec(arg_6_1)
	if arg_6_1 and arg_6_1.id then
		if self._pushGiftList[arg_6_1.id] then
			self._pushGiftList[arg_6_1.id] = nil

			self:resetGiftGroupMap()
		end
	end
end

function PushGiftData:resetGiftGroupMap()
	self._giftGroupMap = {}

	for iter_7_0, iter_7_1 in pairs(self._pushGiftList) do
		self._giftGroupMap[iter_7_1.push_gift_id] = self._giftGroupMap[iter_7_1.push_gift_id] or {}

		table.insert(self._giftGroupMap[iter_7_1.push_gift_id], iter_7_1)
	end

	self:sortGiftGroupData()
end

function PushGiftData:sortGiftGroupData()
	for iter_8_0, iter_8_1 in pairs(self._pushGiftList) do
		if self._giftGroupMap[iter_8_1.push_gift_id] then
			table.sort(self._giftGroupMap[iter_8_1.push_gift_id], function(arg_9_0, arg_9_1)
				local var_9_0 = self:getPushGiftContentInfo(arg_9_0.gift_id)
				local var_9_1 = self:getPushGiftContentInfo(arg_9_1.gift_id)

				if var_9_0 and var_9_1 then
					return var_9_0.price < var_9_1.price
				end

				return false
			end)
		end
	end
end

function PushGiftData:getPushGiftCount()
	self:checkValidData()

	return table.nums(self._pushGiftList)
end

function PushGiftData:getPushGiftGroupCount()
	self:checkValidData()

	return table.nums(self._giftGroupMap)
end

function PushGiftData:getGiftGroupDataByIdx(arg_12_1)
	self:checkValidData()

	for iter_12_0, iter_12_1 in pairs(self._giftGroupMap) do
		if 1 == arg_12_1 then
			return iter_12_1
		end
	end

	return nil
end

function PushGiftData:getGiftDataByIndex(arg_13_1, arg_13_2)
	self:checkValidData()

	for iter_13_0, iter_13_1 in pairs(self._giftGroupMap) do
		if 1 == arg_13_1 then
			for iter_13_2, iter_13_3 in ipairs(iter_13_1) do
				if iter_13_2 == arg_13_2 then
					return iter_13_3
				end
			end
		end
	end

	return nil
end

function PushGiftData:getShortTimeGift()
	self:checkValidData()

	local var_14_0 = {}

	if table.nums(self._pushGiftList) > 0 then
		for iter_14_0, iter_14_1 in pairs(self._pushGiftList) do
			if iter_14_1.type == 0 then
				table.insert(var_14_0, iter_14_1)
			end
		end
	end

	table.sort(var_14_0, function(arg_15_0, arg_15_1)
		if arg_15_0 and arg_15_1 then
			return arg_15_0.create_time < arg_15_1.create_time
		else
			return false
		end
	end)

	if #var_14_0 > 0 then
		return var_14_0[1]
	end

	return nil
end

function PushGiftData:getGiftDiscountById(arg_16_1)
	local var_16_0 = 0
	local var_16_1 = self:getPushGiftContentInfo(arg_16_1)

	if var_16_1 then
		local var_16_2 = var_16_1.original_price

		if var_16_1.original_price == 0 then
			var_16_2 = 1
		end

		if var_16_1.price == 0 then
			return 0
		end

		var_16_0 = math.ceil(string.format("%.1f", var_16_2 / var_16_1.price * 10)) * 10
	end

	return var_16_0
end

function PushGiftData:getGiftAwardsByGiftId(arg_17_1)
	local var_17_0 = {}
	local var_17_1 = self:getPushGiftContentInfo(arg_17_1)

	if var_17_1 then
		for iter_17_0 = 1, var_0_2.AWARDS_COUNT do
			local var_17_2 = var_17_1["gift_type_" .. iter_17_0]
			local var_17_3 = var_17_1["gift_value_" .. iter_17_0]
			local var_17_4 = var_17_1["gift_size_" .. iter_17_0]

			if iter_17_0 < 4 then
				local var_17_5 = var_17_1["gift_effect_" .. iter_17_0] or 0

				if var_17_2 and var_17_3 and (var_17_2 > 0 or var_17_3 > 0) then
					table.insert(var_17_0, {
						type = var_17_2,
						value = var_17_3,
						size = var_17_4,
						effect = var_17_5
					})
				end
			end
		end
	end

	return var_17_0
end

function PushGiftData:checkValidData()
	local var_18_0 = g.core.common.ServerTime:getTime()

	for iter_18_0, iter_18_1 in pairs(self._pushGiftList) do
		local var_18_1 = self:getPushGiftContentInfo(iter_18_1.gift_id)

		if var_18_1 then
			if var_18_0 > iter_18_1.create_time + var_18_1.gift_time_limit or iter_18_1.type ~= 0 then
				self._pushGiftList[iter_18_0] = nil
			end
		else
			self._pushGiftList[iter_18_0] = nil
		end
	end

	self:resetGiftGroupMap()
end

function PushGiftData:isShowPushGift()
	self:checkValidData()

	return table.nums(self._pushGiftList) > 0
end

function PushGiftData:clearGiftNew(arg_20_1)
	local var_20_0 = g.core.common.Storage:load("pushGift_new.json") or {}

	if self._giftGroupMap[arg_20_1] then
		var_20_0["pushGift_" .. arg_20_1] = true
	end

	g.core.common.Storage:save("pushGift_new.json", var_20_0)
end

function PushGiftData:getHasNew()
	self:checkValidData()

	local var_21_0 = g.core.common.Storage:load("pushGift_new.json") or {}

	for iter_21_0, iter_21_1 in pairs(self._giftGroupMap) do
		if not var_21_0["pushGift_" .. iter_21_0] then
			return true
		end
	end

	return false
end

function PushGiftData:getNewGiftIndex()
	self:checkValidData()

	local var_22_0 = g.core.common.Storage:load("pushGift_new.json") or {}
	local var_22_1 = 1

	for iter_22_0, iter_22_1 in pairs(self._giftGroupMap) do
		if not var_22_0["pushGift_" .. iter_22_0] then
			return var_22_1
		end

		var_22_1 = var_22_1 + 1
	end

	return 1
end

function PushGiftData:isHaveAwardGet(arg_23_1)
	if arg_23_1.id and self._pushGiftList[arg_23_1.id] then
		return self._pushGiftList[arg_23_1.id].type ~= 0
	else
		for iter_23_0, iter_23_1 in pairs(self._pushGiftList) do
			if iter_23_1.type ~= 0 then
				return true
			end
		end
	end

	return false
end

function PushGiftData:setTriggerIconState(arg_24_1)
	self._isTriggerIcon = arg_24_1
end

function PushGiftData:getTriggerIconState()
	return self._isTriggerIcon
end

function PushGiftData:isFirstPushGiftAvgShow()
	if not (g.core.common.Storage:load("first_pushGift_avg.json", true) or {}).isPlay then
		return true
	end

	return false
end

function PushGiftData:setFirstPushGiftAvgShow()
	g.core.common.Storage:save("first_pushGift_avg.json", {
		isPlay = true
	}, true)
end

function PushGiftData:getPushGiftInfo(arg_28_1)
	local var_28_0 = var_0_0.fetch(arg_28_1)

	if var_28_0 then
		return var_28_0
	elseif self._gmGiftInfo[arg_28_1] then
		return self._gmGiftInfo[arg_28_1]
	end
end

function PushGiftData:getPushGiftContentInfo(arg_29_1)
	self._gmGiftContentInfo = self._gmGiftContentInfo or {}

	local var_29_0 = var_0_1.fetch(arg_29_1)

	if var_29_0 then
		return var_29_0
	elseif self._gmGiftContentInfo[arg_29_1] then
		return self._gmGiftContentInfo[arg_29_1]
	end
end

return PushGiftData
