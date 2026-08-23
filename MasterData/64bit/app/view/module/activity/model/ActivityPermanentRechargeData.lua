local var_0_1 = g.core.config.recharge_rebate_info
local var_0_2 = g.core.config.recharge_rebate_gift_info
local var_0_3 = g.core.model.User.resourceData
local var_0_4 = g.core.common.Goods
local var_0_5 = g.core.common.Drops
local ActivityPermanentRechargeData = class("ActivityPermanentRechargeData")
local var_0_7 = {
	NOT_FINISH = 0,
	HAS_DRAW = 2,
	CAN_DRAW = 1
}

function ActivityPermanentRechargeData:ctor()
	self:initData()
end

function ActivityPermanentRechargeData:initData()
	self._preId = nil
	self._activityId = 1
	self._skinIndex = 0
	self._firstId = 0
	self._lastId = 0
	self._nextGiftStartTime = 0
	self._giftGroup = 0

	self:_initRechargeRebateInfo()
	self:_initGiftGroup()
end

function ActivityPermanentRechargeData:_initRechargeRebateInfo()
	self._rechargeRebateInfo = {}
	self._rechargeRebateAwardData = {}

	for iter_3_0, iter_3_1 in var_0_1.ipairs() do
		table.insert(self._rechargeRebateInfo, iter_3_1)

		local var_3_0 = {}

		while var_0_1.hasKey("type_" .. 1) do
			local var_3_1 = var_0_4:convert({
				type = iter_3_1["type_" .. 1],
				value = iter_3_1["value_" .. 1],
				size = iter_3_1["size_" .. 1]
			})

			if var_3_1.type == var_0_4.TYPE_SKIN then
				self._skinIndex = iter_3_0
			end

			table.insert(var_3_0, var_3_1)
		end

		table.insert(self._rechargeRebateAwardData, {
			newAwardState = false,
			isReceive = false,
			awards = var_3_0,
			info = iter_3_1
		})
	end

	self._firstId = 1
	self._lastId = #self._rechargeRebateAwardData
end

function ActivityPermanentRechargeData:getFrontAndRearId()
	return self._firstId, self._lastId
end

function ActivityPermanentRechargeData:getSkinIndex()
	return self._skinIndex
end

function ActivityPermanentRechargeData:getAwardList()
	return self._rechargeRebateAwardData or {}
end

function ActivityPermanentRechargeData:getAwardDataById(arg_7_1)
	return self._rechargeRebateAwardData[arg_7_1] or {}
end

function ActivityPermanentRechargeData:_initGiftGroup()
	self._giftDataDict = {}

	for iter_8_0, iter_8_1 in var_0_2.ipairs() do
		local var_8_0

		if not self._giftDataDict[iter_8_1.gift_group] then
			self._giftDataDict[iter_8_1.gift_group] = {}
			var_8_0 = {
				hasBuy = false
			}
		end

		var_8_0.giftList = var_0_5:getGoodsArray(iter_8_1.value)
		var_8_0.info = iter_8_1

		table.insert(self._giftDataDict[iter_8_1.gift_group], var_8_0)
	end
end

function ActivityPermanentRechargeData:getGiftList()
	return self._giftDataDict[self._giftGroup] or {}
end

function ActivityPermanentRechargeData:getGiftDataById(arg_10_1)
	return self._giftDataDict[self._giftGroup][arg_10_1] or {}
end

function ActivityPermanentRechargeData:getCurrentRechargeRebateId()
	local var_11_0 = 0

	for iter_11_0, iter_11_1 in ipairs((self:getAwardList())) do
		if iter_11_1.isReceive then
			var_11_0 = iter_11_0
		end
	end

	return var_11_0 + 1
end

function ActivityPermanentRechargeData:getOwnLightSize()
	return (var_0_3:getResourceById(g.core.common.Goods.RESOURCE.TYPE_LIGHT))
end

function ActivityPermanentRechargeData:getNeedLightSizeById(arg_13_1)
	return self._rechargeRebateAwardData[arg_13_1].info.size
end

function ActivityPermanentRechargeData:getAmountOwnAndNeedSize()
	local var_14_0 = self:getOwnLightSize()
	local var_14_1 = 0

	for iter_14_0 = 1, self:getLastUnlockId() do
		if self._rechargeRebateAwardData[iter_14_0].isReceive then
			var_14_0 = var_14_0 + self._rechargeRebateAwardData[iter_14_0].info.size
		end

		var_14_1 = var_14_1 + self._rechargeRebateAwardData[iter_14_0].info.size
	end

	return var_14_0, var_14_1
end

function ActivityPermanentRechargeData:getActivityId()
	return self._activityId or 0
end

function ActivityPermanentRechargeData:getLastUnlockId()
	local var_16_0 = self:getOwnLightSize()
	local var_16_1 = 0

	for iter_16_0, iter_16_1 in ipairs(self._rechargeRebateAwardData) do
		var_16_1 = var_16_1 + iter_16_1.info.size

		if iter_16_1.isReceive then
			var_16_0 = var_16_0 + iter_16_1.info.size
		end

		if var_16_0 < var_16_1 then
			return iter_16_1.info.id
		end
	end

	return #self._rechargeRebateAwardData
end

function ActivityPermanentRechargeData:getFirstNotReceiveId()
	for iter_17_0, iter_17_1 in ipairs(self._rechargeRebateAwardData) do
		if not iter_17_1.isReceive or iter_17_1.newAwardState then
			return iter_17_0
		end
	end

	return self:getLastUnlockId()
end

function ActivityPermanentRechargeData:getLastNeedRechargeNum()
	local var_18_0 = 0
	local var_18_1 = self:getOwnLightSize()

	for iter_18_0 = 1, self:getLastUnlockId() do
		if self._rechargeRebateAwardData[iter_18_0].isReceive then
			var_18_1 = var_18_1 + self._rechargeRebateAwardData[iter_18_0].info.size
		end

		var_18_0 = var_18_0 + self._rechargeRebateAwardData[iter_18_0].info.size
	end

	return math.max(0, var_18_0 - var_18_1)
end

function ActivityPermanentRechargeData:isAllAwardReceive()
	return self:getLastNeedRechargeNum() <= 0
end

function ActivityPermanentRechargeData:onRcvRechargeRebateInfo(arg_20_1)
	if arg_20_1 then
		if arg_20_1.info then
			self._activityId = arg_20_1.info.activity_id
			self._giftGroup = arg_20_1.info.gift_group
			self._startTime = arg_20_1.info.start_time
		end

		self._nextGiftStartTime = arg_20_1.refresh_time or 0
	end
end

function ActivityPermanentRechargeData:onRcvRechargeRebateAward(arg_21_1)
	if arg_21_1 then
		local var_21_0 = self:getAwardDataById(arg_21_1.id)

		var_21_0.isReceive = true
		var_21_0.newAwardState = false
	end
end

function ActivityPermanentRechargeData:onRcvDiamondBuyGiftInfo(arg_22_1)
	if arg_22_1.id then
		self:getGiftDataById(arg_22_1.id).hasBy = true
	end
end

function ActivityPermanentRechargeData:onUpdateRechargeRebateGMInfo(arg_23_1)
	if arg_23_1 then
		if arg_23_1.info then
			self._activityId = arg_23_1.info.activity_id
			self._giftGroup = arg_23_1.info.gift_group
			self._startTime = arg_23_1.info.start_time
		end

		self._nextGiftStartTime = arg_23_1.refresh_time or 0
	end
end

function ActivityPermanentRechargeData:onRcvCashBuyGiftInfo(arg_24_1)
	if arg_24_1.update then
		for iter_24_0, iter_24_1 in ipairs(arg_24_1.update) do
			if iter_24_1.award_state then
				for iter_24_2, iter_24_3 in ipairs(iter_24_1.gifts) do
					self:_setGiftBuyTimesByGiftId(iter_24_3.id, iter_24_3.num)
				end
			end
		end
	end
end

function ActivityPermanentRechargeData:onUpdateRechargeProcess(arg_25_1)
	if arg_25_1 then
		for iter_25_0, iter_25_1 in ipairs(arg_25_1) do
			local var_25_0 = iter_25_1.id

			self._rechargeRebateAwardData[iter_25_1.id].isReceive = iter_25_1.award_state
			self._rechargeRebateAwardData[var_25_0].newAwardState = iter_25_1.new_award_state
			self._giftDataDict[self._giftGroup][var_25_0].hasBuy = iter_25_1.gifts and iter_25_1.gifts[1].num and iter_25_1.gifts[1].num > 0 or false
		end
	end
end

function ActivityPermanentRechargeData:onRcvBuyGift(arg_26_1)
	if arg_26_1 then
		self:getGiftDataById(arg_26_1.id).hasBuy = true
	end
end

function ActivityPermanentRechargeData:isLightEnough(arg_27_1)
	return self:getOwnLightSize() >= self:getNeedLightSizeById(arg_27_1)
end

function ActivityPermanentRechargeData:leftHasGift(arg_28_1)
	if not self:isShowEntrance() then
		return false
	end

	local var_28_0 = self:getLastUnlockId()

	for iter_28_0 = 1, arg_28_1 - 1 do
		if iter_28_0 < var_28_0 then
			if not self._rechargeRebateAwardData[iter_28_0].isReceive then
				return true
			end

			if self._rechargeRebateAwardData[iter_28_0].newAwardState then
				return true
			end
		else
			return false
		end
	end

	return false
end

function ActivityPermanentRechargeData:rightHasGift(arg_29_1)
	if not self:isShowEntrance() then
		return false
	end

	local var_29_0 = self:getLastUnlockId()

	for iter_29_0 = arg_29_1 + 1, #self._rechargeRebateAwardData do
		if iter_29_0 < var_29_0 then
			if not self._rechargeRebateAwardData[iter_29_0].isReceive then
				return true
			end

			if self._rechargeRebateAwardData[iter_29_0].newAwardState then
				return true
			end
		else
			return false
		end
	end

	return false
end

function ActivityPermanentRechargeData:hasAwardCanReceive(arg_30_1)
	if not self:isShowEntrance() then
		return false
	end

	local var_30_0 = self:getLastUnlockId()
	local var_30_1, var_30_2 = self:getAmountOwnAndNeedSize()

	if arg_30_1 then
		if arg_30_1 < var_30_0 then
			if self._rechargeRebateAwardData[arg_30_1].isReceive then
				if self._rechargeRebateAwardData[arg_30_1].newAwardState then
					return true
				else
					return false
				end
			else
				return true
			end
		elseif self._rechargeRebateAwardData[arg_30_1].isReceive then
			if self._rechargeRebateAwardData[arg_30_1].newAwardState then
				return true
			else
				return false
			end
		else
			return var_30_2 <= var_30_1
		end
	else
		for iter_30_0 = 1, var_30_0 - 1 do
			if iter_30_0 < var_30_0 and not self._rechargeRebateAwardData[iter_30_0].isReceive then
				return true
			end

			if self._rechargeRebateAwardData[iter_30_0].newAwardState then
				return true
			end
		end

		if self._rechargeRebateAwardData[var_30_0].isReceive then
			if self._rechargeRebateAwardData[var_30_0].newAwardState then
				return true
			else
				return false
			end
		else
			return var_30_2 <= var_30_1
		end
	end

	return false
end

function ActivityPermanentRechargeData:tempSavePreId(arg_31_1)
	self._preId = arg_31_1
end

function ActivityPermanentRechargeData:getTempSavePreId()
	return self._preId
end

function ActivityPermanentRechargeData:isShowEntrance()
	return (g.core.model.User.rechargeData:getTotalRecharge() > 0 or g.core.model.User.rechargeData:isOldPlayerWithRecharge()) and not self:_checkAwardAndGiftStatus()
end

function ActivityPermanentRechargeData:_checkAwardAndGiftStatus()
	for iter_34_0, iter_34_1 in ipairs(self._rechargeRebateAwardData) do
		if not iter_34_1.isReceive or iter_34_1.newAwardState then
			return false
		end
	end

	for iter_34_2, iter_34_3 in ipairs(self._giftDataDict[self._giftGroup]) do
		if not iter_34_3.hasBuy then
			return false
		end
	end

	return true
end

function ActivityPermanentRechargeData:getGiftCanBuy()
	local var_35_0 = {}

	for iter_35_0, iter_35_1 in ipairs(self._allGiftGroupArr[self._giftGroup]) do
		if self:_checkGiftBuyStatus(iter_35_1) then
			table.insert(var_35_0, iter_35_1)
		end
	end

	return var_35_0
end

function ActivityPermanentRechargeData:_checkGiftBuyStatus(arg_36_1)
	return arg_36_1.buyTimes < arg_36_1.times and self:_getBuildingFinishStatus(arg_36_1.stage_id)
end

function ActivityPermanentRechargeData:hasGiftCanBuy()
	return #self:getGiftCanBuy() > 0
end

function ActivityPermanentRechargeData:getShowBuildingByGroupId(arg_38_1)
	local var_38_1

	for iter_38_0, iter_38_1 in pairs(self._allBuildResDict[arg_38_1] or {}) do
		var_38_1 = iter_38_1

		if not self:_getBuildingFinishStatus(iter_38_1.id) then
			break
		end
	end

	return var_38_1
end

function ActivityPermanentRechargeData:getShowRewardsByGroupIdAndStageId(arg_39_1, arg_39_2)
	return self._allRewardDict[arg_39_1][arg_39_2]
end

function ActivityPermanentRechargeData:getCurBuildingFinishStatusById(arg_40_1)
	local var_40_0 = self:getShowBuildingByGroupId(self:_getGroupIdById(arg_40_1))

	if var_40_0.isFinished then
		return var_0_7.HAS_DRAW
	elseif self:getNeedLightSizeById(var_40_0.id) <= self:getOwnLightSize() then
		return var_0_7.CAN_DRAW
	else
		return var_0_7.NOT_FINISH
	end
end

function ActivityPermanentRechargeData:getMoreLightSize(arg_41_1)
	local var_41_0 = self:getNeedLightSizeById(arg_41_1) - self:getOwnLightSize()

	return var_41_0 >= 0 and var_41_0 or 0
end

function ActivityPermanentRechargeData:hasNewStageWithCustomData(arg_42_1)
	if not self:isShowEntrance() then
		return false
	end

	return false
end

function ActivityPermanentRechargeData:hasNewGiftCanBuy(arg_43_1)
	return false
end

function ActivityPermanentRechargeData:hasAwardCanDrawWithCustomData(arg_44_1)
	if not self:isShowEntrance() then
		return false
	end

	if arg_44_1.id then
		local var_44_0 = self:_getStageIdById(arg_44_1.id)

		return self:getPreStageFinishStatus(self:_getPreId(arg_44_1.id), var_44_0) and not self._allBuildResDict[self:_getGroupIdById(arg_44_1.id)][var_44_0].isFinished and self:isLightEnough(arg_44_1.id)
	else
		local var_44_1 = self:getFirstUnFinishedLightSize()

		return var_44_1 <= self:getOwnLightSize() and var_44_1 ~= 0
	end
end

return ActivityPermanentRechargeData
