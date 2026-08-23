local ReleaseActivityData = class("ReleaseActivityData", require("app.core.model.BaseData"))
local ReleaseTaskData = require("app.view.module.release.model.ReleaseTaskData")

function ReleaseActivityData:ctor()
	self:initData()
end

function ReleaseActivityData:initData()
	self._activityId = 1
	self._openDay = 0
	self._startTime = 0
	self._endTime = 0
	self._minLv = 0
	self._maxLv = 0
	self._isHaveRedPoint = false
	self._drawTime = 0
	self._releaseRewards = {}
	self._spinnerGroupMap = {}
	self._prizeGroupMap = {}
	self._rewardsMap = {}
	self._spinnerTime = 0
	self._spinnerPrizes = {}
	self._spinnerTime = 0
	self._recordPrize = {}
	self._recordArray = {}
	self._extraAwards = {}
	self._useDrawNum = 0
	self._isGetBigAward = false
	self._taskData = ReleaseTaskData.new()
end

function ReleaseActivityData:onS2CRedPoint(arg_3_1)
	if arg_3_1.activity then
		self._activityId = arg_3_1.activity.sub_id or 0
		self._openDay = arg_3_1.activity.open_day or 0
		self._startTime = arg_3_1.activity.start_time or 0
		self._endTime = arg_3_1.activity.end_time or 0
		self._minLv = arg_3_1.activity.min_level or 0
		self._maxLv = arg_3_1.activity.max_level or 0

		local var_3_0 = g.core.config.activity_release_info.fetch(self._activityId)

		if var_3_0 then
			self._taskData:initTaskData(var_3_0.task_group)
		end

		self:_initReleaseRewardInfo()
		self:_initReleaseSpinnerInfo()
	end

	if arg_3_1.hint then
		self._isHaveRedPoint = arg_3_1.hint
	end
end

function ReleaseActivityData:onS2CReleaseGetInfo(arg_4_1)
	if arg_4_1.release then
		self._drawTime = arg_4_1.release.times or 0

		if arg_4_1.release.reward_ids then
			for iter_4_0, iter_4_1 in ipairs(arg_4_1.release.reward_ids) do
				self._rewardsMap[iter_4_1] = self._rewardsMap[iter_4_1] or {}
				self._rewardsMap[iter_4_1] = true
			end
		end
	end

	if arg_4_1.spinner then
		self._spinnerTime = arg_4_1.spinner.times or 0
		self._curSpinnerId = arg_4_1.spinner.id
		self._spinnerPrizes = {}

		for iter_4_2, iter_4_3 in ipairs(arg_4_1.spinner.prizes or {}) do
			self._spinnerPrizes[iter_4_3.id] = self._spinnerPrizes[iter_4_3.id] or iter_4_3.num
		end
	end

	if arg_4_1.tasks then
		self._taskData:updateTaskData(arg_4_1.tasks)
	end
end

function ReleaseActivityData:getTaskData()
	return self._taskData
end

function ReleaseActivityData:isCanRewardTask()
	if self._isHaveRedPoint then
		self._isHaveRedPoint = false

		return true
	end

	return self._taskData:isCanRewardTask()
end

function ReleaseActivityData:isCanAccumulateAward(arg_7_1)
	if arg_7_1.id then
		if not self:isGetReleaseReward(arg_7_1.id) and self:getDrawTime() >= g.core.config.activity_release_reward_info.get(arg_7_1.id).num then
			return true
		end
	else
		for iter_7_0, iter_7_1 in ipairs(self._releaseRewards) do
			if not self:isGetReleaseReward(iter_7_1.id) and self:getDrawTime() >= iter_7_1.num then
				return true
			end
		end
	end

	return false
end

function ReleaseActivityData:onS2CReleasePrizeList(arg_8_1)
	self._recordPrize = {}
	self._recordArray = {}

	if arg_8_1.prizes then
		for iter_8_0, iter_8_1 in ipairs(arg_8_1.prizes) do
			self._recordPrize[iter_8_1.spinner_number] = self._recordPrize[iter_8_1.spinner_number] or {}

			table.insert(self._recordPrize[iter_8_1.spinner_number], iter_8_1)
		end
	end

	for iter_8_2, iter_8_3 in pairs(self._recordPrize) do
		table.insert(self._recordArray, iter_8_3)
	end

	table.sort(self._recordArray, function(arg_9_0, arg_9_1)
		if arg_9_0[1].spinnerId ~= arg_9_1[1].spinnerId then
			return arg_9_0[1].spinnerId > arg_9_1[1].spinnerId
		end

		if arg_9_0[1].spinner_number ~= arg_9_1[1].spinner_number then
			return arg_9_0[1].spinner_number > arg_9_1[1].spinner_number
		end

		return false
	end)
end

function ReleaseActivityData:onS2CReleaseDraw(arg_10_1)
	if arg_10_1.prize_ids then
		self._drawTime = self._drawTime + #arg_10_1.prize_ids

		for iter_10_0, iter_10_1 in ipairs(arg_10_1.prize_ids) do
			self._spinnerPrizes[iter_10_1] = not self._spinnerPrizes[iter_10_1] and 1 or self._spinnerPrizes[iter_10_1] + 1
		end

		self:checkExtraSendAward(arg_10_1.prize_ids)
	end
end

function ReleaseActivityData:onS2CReleaseGetReward(arg_11_1)
	if arg_11_1.id then
		self._rewardsMap[arg_11_1.id] = true
	end
end

function ReleaseActivityData:onS2CReleaseTaskAward(arg_12_1)
	if arg_12_1.ids and next(arg_12_1.ids) then
		for iter_12_0, iter_12_1 in ipairs(arg_12_1.ids) do
			self._taskData:onTaskAward(iter_12_1)
		end
	end
end

function ReleaseActivityData:isActivityOpen(arg_13_1)
	arg_13_1 = arg_13_1 or self._activityId

	if self._activityId ~= arg_13_1 then
		return false
	end

	if g.core.common.ServerTime:getOpenDays() < self._openDay then
		return false
	end

	local var_13_0 = g.core.model.User:getLevel()

	if var_13_0 < self._minLv or var_13_0 > self._maxLv then
		return false
	end

	local var_13_1 = g.core.common.ServerTime:getTime()

	if var_13_1 < self._startTime or var_13_1 > self._endTime then
		return false
	end

	return true
end

function ReleaseActivityData:getActivityReleaseDisplayCfg()
	return (g.core.config.activity_release_display_info.get(self._activityId))
end

function ReleaseActivityData:getReleaseInfo()
	return (g.core.config.activity_release_info.get(self._activityId))
end

function ReleaseActivityData:_initReleaseRewardInfo()
	local var_16_0 = g.core.config.activity_release_reward_info.match(function(arg_17_0)
		return arg_17_0.group == self:getReleaseInfo().reward_group
	end)

	table.sort(var_16_0, function(arg_18_0, arg_18_1)
		if arg_18_0.num ~= arg_18_1.num then
			return arg_18_0.num < arg_18_1.num
		end
	end)

	self._releaseRewards = var_16_0
end

function ReleaseActivityData:_initReleaseSpinnerInfo()
	self._spinnerGroupMap = {}

	for iter_19_0, iter_19_1 in g.core.config.activity_release_spinner_info.ipairs() do
		if iter_19_1.group == self:getReleaseInfo().spinner_group then
			self._spinnerGroupMap[iter_19_1.group] = self._spinnerGroupMap[iter_19_1.group] or {}

			table.insert(self._spinnerGroupMap[iter_19_1.group], iter_19_1)
		end
	end

	self:_initReleaseSpinnerPrizeInfo()
end

function ReleaseActivityData:_initReleaseSpinnerPrizeInfo()
	self._prizeGroupMap = {}

	for iter_20_0, iter_20_1 in g.core.config.activity_release_spinner_prize_info.ipairs() do
		self._prizeGroupMap[iter_20_1.group] = self._prizeGroupMap[iter_20_1.group] or {}

		table.insert(self._prizeGroupMap[iter_20_1.group], iter_20_1)
	end
end

function ReleaseActivityData:getSpinnerPrizeCountById(arg_21_1)
	if self._spinnerPrizes[arg_21_1] then
		return self._spinnerPrizes[arg_21_1]
	else
		return 0
	end
end

function ReleaseActivityData:isGetSpinnerBigAward(arg_22_1)
	if self._prizeGroupMap[arg_22_1] then
		for iter_22_0, iter_22_1 in ipairs(self._prizeGroupMap[arg_22_1]) do
			if iter_22_1.grand_prize == 1 and self:getSpinnerPrizeCountById(iter_22_1.id) == iter_22_1.num then
				return true
			end
		end
	end

	return false
end

function ReleaseActivityData:getSpinnerBigAwardInfo(arg_23_1)
	for iter_23_0, iter_23_1 in ipairs(self._prizeGroupMap[arg_23_1]) do
		if iter_23_1.grand_prize == 1 then
			return iter_23_1
		end
	end
end

function ReleaseActivityData:getSpinnerNormalAwardInfo(arg_24_1)
	local var_24_0 = {}

	for iter_24_0, iter_24_1 in ipairs(self._prizeGroupMap[arg_24_1]) do
		if iter_24_1.grand_prize ~= 1 then
			table.insert(var_24_0, iter_24_1)
		end
	end

	return var_24_0
end

function ReleaseActivityData:getActId()
	return self._activityId
end

function ReleaseActivityData:getReleaseRewardData()
	return self._releaseRewards
end

function ReleaseActivityData:getDrawTime()
	return self._drawTime
end

function ReleaseActivityData:isGetReleaseReward(arg_28_1)
	return self._rewardsMap[arg_28_1]
end

function ReleaseActivityData:getSpinnerId()
	return self._curSpinnerId
end

function ReleaseActivityData:getReleaseSpinnerInfoByGroup(arg_30_1)
	return self._spinnerGroupMap[arg_30_1]
end

function ReleaseActivityData:getReleaseSpinnerPrizeByGroup(arg_31_1)
	return self._prizeGroupMap[arg_31_1]
end

function ReleaseActivityData:getReleaseRecordByNumber(arg_32_1)
	return self._recordPrize[arg_32_1]
end

function ReleaseActivityData:getReleaseRecordList()
	return self._recordArray
end

function ReleaseActivityData:checkExtraSendAward(arg_34_1)
	self._extraAwards = {}
	self._useDrawNum = 0
	self._isGetBigAward = false

	local var_34_0 = 0

	for iter_34_0, iter_34_1 in ipairs(arg_34_1) do
		local var_34_1 = g.core.config.activity_release_spinner_prize_info.get(iter_34_1)

		if var_34_1.grand_prize == 1 and self:getSpinnerPrizeCountById(var_34_1.id) == var_34_1.num then
			var_34_0 = var_34_1.group

			break
		end
	end

	local var_34_2 = self:getReleaseSpinnerPrizeByGroup(var_34_0)

	if var_34_2 then
		for iter_34_2, iter_34_3 in ipairs(var_34_2) do
			local var_34_3 = self:getSpinnerPrizeCountById(iter_34_3.id)

			self._useDrawNum = self._useDrawNum + var_34_3

			if iter_34_3.num - var_34_3 > 0 then
				table.insert(self._extraAwards, {
					type = iter_34_3.type,
					value = iter_34_3.value,
					size = iter_34_3.num - var_34_3
				})
			end
		end
	end

	if var_34_0 > 0 then
		self._isGetBigAward = true
		self._curSpinnerId = g.core.config.activity_release_spinner_info.get(self._curSpinnerId).next_id
		self._spinnerPrizes = {}
	end
end

function ReleaseActivityData:getReleaseExtraAwards()
	return self._extraAwards
end

function ReleaseActivityData:getBigAwardsUseTime()
	return self._useDrawNum
end

function ReleaseActivityData:isGetBigAward()
	return self._isGetBigAward
end

function ReleaseActivityData:getActEndTime()
	return self._endTime
end

function ReleaseActivityData:getActivityShowTime(arg_39_1)
	arg_39_1 = arg_39_1 or self._activityId

	if arg_39_1 ~= self._activityId then
		return 0
	end

	return self._endTime
end

function ReleaseActivityData:isNewActivityRelease()
	self._cacheMap = self._cacheMap or g.core.common.Storage:load("release_act_cache.json") or {}

	if self._activityId == 0 or self._cacheMap.actId == self._activityId then
		return false
	end

	return self:isActivityOpen()
end

function ReleaseActivityData:saveNewActivityRelease()
	self._cacheMap = self._cacheMap or {}
	self._cacheMap.actId = self._activityId

	g.core.common.Storage:save("release_act_cache.json", self._cacheMap)
end

return ReleaseActivityData
