local var_0_0 = g.core.config.homeland_train_info
local var_0_1 = g.core.config.homeland_train_base_info
local var_0_2 = g.core.config.homeland_train_product_info
local HLTrainConst = require("app.view.module.homeLandTrain.const.HLTrainConst")
local var_0_4 = HLTrainConst.ROOM_LEVEL_UP_COND_TYPE
local var_0_5 = HLTrainConst.DISPATCH_PLACE_STATE
local var_0_6 = g.core.model.User
local HLTrainRoomStruct = class("HLTrainRoomStruct")

function HLTrainRoomStruct:ctor(arg_1_1)
	self.advanceId = arg_1_1
	self.curLevel = 1
	self.productId = 0
	self.knightIdArr = {}
	self.totalTrainTime = 0
	self.productNum = 0
	self.isLuck = false
	self._unlocked = false
	self.uuId = self:calcUUID(arg_1_1, self.curLevel)
	self.refCfgInfo = var_0_0.get(self.uuId)
	self.refCfgBaseInfo = var_0_1.get(arg_1_1)
end

function HLTrainRoomStruct:setServerData(arg_2_1)
	self.curLevel = arg_2_1.level or 1
	self.curLevel = math.max(1, self.curLevel)
	self.productId = arg_2_1.product or 0

	self:setDispatchedKnights(arg_2_1.knight_ids)

	self.totalTrainTime = arg_2_1.work_time or 0
	self.productNum = arg_2_1.product_num or 0
	self.isLuck = arg_2_1.is_luck or false
	self.progress = arg_2_1.progress or 0
	self._unlocked = true
	self.uuId = self:calcUUID(self.advanceId, self.curLevel)
	self.refCfgInfo = var_0_0.get(self.uuId)
end

function HLTrainRoomStruct:calcUUID(arg_3_1, arg_3_2)
	return arg_3_1 * 100 + arg_3_2
end

function HLTrainRoomStruct:setDispatchedKnights(arg_4_1)
	if arg_4_1 then
		local var_4_0 = {}

		for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
			if iter_4_1 > 0 then
				table.insert(var_4_0, iter_4_1)
			end
		end

		self.knightIdArr = var_4_0
	else
		self.knightIdArr = {}
	end
end

function HLTrainRoomStruct:removeKnightId(arg_5_1)
	if not arg_5_1 or arg_5_1 == 0 then
		return
	end

	table.removebyvalue(self.knightIdArr, arg_5_1, false)
end

function HLTrainRoomStruct:setProductId(arg_6_1)
	self.productId = arg_6_1 or 0
end

function HLTrainRoomStruct:isUnlocked()
	if HLTrainConst.NEED_BLOCK and HLTrainConst.BLOCK_ADVANCE_ID[self.advanceId] then
		return false
	end

	return self._unlocked
end

function HLTrainRoomStruct:isExistAward()
	return self.productNum > 0
end

function HLTrainRoomStruct:isCanLevelUp()
	if not self:isUnlocked() then
		return false
	elseif self.refCfgInfo.next_level == 0 then
		return false
	else
		return self:isEnoughItemLevelUpNeed() and self:isLevelUpConditionsOK()
	end

	return false
end

function HLTrainRoomStruct:isLevelUpConditionsOK()
	while var_0_0.hasKey("up_type_" .. 1) do
		if not self:_isReachLevelUpCondWithTV(self.refCfgInfo["up_type_" .. 1], self.refCfgInfo["up_value_" .. 1]) then
			return false
		end
	end

	return true
end

function HLTrainRoomStruct:_isReachLevelUpCondWithTV(arg_11_1, arg_11_2)
	if arg_11_1 == var_0_4.NONE then
		return true, arg_11_2
	elseif arg_11_1 == var_0_4.TRAIN_TIME then
		return arg_11_2 <= self.totalTrainTime / 3600, math.floor(self.totalTrainTime / 3600)
	elseif arg_11_1 == var_0_4.KNIGHT_NUM then
		local var_11_0 = #var_0_6.knightsData:getOwnerAllList()

		return arg_11_2 <= var_11_0, var_11_0
	elseif arg_11_1 == var_0_4.CHAPTER then
		local var_11_1 = var_0_6.dungeonData:getLastPassedChapter()

		return arg_11_2 <= var_11_1, var_11_1
	elseif arg_11_1 == var_0_4.UNLOCK_ROOM then
		local var_11_2 = var_0_6.hlTrainData:isRoomUnlocked(arg_11_2)

		return var_11_2, var_11_2 and 1 or 0
	else
		return false, 0
	end
end

function HLTrainRoomStruct:isEnoughItemLevelUpNeed()
	if self.refCfgInfo.cost_type == 0 then
		return true
	else
		return var_0_6.bagData:getCountById(self.refCfgInfo.cost_type, self.refCfgInfo.cost_value) >= self.refCfgInfo.cost_size
	end
end

function HLTrainRoomStruct:getLevelUpCondInfoArr()
	local var_13_0 = {}
	local var_13_1 = 1

	while var_0_0.hasKey("up_type_" .. var_13_1) do
		local var_13_2, var_13_3 = self:_isReachLevelUpCondWithTV(self.refCfgInfo["up_type_" .. var_13_1], self.refCfgInfo["up_value_" .. var_13_1])
		local var_13_4 = {
			desc = "",
			curProgress = var_13_3,
			maxProgress = self.refCfgInfo["up_value_" .. var_13_1]
		}

		if self.refCfgInfo["up_type_" .. var_13_1] == var_0_4.TRAIN_TIME then
			var_13_4.desc = g.core.lang:get(111001, {
				total = self.refCfgInfo["up_value_" .. var_13_1]
			})

			table.insert(var_13_0, var_13_4)
		elseif self.refCfgInfo["up_type_" .. var_13_1] == var_0_4.KNIGHT_NUM then
			var_13_4.desc = g.core.lang:get(111002, {
				num = self.refCfgInfo["up_value_" .. var_13_1]
			})

			table.insert(var_13_0, var_13_4)
		elseif self.refCfgInfo["up_type_" .. var_13_1] == var_0_4.CHAPTER then
			var_13_4.desc = g.core.lang:get(111042, {
				num = self.refCfgInfo["up_value_" .. var_13_1]
			})

			table.insert(var_13_0, var_13_4)
		elseif self.refCfgInfo["up_type_" .. var_13_1] == var_0_4.UNLOCK_ROOM then
			var_13_4.desc = g.core.lang:get(111043, {
				name = var_0_1.get(self.refCfgInfo["up_value_" .. var_13_1]).name
			})
			var_13_4.maxProgress = 1

			table.insert(var_13_0, var_13_4)
		end

		var_13_1 = var_13_1 + 1
	end

	return var_13_0
end

function HLTrainRoomStruct:getDispatchPlaceUnlockLv(arg_14_1)
	for iter_14_0, iter_14_1 in var_0_0.ipairs() do
		if iter_14_1.advance_id == self.advanceId and iter_14_1.limit_dispatch == arg_14_1 then
			return iter_14_1.level
		end
	end

	return 0
end

function HLTrainRoomStruct:getDispatchPlaceLimit(arg_15_1)
	if arg_15_1 then
		for iter_15_0, iter_15_1 in var_0_0.ipairs() do
			if iter_15_1.advance_id == self.advanceId and iter_15_1.level == arg_15_1 then
				return iter_15_1.limit_dispatch
			end
		end
	else
		return self.refCfgInfo.limit_dispatch
	end
end

function HLTrainRoomStruct:getMobilityBaseCostPerHour()
	if self.productId == 0 then
		return 0
	else
		return math.ceil(3600 * self.refCfgInfo.cost_mobility / self.refCfgInfo.cost_mobility_time)
	end
end

function HLTrainRoomStruct:isWorking()
	if self.productId == 0 then
		return false
	elseif #self.knightIdArr == 0 then
		return false
	else
		for iter_17_0, iter_17_1 in ipairs(self.knightIdArr) do
			if var_0_6.knightsData:getKnightById(iter_17_1):getMobilityVal() > 0 then
				return true
			end
		end

		return false
	end
end

function HLTrainRoomStruct:isProductToPercentage(arg_18_1)
	if self.productId == 0 then
		return false
	end

	arg_18_1 = arg_18_1 or 0
	arg_18_1 = math.min(100, arg_18_1)
	arg_18_1 = math.max(0, arg_18_1)

	if arg_18_1 == 0 then
		return false
	else
		arg_18_1 = arg_18_1 / 100

		return arg_18_1 <= self.productNum / var_0_2.get(self.productId).product_storage
	end
end

function HLTrainRoomStruct:getDispatchPlaceState(arg_19_1)
	if not self:isUnlocked() then
		return var_0_5.LOCK
	elseif arg_19_1 > self.refCfgInfo.limit_dispatch then
		return var_0_5.LOCK
	elseif arg_19_1 > #self.knightIdArr then
		return var_0_5.IDLE
	elseif var_0_6.knightsData:getKnightById(self.knightIdArr[arg_19_1]):getMobilityVal() == 0 then
		return var_0_5.MOBILITY_NULL
	else
		return var_0_5.WORKING
	end
end

function HLTrainRoomStruct:getKnightArr()
	return self.knightIdArr
end

function HLTrainRoomStruct:getBaseInfo()
	return self.refCfgBaseInfo
end

return HLTrainRoomStruct
