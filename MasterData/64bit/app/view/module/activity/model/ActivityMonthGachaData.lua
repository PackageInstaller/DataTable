local var_0_0 = g.core.config.month_gacha
local var_0_1 = g.core.config.month_gacha_reward
local var_0_2 = g.core.config.month_gacha_mission
local var_0_3 = g.core.const.ConstMgr.ActivityConst.ACTIVITY_TYPE.MONTH_GACHA
local var_0_4 = g.core.const.ConstMgr.ActivityConst.MONTH_GACHA_QUALITY_MAP
local var_0_5 = {
	PHASE = 2,
	DAILY = 1
}
local var_0_6 = g.core.const.ConstMgr.ActivityConst.ROUND_STATE
local ActivityMonthGachaData = class("ActivityMonthGachaData")

function ActivityMonthGachaData:ctor()
	self:initCfg()
	self:initData()
end

function ActivityMonthGachaData:initCfg()
	self._allRewardCfg = {}
	self._allTaskCfg = {}
	self._reqTaskInfo = false
	self._isShowTaskRedPoint = false
	self._rewardChooseIndexs = {}
	self._drawTimes = 0

	for iter_2_0 = 1, var_0_1.getLength() do
		local var_2_0 = var_0_1.indexOf(iter_2_0)

		self._allRewardCfg[var_2_0.stage] = self._allRewardCfg[var_2_0.stage] or {}

		table.insert(self._allRewardCfg[var_2_0.stage], var_2_0)
	end

	for iter_2_1 = 1, var_0_2.getLength() do
		local var_2_1 = var_0_2.indexOf(iter_2_1)

		self._allTaskCfg[var_2_1.stage] = self._allTaskCfg[var_2_1.stage] or {}

		table.insert(self._allTaskCfg[var_2_1.stage], var_2_1)
	end
end

function ActivityMonthGachaData:initData()
	self._curTaskData = {}
	self._curStageTask = {}
	self._curRewardData = {}
	self._curTaskIdData = {}
	self._curRewardIdData = {}
	self._curStageCfg = nil
	self._activityId = 0
	self._svrActivityId = 0
	self._activityData = nil
	self._redPointAllAwardEmpty = false
	self._bigRewardData = nil
	self._curRound = 1
	self._luckyValue = 0
	self._startTime = 0
	self._endTime = 0
	self._lastSNum = 999
end

function ActivityMonthGachaData:onUpdateRedPoint(arg_4_1)
	self._reqTaskInfo = false
	self._isShowTaskRedPoint = arg_4_1.awardable
	self._activityData = arg_4_1.activity
	self._redPointAllAwardEmpty = arg_4_1.reward_pool_end

	self:updateByActivity(arg_4_1.activity)
	self:addToGmActivityMgr()
end

function ActivityMonthGachaData:onUpdateStageData(arg_5_1)
	self._activityData = arg_5_1.activity
	self._lastSNum = arg_5_1.ssr_guarant_num

	if arg_5_1.activity then
		self:updateByActivity(arg_5_1.activity)
	end

	self._luckyValue = arg_5_1.lucky_value or 0

	if arg_5_1.reward_id_index then
		for iter_5_0, iter_5_1 in ipairs(arg_5_1.reward_id_index) do
			self._rewardChooseIndexs[iter_5_1.id] = iter_5_1.num
		end
	end

	self._curRound = arg_5_1.round
	self._drawTimes = arg_5_1.draw_total_times or self._drawTimes

	self:updateActivityData(arg_5_1)
	self:addToGmActivityMgr()
end

function ActivityMonthGachaData:updateByActivity(arg_6_1)
	if not arg_6_1 then
		return
	end

	if self._activityId == arg_6_1.activity_sub_id and self._svrActivityId == arg_6_1.activity_id then
		return
	end

	self._activityId = arg_6_1.activity_sub_id
	self._svrActivityId = arg_6_1.activity_id
	self._curStageCfg = var_0_0.get(self._activityId)
	self._startTime = arg_6_1.start_time
	self._endTime = arg_6_1.end_time

	self:checkAndUpdateCurStageData()
end

function ActivityMonthGachaData:checkAndUpdateCurStageData()
	self._curTaskData = {}
	self._curRewardData = {}
	self._curTaskIdData = {}
	self._curRewardIdData = {}

	if not self._allRewardCfg[self._activityId] then
		g.core.log:error("can't find month_gacha_reward target reward config,activityId = " .. self._activityId)

		return
	end

	local var_7_0 = self._allTaskCfg[self._activityId]

	if not self._allTaskCfg[self._activityId] then
		g.core.log:error("can't find month_gacha_mission target task config,activityId = " .. self._activityId)

		return
	end

	for iter_7_0, iter_7_1 in ipairs(self._allRewardCfg[self._activityId]) do
		local var_7_1 = {
			lastNum = iter_7_1.reward_num,
			allNum = iter_7_1.reward_num,
			cfgId = iter_7_1.id,
			quality = iter_7_1.type,
			award = {
				type = iter_7_1.reward_type1,
				value = iter_7_1.reward_value1,
				size = iter_7_1.reward_num1
			},
			dropId = iter_7_1.reward_drop,
			dropName = iter_7_1.drop_name,
			isBigReward = iter_7_1.if_big_reward == 1
		}

		if iter_7_1.reward_type1 == 0 then
			var_7_1.award = nil
		else
			var_7_1.good = g.core.common.Goods:convert(var_7_1.award)
		end

		if var_7_1.isBigReward then
			self._bigRewardData = var_7_1
		end

		self._curRewardIdData[iter_7_1.id] = var_7_1

		table.insert(self._curRewardData, var_7_1)
	end

	for iter_7_2, iter_7_3 in ipairs(var_7_0) do
		local var_7_2 = {
			curValue = 0,
			isReward = false,
			taskCfg = iter_7_3
		}

		self._curTaskIdData[iter_7_3.id] = var_7_2

		if iter_7_3.task_type ~= var_0_5.STAGE then
			table.insert(self._curTaskData, var_7_2)
		else
			table.insert(self._curStageTask, var_7_2)
		end
	end
end

function ActivityMonthGachaData:isHasLeftReward()
	if not self._reqTaskInfo then
		return not self._redPointAllAwardEmpty
	end

	for iter_8_0, iter_8_1 in ipairs(self._curRewardData) do
		if iter_8_1.lastNum > 0 then
			return true
		end
	end

	return false
end

function ActivityMonthGachaData:updateActivityData(arg_9_1)
	local var_9_1 = {}

	for iter_9_0, iter_9_1 in ipairs(arg_9_1.reward_ids or {}) do
		var_9_1[iter_9_1.id] = iter_9_1.num
	end

	for iter_9_2, iter_9_3 in ipairs(self._curRewardData) do
		if var_9_1[iter_9_3.cfgId] then
			iter_9_3.lastNum = iter_9_3.allNum - var_9_1[iter_9_3.cfgId]
		end
	end
end

function ActivityMonthGachaData:onGetDrawReward(arg_10_1)
	self._lastSNum = arg_10_1.ssr_guarant_num

	if arg_10_1.reward_ids then
		for iter_10_0, iter_10_1 in ipairs(arg_10_1.reward_ids) do
			self._curRewardIdData[iter_10_1.id].lastNum = self._curRewardIdData[iter_10_1.id].lastNum - iter_10_1.num

			if self._curRewardIdData[iter_10_1.id].isBigReward and self._curRewardIdData[iter_10_1.id].lastNum == 0 then
				self._curRewardIdData[iter_10_1.id].isNeedShowPop = true
			end
		end
	end

	self._luckyValue = arg_10_1.lucky_value
	self._drawTimes = arg_10_1.draw_total_times or self._drawTimes
end

function ActivityMonthGachaData:getLastSNum()
	if self._curStageCfg then
		return self._curStageCfg.SSR_times - self._lastSNum % self._curStageCfg.SSR_times
	end

	return 0
end

function ActivityMonthGachaData:getLastRewardSNum()
	if self._curStageCfg then
		return self._curStageCfg.SSR_times - self._luckyValue
	end

	return 0
end

function ActivityMonthGachaData:isHasSRewardCanGet()
	for iter_13_0, iter_13_1 in pairs(self._curRewardIdData) do
		if iter_13_1.quality == var_0_4.SSR and iter_13_1.lastNum > 0 then
			return true
		end
	end

	return false
end

function ActivityMonthGachaData:getTargetRewardById(arg_14_1)
	return self._curRewardIdData[arg_14_1.id].award or g.core.common.Drops:getGoodsArray(self._curRewardIdData[arg_14_1.id].dropId)[self._rewardChooseIndexs[self._curRewardIdData[arg_14_1.id].cfgId] or 1], self._curRewardIdData[arg_14_1.id].quality
end

function ActivityMonthGachaData:updateTaskValue(arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(self._curTaskData) do
		if arg_15_1.daily_value and iter_15_1.taskCfg.type == var_0_5.DAILY and arg_15_1.daily_value.type == iter_15_1.taskCfg.task_type then
			if iter_15_1.taskCfg.task_value >= arg_15_1.daily_value.value then
				iter_15_1.curValue = arg_15_1.daily_value.value or iter_15_1.taskCfg.task_value
			end
		elseif arg_15_1.phase_value and iter_15_1.taskCfg.type == var_0_5.PHASE and arg_15_1.phase_value.type == iter_15_1.taskCfg.task_type then
			if iter_15_1.taskCfg.task_value >= arg_15_1.phase_value.value then
				iter_15_1.curValue = arg_15_1.phase_value.value or iter_15_1.taskCfg.task_value
			end
		end
	end
end

function ActivityMonthGachaData:isActOpen(arg_16_1)
	local var_16_0 = g.core.model.User.activityDataManager:getCustomActivityData(var_0_3, self._svrActivityId)

	if not var_16_0 then
		return false
	end

	if not arg_16_1 then
		return var_16_0:isOpen()
	end

	return arg_16_1 == self._activityId and var_16_0:isOpen()
end

function ActivityMonthGachaData:onGetTaskInfo(arg_17_1)
	self._reqTaskInfo = true

	local var_17_0 = {}
	local var_17_1 = {}

	if arg_17_1.task_infos then
		for iter_17_0, iter_17_1 in ipairs(arg_17_1.task_infos.daily_tasks or {}) do
			var_17_0[iter_17_1.type] = iter_17_1.value
		end

		for iter_17_2, iter_17_3 in ipairs(arg_17_1.task_infos.phase_tasks or {}) do
			var_17_1[iter_17_3.type] = iter_17_3.value
		end
	end

	for iter_17_4, iter_17_5 in ipairs(self._curTaskData) do
		local var_17_3 = iter_17_5.taskCfg

		if iter_17_5.taskCfg.type == var_0_5.DAILY then
			local var_17_4 = var_17_0[var_17_3.task_type] or 0

			iter_17_5.curValue = var_17_4 <= var_17_3.task_value and var_17_4 or var_17_3.task_value
		elseif var_17_3.type == var_0_5.PHASE then
			local var_17_5 = var_17_1[var_17_3.task_type] or 0

			iter_17_5.curValue = var_17_5 <= var_17_3.task_value and var_17_5 or var_17_3.task_value
		end

		iter_17_5.isReward = false
	end

	for iter_17_6, iter_17_7 in ipairs(arg_17_1.task_awarded_ids or {}) do
		self._curTaskIdData[iter_17_7].isReward = true
	end
end

function ActivityMonthGachaData:onGetTaskReward(arg_18_1)
	if arg_18_1.task_ids then
		for iter_18_0, iter_18_1 in ipairs(arg_18_1.task_ids) do
			self._curTaskIdData[iter_18_1].isReward = true
		end
	end
end

function ActivityMonthGachaData:isAllRewardAllChoose()
	for iter_19_0, iter_19_1 in ipairs(self._curRewardData) do
		if iter_19_1.dropId ~= 0 and not self._rewardChooseIndexs[iter_19_1.cfgId] then
			return false
		end
	end

	return true
end

function ActivityMonthGachaData:getTaskData(arg_20_1)
	local var_20_0 = {}

	if arg_20_1 then
		for iter_20_0, iter_20_1 in ipairs(self._curTaskData) do
			if iter_20_1.taskCfg.reward_task == 1 then
				table.insert(var_20_0, iter_20_1)
			end
		end
	else
		for iter_20_2, iter_20_3 in ipairs(self._curTaskData) do
			if iter_20_3.taskCfg.reward_task == 0 then
				table.insert(var_20_0, iter_20_3)
			end
		end

		table.sort(var_20_0, function(arg_21_0, arg_21_1)
			if ((not arg_21_0.isReward or false) and arg_21_0.taskCfg.task_value <= arg_21_0.curValue) ~= ((not arg_21_1.isReward or false) and arg_21_1.taskCfg.task_value <= arg_21_1.curValue) then
				return (not arg_21_0.isReward or false) and arg_21_0.taskCfg.task_value <= arg_21_0.curValue
			end

			if arg_21_0.isReward ~= arg_21_1.isReward then
				return arg_21_1.isReward
			end

			if arg_21_0.taskCfg.id ~= arg_21_1.taskCfg.id then
				return arg_21_0.taskCfg.id < arg_21_1.taskCfg.id
			end

			return false
		end)
	end

	return var_20_0
end

function ActivityMonthGachaData:getNewTaskData()
	return self._curStageTask
end

function ActivityMonthGachaData:getAllRewardData()
	return self._curRewardData
end

function ActivityMonthGachaData:getLuckyValue()
	return self._luckyValue
end

function ActivityMonthGachaData:getSelectRewardIndex(arg_25_1)
	return self._rewardChooseIndexs[arg_25_1]
end

function ActivityMonthGachaData:getNormalDrawItemId()
	if self._curStageCfg then
		return self._curStageCfg.item_1
	end
end

function ActivityMonthGachaData:getSpecialDrawItemId()
	if self._curStageCfg then
		return self._curStageCfg.item_2
	end
end

function ActivityMonthGachaData:getAllDrawNums()
	return g.core.model.User.bagData:getCountById(g.core.common.Goods.TYPE_ITEM, (self:getNormalDrawItemId())) + g.core.model.User.bagData:getCountById(g.core.common.Goods.TYPE_ITEM, (self:getSpecialDrawItemId()))
end

function ActivityMonthGachaData:isHasCanUseDraw()
	if not self:isActOpen() then
		return false
	end

	if not self:isHasLeftReward() then
		return false
	end

	if self._curStageCfg then
		return self:getAllDrawNums() > 0
	end

	return false
end

function ActivityMonthGachaData:getAllAndLastNumByQuality(arg_30_1)
	local var_30_0 = 0
	local var_30_1 = 0

	for iter_30_0, iter_30_1 in ipairs(self._curRewardData) do
		if iter_30_1.quality == arg_30_1 then
			var_30_0 = var_30_0 + iter_30_1.allNum
			var_30_1 = var_30_1 + iter_30_1.lastNum
		end
	end

	return var_30_1, var_30_0
end

function ActivityMonthGachaData:isCanRewardTask()
	if not self:isActOpen() then
		return false
	end

	if not self._reqTaskInfo then
		return self._isShowTaskRedPoint
	else
		for iter_31_0, iter_31_1 in pairs(self._curTaskIdData) do
			if iter_31_1.taskCfg.reward_task == 0 and not iter_31_1.isReward and iter_31_1.taskCfg.task_value <= iter_31_1.curValue then
				return true
			end
		end

		return false
	end
end

function ActivityMonthGachaData:isCanRewardStageTask()
	if not self:isActOpen() then
		return false
	end

	if not self._reqTaskInfo then
		return self._isShowTaskRedPoint
	else
		for iter_32_0, iter_32_1 in pairs(self._curTaskIdData) do
			if iter_32_1.taskCfg.reward_task == 1 and not iter_32_1.isReward and iter_32_1.taskCfg.task_value <= iter_32_1.curValue then
				return true
			end
		end

		return false
	end
end

function ActivityMonthGachaData:addToGmActivityMgr()
	if self._svrActivityId == 0 or self._activityId == 0 then
		return
	end

	g.core.model.User.activityDataManager:addIndependentCustomActivity({
		type = var_0_3,
		id = self._svrActivityId,
		sub_activity_id = self._activityId,
		title = g.core.lang:get(408101),
		start_time = self._startTime,
		finish_time = self._endTime
	})
end

function ActivityMonthGachaData:getActId()
	return self._svrActivityId
end

function ActivityMonthGachaData:getActivityTime()
	return self._startTime, self._endTime
end

function ActivityMonthGachaData:getTimeData()
	return self._startTime, self._endTime, self._endTime
end

function ActivityMonthGachaData:isBigRewardGet()
	if not self._bigRewardData then
		return false
	end

	return self._bigRewardData.lastNum == 0
end

function ActivityMonthGachaData:isNeedShowPop()
	if not self._bigRewardData then
		return false
	end

	local var_38_0, var_38_1 = self:getCurRoundAndState()

	if var_38_1 == var_0_6.STATE_END_ROUND then
		return false
	end

	local var_38_2 = false

	if self._bigRewardData.isNeedShowPop then
		self._bigRewardData.isNeedShowPop = false
		var_38_2 = true
	end

	return self._bigRewardData.lastNum == 0 and var_38_2
end

function ActivityMonthGachaData:resetAllReward()
	for iter_39_0, iter_39_1 in ipairs(self._curRewardData) do
		iter_39_1.lastNum = iter_39_1.allNum
	end
end

function ActivityMonthGachaData:onChooseRewardItem(arg_40_1)
	self._rewardChooseIndexs[arg_40_1.award_id] = arg_40_1.index
end

function ActivityMonthGachaData:getCurRoundAndState()
	if self._curStageCfg then
		local var_41_0 = var_0_6.STATE_END_ROUND

		if self._curRound == 0 then
			var_41_0 = var_0_6.STATE_FIRST_ROUND
		elseif self._curRound < self._curStageCfg.round - 1 then
			var_41_0 = var_0_6.STATE_IN_ROUND
		end

		return self._curRound, var_41_0
	end

	return 1, var_0_6.STATE_FIRST_ROUND
end

function ActivityMonthGachaData:getDrawTimes()
	return self._drawTimes
end

return ActivityMonthGachaData
