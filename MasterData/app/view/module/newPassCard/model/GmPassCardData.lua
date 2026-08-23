local var_0_0 = g.core.config.gm_passcard_info
local var_0_1 = g.core.config.gm_passcard_level_info
local var_0_2 = g.core.config.gm_passcard_reward_info
local var_0_3 = g.core.config.gm_passcard_task_info
local var_0_4 = g.core.common.Goods
local GmPassCardConst = require("app.view.module.newPassCard.const.GmPassCardConst")
local GmPassCardData = class("GmPassCardData")

function GmPassCardData:insertInList(arg_1_1, arg_1_2)
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

function GmPassCardData:ctor()
	self:initData()
end

function GmPassCardData:initData()
	self._passCardIdMap = {}
	self._activity = nil
	self._actId = 0
	self._level = 0
	self._exp = 0
	self._isRecharge = false
	self._maxLv = 0
	self._hasSvrInfo = false
	self._freeLvAward = {}
	self._payLvAward = {}
	self._taskAwards = {}
	self._taskStateMap = {}
	self._taskCfgMap = {}

	self:_initTaskCfg()
end

function GmPassCardData:_initTaskCfg()
	if next(self._taskCfgMap) then
		return
	end

	for iter_4_0, iter_4_1 in var_0_3.ipairs() do
		self._taskCfgMap[iter_4_1.passcard_id] = self._taskCfgMap[iter_4_1.passcard_id] or {}
		self._taskCfgMap[iter_4_1.passcard_id][iter_4_1.task_type] = self._taskCfgMap[iter_4_1.passcard_id][iter_4_1.task_type] or {}

		table.insert(self._taskCfgMap[iter_4_1.passcard_id][iter_4_1.task_type], iter_4_1)
	end
end

function GmPassCardData:isMaxLv()
	return self._level >= self._maxLv
end

function GmPassCardData:getActivityCfg()
	return var_0_0.get(self._actId)
end

function GmPassCardData:onS2CRedPoint(arg_7_1)
	self:addActivity(arg_7_1.activity)

	self._svrRedAward = arg_7_1.award
end

function GmPassCardData:addActivity(arg_8_1)
	self._activity = arg_8_1
	self._actId = arg_8_1.sub_id

	self:passCardActOpen(self._actId)
end

function GmPassCardData:isInOpenTime()
	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.PASS_CARD_NEW) then
		return false
	end

	if not self._activity then
		return false
	end

	local var_9_0 = g.core.model.User:getLevel()

	if var_9_0 < self._activity.min_level or var_9_0 > self._activity.max_level then
		return false
	end

	local var_9_1 = g.core.common.ServerTime:getTime()

	return var_9_1 >= self._activity.start_time and var_9_1 <= self._activity.end_time
end

function GmPassCardData:getActivityTime()
	if not self._activity then
		return
	end

	return self._activity.start_time, self._activity.end_time
end

function GmPassCardData:updatePassCardRecharge(arg_11_1)
	self._isRecharge = true
end

function GmPassCardData:isNeedShowOneKey()
	local var_12_0 = 0

	for iter_12_0 = 1, self._level do
		if not self._freeLvAward[iter_12_0] then
			var_12_0 = var_12_0 + 1
		end

		if self._isRecharge and not self._payLvAward[iter_12_0] then
			var_12_0 = var_12_0 + 1
		end
	end

	return var_12_0
end

function GmPassCardData:updatePassCardData(arg_13_1)
	self._svrRedAward = false
	self._level = arg_13_1.level
	self._exp = arg_13_1.exp
	self._isRecharge = arg_13_1.recharge

	for iter_13_0, iter_13_1 in ipairs(arg_13_1.normal_award_lvs or {}) do
		self._freeLvAward[iter_13_1] = true
	end

	for iter_13_2, iter_13_3 in ipairs(arg_13_1.recharge_award_lvs or {}) do
		self._payLvAward[iter_13_3] = true
	end

	self._hasSvrInfo = true

	self:updateTaskInfo(arg_13_1.tasks)
end

function GmPassCardData:getRechargeId()
	return self._activity.id
end

function GmPassCardData:isGetLvReward(arg_15_1, arg_15_2)
	if arg_15_2 then
		return self._freeLvAward[arg_15_1]
	else
		return self._payLvAward[arg_15_1]
	end
end

function GmPassCardData:updateTaskInfo(arg_16_1)
	self._taskStateMap = {}
	self._taskAwards = {}

	for iter_16_0, iter_16_1 in ipairs(arg_16_1 or {}) do
		for iter_16_2, iter_16_3 in ipairs(iter_16_1.award_task_ids or {}) do
			self._taskAwards[iter_16_3] = true
		end

		self._taskStateMap[iter_16_1.reset_type] = self._taskStateMap[iter_16_1.reset_type] or {}

		for iter_16_4, iter_16_5 in ipairs(iter_16_1.actions or {}) do
			self._taskStateMap[iter_16_1.reset_type][iter_16_5.type .. "_" .. iter_16_5.key] = iter_16_5.value
		end
	end
end

function GmPassCardData:passCardTaskAward(arg_17_1)
	for iter_17_0, iter_17_1 in ipairs(arg_17_1.ids) do
		self._taskAwards[iter_17_1] = true
	end
end

function GmPassCardData:getAllCanRewardTaskIds()
	local var_18_0 = {}

	for iter_18_0, iter_18_1 in pairs(self._taskCfgMap[self._actId] or {}) do
		for iter_18_2, iter_18_3 in ipairs(iter_18_1) do
			if (iter_18_3.function_id == 0 or g.core.common.ModuleUnlock:isModuleUnlock(iter_18_3.function_id)) and not self._taskAwards[iter_18_3.id] then
				if self._taskStateMap[iter_18_3.task_type] then
					if (self._taskStateMap[iter_18_3.task_type][iter_18_3.action_id .. "_" .. iter_18_3.action_key] or 0) >= iter_18_3.action_value then
						table.insert(var_18_0, iter_18_3.id)
					end
				end
			end
		end
	end

	return var_18_0
end

function GmPassCardData:isHasTaskReward(arg_19_1)
	for iter_19_0, iter_19_1 in pairs(self._taskCfgMap[self._actId] or {}) do
		for iter_19_2, iter_19_3 in ipairs(iter_19_1) do
			if iter_19_3.task_type == arg_19_1 and (iter_19_3.function_id == 0 or g.core.common.ModuleUnlock:isModuleUnlock(iter_19_3.function_id)) and not self._taskAwards[iter_19_3.id] then
				if self._taskStateMap[iter_19_3.task_type] then
					if (self._taskStateMap[iter_19_3.task_type][iter_19_3.action_id .. "_" .. iter_19_3.action_key] or 0) >= iter_19_3.action_value then
						return true
					end
				end
			end
		end
	end

	return false
end

function GmPassCardData:onS2CActionStatusFlush(arg_20_1)
	self._taskStateMap[arg_20_1.status.reset_type] = self._taskStateMap[arg_20_1.status.reset_type] or {}
	self._taskStateMap[arg_20_1.status.reset_type][arg_20_1.status.id .. "_" .. arg_20_1.status.key] = arg_20_1.status.status
end

function GmPassCardData:getTaskByResetType(arg_21_1)
	local var_21_0 = {}

	if not self._taskCfgMap[self._actId][arg_21_1] then
		return var_21_0
	end

	local var_21_1 = g.core.common.ModuleUnlock

	for iter_21_0, iter_21_1 in ipairs(self._taskCfgMap[self._actId][arg_21_1]) do
		if iter_21_1.function_id == 0 or var_21_1:isModuleUnlock(iter_21_1.function_id) then
			local var_21_2 = 0
			local var_21_3, var_21_4

			if self._taskStateMap[arg_21_1] and not self._taskStateMap[arg_21_1][iter_21_1.action_id .. "_" .. iter_21_1.action_key] then
				::label_21_0::

				var_21_2 = 0
				var_21_3 = var_21_0
				var_21_4 = {
					cfg = iter_21_1
				}
			end

			var_21_4.state = self:getTaskState(iter_21_1)
			var_21_4.curValue = var_21_2

			table.insert(var_21_0, var_21_4)
		end
	end

	table.sort(var_21_0, function(arg_22_0, arg_22_1)
		if arg_22_0.state ~= arg_22_1.state then
			return arg_22_0.state < arg_22_1.state
		end

		return arg_22_0.cfg.id < arg_22_1.cfg.id
	end)

	return var_21_0
end

function GmPassCardData:getTaskState(arg_23_1)
	local var_23_0 = 0

	if self._taskStateMap[arg_23_1.task_type] then
		var_23_0 = self._taskStateMap[arg_23_1.task_type][arg_23_1.action_id .. "_" .. arg_23_1.action_key] or 0
	end

	local var_23_1 = GmPassCardConst.TASK_STATE.NOT_FINISH

	if self._taskAwards[arg_23_1.id] then
		var_23_1 = GmPassCardConst.TASK_STATE.GET
	elseif var_23_0 >= arg_23_1.action_value then
		var_23_1 = GmPassCardConst.TASK_STATE.FINISH
	end

	return var_23_1
end

function GmPassCardData:onGetActivityLevelAward(arg_24_1)
	if arg_24_1.lv == 0 then
		for iter_24_0 = 1, self._maxLv do
			if iter_24_0 <= self._level then
				self._freeLvAward[iter_24_0] = true

				if self._isRecharge then
					self._payLvAward[iter_24_0] = true
				end
			else
				break
			end
		end
	elseif arg_24_1.type == 1 then
		self._freeLvAward[arg_24_1.lv] = true
	else
		self._payLvAward[arg_24_1.lv] = true
	end
end

function GmPassCardData:updateBuyLevel(arg_25_1)
	self._level = arg_25_1.level
end

function GmPassCardData:getPassCardLv()
	return self._level
end

function GmPassCardData:getMinCanRewardLv()
	for iter_27_0 = 1, self._maxLv do
		if iter_27_0 <= self._level then
			if not self._freeLvAward[iter_27_0] then
				return iter_27_0
			end

			if self._isRecharge and not self._payLvAward[iter_27_0] then
				return iter_27_0
			end
		else
			break
		end
	end

	return self._level
end

function GmPassCardData:updateLvExp(arg_28_1)
	self._level = arg_28_1.level
	self._exp = arg_28_1.exp
end

function GmPassCardData:getMaxPassCardLv()
	return self._maxLv
end

function GmPassCardData:passCardActOpen(arg_30_1)
	if self._passCardIdMap[arg_30_1] then
		return
	end

	self._passCardIdMap[arg_30_1] = {}

	for iter_30_0, iter_30_1 in var_0_2.ipairs() do
		if iter_30_1.passcard_id == arg_30_1 then
			self._passCardIdMap[arg_30_1][iter_30_1.level] = iter_30_1
		end
	end

	if self._maxLv == 0 then
		for iter_30_2, iter_30_3 in var_0_1.ipairs() do
			if iter_30_3.next_level == 0 then
				self._maxLv = iter_30_3.id

				break
			end
		end
	end
end

function GmPassCardData:getCurPassCardLvCfg()
	return var_0_1.get((self._level > 0 or nil) and (self._level or 1))
end

function GmPassCardData:getCurPassCardCfg()
	return self._passCardIdMap[self._actId]
end

function GmPassCardData:getCurExp()
	return self._exp
end

function GmPassCardData:getBuyLevelCost(arg_34_1)
	local var_34_0 = {}
	local var_34_1 = {}

	for iter_34_0 = self._level, arg_34_1 - 1 do
		local var_34_2 = var_0_1.get(iter_34_0)

		if not var_34_2 then
			return
		end

		GmPassCardData.insertInList(var_34_1, var_34_0, var_0_4:convert({
			type = var_34_2.buy_type,
			value = var_34_2.buy_value,
			size = var_34_2.buy_size
		}))
	end

	return var_34_0
end

function GmPassCardData:getAllPassCardAwards()
	if not self._passCardIdMap[self._actId] then
		return
	end

	local var_35_0 = {}
	local var_35_1 = {}
	local var_35_2 = {}
	local var_35_3 = {}

	for iter_35_0, iter_35_1 in ipairs(self._passCardIdMap[self._actId]) do
		local var_35_4 = var_0_4:convert({
			type = iter_35_1.free_type,
			value = iter_35_1.free_value,
			size = iter_35_1.free_size
		})

		var_35_4.prize_type = iter_35_1.prize_type

		GmPassCardData.insertInList(var_35_1, var_35_0, var_35_4)

		local var_35_5 = var_0_4:convert({
			type = iter_35_1.pay_type,
			value = iter_35_1.pay_value,
			size = iter_35_1.pay_size
		})

		var_35_5.prize_type = iter_35_1.prize_type

		GmPassCardData.insertInList(var_35_3, var_35_2, var_35_5)
	end

	local function var_35_6(arg_36_0, arg_36_1)
		if arg_36_0.prize_type ~= arg_36_1.prize_type then
			return arg_36_0.prize_type == 1
		end

		if arg_36_0.quality ~= arg_36_1.quality then
			return arg_36_0.quality > arg_36_1.quality
		end

		return false
	end

	table.sort(var_35_0, var_35_6)
	table.sort(var_35_2, var_35_6)

	return var_35_0, var_35_2
end

function GmPassCardData:getUpgradePassCardAward(arg_37_1)
	if not self._passCardIdMap[self._actId] then
		return
	end

	local var_37_0 = {}

	arg_37_1 = arg_37_1 or self._level

	for iter_37_0 = self._level + 1, self._maxLv do
		if self._passCardIdMap[self._actId][iter_37_0] then
			if self._isRecharge then
				local var_37_1 = var_0_4:convert({
					type = self._passCardIdMap[self._actId][iter_37_0].pay_type,
					value = self._passCardIdMap[self._actId][iter_37_0].pay_value,
					size = self._passCardIdMap[self._actId][iter_37_0].pay_size
				})

				var_37_1.showMask = arg_37_1 < iter_37_0

				table.insert(var_37_0, var_37_1)
			end

			local var_37_2 = var_0_4:convert({
				type = self._passCardIdMap[self._actId][iter_37_0].free_type,
				value = self._passCardIdMap[self._actId][iter_37_0].free_value,
				size = self._passCardIdMap[self._actId][iter_37_0].free_size
			})

			var_37_2.showMask = arg_37_1 < iter_37_0

			table.insert(var_37_0, var_37_2)
		end
	end

	return var_37_0
end

function GmPassCardData:getNextBigAwardCfg(arg_38_1)
	for iter_38_0 = arg_38_1, #self._passCardIdMap[self._actId] do
		if self._passCardIdMap[self._actId][iter_38_0].prize_type == 1 then
			return self._passCardIdMap[self._actId][iter_38_0]
		end
	end

	return nil
end

function GmPassCardData:isRecharge()
	return self._isRecharge
end

function GmPassCardData:hasPassCardLevelReward()
	if self._svrRedAward then
		return true
	end

	if not self._hasSvrInfo then
		return false
	end

	for iter_40_0 = 1, self._maxLv do
		if iter_40_0 <= self._level then
			if not self._freeLvAward[iter_40_0] then
				return true
			end

			if self._isRecharge and not self._payLvAward[iter_40_0] then
				return true
			end
		else
			break
		end
	end

	return false
end

function GmPassCardData:hasPassCardTaskReward()
	if not self._hasSvrInfo then
		return false
	end

	return #self:getAllCanRewardTaskIds() > 0
end

return GmPassCardData
