local var_0_0 = g.core.config.homeland_train_base_info
local var_0_1 = g.core.config.homeland_train_product_info
local var_0_2 = g.core.common.ModuleUnlock
local var_0_3 = g.core.const.ConstMgr
local HLTrainConst = require("app.view.module.homeLandTrain.const.HLTrainConst")
local var_0_5 = g.core.model.User
local HLTrainRoomStruct = import(".HLTrainRoomStruct")
local HLTrainData = class("HLTrainData", require("app.core.model.BaseData"))

function HLTrainData:ctor()
	self:initData()
end

function HLTrainData:initData()
	self.super.ctor(self)

	if ({
		[g.core.const.ConstMgr.PlatformConst.REGION.SEA] = true,
		[g.core.const.ConstMgr.PlatformConst.REGION.JAPAN] = true,
		[g.core.const.ConstMgr.PlatformConst.REGION.TW] = true
	})[config.PUBLISH_REGION] then
		HLTrainConst.NEED_BLOCK = false
	end

	self._roomStructDict = {}
	self._dispatchedKnightIdDict = {}
	self._roomAdvIdArr = table.keys((var_0_0.get_index_data()))

	table.sort(self._roomAdvIdArr, function(arg_3_0, arg_3_1)
		return var_0_0.get(arg_3_0).sign < var_0_0.get(arg_3_1).sign
	end)
end

function HLTrainData:checkExpired(arg_4_1)
	return g.core.common.ServerTime:getTime() - arg_4_1 >= HLTrainConst.DATA_EXPIRED_INTERVAL
end

function HLTrainData:onS2CFlushRedPoint(arg_5_1)
	if arg_5_1.hand_land_hint then
		self:_initData(arg_5_1.hand_lands)
	end
end

function HLTrainData:onS2CHomeLandTrainGetInfo(arg_6_1)
	self:_initData(arg_6_1.hand_lands)
end

function HLTrainData:onS2CHomeLandTrainUpLevel(arg_7_1)
	self:setRoomStructSvrData(arg_7_1.home_land)
	self:_updateDispatchedKnight()
end

function HLTrainData:onS2CHomeLandTrainProduct(arg_8_1)
	self:getRoomStruct(arg_8_1.product.adv_id):setProductId(arg_8_1.product.product)
end

function HLTrainData:onS2CHomeLandTrainDispatch(arg_9_1)
	if arg_9_1.dispatch then
		for iter_9_0, iter_9_1 in pairs(arg_9_1.dispatch) do
			self:getRoomStruct(iter_9_1.adv_id):setDispatchedKnights(iter_9_1.knight_ids)
		end

		self:_updateDispatchedKnight()
	end
end

function HLTrainData:onS2CDispatchAward(arg_10_1)
	if not arg_10_1.adv_id then
		return
	end

	self:_initData(arg_10_1.hand_lands)
end

function HLTrainData:onS2CFurnitureRoomPlaceKnight(arg_11_1)
	if not arg_11_1.knight_id then
		return
	end

	for iter_11_0, iter_11_1 in ipairs(arg_11_1.knight_id) do
		if iter_11_1.knight_id then
			for iter_11_2, iter_11_3 in ipairs(iter_11_1.knight_id) do
				if self._dispatchedKnightIdDict[iter_11_3] then
					self:getRoomStruct(self._dispatchedKnightIdDict[iter_11_3]):removeKnightId(iter_11_3)
				end
			end
		end
	end

	self:_updateDispatchedKnight()
end

function HLTrainData:reqGetAllRoomsAward()
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in pairs(self._roomStructDict) do
		if iter_12_1:isExistAward() then
			table.insert(var_12_0, iter_12_1.advanceId)
		end
	end

	if #var_12_0 < 1 then
		g.core.module.ModuleManager:tip(g.core.lang:get(111011))
	else
		g.core.network.GameNetProxy:send_C2S_HomeLandTrain_DispatchAward({
			adv_id = var_12_0
		})
	end
end

function HLTrainData:reqGetRoomAward(arg_13_1)
	if self:getRoomStruct(arg_13_1).productNum < 1 then
		g.core.module.ModuleManager:tip(g.core.lang:get(111011))

		return
	end

	g.core.network.GameNetProxy:send_C2S_HomeLandTrain_DispatchAward({
		adv_id = {
			arg_13_1
		}
	})
end

function HLTrainData:_initData(arg_14_1)
	if not arg_14_1 then
		return
	end

	for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
		self:setRoomStructSvrData(iter_14_1)
	end

	self:_updateDispatchedKnight()
end

function HLTrainData:_updateDispatchedKnight()
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in pairs(self._roomStructDict) do
		if iter_15_1:isUnlocked() then
			for iter_15_2, iter_15_3 in pairs(iter_15_1.knightIdArr) do
				var_15_0[iter_15_3] = iter_15_0
			end
		end
	end

	self._dispatchedKnightIdDict = var_15_0
end

function HLTrainData:getRoomStruct(arg_16_1)
	self._roomStructDict[arg_16_1] = self._roomStructDict[arg_16_1] or HLTrainRoomStruct.new(arg_16_1)

	return self._roomStructDict[arg_16_1]
end

function HLTrainData:setRoomStructSvrData(arg_17_1)
	self:getRoomStruct(arg_17_1.adv_id):setServerData(arg_17_1)
end

function HLTrainData:isRoomUnlocked(arg_18_1)
	return self:getRoomStruct(arg_18_1):isUnlocked()
end

function HLTrainData:isChangeDispatchKnights(arg_19_1, arg_19_2)
	if not arg_19_1 then
		return false
	end

	local var_19_0 = self:getRoomStruct(arg_19_1).knightIdArr

	if arg_19_2 then
		local var_19_1 = #arg_19_2 or 0

		if #var_19_0 ~= var_19_1 then
			return true
		elseif var_19_1 == 0 then
			return false
		elseif var_19_1 == 1 then
			return var_19_0[1] ~= arg_19_2[1]
		end
	end

	do
		local var_19_2 = " "
		local var_19_3 = clone(var_19_0)

		table.sort(var_19_3)

		local var_19_4 = table.concat(var_19_3, var_19_2)
		local var_19_5 = clone(arg_19_2)

		table.sort(var_19_5)

		return var_19_4 ~= table.concat(var_19_5, var_19_2)
	end
end

function HLTrainData:getAllRoomAdvIds()
	return self._roomAdvIdArr
end

function HLTrainData:getDispatchedKnightIdMap()
	return self._dispatchedKnightIdDict
end

function HLTrainData:getDispatchedAdvanceId(arg_22_1)
	return self._dispatchedKnightIdDict[arg_22_1]
end

function HLTrainData:getDispatchedKnightIdKeyAdvIdMap()
	local var_23_0 = {}

	for iter_23_0, iter_23_1 in pairs(self._roomStructDict) do
		if iter_23_1:isUnlocked() then
			var_23_0[iter_23_0] = iter_23_1.knightIdArr
		end
	end

	return var_23_0
end

function HLTrainData:getUnlockedRoomStructArr()
	local var_24_0 = {}

	for iter_24_0, iter_24_1 in pairs(self._roomStructDict) do
		if iter_24_1:isUnlocked() then
			table.insert(var_24_0, iter_24_1)
		end
	end

	return var_24_0
end

function HLTrainData:isCanLevelUpWithCustomData(arg_25_1)
	return self:isCanLevelUp(arg_25_1.advId)
end

function HLTrainData:isCanLevelUp(arg_26_1)
	return self:getRoomStruct(arg_26_1):isCanLevelUp()
end

function HLTrainData:isKnightDispatched(arg_27_1)
	return checkbool(self._dispatchedKnightIdDict[arg_27_1])
end

function HLTrainData:isExistDispatchedKnight()
	return checkbool((next(self._dispatchedKnightIdDict)))
end

function HLTrainData:getAppearProductInfoArr(arg_29_1, arg_29_2)
	return var_0_1.match(function(arg_30_0)
		if arg_30_0.advance_id == arg_29_1 then
			return arg_29_2 < arg_30_0.block_level
		end
	end)
end

function HLTrainData:isRoomCanUnlock(arg_31_1)
	if HLTrainConst.NEED_BLOCK and HLTrainConst.BLOCK_ADVANCE_ID[arg_31_1] then
		return false
	end

	local var_31_0 = self:getRoomStruct(arg_31_1)

	if var_31_0:isUnlocked() then
		return false
	elseif var_31_0.refCfgBaseInfo.unlock_type == 0 then
		return true
	else
		local var_31_1 = var_31_0.refCfgBaseInfo
		local var_31_2 = self:getUnlockedRoomStructArr()

		if #var_31_2 < var_31_0.refCfgBaseInfo.unlock_value_1 then
			return false
		else
			local var_31_3 = var_31_1.unlock_value_2
			local var_31_4 = 0

			for iter_31_0, iter_31_1 in ipairs(var_31_2) do
				if var_31_3 <= iter_31_1.curLevel then
					var_31_4 = var_31_4 + 1
				end
			end

			return var_31_4 >= var_31_1.unlock_value_1
		end
	end
end

function HLTrainData:isEnoughResToUnlockRoom(arg_32_1)
	local var_32_0 = self:getRoomStruct(arg_32_1).refCfgBaseInfo

	return var_0_5.bagData:getOwnNum(var_32_0.unlock_consume_type, var_32_0.unlock_consume_value) >= var_32_0.unlock_consume_size
end

function HLTrainData:isRoomCanUnlockWithCustomData(arg_33_1)
	local function var_33_0(arg_34_0)
		if self:isRoomCanUnlock(arg_34_0) then
			return self:isEnoughResToUnlockRoom(arg_34_0)
		end

		return false
	end

	for iter_33_0, iter_33_1 in ipairs(arg_33_1.advId and {
		arg_33_1.advId
	} or self._roomAdvIdArr) do
		if var_33_0(iter_33_1) then
			return true
		end
	end

	return false
end

function HLTrainData:isExistAward()
	for iter_35_0, iter_35_1 in pairs(self._roomStructDict) do
		if iter_35_1:isExistAward() then
			return true
		end
	end

	return false
end

function HLTrainData:getCanLevelUpRoomNum()
	local var_36_0 = 0

	for iter_36_0, iter_36_1 in ipairs((self:getUnlockedRoomStructArr())) do
		if iter_36_1:isCanLevelUp() then
			var_36_0 = var_36_0 + 1
		end
	end

	return var_36_0
end

function HLTrainData:getMobilityBaseCostPerHourWithKnightId(arg_37_1)
	if self._dispatchedKnightIdDict[arg_37_1] then
		return self:getRoomStruct(self._dispatchedKnightIdDict[arg_37_1]):getMobilityBaseCostPerHour()
	else
		return 0
	end
end

function HLTrainData:getMobilityCostReductionPerHour()
	return 0
end

function HLTrainData:getBaseProductionPerHour(arg_39_1)
	local var_39_0 = var_0_1.get(arg_39_1)

	return math.ceil(3600 * var_39_0.product_size / var_39_0.product_time * 10) / 10
end

function HLTrainData:getAddProductionPerHour(arg_40_1, arg_40_2)
	return math.ceil(self:getBaseProductionPerHour(arg_40_1) * self:getHomeLandTalent(arg_40_2) * 10) / 10
end

function HLTrainData:getTimeRemaining(arg_41_1, arg_41_2, arg_41_3)
	local var_41_0 = var_0_1.get(arg_41_1)

	if var_41_0.product_storage - arg_41_2 <= 0 then
		return 0
	else
		return (math.ceil((var_41_0.product_storage - arg_41_2) / (var_41_0.product_size / var_41_0.product_time * (1 + self:getHomeLandTalent(arg_41_3)))))
	end
end

function HLTrainData:getHomeLandTalent(arg_42_1)
	local var_42_0 = 0

	for iter_42_0, iter_42_1 in ipairs(arg_42_1) do
		var_42_0 = var_42_0 + var_0_5.knightsData:getKnightById(iter_42_1):getHomeLandTalent()
	end

	return var_42_0 / 1000
end

function HLTrainData:isRoomWorking(arg_43_1)
	return self:getRoomStruct(arg_43_1):isWorking()
end

function HLTrainData:isThereCanWorkRoomWithCustomData(arg_44_1)
	if not var_0_2:isModuleUnlock(var_0_3.FUNCTION_TYPE.HOME_LAND_TRAIN) then
		return false
	end

	for iter_44_0, iter_44_1 in ipairs(arg_44_1.advId and {
		arg_44_1.advId
	} or self._roomAdvIdArr) do
		if self:isRoomUnlocked(iter_44_1) and not self:isRoomWorking(iter_44_1) then
			return true
		end
	end
end

function HLTrainData:getCanWorkRoomNum()
	if not var_0_2:isModuleUnlock(var_0_3.FUNCTION_TYPE.HOME_LAND_TRAIN) then
		return 0
	end

	local var_45_0 = 0

	for iter_45_0, iter_45_1 in ipairs(self._roomAdvIdArr) do
		if self:isRoomUnlocked(iter_45_1) and not self:isRoomWorking(iter_45_1) then
			var_45_0 = var_45_0 + 1
		end
	end

	return var_45_0
end

function HLTrainData:isThereRoomProduct40PercentWithCustomData(arg_46_1)
	if not var_0_2:isModuleUnlock(var_0_3.FUNCTION_TYPE.HOME_LAND_TRAIN) then
		return false
	end

	for iter_46_0, iter_46_1 in ipairs(arg_46_1 and arg_46_1.advId and {
		arg_46_1.advId
	} or self._roomAdvIdArr) do
		if self:getRoomStruct(iter_46_1):isProductToPercentage(40) then
			return true
		end
	end
end

function HLTrainData:getRoomNumProduct40Percent()
	if not var_0_2:isModuleUnlock(var_0_3.FUNCTION_TYPE.HOME_LAND_TRAIN) then
		return 0
	end

	local var_47_0 = 0

	for iter_47_0, iter_47_1 in ipairs(self._roomAdvIdArr) do
		if self:getRoomStruct(iter_47_1):isProductToPercentage(40) then
			var_47_0 = var_47_0 + 1
		end
	end

	return var_47_0
end

return HLTrainData
