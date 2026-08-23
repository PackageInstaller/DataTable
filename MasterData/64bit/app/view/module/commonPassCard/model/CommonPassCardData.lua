local var_0_0 = g.core.config.common_passcard_info
local var_0_1 = g.core.config.common_passcard_level_info
local var_0_2 = g.core.config.common_passcard_reward_info
local var_0_3 = g.core.config.common_passcard_task_info
local var_0_4 = g.core.config.common_passcard_pay_info
local var_0_5 = g.core.common.Goods
local var_0_6 = g.core.const.ConstMgr.CommonPassCardConst
local CommonPassCardData = class("CommonPassCardData")

function CommonPassCardData:insertInList(arg_1_1, arg_1_2)
	if not arg_1_2 then
		return
	end

	local var_1_0 = self[arg_1_2.type .. "_" .. arg_1_2.value .. tostring(arg_1_2.showMask)]

	if not var_1_0 then
		self[arg_1_2.type .. "_" .. arg_1_2.value .. tostring(arg_1_2.showMask)] = arg_1_2

		table.insert(arg_1_1, arg_1_2)
	else
		var_1_0.size = var_1_0.size + arg_1_2.size
	end
end

function CommonPassCardData:ctor(arg_2_1)
	self._actId = arg_2_1

	self:initPassCardData()
end

function CommonPassCardData:initPassCardData()
	self._passCardIdMap = {}
	self._activity = nil
	self._level = 0
	self._exp = 0
	self._isRecharge = false
	self._maxLv = 0
	self._hasSvrInfo = false
	self._startTime = 0
	self._endTime = 0
	self._preTime = 0
	self._freeLvAward = {}
	self._payLvAward = {}
	self._taskAwards = {}
	self._taskStateMap = {}
	self._taskCfgMap = {}
	self._passCardPayCfgMap = {}

	self:_initTaskCfg()
	self:_initPassCardPayCfg()
	self:passCardActOpen()
end

function CommonPassCardData:_initTaskCfg()
	for iter_4_0, iter_4_1 in var_0_3.ipairs() do
		self._taskCfgMap[iter_4_1.group] = self._taskCfgMap[iter_4_1.group] or {}
		self._taskCfgMap[iter_4_1.group][iter_4_1.task_type] = self._taskCfgMap[iter_4_1.group][iter_4_1.task_type] or {}

		table.insert(self._taskCfgMap[iter_4_1.group][iter_4_1.task_type], iter_4_1)
	end
end

function CommonPassCardData:_initPassCardPayCfg()
	for iter_5_0, iter_5_1 in var_0_4.ipairs() do
		self._passCardPayCfgMap[iter_5_1.id] = self._passCardPayCfgMap[iter_5_1.id] or {}
		self._passCardPayCfgMap[iter_5_1.id][iter_5_1.type] = self._passCardPayCfgMap[iter_5_1.id][iter_5_1.type] or {}
		self._passCardPayCfgMap[iter_5_1.id][iter_5_1.type] = iter_5_1
	end
end

function CommonPassCardData:getPassCardPayInfo(arg_6_1, arg_6_2)
	return self._passCardPayCfgMap[self:getActivityCfg().pay_group][arg_6_2]
end

function CommonPassCardData:isMaxLv()
	return self._level >= self._maxLv
end

function CommonPassCardData:getActivityCfg()
	return var_0_0.fetch(self._actId)
end

function CommonPassCardData:onS2CRedPoint(arg_9_1)
	self:addActivity(arg_9_1.id)

	self._svrRedAward = arg_9_1.is_hint
end

function CommonPassCardData:addActivity(arg_10_1)
	self._actId = arg_10_1
end

function CommonPassCardData:setActBETimeByModule(arg_11_1, arg_11_2, arg_11_3)
	self._startTime = arg_11_1
	self._endTime = arg_11_2
	self._preTime = arg_11_3
end

function CommonPassCardData:isInOpenTime()
	local var_12_0 = g.core.common.ServerTime:getTime()

	return var_12_0 >= self._startTime and var_12_0 <= self._endTime
end

function CommonPassCardData:getActivityTime()
	return self._startTime, self._endTime
end

function CommonPassCardData:updatePassCardRecharge(arg_14_1)
	self._rechargeType = arg_14_1.tp
	self._isRecharge = self._rechargeType > 0
end

function CommonPassCardData:isNeedShowOneKey()
	local var_15_0 = 0

	for iter_15_0 = 1, self._level do
		if not self._freeLvAward[iter_15_0] then
			var_15_0 = var_15_0 + 1
		end

		if self._isRecharge and not self._payLvAward[iter_15_0] then
			var_15_0 = var_15_0 + 1
		end
	end

	return var_15_0
end

function CommonPassCardData:updatePassCardData(arg_16_1)
	self._svrRedAward = false
	self._level = arg_16_1.level
	self._exp = arg_16_1.exp
	self._rechargeType = arg_16_1.recharge_type
	self._isRecharge = self._rechargeType > 0

	for iter_16_0, iter_16_1 in ipairs(arg_16_1.normal_award_lvs or {}) do
		self._freeLvAward[iter_16_1] = true
	end

	for iter_16_2, iter_16_3 in ipairs(arg_16_1.recharge_award_lvs or {}) do
		self._payLvAward[iter_16_3] = true
	end

	self._hasSvrInfo = true

	self:updateTaskInfo(arg_16_1.tasks)
end

function CommonPassCardData:getRechargeType()
	return self._rechargeType
end

function CommonPassCardData:isGetLvReward(arg_18_1, arg_18_2)
	if arg_18_2 then
		return self._freeLvAward[arg_18_1]
	else
		return self._payLvAward[arg_18_1]
	end
end

function CommonPassCardData:updateTaskInfo(arg_19_1)
	self._taskStateMap = {}
	self._taskAwards = {}

	for iter_19_0, iter_19_1 in ipairs(arg_19_1 or {}) do
		for iter_19_2, iter_19_3 in ipairs(iter_19_1.award_task_ids or {}) do
			self._taskAwards[iter_19_3] = true
		end

		self._taskStateMap[iter_19_1.reset_type] = self._taskStateMap[iter_19_1.reset_type] or {}

		for iter_19_4, iter_19_5 in ipairs(iter_19_1.actions or {}) do
			self._taskStateMap[iter_19_1.reset_type][iter_19_5.type .. "_" .. iter_19_5.key] = iter_19_5.value
		end
	end
end

function CommonPassCardData:passCardTaskAward(arg_20_1)
	for iter_20_0, iter_20_1 in ipairs(arg_20_1.task_ids) do
		self._taskAwards[iter_20_1] = true
	end
end

function CommonPassCardData:getAllCanRewardTaskIds()
	local var_21_0 = {}

	for iter_21_0, iter_21_1 in pairs(self._taskCfgMap[self:getActivityCfg().task_group] or {}) do
		for iter_21_2, iter_21_3 in ipairs(iter_21_1) do
			if (iter_21_3.function_id == 0 or g.core.common.ModuleUnlock:isModuleUnlock(iter_21_3.function_id)) and not self._taskAwards[iter_21_3.id] then
				if self._taskStateMap[iter_21_3.task_type] then
					if (self._taskStateMap[iter_21_3.task_type][iter_21_3.action_id .. "_" .. iter_21_3.action_key] or 0) >= iter_21_3.action_value then
						table.insert(var_21_0, iter_21_3.id)
					end
				end
			end
		end
	end

	return var_21_0
end

function CommonPassCardData:isHasTaskReward(arg_22_1)
	for iter_22_0, iter_22_1 in pairs(self._taskCfgMap[self:getActivityCfg().task_group] or {}) do
		for iter_22_2, iter_22_3 in ipairs(iter_22_1) do
			if iter_22_3.task_type == arg_22_1 and (iter_22_3.function_id == 0 or g.core.common.ModuleUnlock:isModuleUnlock(iter_22_3.function_id)) and not self._taskAwards[iter_22_3.id] then
				if self._taskStateMap[iter_22_3.task_type] then
					if (self._taskStateMap[iter_22_3.task_type][iter_22_3.action_id .. "_" .. iter_22_3.action_key] or 0) >= iter_22_3.action_value then
						return true
					end
				end
			end
		end
	end

	return false
end

function CommonPassCardData:onS2CActionStatusFlush(arg_23_1)
	self._taskStateMap[arg_23_1.reset_type] = self._taskStateMap[arg_23_1.reset_type] or {}
	self._taskStateMap[arg_23_1.reset_type][arg_23_1.action.type .. "_" .. arg_23_1.action.key] = arg_23_1.action.value
end

function CommonPassCardData:getTaskByResetType(arg_24_1)
	local var_24_0 = {}
	local var_24_1 = self._taskCfgMap[self:getActivityCfg().task_group][arg_24_1]

	if not var_24_1 then
		return var_24_0
	end

	local var_24_2 = g.core.common.ModuleUnlock

	for iter_24_0, iter_24_1 in ipairs(var_24_1) do
		if iter_24_1.function_id == 0 or var_24_2:isModuleUnlock(iter_24_1.function_id) then
			local var_24_3 = 0
			local var_24_4, var_24_5

			if self._taskStateMap[arg_24_1] and not self._taskStateMap[arg_24_1][iter_24_1.action_id .. "_" .. iter_24_1.action_key] then
				::label_24_0::

				var_24_3 = 0
				var_24_4 = var_24_0
				var_24_5 = {
					cfg = iter_24_1
				}
			end

			var_24_5.state = self:getTaskState(iter_24_1)
			var_24_5.curValue = var_24_3

			table.insert(var_24_0, var_24_5)
		end
	end

	table.sort(var_24_0, function(arg_25_0, arg_25_1)
		if arg_25_0.state ~= arg_25_1.state then
			return arg_25_0.state < arg_25_1.state
		end

		return arg_25_0.cfg.id < arg_25_1.cfg.id
	end)

	return var_24_0
end

function CommonPassCardData:getTaskState(arg_26_1)
	local var_26_0 = 0

	if self._taskStateMap[arg_26_1.task_type] then
		var_26_0 = self._taskStateMap[arg_26_1.task_type][arg_26_1.action_id .. "_" .. arg_26_1.action_key] or 0
	end

	local var_26_1 = var_0_6.TASK_STATE.NOT_FINISH

	if self._taskAwards[arg_26_1.id] then
		var_26_1 = var_0_6.TASK_STATE.GET
	elseif var_26_0 >= arg_26_1.action_value then
		var_26_1 = var_0_6.TASK_STATE.FINISH
	end

	return var_26_1
end

function CommonPassCardData:onGetActivityLevelAward(arg_27_1)
	if arg_27_1.level == 0 then
		for iter_27_0 = 1, self._maxLv do
			if iter_27_0 <= self._level then
				self._freeLvAward[iter_27_0] = true

				if self._isRecharge then
					self._payLvAward[iter_27_0] = true
				end
			else
				break
			end
		end
	elseif arg_27_1.type == 1 then
		self._freeLvAward[arg_27_1.level] = true
	else
		self._payLvAward[arg_27_1.level] = true
	end
end

function CommonPassCardData:updateBuyLevel(arg_28_1)
	self._level = arg_28_1.level
end

function CommonPassCardData:getPassCardLv()
	return self._level
end

function CommonPassCardData:getMinCanRewardLv()
	for iter_30_0 = 1, self._maxLv do
		if iter_30_0 <= self._level then
			if not self._freeLvAward[iter_30_0] then
				return iter_30_0
			end

			if self._isRecharge and not self._payLvAward[iter_30_0] then
				return iter_30_0
			end
		else
			break
		end
	end

	return self._level
end

function CommonPassCardData:updateLvExp(arg_31_1)
	self._level = arg_31_1.level
	self._exp = arg_31_1.exp
end

function CommonPassCardData:getMaxPassCardLv()
	return self._maxLv
end

function CommonPassCardData:passCardActOpen()
	local var_33_0 = self:getActivityCfg()

	if not var_33_0 then
		return
	end

	local var_33_1 = var_33_0.reward_group

	if self._passCardIdMap[var_33_0.reward_group] then
		return
	end

	self._passCardIdMap[var_33_1] = {}

	for iter_33_0, iter_33_1 in var_0_2.ipairs() do
		if iter_33_1.group == var_33_1 then
			self._passCardIdMap[var_33_1][iter_33_1.level] = iter_33_1
		end
	end

	if self._maxLv == 0 then
		for iter_33_2, iter_33_3 in var_0_1.ipairs() do
			if iter_33_3.next_level == 0 then
				self._maxLv = iter_33_3.id

				break
			end
		end
	end
end

function CommonPassCardData:getCurPassCardLvCfg()
	return var_0_1.get((self._level > 0 or nil) and (self._level or 1))
end

function CommonPassCardData:getCurPassCardCfg()
	return self._passCardIdMap[self:getActivityCfg().reward_group]
end

function CommonPassCardData:getCurExp()
	return self._exp
end

function CommonPassCardData:getBuyLevelCost(arg_37_1)
	local var_37_0 = {}
	local var_37_1 = {}

	for iter_37_0 = self._level, arg_37_1 - 1 do
		local var_37_2 = var_0_1.get(iter_37_0)

		if not var_37_2 then
			return
		end

		CommonPassCardData.insertInList(var_37_1, var_37_0, var_0_5:convert({
			type = var_37_2.buy_type,
			value = var_37_2.buy_value,
			size = var_37_2.buy_size
		}))
	end

	return var_37_0
end

function CommonPassCardData:getAllPassCardAwards()
	local var_38_0 = self._passCardIdMap[self:getActivityCfg().reward_group]

	if not var_38_0 then
		return
	end

	local var_38_1 = {}
	local var_38_2 = {}
	local var_38_3 = {}
	local var_38_4 = {}

	for iter_38_0, iter_38_1 in ipairs(var_38_0) do
		local var_38_5 = var_0_5:convert({
			type = iter_38_1.free_type,
			value = iter_38_1.free_value,
			size = iter_38_1.free_size
		})

		var_38_5.prize_type = iter_38_1.prize_type

		CommonPassCardData.insertInList(var_38_2, var_38_1, var_38_5)

		local var_38_6 = var_0_5:convert({
			type = iter_38_1.pay_type,
			value = iter_38_1.pay_value,
			size = iter_38_1.pay_size
		})

		var_38_6.prize_type = iter_38_1.prize_type

		CommonPassCardData.insertInList(var_38_4, var_38_3, var_38_6)
	end

	local function var_38_7(arg_39_0, arg_39_1)
		if arg_39_0.prize_type ~= arg_39_1.prize_type then
			return arg_39_0.prize_type == 1
		end

		if arg_39_0.quality ~= arg_39_1.quality then
			return arg_39_0.quality > arg_39_1.quality
		end

		return false
	end

	table.sort(var_38_1, var_38_7)
	table.sort(var_38_3, var_38_7)

	return var_38_1, var_38_3
end

function CommonPassCardData:getUpgradePassCardAward(arg_40_1)
	local var_40_0 = self._passCardIdMap[self:getActivityCfg().reward_group]

	if not var_40_0 then
		return
	end

	local var_40_1 = {}

	arg_40_1 = arg_40_1 or self._level

	for iter_40_0 = self._level + 1, self._maxLv do
		if var_40_0[iter_40_0] then
			if self._isRecharge then
				local var_40_2 = var_0_5:convert({
					type = var_40_0[iter_40_0].pay_type,
					value = var_40_0[iter_40_0].pay_value,
					size = var_40_0[iter_40_0].pay_size
				})

				var_40_2.showMask = arg_40_1 < iter_40_0

				table.insert(var_40_1, var_40_2)
			end

			local var_40_3 = var_0_5:convert({
				type = var_40_0[iter_40_0].free_type,
				value = var_40_0[iter_40_0].free_value,
				size = var_40_0[iter_40_0].free_size
			})

			var_40_3.showMask = arg_40_1 < iter_40_0

			table.insert(var_40_1, var_40_3)
		end
	end

	return var_40_1
end

function CommonPassCardData:getNextBigAwardCfg(arg_41_1)
	local var_41_0 = self._passCardIdMap[self:getActivityCfg().reward_group]

	for iter_41_0 = arg_41_1, #var_41_0 do
		if var_41_0[iter_41_0].prize_type == 1 then
			return var_41_0[iter_41_0]
		end
	end

	return nil
end

function CommonPassCardData:isRecharge()
	return self._isRecharge
end

function CommonPassCardData:hasPassCardLevelReward()
	if self._svrRedAward then
		return true
	end

	if not self._hasSvrInfo then
		return false
	end

	for iter_43_0 = 1, self._maxLv do
		if iter_43_0 <= self._level then
			if not self._freeLvAward[iter_43_0] then
				return true
			end

			if self._isRecharge and not self._payLvAward[iter_43_0] then
				return true
			end
		else
			break
		end
	end

	return false
end

function CommonPassCardData:hasPassCardTaskReward()
	if not self._hasSvrInfo then
		return false
	end

	if self._preTime then
		local var_44_0 = g.core.common.ServerTime:getTime()

		if var_44_0 >= self._preTime and var_44_0 < self._startTime then
			return false
		end
	end

	return #self:getAllCanRewardTaskIds() > 0
end

return CommonPassCardData
