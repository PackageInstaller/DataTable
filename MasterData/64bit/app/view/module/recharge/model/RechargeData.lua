local var_0_0 = g.core.const.ConstMgr.RechargeConst
local RechargeData = class("RechargeData")
local var_0_2 = g.core.config.vip_level_info

function RechargeData:ctor()
	self:initData()
end

function RechargeData:initData()
	self._totalRecharge = 0
	self._customTotalRecharge = 0
	self._itemIds = nil
	self._itemDirty = false
	self._rechargeIds = {}
	self._typeIds = nil
	self._rechargeNotifyMap = {}
	self._rechargeInfoMap = {}
	self._vipLevelInfoMap = {}
	self._vipLevelInfoList = {}
	self._GMdoubleRechargeIds = {}
	self._GMdoubleRechargeActivityId = 0
	self._GMdoubleRechargeStartTime = 0
	self._GMdoubleRechargeEndTime = 0
	self._GMdoubleRechargeLevelMin = 0
	self._GMdoubleRechargeLevelMax = 0
	self._GMdoubleRechargeOpenDay = 0
	self._hasNewOrderId = false
	self._returnPayAmount = 0
	self._returnPayGetTime = 0

	self:_initData()
	self:initRechargeInfoMap()

	self._canRecharge = true
	self._orderIds = {}
end

function RechargeData:setRechargeStatus(arg_3_1)
	self._canRecharge = arg_3_1
end

function RechargeData:getRechargeStatus()
	return self._canRecharge
end

function RechargeData:initRechargeData(arg_5_1)
	self._customTotalRecharge = 0
	self._itemIds = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_1.show_ids or {}) do
		if g.core.config.recharge_info.fetch(iter_5_1) then
			table.insert(self._itemIds, iter_5_1)
		end
	end

	self._itemDirty = not not arg_5_1.show_ids

	if arg_5_1.recharge_ids then
		for iter_5_2, iter_5_3 in ipairs(arg_5_1.recharge_ids) do
			self._rechargeIds[iter_5_3] = true

			local var_5_0 = self:getRechargeInfoById(iter_5_3)

			if var_5_0 then
				self._customTotalRecharge = self._customTotalRecharge + var_5_0.money
			else
				print("RechargeData:initRechargeData() -> rehcarge_info not id: " .. iter_5_3)
			end
		end

		g.core.platform.PlatformProxy:setHasRecharge(true)
	else
		g.core.platform.PlatformProxy:setHasRecharge(false)
	end

	local var_5_1 = arg_5_1.recharges

	if arg_5_1.recharges then
		for iter_5_4 = 1, #var_5_1 do
			self._rechargeNotifyMap[var_5_1[iter_5_4].type + 1] = var_5_1[iter_5_4]
		end

		if self._rechargeNotifyMap[g.core.network.proto.RIT_RECHARGE_TOTAL + 1] then
			self._totalRecharge = self._rechargeNotifyMap[g.core.network.proto.RIT_RECHARGE_TOTAL + 1].value or 0
		end
	end
end

function RechargeData:isOldPlayerWithRecharge()
	if not self._rechargeNotifyMap[g.core.network.proto.RIT_RECHARGE_INHERIT_TOTAL + 1] then
		return false
	end

	return self._rechargeNotifyMap[g.core.network.proto.RIT_RECHARGE_INHERIT_TOTAL + 1].value > 0
end

function RechargeData:updateItemRechargeFlag(arg_7_1)
	self._rechargeIds[arg_7_1] = true
end

function RechargeData:getItemIds()
	self:_sortItemIds()

	return self._itemIds
end

function RechargeData:_sortItemIds()
	if self._itemDirty then
		local var_9_0 = g.core.config.recharge_info

		table.sort(self._itemIds, function(arg_10_0, arg_10_1)
			local var_10_0 = var_9_0.get(arg_10_0)
			local var_10_1 = var_9_0.get(arg_10_1)

			if var_10_0.order ~= var_10_1.order then
				return var_10_0.order < var_10_1.order
			end

			return var_10_0.id < var_10_1.id
		end)

		local var_9_1 = {}

		for iter_9_0, iter_9_1 in ipairs(self._itemIds) do
			local var_9_2 = g.core.config.recharge_info.get(iter_9_1)

			if var_9_2.seen then
				var_9_1[var_9_2.recharge_type] = var_9_1[var_9_2.recharge_type] or {}

				table.insert(var_9_1[var_9_2.recharge_type], iter_9_1)
			end
		end

		self._typeIds = var_9_1
		self._itemDirty = false
	end
end

function RechargeData:getIdsByType(arg_11_1)
	self:_sortItemIds()

	if not arg_11_1 or not self._typeIds then
		return nil
	end

	return self._typeIds[arg_11_1]
end

function RechargeData:hasRecharge(arg_12_1)
	return self._rechargeIds[arg_12_1]
end

function RechargeData:isRechargeByProductId(arg_13_1)
	for iter_13_0 in pairs(self._rechargeIds) do
		local var_13_0 = g.core.config.recharge_info.get(iter_13_0)

		if var_13_0 and var_13_0.product_id == arg_13_1 then
			return true
		end
	end

	return false
end

function RechargeData:_initData()
	self._vipLevelInfoMap = {}

	for iter_14_0 = 1, var_0_2.getLength() do
		local var_14_0 = var_0_2.indexOf(iter_14_0)

		self._vipLevelInfoMap[var_14_0.level] = var_14_0

		table.insert(self._vipLevelInfoList, var_14_0)
	end

	table.sort(self._vipLevelInfoList, function(arg_15_0, arg_15_1)
		if arg_15_0.level ~= arg_15_1.level then
			return arg_15_0.level < arg_15_1.level
		end
	end)
end

function RechargeData:getPriceByNum(arg_16_1, arg_16_2)
	local var_16_0 = arg_16_1

	if not g.core.platform.PlatformProxy:isChannelOfChina() and not g.core.platform.PlatformProxy:isChannelOfKr() then
		var_16_0 = math.floor(arg_16_1 / 100)

		if arg_16_1 % 100 ~= 0 then
			local var_16_1 = "0." .. tostring(arg_16_1 % 100)
			local var_16_2 = #var_16_1

			for iter_16_0 = #var_16_1, 1 do
				if var_16_1:sub(iter_16_0, iter_16_0) ~= "0" then
					var_16_2 = iter_16_0

					break
				end
			end

			var_16_0 = var_16_0 + tonumber((var_16_1:sub(1, var_16_2)))
		end
	end

	if arg_16_2 then
		return var_16_0
	else
		return self:getCurrency() .. var_16_0
	end
end

function RechargeData:initRechargeInfoMap()
	self._rechargeInfoMap = {}

	for iter_17_0, iter_17_1 in g.core.config.recharge_info.ipairs() do
		local var_17_0 = iter_17_1:toObject()

		var_17_0.client_price = var_17_0.money
		self._rechargeInfoMap[var_17_0.id] = var_17_0
	end
end

function RechargeData:getCurrency()
	if g.core.platform.PlatformProxy:isChannelOfChina() then
		return "¥"
	end

	local var_18_0 = "$"

	for iter_18_0, iter_18_1 in pairs(self._rechargeInfoMap) do
		var_18_0 = iter_18_1.moneyUnit

		break
	end

	return (g.core.platform.PlatformProxy:isDmmPC() or nil) and "Pt"
end

function RechargeData:requestRealProductsInfo()
	if not self._rechargeInfoMap then
		self:initRechargeInfoMap()
	end

	g.core.platform.PlatformProxy:requestRealProductsInfo(self._rechargeInfoMap)
end

function RechargeData:getVipLevelInfoByLevel(arg_20_1)
	return self._vipLevelInfoMap[arg_20_1 or 0]
end

function RechargeData:getVipExpByLevel(arg_21_1)
	if self._vipLevelInfoMap[arg_21_1 - 1] then
		return self._vipLevelInfoMap[arg_21_1 - 1].need_vip_exp
	else
		return 0
	end
end

function RechargeData:getTotalVipexpToViplevel(arg_22_1)
	if not arg_22_1 then
		return
	end

	local var_22_0 = 0

	for iter_22_0 = 1, g.core.config.vip_level_info.getLength() do
		local var_22_1 = g.core.config.vip_level_info.indexOf(iter_22_0)

		if arg_22_1 > var_22_1.level then
			var_22_0 = var_22_0 + var_22_1.need_vip_exp
		end

		if var_22_1.level == arg_22_1 then
			break
		end
	end

	return var_22_0
end

function RechargeData:isMaxVipLevel()
	if self._vipLevelInfoMap[g.core.model.User:getVipLevel() + 1] then
		return false
	else
		return true
	end
end

function RechargeData:addTotalRecharge(arg_24_1)
	if arg_24_1.id then
		local var_24_0 = self:getRechargeInfoById(arg_24_1.id)

		if var_24_0 then
			self._totalRecharge = self._totalRecharge + var_24_0.money
			self._customTotalRecharge = self._customTotalRecharge + var_24_0.money
		end
	end

	g.core.platform.PlatformProxy:sendAdvBigRecharge()

	if arg_24_1.order_id then
		self._orderIds[arg_24_1.order_id] = nil
	end
end

function RechargeData:addOrderId(arg_25_1)
	if arg_25_1 then
		self._hasNewOrderId = true
		self._orderIds[arg_25_1] = g.core.common.ServerTime:getTime()

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GET_NEW_RECHARGE, false)
	end
end

function RechargeData:delOrderId(arg_26_1)
	if arg_26_1 then
		self._orderIds[arg_26_1] = nil
	end
end

function RechargeData:getOrderIds()
	return self._orderIds
end

function RechargeData:clearOrderIds()
	self._orderIds = {}
end

function RechargeData:resetHasNewOrderId()
	self._hasNewOrderId = false
end

function RechargeData:isHasNewOrderId()
	return self._hasNewOrderId
end

function RechargeData:getRechargeVipInfoList()
	return self._vipLevelInfoList
end

function RechargeData:getTotalRecharge()
	return self:getPriceByNum(self._totalRecharge, true)
end

function RechargeData:getCustomTotalRecharge()
	local var_33_0 = g.core.platform.PlatformProxy:getGameId()

	if not var_33_0 or config.PUBLISH_REGION == g.core.const.ConstMgr.PlatformConst.REGION.EN then
		return self:getPriceByNum(self._totalRecharge, true)
	end

	return self:getPriceByNum(math.floor(self._totalRecharge / g.core.config.recharge_exchange_rate_info.get((tonumber(var_33_0))).client_rate * 10000), true)
end

function RechargeData:getUSDByMoneyLocal(arg_34_1)
	local var_34_0 = g.core.platform.PlatformProxy:getGameId()

	if not var_34_0 then
		return self:getPriceByNum(arg_34_1, true)
	end

	return self:getPriceByNum(math.floor(arg_34_1 / g.core.config.recharge_exchange_rate_info.get((tonumber(var_34_0))).exchange_rate * 10000), true)
end

function RechargeData:getRechargeNotifyByType(arg_35_1)
	return self._rechargeNotifyMap[arg_35_1]
end

function RechargeData:getOpIdByRechargeInfo()
	local var_36_0 = g.core.platform.PlatformProxy:getOpId()

	for iter_36_0, iter_36_1 in g.core.config.recharge_info.ipairs() do
		if iter_36_1.app_id == tostring(var_36_0) then
			return iter_36_1.app_id
		end
	end

	return 1
end

function RechargeData:getRechargeInfoByProductId(arg_37_1)
	local var_37_0 = self:getOpIdByRechargeInfo()
	local var_37_1 = {}

	for iter_37_0, iter_37_1 in g.core.config.recharge_info.ipairs() do
		if iter_37_1.app_id == tostring(var_37_0) and arg_37_1 == iter_37_1.product_id then
			table.insert(var_37_1, self:getRechargeInfoById(iter_37_1.id))
		end
	end

	return var_37_1
end

function RechargeData:getRechargeInfoById(arg_38_1)
	return self._rechargeInfoMap[arg_38_1]
end

function RechargeData:getRechargeInfoByTypeAndPrice(arg_39_1, arg_39_2, arg_39_3)
	local var_39_0 = self:getOpIdByRechargeInfo()

	for iter_39_0, iter_39_1 in g.core.config.recharge_info.ipairs() do
		if iter_39_1.app_id == tostring(var_39_0) and arg_39_1 == iter_39_1.recharge_type and arg_39_2 == iter_39_1.money and (arg_39_3 and arg_39_3 == 1 or nil) and iter_39_1.special == 1 then
			return self:getRechargeInfoById(iter_39_1.id)
		end
	end
end

function RechargeData:_addPriceStr(arg_40_1, arg_40_2)
	local var_40_0 = ""
	local var_40_1 = 0
	local var_40_2 = 1

	if string.sub(arg_40_2, 1, 1) == "-" then
		var_40_2 = -1
		arg_40_2 = string.sub(arg_40_2, 2, #arg_40_2)
	end

	local var_40_3 = #arg_40_2
	local var_40_4 = #arg_40_1

	for iter_40_0 = 0, #arg_40_1 - 1 do
		local var_40_5 = string.sub(arg_40_1, var_40_4 - iter_40_0, var_40_4 - iter_40_0)
		local var_40_6 = tonumber(var_40_5)
		local var_40_7 = tonumber((string.sub(arg_40_2, var_40_3, var_40_3)))

		if var_40_6 and var_40_3 > 0 or var_40_6 == nil and var_40_7 == nil then
			if var_40_7 then
				var_40_5, var_40_1 = self:_oneNumAdd(var_40_6 + var_40_1, var_40_2 * var_40_7, iter_40_0 == var_40_4 - 1)
			end

			var_40_3 = var_40_3 - 1
		elseif var_40_6 and var_40_1 ~= 0 then
			var_40_5, var_40_1 = self:_oneNumAdd(var_40_6, var_40_1, iter_40_0 == var_40_4 - 1)
		end

		var_40_0 = var_40_5 .. var_40_0
	end

	for iter_40_1 = var_40_3, 1, -1 do
		local var_40_8 = string.sub(arg_40_2, iter_40_1, iter_40_1)
		local var_40_9 = tonumber(var_40_8)

		if var_40_9 then
			var_40_8, var_40_1 = self:_oneNumAdd(var_40_2 * var_40_9, var_40_1, iter_40_1 == 1)
		end

		var_40_0 = var_40_8 .. var_40_0
	end

	if var_40_1 ~= 0 then
		var_40_0 = var_40_1 .. var_40_0
	end

	return var_40_0
end

function RechargeData:_oneNumAdd(arg_41_1, arg_41_2, arg_41_3)
	local var_41_0 = 0
	local var_41_1 = arg_41_1 + arg_41_2

	if arg_41_1 + arg_41_2 >= 10 then
		var_41_0 = 1
		var_41_1 = var_41_1 % 10
	elseif var_41_1 < 0 then
		var_41_0 = -1
		var_41_1 = var_41_1 + 10
	end

	var_41_1 = arg_41_3 and var_41_1 == 0 and var_41_0 == 0 and "" or tostring(var_41_1)

	return var_41_1, var_41_0
end

function RechargeData:_mulPriceStr(arg_42_1, arg_42_2, arg_42_3)
	local var_42_0 = 0
	local var_42_2 = 0

	if arg_42_3 then
		var_42_2 = -2
	end

	local var_42_3 = math.max(arg_42_2 - 1, 1 - arg_42_2)

	for iter_42_0 = #arg_42_1, 1, -1 do
		local var_42_4 = tonumber((string.sub(arg_42_1, iter_42_0, iter_42_0)))

		if var_42_4 then
			var_42_0 = var_42_0 + var_42_4 * var_42_3 * math.pow(10, var_42_2)
			var_42_2 = var_42_2 + 1
		end
	end

	local var_42_5 = tostring(var_42_0)

	if arg_42_3 then
		var_42_5 = string.format("%.2f", var_42_0)
	elseif var_42_0 % 1 ~= 0 then
		var_42_5 = string.format("%.2f", var_42_0)
		arg_42_1 = arg_42_1 .. ".00"
	end

	return arg_42_2 > 1 and self:_addPriceStr(arg_42_1, var_42_5) or self:_addPriceStr(arg_42_1, "-" .. var_42_5)
end

function RechargeData:_checkPriceStr(arg_43_1, arg_43_2)
	local var_43_0 = false
	local var_43_1 = tostring((math.floor(arg_43_2 / 1000000)))
	local var_43_2 = 1
	local var_43_3 = 1
	local var_43_4 = var_43_1:sub(1, 1)

	for iter_43_0 = 1, #arg_43_1 do
		if arg_43_1:sub(iter_43_0, iter_43_0) == var_43_4 then
			var_43_3 = iter_43_0
			var_43_2 = var_43_2 + 1

			if var_43_2 <= #var_43_1 then
				var_43_4 = var_43_1:sub(var_43_2, var_43_2)
			else
				break
			end
		end
	end

	for iter_43_1 = var_43_3 + 1, #arg_43_1 do
		if tonumber((arg_43_1:sub(iter_43_1, iter_43_1))) ~= nil then
			var_43_0 = true

			break
		end
	end

	return var_43_0
end

function RechargeData:safeCalPriceString(arg_44_1, arg_44_2, arg_44_3)
	local var_44_0 = self:getRechargeInfoById(arg_44_1)
	local var_44_1 = tostring(var_44_0.realMoney)
	local var_44_2 = tostring(arg_44_2)
	local var_44_3 = self:_checkPriceStr(var_44_1, var_44_0.realMoneyMicros)

	if var_44_3 then
		var_44_2 = string.format("%.2f", arg_44_2)
	elseif arg_44_2 % 1 ~= 0 then
		var_44_2 = string.format("%.2f", arg_44_2)
		var_44_1 = var_44_1 .. ".00"
	end

	local var_44_4 = "0"

	if arg_44_3 == "+" then
		var_44_4 = self:_addPriceStr(var_44_1, var_44_2)
	elseif arg_44_3 == "-" then
		var_44_4 = self:_addPriceStr(var_44_1, "-" .. var_44_2)
	elseif arg_44_3 == "*" then
		var_44_4 = self:_mulPriceStr(tostring(var_44_0.realMoney), arg_44_2, var_44_3)
	end

	print("ret is ------------------------->")
	print(var_44_4)

	return var_44_4
end

function RechargeData:isGMDoubleRechargeOpen()
	if self._GMdoubleRechargeActivityId == 0 then
		return false
	end

	if self._GMdoubleRechargeLevelMin ~= self._GMdoubleRechargeLevelMax then
		local var_45_0 = g.core.model.User:getLevel()

		if var_45_0 < self._GMdoubleRechargeLevelMin or var_45_0 > self._GMdoubleRechargeLevelMax then
			return false
		end
	end

	local var_45_1 = g.core.common.ServerTime

	if g.core.common.ServerTime:getOpenDays() < self._GMdoubleRechargeOpenDay then
		return false
	end

	local var_45_2 = var_45_1:getTime()

	if var_45_2 < self._GMdoubleRechargeStartTime or var_45_2 > self._GMdoubleRechargeEndTime then
		return false
	end

	return true
end

function RechargeData:hasDoubleRechargeById(arg_46_1)
	if not self:isGMDoubleRechargeOpen() then
		return false
	end

	return (self._GMdoubleRechargeIds[self._GMdoubleRechargeActivityId] or {})[arg_46_1] == nil
end

function RechargeData:onS2CGMDoubleRechargeInfo(arg_47_1)
	if arg_47_1.info then
		self._GMdoubleRechargeActivityId = arg_47_1.info.activity_id or 0
		self._GMdoubleRechargeOpenDay = arg_47_1.info.open_days or 0
		self._GMdoubleRechargeStartTime = arg_47_1.info.start_time or 0
		self._GMdoubleRechargeEndTime = arg_47_1.info.end_time or 0
		self._GMdoubleRechargeLevelMin = arg_47_1.info.start_level or 0
		self._GMdoubleRechargeLevelMax = arg_47_1.info.end_level or 0
	end

	if (arg_47_1.delete or 0) == self._GMdoubleRechargeActivityId then
		self._GMdoubleRechargeActivityId = 0
		self._GMdoubleRechargeOpenDay = 0
		self._GMdoubleRechargeStartTime = 0
		self._GMdoubleRechargeEndTime = 0
		self._GMdoubleRechargeLevelMin = 0
		self._GMdoubleRechargeLevelMax = 0
	end
end

function RechargeData:onS2CGMDoubleRechargeIds(arg_48_1)
	if arg_48_1.activity_id and arg_48_1.activity_id > 0 then
		local var_48_1 = {}

		for iter_48_0, iter_48_1 in pairs(arg_48_1.ids or {}) do
			var_48_1[iter_48_1] = true
		end

		self._GMdoubleRechargeIds[arg_48_1.activity_id] = var_48_1
	end
end

function RechargeData:onS2CGMDoubleRechargeIdsOP(arg_49_1)
	if arg_49_1.insert then
		if arg_49_1.insert.activity_id and arg_49_1.insert.activity_id > 0 then
			local var_49_1 = self._GMdoubleRechargeIds[arg_49_1.insert.activity_id] or {}

			for iter_49_0, iter_49_1 in pairs(arg_49_1.insert.ids or {}) do
				var_49_1[iter_49_1] = true
			end

			self._GMdoubleRechargeIds[arg_49_1.insert.activity_id] = var_49_1
		end
	end
end

function RechargeData:onS2CReturnPayGetInfo(arg_50_1)
	self._returnPayAmount = arg_50_1.recharge_amount or 0
	self._returnPayGetTime = arg_50_1.award_time or 0
end

function RechargeData:onS2CReturnPayGetAward(arg_51_1)
	self._returnPayGetTime = arg_51_1.award_time and arg_51_1.award_time or g.core.common.ServerTime:getTime()
end

function RechargeData:getReturnPayRechargeNum()
	return self._returnPayAmount
end

function RechargeData:getReturnPayNum()
	local var_53_0 = var_0_0.RETURN_PAY

	return math.ceil(self._returnPayAmount > var_0_0.RETURN_PAY.NUM and var_53_0.NUM * var_53_0.VAL1 + (self._returnPayAmount - var_53_0.NUM) * var_53_0.VAL2 or self._returnPayAmount * var_53_0.VAL1) * var_53_0.SCALE
end

function RechargeData:hasReturnPayAward()
	if self._returnPayAmount > 0 then
		return self._returnPayGetTime == 0
	else
		return false
	end
end

function RechargeData:isShowReturnPay()
	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.RETURN_PAY) then
		return false
	end

	return self:hasReturnPayAward()
end

return RechargeData
