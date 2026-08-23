local var_0_0 = g.core.common.ServerTime
local var_0_1 = g.core.config.daily_sale_info
local var_0_3 = g.core.config.daily_box_reward_info
local ActivityDailyBoxData = class("ActivityDailyBoxData", require("app.core.model.BaseData"))
local var_0_5 = g.core.const.ConstMgr.ActivityConst.DAILY_BOX_DRAW_STATUS
local var_0_6 = g.core.const.ConstMgr.ActivityConst.DAILY_SALE_INFO_INDEX

function ActivityDailyBoxData:ctor()
	self:initData()
end

function ActivityDailyBoxData:initData()
	self._activityData = {}
	self._turnTime = 0
	self._turnAwards = {}
	self._turnRewardCfg = {}
	self._weekCardLeftTime = 0
	self._weekCardExpireTime = nil

	self:_initDailyBoxData()
end

function ActivityDailyBoxData:_initDailyBoxData()
	for iter_3_0 = 1, var_0_1.getLength() do
		local var_3_0 = var_0_1.indexOf(iter_3_0).toObject()

		table.insert(self._activityData, {
			isBuy = false,
			info = var_3_0,
			chargeInfo = (var_3_0.recharge_type and var_3_0.recharge_type ~= 0 or nil) and g.core.model.User.rechargeData:getRechargeInfoByTypeAndPrice(var_3_0.recharge_type, var_3_0.recharge_money)
		})
	end
end

function ActivityDailyBoxData:updateInfo(arg_4_1)
	local var_4_0 = arg_4_1.daily_sale_ids or {}

	if arg_4_1.due_time then
		self._weekCardExpireTime = arg_4_1.due_time
		self._weekCardLeftTime = math.max(0, self._weekCardExpireTime - var_0_0:getTime())
	else
		self._weekCardExpireTime = nil
		self._weekCardLeftTime = 0
	end

	for iter_4_0, iter_4_1 in ipairs(self._activityData) do
		iter_4_1.isBuy = false

		for iter_4_2, iter_4_3 in ipairs(var_4_0) do
			if iter_4_3 == iter_4_1.info.id then
				iter_4_1.isBuy = true

				break
			end
		end
	end

	self:_updateAllGiftData()
end

function ActivityDailyBoxData:updateInfoByOp(arg_5_1)
	if arg_5_1 and arg_5_1.id then
		for iter_5_0, iter_5_1 in ipairs(self._activityData) do
			if arg_5_1.id == iter_5_1.info.id then
				iter_5_1.isBuy = true

				break
			end
		end

		self:_updateAllGiftData()
	end
end

function ActivityDailyBoxData:getDailyBoxData()
	return self._activityData
end

function ActivityDailyBoxData:isHasFreeGift()
	if self._activityData[1] then
		return not self._activityData[1].isBuy
	else
		return false
	end
end

function ActivityDailyBoxData:isCanOneKeyBuy()
	for iter_8_0, iter_8_1 in ipairs(self._activityData) do
		if iter_8_1.info and iter_8_1.info.type == 2 and iter_8_1.isBuy then
			return false
		end
	end

	return true
end

function ActivityDailyBoxData:_getCanDrawGiftList(arg_9_1)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in ipairs(self._activityData) do
		if iter_9_1.info and not iter_9_1.isBuy and (iter_9_1.info.type == 2 or iter_9_1.info.type == 1 and arg_9_1) then
			table.insert(var_9_0, iter_9_1)
		end
	end

	return var_9_0
end

function ActivityDailyBoxData:isWeekCardValid()
	return self._weekCardLeftTime > 0
end

function ActivityDailyBoxData:getWeekCardRemainTimeString()
	if self._weekCardLeftTime > 0 then
		local var_11_0, var_11_1, var_11_2, var_11_3 = var_0_0:getLeftTimeParts(self._weekCardExpireTime)

		if var_11_1 > 0 or var_11_2 > 0 or var_11_3 > 0 then
			var_11_0 = var_11_0 + 1
		end

		return g.core.lang:get(404021, {
			day = var_11_0
		})
	end

	return ""
end

function ActivityDailyBoxData:checkWeekCardDrawStatusNotFree()
	local var_12_0 = #self:_getCanDrawGiftList(false)

	if var_12_0 == 3 then
		return var_0_5.NO_PRIVILEGE
	elseif var_12_0 == 0 then
		return var_0_5.NO_PRIVILEGE_HAS_DRAW
	else
		return var_0_5.NO_PRIVILEGE_PART_DRAW
	end
end

function ActivityDailyBoxData:checkWeekCardDrawStatus()
	if #self:_getCanDrawGiftList(true) == 0 then
		return var_0_5.HAS_DRAW
	else
		return var_0_5.NOT_DRAW
	end
end

function ActivityDailyBoxData:isBuyFullGift()
	if self._activityData[5] and self._activityData[5].isBuy then
		return true
	end

	for iter_14_0, iter_14_1 in ipairs(self._activityData) do
		if iter_14_1.info and iter_14_1.info.type == 2 and not iter_14_1.isBuy then
			return false
		end
	end

	return true
end

function ActivityDailyBoxData:convertChargeInfo(arg_15_1)
	local var_15_0 = clone(arg_15_1)

	var_15_0.discount = arg_15_1.off
	var_15_0.times = 1
	var_15_0.limit_type = g.core.const.ConstMgr.RechargeConst.GIFT_LIMIT_TYPE.DAILY

	return var_15_0
end

function ActivityDailyBoxData:_updateAllGiftData()
	if self._activityData[var_0_6.ALL_BUY].isBuy or self._activityData[var_0_6.WEEK_CARD].isBuy then
		for iter_16_0, iter_16_1 in ipairs(self._activityData) do
			if iter_16_0 ~= 1 and not iter_16_1.isBuy then
				iter_16_1.isBuy = true
			end
		end
	end
end

function ActivityDailyBoxData:resetDataWhenCrossDay()
	for iter_17_0, iter_17_1 in ipairs(self._activityData) do
		iter_17_1.isBuy = false
	end
end

function ActivityDailyBoxData:updateAwardCfg(arg_18_1)
	if not arg_18_1 then
		return
	end

	self._turnTime = arg_18_1.id
	self._turnAwards = arg_18_1.reward_ids or {}

	if arg_18_1.daily_box_turn and arg_18_1.daily_box_turn.reward_ids then
		self._turnAwards = arg_18_1.daily_box_turn.reward_ids
	end

	if not next(self._turnRewardCfg) then
		self._turnRewardCfg = var_0_3.match(function(arg_19_0)
			return arg_19_0.times == self._turnTime
		end) or {}
	end
end

function ActivityDailyBoxData:getAwardCfg(arg_20_1)
	return self._turnRewardCfg
end

function ActivityDailyBoxData:getDailyBoxTurnAwardData(arg_21_1)
	local var_21_0 = {}
	local var_21_1 = var_0_3.get(arg_21_1)

	for iter_21_0 = 1, 4 do
		if var_21_1["type_" .. iter_21_0] > 0 and var_21_1["value_" .. iter_21_0] > 0 or var_21_1["type_" .. iter_21_0] == 999 and var_21_1["value_" .. iter_21_0] == 0 then
			table.insert(var_21_0, {
				type = var_21_1["type_" .. iter_21_0],
				value = var_21_1["value_" .. iter_21_0],
				size = var_21_1["size_" .. iter_21_0]
			})
		end
	end

	return var_21_0
end

function ActivityDailyBoxData:isGetDailyBoxTurnAward(arg_22_1)
	if next(self._turnAwards) then
		for iter_22_0, iter_22_1 in pairs(self._turnAwards) do
			if iter_22_1 == arg_22_1 then
				return true
			end
		end
	end

	return false
end

function ActivityDailyBoxData:getCurDailyBoxAwardScore()
	return (g.core.model.User.bagData:getCountById(g.core.common.Goods.TYPE_RESOURCE, 61))
end

function ActivityDailyBoxData:getDailyBoxTurnId()
	return self._turnTime
end

function ActivityDailyBoxData:getDailyBoxAwardMaxScore()
	return (next(self._turnRewardCfg) or nil) and self._turnRewardCfg[#self._turnRewardCfg].score
end

function ActivityDailyBoxData:isCanGetDailyTurnAwards()
	for iter_26_0, iter_26_1 in pairs(self._turnRewardCfg) do
		if not self:isGetDailyBoxTurnAward(iter_26_1.id) and self:getCurDailyBoxAwardScore() >= iter_26_1.score then
			return true
		end
	end

	return false
end

function ActivityDailyBoxData:isProgCanAward()
	local var_27_0 = self:getAwardCfg()
	local var_27_1 = self:getCurDailyBoxAwardScore()

	for iter_27_0 = 1, #var_27_0 do
		if var_27_1 >= var_27_0[iter_27_0].score and not self:isGetDailyBoxTurnAward(var_27_0[iter_27_0].id) then
			return true
		end
	end

	return false
end

function ActivityDailyBoxData:hasGiftCanDraw()
	if not self:isWeekCardValid() then
		return false
	end

	return self:checkWeekCardDrawStatus() == var_0_5.NOT_DRAW
end

function ActivityDailyBoxData:getCurProgressDailyAwardId()
	local var_29_0 = 0

	for iter_29_0, iter_29_1 in pairs(self._turnRewardCfg) do
		var_29_0 = iter_29_1.id

		if not self:isGetDailyBoxTurnAward(iter_29_1.id) then
			break
		end
	end

	return var_29_0
end

function ActivityDailyBoxData:getPreDailyAwardScore()
	local var_30_0 = 0
	local var_30_1 = self:getCurProgressDailyAwardId()

	for iter_30_0, iter_30_1 in pairs(self._turnRewardCfg) do
		if iter_30_1.next_id == var_30_1 then
			var_30_0 = iter_30_1.score
		end
	end

	return var_30_0
end

function ActivityDailyBoxData:hasGameCount()
	return g.core.model.User.bagData:getOwnNum(g.core.common.Goods.TYPE_ITEM, g.core.model.User.itemsData:getDailyBoxGameItemInfo().id) > 0
end

return ActivityDailyBoxData
