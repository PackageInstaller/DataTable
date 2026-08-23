local DailyTaskData = class("DailyTaskData", require("app.core.model.BaseData"))

function DailyTaskData:ctor()
	self:initData()
end

function DailyTaskData:initData()
	DailyTaskData.super.ctor(self)

	self._basicInfo = {}
	self._taskRewards = {}
	self._degreeRewards = {}
	self._taskInfo = {}
	self._lockTaskInfo = {}
	self._degreeInfo = {}
	self._curAwards = {}
	self._tasks = {}
	self._maxDegree = 0
	self._lastResetTime = 0
	self._curLevel = 1
	self._profileLevel = 1
	self._profileLevelInfo = {}
	self._profileMainTitleInfo = {}
	self._allProfileListData = {}
	self._showProfileListData = {}
	self._newUnLockProfileInfo = {}
	self._dialogCfgData = {}
	self._showDialogData = {}
	self._hasData = false

	self:_initAllProfileLevelInfo()
	self:_initMainTitleInfo()
	self:_initAllProfileListCfgData()
	self:_initNpcDialogCfg()
end

function DailyTaskData:hasData()
	return self._hasData
end

function DailyTaskData:updateTaskInfo(arg_4_1)
	self._basicInfo = {}
	self._basicInfo.degreeLv = arg_4_1.degree_level
	self._basicInfo.curDegree = arg_4_1.cur_degree
	self._basicInfo.profileExp = arg_4_1.profile_exp
	self._basicInfo.profileIds = arg_4_1.profile_ids or {}
	self._profileLevel = self:getDailyTaskProfileValueByExp()

	self:updateAllProfileSubItemState()
	self:_updateDiaLogDataWhenFinishTask()

	self._taskRewards = {}
	self._degreeRewards = {}

	if arg_4_1.finish_rewards then
		self._taskRewards = arg_4_1.finish_rewards
	end

	if arg_4_1.degree_rewards then
		self._degreeRewards = arg_4_1.degree_rewards
	end

	self._tasks = arg_4_1.tasks or {}

	self:_initTaskInfo()
	self:_initTaskDegreeInfo()

	self._hasData = self._hasData or true
	self._lastResetTime = g.core.common.ServerTime:getTime()
end

function DailyTaskData:checkResetData()
	if self:checkExpired(self._lastResetTime) then
		self._tasks = {}

		for iter_5_0, iter_5_1 in pairs(self._taskInfo) do
			iter_5_1.value = 0
			iter_5_1.state = 1
		end

		self._lastResetTime = g.core.common.ServerTime:getTime()
	end
end

function DailyTaskData:updateTaskProgress(arg_6_1)
	if #self._taskInfo == 0 then
		self:_initTaskInfo()
	end

	self:checkResetData()

	local var_6_0 = false

	for iter_6_0, iter_6_1 in pairs(self._tasks) do
		if iter_6_1.type == arg_6_1.id then
			iter_6_1.value = arg_6_1.status
			var_6_0 = true
		end
	end

	if not var_6_0 then
		table.insert(self._tasks, {
			type = arg_6_1.id,
			value = arg_6_1.status
		})
	end

	for iter_6_2, iter_6_3 in pairs(self._taskInfo) do
		if iter_6_3.info.target == arg_6_1.id then
			iter_6_3.value = arg_6_1.status

			if iter_6_3.state == 1 and arg_6_1.status >= iter_6_3.info.num then
				iter_6_3.state = 0
			end
		end
	end
end

function DailyTaskData:onTaskAwardBack(arg_7_1)
	self._basicInfo.degreeLv = arg_7_1.degree_level
	self._basicInfo.curDegree = arg_7_1.cur_degree
	self._basicInfo.profileExp = arg_7_1.profile_exp
	self._curAwards = arg_7_1.awards
	self._profileLevel = self:getDailyTaskProfileValueByExp()

	self:updateAllProfileSubItemState()
	self:_updateDiaLogDataWhenFinishTask()

	self._taskRewards = {}

	if arg_7_1.finish_rewards then
		self._taskRewards = arg_7_1.finish_rewards
	end

	for iter_7_0, iter_7_1 in pairs(self._degreeInfo) do
		if self._basicInfo.curDegree >= self._degreeInfo[iter_7_0].info.num and self._degreeInfo[iter_7_0].state == 0 then
			self._degreeInfo[iter_7_0].state = 1
		end
	end

	self:_updateTaskList()
end

function DailyTaskData:onDegreeAwardBack(arg_8_1)
	self._curAwards = arg_8_1.awards
	self._degreeRewards = {}

	if arg_8_1.degree_rewards then
		self._degreeRewards = arg_8_1.degree_rewards
	end

	self:_updateDegreeList()
end

function DailyTaskData:_initTaskInfo()
	self._taskInfo = {}
	self._lockTaskInfo = {}

	local var_9_0 = g.core.common.ServerTime:getWeekDay()

	if var_9_0 == 0 then
		var_9_0 = 7
	end

	local var_9_1 = g.core.model.User:getLevel()

	for iter_9_0 = 1, g.core.config.daily_task_info.getLength() do
		local var_9_2 = g.core.config.daily_task_info.indexOf(iter_9_0).toObject()
		local var_9_5 = {
			info = var_9_2,
			surpriseId = var_9_2.type == 2 and 1 or 0
		}

		var_9_5.value = 0

		if self:_getIsTaskUnLockByType(var_9_2) then
			if (var_9_2.time == 0 or var_9_2.time == var_9_0 or var_9_2.time == 8 and var_9_0 % 2 == 1 or var_9_2.time == 9 and (var_9_0 % 2 == 0 or var_9_0 == 7)) and (var_9_2.type == 1 or var_9_2.type == 2) then
				var_9_5.state = 1

				for iter_9_1 = 1, #self._tasks do
					if self._tasks[iter_9_1].type == var_9_2.target then
						var_9_5.value = self._tasks[iter_9_1].value

						if self._tasks[iter_9_1].value >= var_9_2.num then
							var_9_5.state = 0

							break
						end
					end
				end

				table.insert(self._taskInfo, var_9_5)
			elseif var_9_2.type == 1 then
				var_9_5.isLock = true

				table.insert(self._lockTaskInfo, var_9_5)
			end
		elseif var_9_2.type == 1 then
			var_9_5.isLock = true

			table.insert(self._lockTaskInfo, var_9_5)
		end
	end

	self:_updateDegreeList()
	self:_updateTaskList()

	self._taskInfo = self:_sortList(self._taskInfo)
	self._curLevel = g.core.model.User:getLevel()
end

function DailyTaskData:_updateTaskList()
	for iter_10_0 = 1, #self._taskRewards do
		for iter_10_1, iter_10_2 in pairs(self._taskInfo) do
			if math.uint64_equal(self._taskRewards[iter_10_0], self._taskInfo[iter_10_1].info.id) then
				self._taskInfo[iter_10_1].state = 2

				break
			end
		end
	end
end

function DailyTaskData:_updateDegreeList()
	for iter_11_0 = 1, #self._degreeRewards do
		for iter_11_1, iter_11_2 in pairs(self._degreeInfo) do
			if math.uint64_equal(self._degreeRewards[iter_11_0], self._degreeInfo[iter_11_1].info.id) then
				self._degreeInfo[iter_11_1].state = 2

				break
			end
		end
	end
end

function DailyTaskData:_initTaskDegreeInfo()
	local var_12_0 = 0

	self._degreeInfo = {}

	for iter_12_0 = 1, g.core.config.daily_task_active_degree_info.getLength() do
		local var_12_1 = g.core.config.daily_task_active_degree_info.indexOf(iter_12_0)

		if var_12_1.unlock_level == self._basicInfo.degreeLv then
			if var_12_0 < var_12_1.num then
				var_12_0 = var_12_1.num
			end

			local var_12_2 = {
				info = var_12_1
			}

			var_12_2.state = 0

			if self._basicInfo.curDegree >= var_12_1.num then
				var_12_2.state = 1
			end

			table.insert(self._degreeInfo, var_12_2)
		end
	end

	self._maxDegree = var_12_0

	self:_updateDegreeList()
end

function DailyTaskData:_sortList(arg_13_1)
	table.sort(arg_13_1 or {}, function(arg_14_0, arg_14_1)
		if arg_14_0.state ~= arg_14_1.state then
			if arg_14_0.state == 0 then
				return true
			elseif arg_14_0.state == 1 then
				if arg_14_1.state == 0 then
					return false
				else
					return true
				end
			else
				return false
			end
		end

		if arg_14_0.surpriseId ~= arg_14_1.surpriseId then
			return arg_14_0.surpriseId > arg_14_1.surpriseId
		end

		if arg_14_0.info.time > 0 ~= (arg_14_1.info.time > 0) then
			return arg_14_0.info.time > 0
		end

		if arg_14_0.info.sort ~= arg_14_1.info.sort then
			return arg_14_0.info.sort < arg_14_1.info.sort
		end

		if arg_14_0.info.id ~= arg_14_1.info.id then
			return arg_14_0.info.id > arg_14_1.info.id
		end

		return false
	end)

	return arg_13_1
end

function DailyTaskData:getDailyTaskAllCanReceiveDegreeId()
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in pairs(self._degreeInfo) do
		if iter_15_1.state == 1 then
			table.insert(var_15_0, iter_15_1.info.id)
		elseif iter_15_1.state == 0 then
			break
		end
	end

	return var_15_0
end

function DailyTaskData:getDailyTaskInfo(arg_16_1)
	if self._curLevel ~= g.core.model.User:getLevel() then
		self:_initTaskInfo()
	end

	if arg_16_1 then
		self._taskInfo = self:_sortList(self._taskInfo)
	end

	return self._taskInfo
end

function DailyTaskData:getFinalDailyTaskInfo(arg_17_1)
	local var_17_0 = clone(self:getDailyTaskInfo(arg_17_1))
	local var_17_1 = self:getLastLockTaskCfg()

	if var_17_1 then
		for iter_17_0, iter_17_1 in ipairs(var_17_0) do
			local var_17_2

			if iter_17_1.state and iter_17_1.state == 2 then
				var_17_2 = true

				table.insert(var_17_0, iter_17_0, var_17_1)

				break
			end
		end

		if not false then
			table.insert(var_17_0, var_17_1)
		end
	end

	return var_17_0
end

function DailyTaskData:getDailyTaskAwardInfo(arg_18_1)
	local var_18_0 = {}
	local var_18_1 = clone(arg_18_1)

	if var_18_1.extra_drop and var_18_1.extra_drop > 0 then
		local var_18_2 = g.core.common.ServerTime:getTime()

		if var_18_1.extra_time_start < var_18_2 and var_18_2 < var_18_1.extra_time_end then
			local var_18_3 = g.core.config.drop_info.get(var_18_1.extra_drop, 1)

			for iter_18_0 = 1, 5 do
				if var_18_3["reward_type_" .. iter_18_0] ~= 0 then
					table.insert(var_18_0, {
						isDailyTaskTimeLimit = true,
						type = var_18_3["reward_type_" .. iter_18_0],
						value = var_18_3["reward_value_" .. iter_18_0],
						size = var_18_3["reward_min_" .. iter_18_0]
					})
				end
			end
		end
	end

	if var_18_1.active_degree > 0 then
		table.insert(var_18_0, {
			type = g.core.common.Goods.TYPE_RESOURCE,
			value = g.core.common.Goods.RESOURCE.TYPE_ACTIVITY,
			size = var_18_1.active_degree
		})
	end

	for iter_18_1 = 1, 2 do
		if var_18_1["reward_type_" .. iter_18_1] > 0 then
			table.insert(var_18_0, {
				type = var_18_1["reward_type_" .. iter_18_1],
				value = var_18_1["reward_value_" .. iter_18_1],
				size = var_18_1["reward_size_" .. iter_18_1]
			})
		end
	end

	return var_18_0
end

function DailyTaskData:getDailyTaskActiveBoxAwardInfo(arg_19_1)
	local var_19_0 = g.core.config.daily_task_active_degree_info.get(arg_19_1)
	local var_19_1 = {}

	for iter_19_0 = 1, 4 do
		if var_19_0["reward_type_" .. iter_19_0] and var_19_0["reward_type_" .. iter_19_0] > 0 then
			table.insert(var_19_1, {
				type = var_19_0["reward_type_" .. iter_19_0],
				value = var_19_0["reward_value_" .. iter_19_0],
				size = var_19_0["reward_size_" .. iter_19_0]
			})
		end
	end

	return var_19_1
end

function DailyTaskData:getIsShowOneKey()
	if not self._taskInfo then
		return
	end

	local var_20_0 = 0

	for iter_20_0, iter_20_1 in ipairs(self._taskInfo) do
		if iter_20_1.state == 0 then
			var_20_0 = var_20_0 + 1

			if var_20_0 >= 2 then
				return true
			end
		end
	end

	return false
end

function DailyTaskData:getLastLockTaskCfg()
	if #self._taskInfo == g.core.config.daily_task_info.getLength() then
		return
	end

	local var_21_0 = self._lockTaskInfo

	table.sort(self._lockTaskInfo, function(arg_22_0, arg_22_1)
		return arg_22_0.info.level < arg_22_1.info.level
	end)

	local var_21_1
	local var_21_2 = g.core.model.User:getLevel()

	for iter_21_0, iter_21_1 in ipairs(var_21_0) do
		if var_21_2 <= iter_21_1.info.level then
			var_21_2 = iter_21_1.info.level
			var_21_1 = iter_21_1

			break
		end
	end

	return var_21_1
end

function DailyTaskData:_getIsTaskUnLockByType(arg_23_1)
	local var_23_0 = true

	if arg_23_1.function_id ~= 0 then
		var_23_0 = g.core.common.ModuleUnlock:isModuleUnlock(arg_23_1.function_id)
	end

	if not var_23_0 then
		return false
	end

	if arg_23_1.type == 2 then
		local var_23_1 = arg_23_1.time_start or 0
		local var_23_2 = arg_23_1.time_end or 0
		local var_23_3 = g.core.common.ServerTime:getTime()

		if var_23_1 > 0 and var_23_2 == 0 then
			if var_23_3 < var_23_1 then
				var_23_0 = false
			end
		elseif var_23_1 > 0 and var_23_2 > 0 and (var_23_3 < var_23_1 or var_23_2 < var_23_3) then
			var_23_0 = false
		end
	end

	return var_23_0
end

function DailyTaskData:updateProfileAllGetAward(arg_24_1)
	self._basicInfo.profileIds = arg_24_1.degree_rewards or {}

	self:updateAllProfileSubItemState()
end

function DailyTaskData:getDailyTaskProfileValueByExp()
	self._profileLevel = 1

	local var_25_0 = 0
	local var_25_1 = #self._profileLevelInfo

	for iter_25_0, iter_25_1 in ipairs(self._profileLevelInfo) do
		if self._basicInfo.profileExp <= iter_25_1.num then
			self._profileLevel = self._profileLevelInfo[(iter_25_0 - 1 > 0 or nil) and (iter_25_0 - 1 or 1)].id
			var_25_0 = self._profileLevelInfo[var_25_1 < iter_25_0 + 1 and var_25_1 or iter_25_0 + 1].num

			break
		else
			self._profileLevel = self._profileLevelInfo[var_25_1].id
			var_25_0 = self._profileLevelInfo[var_25_1].num
		end
	end

	return self._profileLevel, var_25_0
end

function DailyTaskData:_initAllProfileLevelInfo()
	self._profileLevelInfo = self._profileLevelInfo or {}

	local var_26_0 = g.core.config.daily_profile_info

	for iter_26_0 = 1, g.core.config.daily_profile_info.getLength() do
		self._profileLevelInfo[iter_26_0] = clone(var_26_0.indexOf(iter_26_0).toObject())
	end

	table.sort(self._profileLevelInfo, function(arg_27_0, arg_27_1)
		return arg_27_0.num < arg_27_1.num
	end)
end

function DailyTaskData:_initMainTitleInfo()
	for iter_28_0 = 1, g.core.config.daily_profile_info.getLength() do
		local var_28_0 = clone(g.core.config.daily_profile_info.indexOf(iter_28_0))

		if var_28_0.type and var_28_0.type ~= 0 and not self._profileMainTitleInfo[var_28_0.type] then
			self._profileMainTitleInfo[tonumber(var_28_0.type)] = var_28_0.toObject()
		end
	end
end

function DailyTaskData:_initAllProfileListCfgData()
	for iter_29_0, iter_29_1 in ipairs(self._profileMainTitleInfo) do
		self._allProfileListData[iter_29_0] = self._allProfileListData[iter_29_0] or {}

		for iter_29_2, iter_29_3 in ipairs(self._profileLevelInfo) do
			if iter_29_3.type and iter_29_3.type ~= 0 and tonumber(iter_29_3.type) == tonumber(iter_29_0) then
				table.insert(self._allProfileListData[iter_29_0], clone(iter_29_3))
			end
		end
	end
end

function DailyTaskData:updateProfileListDataByType(arg_30_1, arg_30_2)
	self._showProfileListData = {}
	arg_30_1 = arg_30_1 or 1

	for iter_30_0, iter_30_1 in ipairs(self._allProfileListData) do
		local var_30_0 = clone(self._profileMainTitleInfo[iter_30_0])

		var_30_0.isMain = true
		var_30_0.mainType = iter_30_0
		var_30_0.subNum = #iter_30_1
		var_30_0.unLockNum = 0
		var_30_0.isExpand = false

		if iter_30_0 == arg_30_1 then
			var_30_0.isExpand = arg_30_2
		end

		table.insert(self._showProfileListData, var_30_0)

		local var_30_1 = 0

		for iter_30_2, iter_30_3 in ipairs(iter_30_1) do
			local var_30_2 = clone(iter_30_3)

			var_30_2.isMain = false

			if self._profileLevel >= iter_30_3.id then
				var_30_1 = var_30_1 + 1
			end

			if arg_30_2 and iter_30_0 == arg_30_1 then
				var_30_2.isNew = self._profileLevelInfo[iter_30_3.id].isNew
				var_30_2.hasGift = self._profileLevelInfo[iter_30_3.id].hasGift
				var_30_2.lockState = self._profileLevelInfo[iter_30_3.id].lockState
				var_30_2.awardState = self._profileLevelInfo[iter_30_3.id].awardState

				table.insert(self._showProfileListData, var_30_2)
			end
		end

		var_30_0.unLockNum = var_30_1
	end

	return self._showProfileListData
end

function DailyTaskData:getCurItemIndexWhenFirstEnter()
	self:updateAllProfileSubItemState()

	if not self._newUnLockProfileInfo[1] then
		local var_31_0, var_31_1 = self:_getIndexWithoutNewUnLockWhenFirstEnter()
		local var_31_2, var_31_3 = self:_getSelectedIndexByShowProfileListData(var_31_0, var_31_1)

		return var_31_2, var_31_3, var_31_1, var_31_0
	end

	for iter_31_0, iter_31_1 in ipairs(self._allProfileListData) do
		for iter_31_2, iter_31_3 in ipairs(iter_31_1) do
			if self._newUnLockProfileInfo[1].id == iter_31_3.id then
				local var_31_4, var_31_5 = self:_getSelectedIndexByShowProfileListData(iter_31_0, self._newUnLockProfileInfo[1].id)

				return var_31_4, var_31_5, self._newUnLockProfileInfo[1].id, iter_31_0
			end
		end
	end
end

function DailyTaskData:setPreSubItemNewState(arg_32_1)
	if self._profileLevelInfo[arg_32_1].isNew then
		self:setNewProfileClickRecord(arg_32_1)
	end
end

function DailyTaskData:_getIndexWithoutNewUnLockWhenFirstEnter()
	for iter_33_0, iter_33_1 in ipairs(self._allProfileListData) do
		for iter_33_2, iter_33_3 in ipairs(iter_33_1) do
			local var_33_1, var_33_2, var_33_3

			if iter_33_3.id <= self._profileLevel and 1 <= iter_33_3.id then
				var_33_1 = iter_33_3.id
				var_33_2 = iter_33_0
				var_33_3 = iter_33_3.id
			end
		end
	end

	return nil, nil
end

function DailyTaskData:getCurItemIndexWhenMainClick(arg_34_1)
	for iter_34_0, iter_34_1 in ipairs(self._showProfileListData) do
		if iter_34_1.mainType == arg_34_1 then
			return iter_34_0
		end
	end
end

function DailyTaskData:_getSelectedIndexByShowProfileListData(arg_35_1, arg_35_2)
	local var_35_0
	local var_35_1

	for iter_35_0, iter_35_1 in ipairs((self:updateProfileListDataByType(arg_35_1, true))) do
		if iter_35_1.isMain then
			if iter_35_1.mainType == arg_35_1 then
				var_35_0 = iter_35_0
			end
		elseif iter_35_1.id == arg_35_2 then
			var_35_1 = iter_35_0
		end

		if var_35_0 and var_35_1 then
			return var_35_0, var_35_1
		end
	end
end

function DailyTaskData:updateAllProfileSubItemState()
	self._newUnLockProfileInfo = {}

	for iter_36_0, iter_36_1 in ipairs(self._profileLevelInfo) do
		if iter_36_1.type and iter_36_1.type ~= 0 then
			iter_36_1.isNew = false
			iter_36_1.hasGift = iter_36_1.drop_id ~= 0
			iter_36_1.awardState = 2

			if self._profileLevel >= iter_36_1.id then
				if not self:judgeProfileHasClick(iter_36_1.id) then
					iter_36_1.isNew = true

					table.insert(self._newUnLockProfileInfo, clone(iter_36_1))
				end

				iter_36_1.lockState = 0

				if iter_36_1.hasGift then
					iter_36_1.awardState = self:_isHasGetAward(iter_36_1.id) and 1 or 0
				end
			else
				iter_36_1.lockState = 1
			end
		end
	end

	if #self._newUnLockProfileInfo > 1 then
		table.sort(self._newUnLockProfileInfo, function(arg_37_0, arg_37_1)
			return arg_37_0.id < arg_37_1.id
		end)
	end
end

function DailyTaskData:_isHasGetAward(arg_38_1)
	for iter_38_0, iter_38_1 in ipairs(self._basicInfo.profileIds) do
		if arg_38_1 == iter_38_1 then
			return true
		end
	end

	return false
end

function DailyTaskData:getProfileJudgeStr(arg_39_1)
	return "DailyTaskProfile" .. tostring(arg_39_1) .. "_" .. tostring((g.core.model.User:getId())) .. "_" .. tostring(g.core.platform.ServerListProxy:getSelectedServer().sid)
end

function DailyTaskData:setNewProfileClickRecord(arg_40_1)
	local var_40_0 = self._setConfig

	if not self._setConfig then
		var_40_0 = g.core.common.Storage:load("DailyTaskProfileRecord.json", false)
		var_40_0 = var_40_0 or {}
	end

	self._setConfig = var_40_0
	self._setConfig[self:getProfileJudgeStr(arg_40_1)] = "1"

	g.core.common.Storage:save("DailyTaskProfileRecord.json", self._setConfig, false)

	self._profileLevelInfo[arg_40_1].isNew = false

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_DAILY_TASK_PROFILE_BTN_REFRESH_POINT)
end

function DailyTaskData:judgeProfileHasClick(arg_41_1)
	if (g.core.common.Storage:load("DailyTaskProfileRecord.json", false) or {})[self:getProfileJudgeStr(arg_41_1)] then
		return true
	end

	return false
end

function DailyTaskData:getProfileAwardInfo(arg_42_1)
	local var_42_0 = {}
	local var_42_1 = g.core.config.drop_info.get(arg_42_1, 1)

	for iter_42_0 = 1, 5 do
		if var_42_1["reward_type_" .. iter_42_0] ~= 0 then
			local var_42_2 = {
				type = var_42_1["reward_type_" .. iter_42_0],
				value = var_42_1["reward_value_" .. iter_42_0],
				size = var_42_1["reward_min_" .. iter_42_0]
			}

			var_42_2.changeControllers = true
			var_42_2.nameRow = 2

			table.insert(var_42_0, var_42_2)
		end
	end

	return var_42_0
end

function DailyTaskData:_initNpcDialogCfg()
	local var_43_0 = clone(g.core.config.daily_npc_info)

	self._dialogCfgData = {}

	for iter_43_0 = 1, var_43_0.getLength() do
		local var_43_1 = var_43_0.indexOf(iter_43_0).toObject()

		self._dialogCfgData[var_43_1.talk_type] = self._dialogCfgData[var_43_1.talk_type] or {}

		table.insert(self._dialogCfgData[var_43_1.talk_type], var_43_1)
	end
end

function DailyTaskData:_updateDiaLogDataWhenFinishTask()
	self._showDialogData = {}

	for iter_44_0, iter_44_1 in ipairs(self._dialogCfgData) do
		local var_44_0 = clone(iter_44_1)

		for iter_44_2 = #var_44_0, 1, -1 do
			if var_44_0[iter_44_2].unlock_level > self._profileLevel then
				table.remove(var_44_0, #var_44_0)
			end
		end

		if #var_44_0 > 1 then
			table.sort(var_44_0, function(arg_45_0, arg_45_1)
				return arg_45_0.unlock_level < arg_45_1.unlock_level
			end)
		end

		self._showDialogData[iter_44_0] = var_44_0
	end
end

function DailyTaskData:getCurDialogText(arg_46_1)
	local var_46_0

	if arg_46_1.talkType == 1 then
		var_46_0 = self._showDialogData[arg_46_1.talkType][math.random(1, #self._showDialogData[arg_46_1.talkType])].talk_txt
	elseif arg_46_1.talkType == 2 or arg_46_1.talkType == 3 then
		local var_46_1, var_46_2 = self:checkDailyTaskCompleted()
		local var_46_3 = {}

		if arg_46_1.talkType == 2 then
			if var_46_1 or self:checkDailyTaskBoxAward() then
				for iter_46_0, iter_46_1 in ipairs(self._showDialogData[arg_46_1.talkType]) do
					if iter_46_1.talk_trigger == 1 and var_46_2 < iter_46_1.trigger_num then
						table.insert(var_46_3, iter_46_1)
					end
				end

				var_46_0 = self:_getRandomDialogText(var_46_3)
			else
				for iter_46_2, iter_46_3 in ipairs(self._showDialogData[arg_46_1.talkType]) do
					if iter_46_3.talk_trigger == 0 and var_46_2 < iter_46_3.trigger_num then
						table.insert(var_46_3, iter_46_3)
					end
				end

				var_46_0 = self:_getRandomDialogText(var_46_3)
			end
		elseif arg_46_1.talkType == 3 then
			for iter_46_4, iter_46_5 in ipairs(self._showDialogData[arg_46_1.talkType]) do
				if iter_46_5.talk_trigger == 2 and var_46_2 < iter_46_5.trigger_num then
					table.insert(var_46_3, iter_46_5)
				end
			end

			var_46_0 = self:_getRandomDialogText(var_46_3)
		end
	end

	return var_46_0
end

function DailyTaskData:_getRandomDialogText(arg_47_1)
	if #arg_47_1 == 1 then
		return arg_47_1[1].talk_txt
	elseif #arg_47_1 > 1 then
		return arg_47_1[math.random(1, #arg_47_1)].talk_txt
	end
end

function DailyTaskData:checkDailyTaskCompleted()
	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.DAILY_TASK) then
		return false, #self._taskInfo
	end

	local var_48_0 = 0
	local var_48_1 = false

	for iter_48_0 = 1, #self._taskInfo do
		if self._taskInfo[iter_48_0].state == 0 then
			var_48_1 = true
		elseif self._taskInfo[iter_48_0].state == 1 then
			var_48_0 = var_48_0 + 1
		end
	end

	return var_48_1, var_48_0
end

function DailyTaskData:checkDailyTaskBoxAward()
	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.DAILY_TASK) then
		return false
	end

	local var_49_0 = self:getDailyTaskDegreeInfo()

	for iter_49_0 = 1, #var_49_0 do
		if var_49_0[iter_49_0].state == 1 then
			return true
		end
	end

	return false
end

function DailyTaskData:checkDailyTaskAward()
	if not self._taskInfo then
		return
	end

	for iter_50_0, iter_50_1 in ipairs(self._taskInfo) do
		if iter_50_1.state == 0 then
			return true
		end
	end

	return false
end

function DailyTaskData:checkHasAwardCanGet()
	self:checkResetData()

	return self:checkDailyTaskAward() or self:checkDailyTaskBoxAward()
end

function DailyTaskData:checkAllProfileHasNew()
	for iter_52_0, iter_52_1 in ipairs(self._profileLevelInfo) do
		if iter_52_1.lockState == 0 and iter_52_1.isNew then
			return true
		end
	end

	return false
end

function DailyTaskData:checkAllProfileHasAward()
	for iter_53_0, iter_53_1 in ipairs(self._profileLevelInfo) do
		if iter_53_1.lockState == 0 and iter_53_1.awardState == 0 then
			return true
		end
	end

	return false
end

function DailyTaskData:isProfileCellCanGetAward(arg_54_1)
	if self._profileLevelInfo[arg_54_1 or 0] and self._profileLevelInfo[arg_54_1 or 0].lockState == 0 and self._profileLevelInfo[arg_54_1 or 0].awardState == 0 then
		return true
	end

	return false
end

function DailyTaskData:getDailyTaskBasicInfo()
	return self._basicInfo
end

function DailyTaskData:getDailyTaskDegreeInfo()
	return self._degreeInfo
end

function DailyTaskData:getDailyTaskAwards()
	return self._curAwards
end

function DailyTaskData:getDailyTaskMaxDegree()
	return self._maxDegree
end

function DailyTaskData:getProfileLevelInfo()
	return self._profileLevelInfo
end

function DailyTaskData:getProfileListInfo()
	return self._showProfileListData
end

function DailyTaskData:getAllProfileCfgInfo()
	return self._allProfileListData
end

return DailyTaskData
