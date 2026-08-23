local var_0_0 = g.core.config.passcard_info
local var_0_1 = g.core.config.passcard_level_info
local var_0_2 = g.core.config.passcard_pay_info
local var_0_3 = g.core.config.passcard_reward_info
local var_0_4 = g.core.config.passcard_task_info
local var_0_5 = g.core.config.parameter_info
local var_0_6 = 2
local var_0_7 = g.core.common.Goods
local PassCardConst = require("app.view.module.passCard.const.PassCardConst")
local PassCardData = class("PassCardData")

function PassCardData:ctor()
	self:initData()
end

function PassCardData:initData()
	self._passCardBaseInfo = {}
	self._passCardRewardInfo = {
		normalReward = {},
		seniorReward = {},
		bigNormalReward = {},
		bigSeniorReward = {},
		allRewardMap = {}
	}
	self._passCardPayInfo = {}
	self._passCardTaskInfo = {}
	self._passCardRechargeInfo = {}
	self._hasGetRewardData = {}
	self._taskProgressData = {}
	self._hasFinishTaskData = {}
	self._isInit = false
	self._passCardId = nil
	self._maxBigNormalRewardLevel = 0
	self._maxBigSeniorRewardLevel = 0
	self._maxRewardMaxLevel = 0
	self._allCanBuyLevelAwardData = {}
	self._isActivityEnd = false
end

function PassCardData:_initCfgData()
	self._passCardBaseInfo.baseInfo = var_0_0.get(self._passCardId).toObject()
	self._passCardBaseInfo.cardLevelUpLimit = self:_getCardMaxConfigLevel()
	self._passCardBaseInfo.buyOneLevelConsume = var_0_5.get(20003).parameter

	self:_initRewardInfo()
	self:_initTaskInfo()
	self:_initPassRechargeInfo()
end

function PassCardData:_initRewardInfo()
	self._passCardRewardInfo.allRewardMap[PassCardConst.RewardType.NORMAL] = {}
	self._passCardRewardInfo.allRewardMap[PassCardConst.RewardType.SENIOR] = {}

	for iter_4_0 = 1, var_0_3.getLength() do
		local var_4_0 = var_0_3.indexOf(iter_4_0)

		if var_4_0.order == self._passCardId then
			local var_4_1 = var_4_0.toObject()
			local var_4_2 = {
				type = var_4_0.reward_type_1,
				value = var_4_0.reward_value_1,
				size = var_4_0.reward_size_1
			}
			local var_4_3 = {
				type = var_4_0.reward_type_2,
				value = var_4_0.reward_value_2,
				size = var_4_0.reward_size_2
			}
			local var_4_4 = {
				rewardType = PassCardConst.RewardType.NORMAL,
				info = var_4_1,
				reward = var_4_2,
				getState = PassCardConst.RewardState.CAN_NOT_GET
			}
			local var_4_5 = {
				rewardType = PassCardConst.RewardType.SENIOR,
				info = var_4_1,
				reward = var_4_3,
				getState = PassCardConst.RewardState.CAN_NOT_GET
			}

			table.insert(self._passCardRewardInfo.normalReward, var_4_4)
			table.insert(self._passCardRewardInfo.seniorReward, var_4_5)

			if var_4_1.level > self._maxRewardMaxLevel then
				self._maxRewardMaxLevel = var_4_1.level
			end

			if var_4_2.type ~= 0 then
				local var_4_6 = var_0_7:convert({
					type = var_4_2.type,
					value = var_4_2.value,
					size = var_4_2.size
				})
				local var_4_7 = tostring(var_4_2.type) .. "_" .. tostring(var_4_2.value)

				if not self._passCardRewardInfo.allRewardMap[PassCardConst.RewardType.NORMAL][var_4_7] then
					self._passCardRewardInfo.allRewardMap[PassCardConst.RewardType.NORMAL][var_4_7] = clone(var_4_2)
				else
					self._passCardRewardInfo.allRewardMap[PassCardConst.RewardType.NORMAL][var_4_7].size = self._passCardRewardInfo.allRewardMap[PassCardConst.RewardType.NORMAL][var_4_7].size + var_4_2.size
				end

				self._passCardRewardInfo.allRewardMap[PassCardConst.RewardType.NORMAL][var_4_7].itemQuality = var_4_6.quality or 0
				self._passCardRewardInfo.allRewardMap[PassCardConst.RewardType.NORMAL][var_4_7].cardRewardId = var_4_1.id
				self._passCardRewardInfo.allRewardMap[PassCardConst.RewardType.NORMAL][var_4_7].cardPrizeType = var_4_1.prize_type
			end

			if var_4_3.type ~= 0 then
				local var_4_8 = var_0_7:convert({
					type = var_4_3.type,
					value = var_4_3.value,
					size = var_4_3.size
				})
				local var_4_9 = tostring(var_4_3.type) .. "_" .. tostring(var_4_3.value)

				if not self._passCardRewardInfo.allRewardMap[PassCardConst.RewardType.SENIOR][var_4_9] then
					self._passCardRewardInfo.allRewardMap[PassCardConst.RewardType.SENIOR][var_4_9] = clone(var_4_3)
				else
					self._passCardRewardInfo.allRewardMap[PassCardConst.RewardType.SENIOR][var_4_9].size = self._passCardRewardInfo.allRewardMap[PassCardConst.RewardType.SENIOR][var_4_9].size + var_4_3.size
				end

				self._passCardRewardInfo.allRewardMap[PassCardConst.RewardType.SENIOR][var_4_9].itemQuality = var_4_8.quality or 0
				self._passCardRewardInfo.allRewardMap[PassCardConst.RewardType.SENIOR][var_4_9].cardRewardId = var_4_1.id
				self._passCardRewardInfo.allRewardMap[PassCardConst.RewardType.SENIOR][var_4_9].cardPrizeType = var_4_1.prize_type
			end

			if var_4_0.prize_type ~= 0 then
				if var_4_4.reward.type ~= 0 then
					table.insert(self._passCardRewardInfo.bigNormalReward, var_4_4)
				end

				if var_4_5.reward.type ~= 0 then
					table.insert(self._passCardRewardInfo.bigSeniorReward, var_4_5)
				end

				if var_4_0.reward_type_1 ~= 0 and var_4_1.level > self._maxBigNormalRewardLevel then
					self._maxBigNormalRewardLevel = var_4_1.level
				end

				if var_4_0.reward_type_2 ~= 0 and var_4_1.level > self._maxBigSeniorRewardLevel then
					self._maxBigSeniorRewardLevel = var_4_1.level
				end
			end
		end
	end
end

function PassCardData:_initTaskInfo()
	self._passCardTaskInfo = {}

	for iter_5_0 = 1, var_0_4.getLength() do
		local var_5_0 = var_0_4.indexOf(iter_5_0)

		if var_5_0.order == self._passCardId then
			self._passCardTaskInfo[var_5_0.type] = self._passCardTaskInfo[var_5_0.type] or {}

			table.insert(self._passCardTaskInfo[var_5_0.type], {
				finishNum = 0,
				taskInfo = var_5_0.toObject(),
				finishState = PassCardConst.TaskFinishState.NOT_FINISH,
				rewards = {
					{
						type = var_5_0.reward_type,
						value = var_5_0.reward_value,
						size = var_5_0.reward_size
					}
				}
			})
		end
	end
end

function PassCardData:_initPassRechargeInfo()
	local var_6_1 = {}

	for iter_6_0 = 1, var_0_2.getLength() do
		local var_6_2 = var_0_2.indexOf(iter_6_0)

		var_6_1[var_6_2.id] = var_6_1[var_6_2.id] or {}
		var_6_1[var_6_2.id][var_6_2.type] = var_6_1[var_6_2.id][var_6_2.type] or {}
		var_6_1[var_6_2.id][var_6_2.type].cfg = var_6_2
		var_6_1[var_6_2.id][var_6_2.type].rechargeInfo = g.core.model.User.rechargeData:getRechargeInfoByTypeAndPrice(var_6_2.recharge_type, var_6_2.recharge_money)
		var_6_1[var_6_2.id][var_6_2.type].rewards = var_6_2.drop_id ~= 0 and g.core.common.Drops:getGoodsArray(var_6_2.drop_id) or {}
	end

	self._passCardRechargeInfo = var_6_1
end

function PassCardData:updateCardInfo(arg_7_1)
	self._lastUpdateTime = g.core.common.ServerTime:getTime()

	if arg_7_1 and arg_7_1.id then
		self:initData()

		self._passCardId = arg_7_1.id

		if not self._passCardId or self._passCardId == 0 then
			return
		end

		self:_initCfgData()

		self._passCardBaseInfo.start_time = arg_7_1.start_time or 0
		self._passCardBaseInfo.level = arg_7_1.level or 0
		self._passCardBaseInfo.exp = arg_7_1.exp or 0
		self._passCardBaseInfo.rechargr_type = arg_7_1.rechargr_type or 0
		self._taskProgressData = arg_7_1.tasks or {}
		self._hasFinishTaskData = arg_7_1.task_ids or {}

		self:_setHasGetRewardData(arg_7_1)
		self:_updateRewardInfo()
		self:_updateTaskInfo()
	end
end

function PassCardData:updateRechargeState(arg_8_1)
	if arg_8_1 then
		self._passCardBaseInfo.rechargr_type = arg_8_1.tp or 0
	end

	if arg_8_1.lv then
		self._passCardBaseInfo.level = arg_8_1.lv
	end

	if arg_8_1.exp then
		self._passCardBaseInfo.exp = arg_8_1.exp
	end

	if self._passCardBaseInfo.rechargr_type ~= 0 then
		self:_updateRewardInfo()
	end
end

function PassCardData:_updateRewardInfo()
	for iter_9_0, iter_9_1 in ipairs(self._passCardRewardInfo.normalReward) do
		iter_9_1.getState = self:_getAwardState(PassCardConst.RewardType.NORMAL, iter_9_1)
	end

	for iter_9_2, iter_9_3 in ipairs(self._passCardRewardInfo.seniorReward) do
		iter_9_3.getState = self:_getAwardState(PassCardConst.RewardType.SENIOR, iter_9_3)
	end

	for iter_9_4, iter_9_5 in pairs(self._passCardRewardInfo.bigNormalReward) do
		iter_9_5.getState = self:_getAwardState(PassCardConst.RewardType.NORMAL, iter_9_5)
	end

	for iter_9_6, iter_9_7 in pairs(self._passCardRewardInfo.bigSeniorReward) do
		iter_9_7.getState = self:_getAwardState(PassCardConst.RewardType.SENIOR, iter_9_7)
	end
end

function PassCardData:_updateTaskInfo()
	for iter_10_0, iter_10_1 in pairs(self._passCardTaskInfo) do
		for iter_10_2, iter_10_3 in ipairs(iter_10_1) do
			local var_10_1 = true

			if iter_10_3.taskInfo.function_id ~= 0 then
				var_10_1 = g.core.common.ModuleUnlock:isModuleUnlock(iter_10_3.taskInfo.function_id)

				if not var_10_1 then
					iter_10_3.finishState = PassCardConst.TaskFinishState.NOT_OPEN
				end
			end

			if var_10_1 then
				local var_10_2 = false

				iter_10_3.finishNum = self:_getTaskProgressById(iter_10_3.taskInfo.id)

				if #self._hasFinishTaskData > 0 then
					for iter_10_4, iter_10_5 in ipairs(self._hasFinishTaskData) do
						if iter_10_3.taskInfo.id == iter_10_5 then
							iter_10_3.finishState = PassCardConst.TaskFinishState.HAS_GET_FINISH_AWARD
							var_10_2 = true

							if iter_10_3.finishNum >= iter_10_3.taskInfo.target_value then
								iter_10_3.finishNum = iter_10_3.taskInfo.target_value
							end

							break
						end
					end
				end

				if not var_10_2 then
					if iter_10_3.finishNum >= iter_10_3.taskInfo.target_value then
						iter_10_3.finishNum = iter_10_3.taskInfo.target_value
						iter_10_3.finishState = PassCardConst.TaskFinishState.CAN_GET_AWARD
					else
						iter_10_3.finishState = PassCardConst.TaskFinishState.NOT_FINISH
					end
				end
			end
		end

		table.sort(iter_10_1, function(arg_11_0, arg_11_1)
			if arg_11_0.finishState ~= arg_11_1.finishState then
				return arg_11_0.finishState < arg_11_1.finishState
			else
				if arg_11_0.sort ~= arg_11_1.sort then
					return arg_11_0.sort > arg_11_1.sort
				end

				return arg_11_0.taskInfo.id < arg_11_1.taskInfo.id
			end
		end)
	end
end

function PassCardData:updateTaskProgress(arg_12_1)
	for iter_12_0, iter_12_1 in pairs(self._passCardTaskInfo) do
		for iter_12_2, iter_12_3 in ipairs(iter_12_1) do
			if iter_12_3.taskInfo.target == arg_12_1.id then
				self:_setTaskProgressById(iter_12_3.taskInfo.id, arg_12_1.status)
			end
		end
	end

	self:_updateTaskInfo()
end

function PassCardData:updateTaskAndExpWhenFinishTask(arg_13_1)
	self._passCardBaseInfo.level = arg_13_1.level or 0
	self._passCardBaseInfo.exp = arg_13_1.exp or 0

	local var_13_0 = arg_13_1.task_ids or {}

	if #var_13_0 > 0 then
		for iter_13_0, iter_13_1 in ipairs(var_13_0) do
			local var_13_1 = false

			for iter_13_2, iter_13_3 in ipairs(self._hasFinishTaskData) do
				if iter_13_3 == iter_13_1 then
					var_13_1 = true

					break
				end
			end

			if not var_13_1 then
				table.insert(self._hasFinishTaskData, iter_13_1)
			end
		end
	end

	self:_updateTaskInfo()

	if self._passCardBaseInfo.level ~= self._passCardBaseInfo.level then
		self:_updateRewardInfo()
	end
end

function PassCardData:updateCardLevelAfterBuyLevel(arg_14_1)
	self._passCardBaseInfo.level = arg_14_1.level or 0

	self:_updateRewardInfo()
end

function PassCardData:_setTaskProgressById(arg_15_1, arg_15_2)
	for iter_15_0, iter_15_1 in ipairs(self._taskProgressData) do
		if arg_15_1 == iter_15_1.type then
			iter_15_1.value = arg_15_2
		end
	end
end

function PassCardData:_getTaskProgressById(arg_16_1)
	for iter_16_0, iter_16_1 in ipairs(self._taskProgressData) do
		if arg_16_1 == iter_16_1.type then
			return iter_16_1.value
		end
	end

	return 0
end

function PassCardData:_setHasGetRewardData(arg_17_1)
	self._hasGetRewardData[PassCardConst.RewardType.NORMAL] = arg_17_1.normal_award_ids or {}
	self._hasGetRewardData[PassCardConst.RewardType.SENIOR] = arg_17_1.recharge_award_ids or {}
end

function PassCardData:_isAwardHasGet(arg_18_1, arg_18_2)
	for iter_18_0, iter_18_1 in ipairs(self._hasGetRewardData[arg_18_1] or {}) do
		if iter_18_1 == arg_18_2 then
			return true
		end
	end

	return false
end

function PassCardData:_getAwardState(arg_19_1, arg_19_2)
	local function var_19_0(arg_20_0, arg_20_1)
		return arg_20_1 <= self._passCardBaseInfo.level and (self:_isAwardHasGet(arg_20_0, arg_20_1) and PassCardConst.RewardState.HAS_GET or PassCardConst.RewardState.CAN_GET) or PassCardConst.RewardState.LEVEL_NOT_ENOUGH
	end

	if arg_19_2.reward.type == 0 then
		return PassCardConst.RewardState.CAN_NOT_GET
	end

	if arg_19_1 == PassCardConst.RewardType.SENIOR then
		if self._passCardBaseInfo.rechargr_type == 0 then
			return PassCardConst.RewardState.CAN_NOT_GET
		else
			return var_19_0(arg_19_1, arg_19_2.info.level) or PassCardConst.RewardState.CAN_NOT_GET
		end
	else
		return var_19_0(arg_19_1, arg_19_2.info.level) or PassCardConst.RewardState.CAN_NOT_GET
	end
end

function PassCardData:getCurCanGetAwardIndex()
	for iter_21_0, iter_21_1 in ipairs(self._passCardRewardInfo.normalReward) do
		if iter_21_1.reward.type ~= 0 and iter_21_1.getState == PassCardConst.RewardState.CAN_GET then
			return iter_21_0
		end

		if self._passCardRewardInfo.seniorReward[iter_21_0].reward.type ~= 0 and self._passCardRewardInfo.seniorReward[iter_21_0].getState == PassCardConst.RewardState.CAN_GET then
			return iter_21_0
		end
	end

	for iter_21_2, iter_21_3 in ipairs(self._passCardRewardInfo.normalReward) do
		if iter_21_3.info and self._passCardBaseInfo.level <= iter_21_3.info.level then
			return iter_21_2
		end
	end
end

function PassCardData:getMaxBigNormalRewardLevel()
	return self._maxBigNormalRewardLevel
end

function PassCardData:getMaxBigSeniorRewardLevel()
	return self._maxBigSeniorRewardLevel
end

function PassCardData:getCardBaseInfo()
	return self._passCardBaseInfo
end

function PassCardData:getAllAwardData()
	return self._passCardRewardInfo
end

function PassCardData:getSingleAwardDataByIndex(arg_26_1, arg_26_2)
	if arg_26_1 == PassCardConst.RewardType.NORMAL then
		return self._passCardRewardInfo.normalReward[arg_26_2]
	else
		return self._passCardRewardInfo.seniorReward[arg_26_2]
	end
end

function PassCardData:getRewardPoolDataByType(arg_27_1)
	local var_27_2 = table.values(arg_27_1 == PassCardConst.RewardType.NORMAL and self._passCardRewardInfo.allRewardMap[PassCardConst.RewardType.NORMAL] or self._passCardRewardInfo.allRewardMap[PassCardConst.RewardType.SENIOR])

	table.sort(var_27_2, function(arg_28_0, arg_28_1)
		if (arg_28_0.cardPrizeType ~= 0 and 1 or 0) ~= (arg_28_1.cardPrizeType ~= 0 and 1 or 0) then
			return (arg_28_1.cardPrizeType ~= 0 and 1 or 0) < (arg_28_0.cardPrizeType ~= 0 and 1 or 0)
		else
			if arg_28_0.itemQuality ~= arg_28_1.itemQuality then
				return arg_28_0.itemQuality > arg_28_1.itemQuality
			end

			return arg_28_0.cardRewardId > arg_28_1.cardRewardId
		end
	end)

	return var_27_2
end

function PassCardData:getCanGetAwardTaskType()
	for iter_29_0, iter_29_1 in ipairs(self._passCardTaskInfo) do
		for iter_29_2, iter_29_3 in ipairs(iter_29_1) do
			if iter_29_3.finishState == PassCardConst.TaskFinishState.CAN_GET_AWARD then
				return iter_29_0
			end
		end
	end

	return 1
end

function PassCardData:isCanShowOneKeyTaskBtn(arg_30_1)
	local var_30_0, var_30_1 = self:getIsHasTaskRewardCanGet()

	if var_30_1 >= var_0_6 then
		return true
	end

	return false
end

function PassCardData:getIsHasTaskRewardCanGet()
	local var_31_0 = 0

	for iter_31_0, iter_31_1 in ipairs(self._passCardTaskInfo) do
		for iter_31_2, iter_31_3 in ipairs(iter_31_1) do
			if iter_31_3.finishState == PassCardConst.TaskFinishState.CAN_GET_AWARD then
				var_31_0 = var_31_0 + 1
			end
		end
	end

	return var_31_0 > 0, var_31_0
end

function PassCardData:getTaskInfoData(arg_32_1)
	self:_updateTaskInfo()

	if arg_32_1 and self._passCardTaskInfo[arg_32_1] then
		return self._passCardTaskInfo[arg_32_1]
	end

	return self._passCardTaskInfo
end

function PassCardData:getIsHasDailyTaskAward()
	for iter_33_0, iter_33_1 in ipairs(self._passCardTaskInfo[1] or {}) do
		if iter_33_1.finishState and iter_33_1.finishState == PassCardConst.TaskFinishState.CAN_GET_AWARD then
			return true
		end
	end

	return false
end

function PassCardData:getIsHasWeekTaskAward()
	for iter_34_0, iter_34_1 in ipairs(self._passCardTaskInfo[2] or {}) do
		if iter_34_1.finishState and iter_34_1.finishState == PassCardConst.TaskFinishState.CAN_GET_AWARD then
			return true
		end
	end

	return false
end

function PassCardData:getIsHasRecycleTaskAward()
	for iter_35_0, iter_35_1 in ipairs(self._passCardTaskInfo[3] or {}) do
		if iter_35_1.finishState and iter_35_1.finishState == PassCardConst.TaskFinishState.CAN_GET_AWARD then
			return true
		end
	end

	return false
end

function PassCardData:getAllCanGetTaskAwardId()
	local var_36_0 = {}

	for iter_36_0, iter_36_1 in ipairs(self._passCardTaskInfo) do
		for iter_36_2, iter_36_3 in ipairs(iter_36_1) do
			if iter_36_3.finishState == PassCardConst.TaskFinishState.CAN_GET_AWARD then
				table.insert(var_36_0, iter_36_3.taskInfo.id)
			end
		end
	end

	return var_36_0
end

function PassCardData:getLevel(arg_37_1)
	if not arg_37_1 then
		local var_37_0 = self._passCardBaseInfo.level or arg_37_1

		if var_37_0 >= 10 then
			return tostring(var_37_0)
		elseif var_37_0 > 0 then
			return tostring("0" .. var_37_0)
		end
	end

	return "0"
end

function PassCardData:getCurMaxExpByLevel()
	return var_0_1.get(self._passCardBaseInfo.level).exp
end

function PassCardData:getIsShowPassCard()
	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.PASS_CARD) then
		return false
	end

	if not self._passCardId or self._passCardId == 0 then
		return false
	end

	if not self._passCardBaseInfo or not self._passCardBaseInfo.start_time then
		return false
	end

	local var_39_0 = self._passCardBaseInfo.start_time + self._passCardBaseInfo.baseInfo.continue_time * 24 * 60 * 60
	local var_39_1 = g.core.common.ServerTime:getTime()

	if var_39_1 < self._passCardBaseInfo.start_time or var_39_0 <= var_39_1 then
		return false
	end

	return true
end

function PassCardData:resetTaskDataWhenCrossDay()
	self:_initTaskInfo()
end

function PassCardData:isCanShowBuyLevelBtn()
	if not self:getIsShowPassCard() then
		return false
	end

	if self:isCardFullLevel() then
		return false
	end

	if var_0_5.get(20002).parameter > self._passCardBaseInfo.level then
		return false
	end

	if (self._passCardBaseInfo.start_time or 0) + (var_0_5.get(20004).parameter or 0) * 24 * 60 * 60 > g.core.common.ServerTime:getTime() then
		return false
	end

	return true
end

function PassCardData:isCardFullLevel()
	return self._passCardBaseInfo.level >= self._maxRewardMaxLevel
end

function PassCardData:getAllCanBuyLevelReward()
	local var_43_0 = self._passCardBaseInfo.rechargr_type ~= 0
	local var_43_1 = {}

	for iter_43_0, iter_43_1 in ipairs(self._passCardRewardInfo.seniorReward) do
		if var_43_0 and iter_43_1.info.level > self._passCardBaseInfo.level and iter_43_1.reward.type ~= 0 then
			table.insert(var_43_1, {
				rewardLevel = 1,
				reward = iter_43_1.reward,
				rewardLevel = iter_43_1.info.level
			})
		end

		local var_43_2 = self._passCardRewardInfo.normalReward[iter_43_0]

		if self._passCardRewardInfo.normalReward[iter_43_0] and var_43_2.reward.type ~= 0 then
			table.insert(var_43_1, {
				rewardLevel = 1,
				reward = var_43_2.reward,
				rewardLevel = iter_43_1.info.level
			})
		end
	end

	self._allCanBuyLevelAwardData = var_43_1

	return var_43_1
end

function PassCardData:getFirstBuyLevelRewardIndex(arg_44_1)
	if self._allCanBuyLevelAwardData and #self._allCanBuyLevelAwardData > 0 then
		for iter_44_0, iter_44_1 in ipairs(self._allCanBuyLevelAwardData) do
			if arg_44_1 <= iter_44_1.rewardLevel then
				return iter_44_0
			end
		end
	end
end

function PassCardData:_getCardMaxConfigLevel()
	return var_0_1.getLength() - 1
end

function PassCardData:isCanShowOneKeyGetAwardBtn()
	local var_46_0, var_46_1 = self:getIsHasPassCardRewardCanGet()

	return var_46_1 >= 2
end

function PassCardData:getIsHasPassCardRewardCanGet()
	local var_47_0 = 0

	for iter_47_0, iter_47_1 in ipairs(self._passCardRewardInfo.normalReward) do
		if iter_47_1.getState == PassCardConst.RewardState.CAN_GET then
			var_47_0 = var_47_0 + 1
		end
	end

	for iter_47_2, iter_47_3 in ipairs(self._passCardRewardInfo.seniorReward) do
		if iter_47_3.getState == PassCardConst.RewardState.CAN_GET then
			var_47_0 = var_47_0 + 1
		end
	end

	return var_47_0 > 0, var_47_0
end

function PassCardData:getCardInfoByIndex(arg_48_1)
	if arg_48_1 == 1 then
		return self._passCardRechargeInfo[self._passCardId][1], self._passCardBaseInfo.rechargr_type > 0
	elseif self._passCardBaseInfo.rechargr_type == 2 or self._passCardBaseInfo.rechargr_type == 3 then
		return self._passCardRechargeInfo[self._passCardId][2], true
	elseif self._passCardBaseInfo.rechargr_type == 1 then
		return self._passCardRechargeInfo[self._passCardId][3], false
	else
		return self._passCardRechargeInfo[self._passCardId][2], false
	end
end

function PassCardData:setActivityEnd(arg_49_1)
	self._isActivityEnd = arg_49_1
end

function PassCardData:getActivityIsEnd()
	return self._isActivityEnd
end

function PassCardData:getLastLevelBigAward(arg_51_1, arg_51_2)
	if arg_51_1 == PassCardConst.RewardType.NORMAL then
		if arg_51_2 >= self._maxRewardMaxLevel then
			if self._passCardRewardInfo.bigNormalReward[#self._passCardRewardInfo.bigNormalReward].info.level == self._maxRewardMaxLevel then
				return self._passCardRewardInfo.bigNormalReward[#self._passCardRewardInfo.bigNormalReward]
			end
		end
	elseif arg_51_1 == PassCardConst.RewardType.SENIOR and arg_51_2 >= self._maxRewardMaxLevel then
		if self._passCardRewardInfo.bigSeniorReward[#self._passCardRewardInfo.bigSeniorReward].info.level == self._maxRewardMaxLevel then
			return self._passCardRewardInfo.bigSeniorReward[#self._passCardRewardInfo.bigSeniorReward]
		end
	end

	return nil
end

function PassCardData:getCurPassCardId()
	return self._passCardId
end

function PassCardData:getChargeSingleAwardDataByRewardType(arg_53_1, arg_53_2)
	if not arg_53_1 then
		return
	end

	for iter_53_0, iter_53_1 in ipairs(self._passCardRewardInfo.seniorReward or {}) do
		if arg_53_1 and not arg_53_2 then
			if iter_53_1.reward and iter_53_1.reward.type == arg_53_1 then
				return iter_53_1.info or {}
			end
		elseif iter_53_1.reward and iter_53_1.reward.type == arg_53_1 and iter_53_1.reward.value == arg_53_2 then
			return iter_53_1.info or {}
		end
	end

	return {}
end

return PassCardData
