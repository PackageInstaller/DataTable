local var_0_0 = g.core.config.wishpool_drop_info
local var_0_1 = g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.DAILY_WISH
local ActivityWishpoolData = class("ActivityWishpoolData")

function ActivityWishpoolData:ctor()
	self._poolBaseCfg = {}

	self:initCfg()
	self:initData()
end

function ActivityWishpoolData:initCfg()
	for iter_2_0, iter_2_1 in var_0_0.ipairs() do
		self._poolBaseCfg[iter_2_1.pool_id] = self._poolBaseCfg[iter_2_1.pool_id] or {}

		table.insert(self._poolBaseCfg[iter_2_1.pool_id], iter_2_1)
	end
end

function ActivityWishpoolData:initData()
	self._currentPool = {}
	self._poolId = 0
	self._toDayRechargeNum = 0
	self._isGetRechargeAward = false
	self._isGetDailyReward = false
	self._activityEndTime = 0
	self._allProbabilityNum = 0
	self._lastFishNum = 0
	self._actCfg = nil
	self._isSkipAnim = false
end

function ActivityWishpoolData:on_S2C_Wishpool_Flush(arg_4_1)
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.wish_record or {}) do
		var_4_0[iter_4_1.id] = iter_4_1.num
	end

	self._currentPool = {}
	self._allProbabilityNum = 0
	self._lastFishNum = 0
	self._actCfg = g.core.config.wishpool_info.get(arg_4_1.pool_id)

	if self._poolBaseCfg[arg_4_1.pool_id] then
		for iter_4_2, iter_4_3 in ipairs(self._poolBaseCfg[arg_4_1.pool_id]) do
			self._currentPool[iter_4_3.id] = iter_4_3.fish_num - (var_4_0[iter_4_3.id] or 0)
			self._lastFishNum = self._lastFishNum + self._currentPool[iter_4_3.id]
			self._allProbabilityNum = self._allProbabilityNum + iter_4_3.weights * self._currentPool[iter_4_3.id]
		end
	end

	self._poolId = arg_4_1.pool_id
	self._toDayRechargeNum = arg_4_1.recharge_money or 0
	self._isGetRechargeAward = arg_4_1.recharge_award == 1
	self._isGetDailyReward = arg_4_1.daily_present_times == 1
	self._activityEndTime = arg_4_1.end_time or 0
	self._activityStartTime = arg_4_1.start_time or 0
	self._todayGetRechargeBait = arg_4_1.recharge_bait or 0
	self._todayGetActiveBait = arg_4_1.active_bait or 0
end

function ActivityWishpoolData:getTodayRechargeBait()
	return self._todayGetRechargeBait or 0
end

function ActivityWishpoolData:getTodayActiveBait()
	return self._todayGetActiveBait or 0
end

function ActivityWishpoolData:isNewActivity()
	if not self._lastCacheTime then
		self:checkAndLoadActivityCache()
	end

	return self._activityEndTime ~= self._lastCacheTime
end

function ActivityWishpoolData:saveNewActivity()
	if self._lastCacheTime ~= self._activityEndTime then
		g.core.common.Storage:save("wish_pool_new_stage.json", {
			lastFinishTime = self._activityEndTime
		}, true)

		self._lastCacheTime = self._activityEndTime
	end
end

function ActivityWishpoolData:checkAndLoadActivityCache()
	self._lastCacheTime = (g.core.common.Storage:load("wish_pool_new_stage.json", true) or {
		lastFinishTime = 0
	}).lastFinishTime
end

function ActivityWishpoolData:onS2CFlushRedPoint(arg_10_1)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_1.wish_record or {}) do
		var_10_0[iter_10_1.id] = iter_10_1.num
	end

	self._currentPool = {}
	self._allProbabilityNum = 0
	self._lastFishNum = 0

	if not arg_10_1.pool_id then
		return
	end

	self._actCfg = g.core.config.wishpool_info.fetch(arg_10_1.pool_id)

	if not self._actCfg then
		return
	end

	if self._poolBaseCfg[arg_10_1.pool_id] then
		for iter_10_2, iter_10_3 in ipairs(self._poolBaseCfg[arg_10_1.pool_id]) do
			self._currentPool[iter_10_3.id] = iter_10_3.fish_num - (var_10_0[iter_10_3.id] or 0)
			self._lastFishNum = self._lastFishNum + self._currentPool[iter_10_3.id]
			self._allProbabilityNum = self._allProbabilityNum + iter_10_3.weights * self._currentPool[iter_10_3.id]
		end
	end

	self._poolId = arg_10_1.pool_id
	self._isGetDailyReward = arg_10_1.daily_present_times == 1
	self._activityEndTime = arg_10_1.end_time or 0
	self._activityStartTime = arg_10_1.start_time or 0
end

function ActivityWishpoolData:isShowEntrance()
	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.DAILY_WISH) then
		return false
	end

	if self._poolId and self._poolId == 0 then
		return false
	end

	local var_11_0 = g.core.common.ServerTime:getTime()

	return var_11_0 < self._activityEndTime and var_11_0 > self._activityStartTime
end

function ActivityWishpoolData:getRechargeMoney()
	return self._toDayRechargeNum
end

function ActivityWishpoolData:on_S2C_Wishpool_DailyPresents(arg_13_1)
	self._isGetDailyReward = true
end

function ActivityWishpoolData:on_S2C_Wishpool_Fishing(arg_14_1)
	if not arg_14_1.drop_id then
		return
	end

	for iter_14_0 = 1, #arg_14_1.drop_id do
		if self._currentPool[arg_14_1.drop_id[iter_14_0]] then
			self._currentPool[arg_14_1.drop_id[iter_14_0]] = self._currentPool[arg_14_1.drop_id[iter_14_0]] - 1
			self._allProbabilityNum = self._allProbabilityNum - var_0_0.get(arg_14_1.drop_id[iter_14_0]).weights
			self._lastFishNum = self._lastFishNum - 1
		end
	end
end

function ActivityWishpoolData:isGetDailyReward()
	return self._isGetDailyReward
end

function ActivityWishpoolData:isRechargeReward()
	return self._isGetRechargeAward
end

function ActivityWishpoolData:getEndTime()
	return self._activityEndTime
end

function ActivityWishpoolData:getLastFishNum()
	return self._lastFishNum
end

function ActivityWishpoolData:isCanFishing(arg_19_1)
	local var_19_0 = g.core.model.User.bagData:getCountById(g.core.common.Goods.TYPE_RESOURCE, g.core.common.Goods.RESOURCE.BAIT)

	if not arg_19_1 or not arg_19_1.num or arg_19_1.num == 1 then
		return self._lastFishNum > 0 and var_19_0 > 0
	else
		local var_19_1 = math.min(10, self._lastFishNum)

		return var_19_1 > 0 and var_19_0 > 0 and var_19_1 <= var_19_0
	end
end

function ActivityWishpoolData:getLastProbabilityById(arg_20_1, arg_20_2)
	if self._currentPool[arg_20_1] == 0 then
		return 0, arg_20_2
	end

	local var_20_0 = math.round(10000 * (var_0_0.get(arg_20_1).weights * self._currentPool[arg_20_1]) / self._allProbabilityNum) / 100

	if arg_20_2 < var_20_0 then
		var_20_0 = arg_20_2
		arg_20_2 = 0
	else
		arg_20_2 = arg_20_2 - var_20_0
	end

	return var_20_0, arg_20_2
end

function ActivityWishpoolData:getPreviewData()
	local var_21_0 = {}

	for iter_21_0, iter_21_1 in ipairs(self._poolBaseCfg[self._poolId]) do
		var_21_0[iter_21_1.fish_appear] = var_21_0[iter_21_1.fish_appear] or {}

		local var_21_2, var_21_3 = self:getLastProbabilityById(iter_21_1.id, 100)
		local var_21_4 = {
			id = iter_21_1.id
		}

		var_21_4.lastNum = self._currentPool[iter_21_1.id] or 0
		var_21_4.reward = {
			type = iter_21_1.reward_type,
			value = iter_21_1.reward_value,
			size = iter_21_1.reward_size
		}
		var_21_4.probability = var_21_2

		table.insert(var_21_0[iter_21_1.fish_appear], var_21_4)
	end

	for iter_21_2, iter_21_3 in ipairs(var_21_0) do
		table.sort(iter_21_3, function(arg_22_0, arg_22_1)
			if arg_22_0.probability ~= arg_22_1.probability then
				return arg_22_0.probability < arg_22_1.probability
			end

			if arg_22_0.id ~= arg_22_1.id then
				return arg_22_0.id > arg_22_1.id
			end

			return false
		end)
	end

	return var_21_0
end

function ActivityWishpoolData:addActivityData()
	g.core.model.User.activityDataManager:addIndependentCustomActivity({
		sub_activity_id = 1,
		id = 1,
		type = var_0_1,
		title = g.core.lang:get(409013),
		finish_time = self._activityEndTime
	})
end

function ActivityWishpoolData:getCurrentAllFish()
	return self._currentPool
end

function ActivityWishpoolData:getCurrentAllShowFish()
	local var_25_0 = 0
	local var_25_1 = {}

	for iter_25_0, iter_25_1 in pairs(self._currentPool) do
		local var_25_2 = var_0_0.get(iter_25_0)

		var_25_1[iter_25_0] = iter_25_1 < var_25_2.show_limit and iter_25_1 or var_25_2.show_limit
		var_25_0 = var_25_0 + var_25_1[iter_25_0]
	end

	self._curShowNum = var_25_0

	return var_25_1
end

function ActivityWishpoolData:isCurFishNeedRemove()
	if not self._curShowNum then
		return true
	end

	local var_26_0 = 0

	for iter_26_0, iter_26_1 in pairs(self._currentPool) do
		local var_26_1 = var_0_0.get(iter_26_0)

		var_26_0 = var_26_0 + (iter_26_1 < var_26_1.show_limit and iter_26_1 or var_26_1.show_limit)
	end

	if var_26_0 < self._curShowNum then
		self._curShowNum = var_26_0

		return true
	end

	return false
end

function ActivityWishpoolData:isDropFishNeedRemove(arg_27_1, arg_27_2)
	local var_27_0 = var_0_0.get(arg_27_1)
	local var_27_1 = self._currentPool[arg_27_1] or 0

	return arg_27_2 > (var_27_1 < var_27_0.show_limit and var_27_1 or var_27_0.show_limit)
end

function ActivityWishpoolData:getAllTypeFishNum()
	local var_28_0 = {}

	if self._poolBaseCfg[self._poolId] then
		for iter_28_0, iter_28_1 in ipairs(self._poolBaseCfg[self._poolId]) do
			var_28_0[iter_28_1.fish_appear] = var_28_0[iter_28_1.fish_appear] or {
				curNum = 0,
				maxNum = 0
			}
			var_28_0[iter_28_1.fish_appear].maxNum = var_28_0[iter_28_1.fish_appear].maxNum + iter_28_1.fish_num
			var_28_0[iter_28_1.fish_appear].curNum = var_28_0[iter_28_1.fish_appear].curNum + self._currentPool[iter_28_1.id]
		end
	end

	return var_28_0
end

function ActivityWishpoolData:getActCfg()
	return self._actCfg
end

function ActivityWishpoolData:setSkipAnimState()
	self._isSkipAnim = not self._isSkipAnim
end

function ActivityWishpoolData:isSkipAnim()
	return self._isSkipAnim
end

return ActivityWishpoolData
