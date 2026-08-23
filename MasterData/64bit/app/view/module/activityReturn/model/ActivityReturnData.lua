local ActivityReturnData = class("ActivityReturnData", require("app.core.model.BaseData"))

function ActivityReturnData:ctor()
	ActivityReturnData.super.ctor(self)

	self._baseInfoMap = {}
	self._curId = -1
	self._canAward = false
end

function ActivityReturnData:initData()
	self._baseInfoMap = {}
end

function ActivityReturnData:isActivityOpen(arg_3_1)
	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.ACTIVITY_RETURN) then
		return false
	end

	if not self._baseInfoMap[arg_3_1] then
		return false
	end

	local var_3_0 = self._baseInfoMap[arg_3_1].activityInfo

	if g.core.common.ServerTime:getOpenDays() < self._baseInfoMap[arg_3_1].activityInfo.open_day then
		return false
	end

	local var_3_1 = g.core.model.User:getLevel()

	if var_3_1 < var_3_0.min_level or var_3_1 > var_3_0.max_level then
		return false
	end

	local var_3_2 = g.core.common.ServerTime:getTime()

	return var_3_2 >= var_3_0.start_time and var_3_2 < var_3_0.end_time
end

function ActivityReturnData:isHasActivityOpen()
	for iter_4_0, iter_4_1 in pairs(self._baseInfoMap) do
		if self:isActivityOpen(iter_4_0) then
			return true
		end
	end

	return false
end

function ActivityReturnData:checkPreciousActIsOpen(arg_5_1)
	if not self:isActivityOpen(arg_5_1) then
		return false, 0
	end

	return self._baseInfoMap[arg_5_1].activityInfo.start_time, self._baseInfoMap[arg_5_1].activityInfo.end_time
end

function ActivityReturnData:getActEndTime(arg_6_1)
	if not self:isActivityOpen(arg_6_1) then
		return 0
	end

	return self._baseInfoMap[arg_6_1].activityInfo.end_time
end

function ActivityReturnData:_createActivityInfo(arg_7_1)
	local var_7_0 = g.core.config.activity_rerun_info.get(arg_7_1)
	local var_7_1 = {
		info = {
			curTimes = 0,
			cfg = var_7_0,
			previewMap = {
				g.core.common.Drops:getGoodsArray(var_7_0.ssr_drop),
				g.core.common.Drops:getGoodsArray(var_7_0.sr_drop),
				g.core.common.Drops:getGoodsArray(var_7_0.r_drop)
			}
		}
	}
	local var_7_2 = {}

	for iter_7_0 = #var_7_1.info.previewMap, 1, -1 do
		for iter_7_1, iter_7_2 in ipairs(var_7_1.info.previewMap[iter_7_0]) do
			var_7_2[table.concat({
				iter_7_2.type,
				iter_7_2.value
			}, "_")] = #var_7_1.info.previewMap - iter_7_0 + 1
		end
	end

	var_7_1.info.dropQualityMap = var_7_2
	var_7_1.taskInfo = self:_createTaskInfo(var_7_0.task_group)
	var_7_1.gameInfo = self:_createGameInfo(arg_7_1)
	var_7_1.activityInfo = {}
	self._baseInfoMap[arg_7_1] = var_7_1
end

function ActivityReturnData:_createTaskInfo(arg_8_1)
	local var_8_0 = {
		normalTask = {},
		actionMap = {},
		stageTask = {}
	}

	for iter_8_0 = 1, g.core.config.activity_rerun_task_info.getLength() do
		local var_8_1 = g.core.config.activity_rerun_task_info.indexOf(iter_8_0)

		if var_8_1.task_group == arg_8_1 then
			local var_8_2 = table.concat({
				var_8_1.action_id,
				var_8_1.action_key
			}, "_")
			local var_8_3 = var_8_0.actionMap[var_8_2]

			if not var_8_0.actionMap[var_8_2] then
				var_8_3 = {
					num = 0
				}
				var_8_0.actionMap[var_8_2] = var_8_3
			end

			local var_8_4 = {
				state = 0,
				cfg = var_8_1,
				cur = var_8_3,
				max = var_8_1.action_value,
				awards = {}
			}

			if var_8_1.action_id == 1094 then
				var_8_4.max = 1
				var_8_3.num = 1
			end

			local var_8_5 = 1
			local var_8_6 = {
				"reward_type"
			}

			var_8_6[2] = 1

			local var_8_7 = table.concat(var_8_6, "_")

			while g.core.config.activity_rerun_task_info.hasKey(var_8_7) do
				local var_8_8 = var_8_1[table.concat({
					"reward_value",
					var_8_5
				}, "_")]
				local var_8_9 = var_8_1[table.concat({
					"reward_size",
					var_8_5
				}, "_")]

				if var_8_1[var_8_7] > 0 then
					var_8_4.awards[#var_8_4.awards + 1] = {
						type = var_8_1[var_8_7],
						value = var_8_8,
						size = var_8_9
					}
				end

				var_8_5 = var_8_5 + 1
				var_8_7 = table.concat({
					"reward_type",
					var_8_5
				}, "_")
			end

			if var_8_1.task_type == 3 then
				var_8_0.stageTask[#var_8_0.stageTask + 1] = var_8_4
			else
				var_8_0.normalTask[#var_8_0.normalTask + 1] = var_8_4
			end
		end
	end

	return var_8_0
end

function ActivityReturnData:_createGameInfo(arg_9_1)
	local var_9_0 = g.core.config.activity_rerun_display_info.get(arg_9_1)
	local var_9_1 = {
		cfg = var_9_0
	}
	local var_9_2 = var_9_0.template

	var_9_1.dotInfoList = g.core.config.activity_rerun_dot_info.match(function(arg_10_0)
		return arg_10_0.template_id == var_9_2
	end) or {}

	return var_9_1
end

function ActivityReturnData:getBaseInfo(arg_11_1)
	if not self._baseInfoMap[arg_11_1] then
		self:_createActivityInfo(arg_11_1)
	end

	return self._baseInfoMap[arg_11_1]
end

function ActivityReturnData:getCurBaseInfo()
	return self:getBaseInfo(self._curId)
end

function ActivityReturnData:getCurId()
	return self._curId
end

function ActivityReturnData:updateActivityData(arg_14_1)
	self._curId = arg_14_1.sub_id
	self:getCurBaseInfo().activityInfo = arg_14_1
end

function ActivityReturnData:updateTasks(arg_15_1)
	local var_15_0 = self:getCurBaseInfo().taskInfo.actionMap

	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		for iter_15_2, iter_15_3 in ipairs(iter_15_1.actions or {}) do
			if iter_15_3.type ~= 1094 then
				local var_15_2 = var_15_0[table.concat({
					iter_15_3.type,
					iter_15_3.key
				}, "_")]

				if var_15_2 then
					var_15_2.num = iter_15_3.value
				end
			end
		end

		self:_onTaskRcvByIdList(iter_15_1.award_task_ids or {})
	end

	self:_checkTaskState()
end

function ActivityReturnData:_onTaskRcvByIdList(arg_16_1)
	local var_16_0 = self:getCurBaseInfo().taskInfo
	local var_16_1 = {}
	local var_16_2 = #arg_16_1

	for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
		var_16_1[iter_16_1] = true
	end

	for iter_16_2, iter_16_3 in ipairs(var_16_0.normalTask) do
		if var_16_1[iter_16_3.cfg.id] then
			iter_16_3.state = 2
			var_16_2 = var_16_2 - 1

			if var_16_2 <= 0 then
				return
			end
		end
	end

	for iter_16_4, iter_16_5 in ipairs(var_16_0.stageTask) do
		if var_16_1[iter_16_5.cfg.id] then
			iter_16_5.state = 2
			var_16_2 = var_16_2 - 1

			if var_16_2 <= 0 then
				return
			end
		end
	end
end

function ActivityReturnData:_updateTaskValue(arg_17_1)
	local var_17_0 = self:getCurBaseInfo().taskInfo.actionMap

	for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
		if iter_17_1.id ~= 1094 then
			var_17_0[table.concat({
				iter_17_1.id,
				iter_17_1.key
			}, "_")].num = iter_17_1.status
		end
	end

	self:_checkTaskState()
end

function ActivityReturnData:_checkTaskState()
	local var_18_0 = self:getCurBaseInfo().taskInfo

	for iter_18_0, iter_18_1 in ipairs(var_18_0.normalTask) do
		if iter_18_1.state == 0 and iter_18_1.cur.num >= iter_18_1.max then
			iter_18_1.state = 1
		end
	end

	for iter_18_2, iter_18_3 in ipairs(var_18_0.stageTask) do
		if iter_18_3.state == 0 and iter_18_3.cur.num >= iter_18_3.max then
			iter_18_3.state = 1
		end
	end
end

function ActivityReturnData:isShowSkip()
	if self._curId <= 0 or not self:isActivityOpen(self._curId) then
		return false
	end

	if self:getCurBaseInfo().taskInfo.stageTask[1].cur.num < g.core.config.parameter_info.get(10144).parameter then
		return false
	end

	return true
end

function ActivityReturnData:canSkip()
	if not self:isShowSkip() then
		return false
	end

	return (g.core.common.Storage:load("activity_rerun_draw.json", true) or {}).skipValue
end

function ActivityReturnData:setSkipActionEnable(arg_21_1)
	local var_21_0 = g.core.common.Storage:load("activity_rerun_draw.json", true) or {}

	var_21_0.skipValue = arg_21_1

	g.core.common.Storage:save("activity_rerun_draw.json", var_21_0, true)
end

function ActivityReturnData:_sortAwards(arg_22_1)
	local var_22_0 = {}

	while 1 < #arg_22_1 do
		local var_22_1

		if arg_22_1[1].type == g.core.common.Goods.TYPE_KNIGHT then
			var_22_0[#var_22_0 + 1] = arg_22_1[1]

			table.remove(arg_22_1, 1)
		else
			var_22_1 = 1 + 1
		end
	end

	for iter_22_0, iter_22_1 in ipairs(var_22_0) do
		table.insert(arg_22_1, 1, iter_22_1)
	end
end

function ActivityReturnData:setBagNewPopEnable(arg_23_1)
	self._popNew = arg_23_1
end

function ActivityReturnData:isBagNewPopEnable()
	return self._popNew
end

function ActivityReturnData:onS2CRedPoint(arg_25_1)
	self:updateActivityData(arg_25_1.activity)

	self._canAward = arg_25_1.award
end

function ActivityReturnData:onS2CRerunGetInfo(arg_26_1)
	self._canAward = false

	local var_26_0 = self:getCurBaseInfo()

	var_26_0.info.curTimes = arg_26_1.guarantee_times

	if arg_26_1.choose_awards then
		var_26_0.info.curAward = arg_26_1.choose_awards[1]
	end

	if self:isExpired() then
		for iter_26_0, iter_26_1 in ipairs(var_26_0.taskInfo.normalTask) do
			if iter_26_1.cfg.action_id == 1094 then
				iter_26_1.state = 0

				break
			end
		end

		self:resetExpired()
	end

	self:updateTasks(arg_26_1.tasks)
end

function ActivityReturnData:onS2CRerunChooseAward(arg_27_1)
	self:getCurBaseInfo().info.curAward = arg_27_1.choose_awards[1]
end

function ActivityReturnData:onS2CRerunDraw(arg_28_1)
	self:getCurBaseInfo().info.curTimes = arg_28_1.guarantee_times

	self:_sortAwards(arg_28_1.awards)
end

function ActivityReturnData:onS2CRerunTaskAward(arg_29_1)
	self:_onTaskRcvByIdList(arg_29_1.ids)
end

function ActivityReturnData:onS2CActionStatusFlush(arg_30_1)
	if self._curId <= 0 or not self:isActivityOpen(self._curId) then
		return
	end

	self:_updateTaskValue({
		arg_30_1.status
	})
end

function ActivityReturnData:hasStageTaskAward(arg_31_1)
	if self._canAward then
		return true
	end

	if self._curId <= 0 or not self:isActivityOpen(self._curId) then
		return false
	end

	local var_31_0 = self:getCurBaseInfo().taskInfo.stageTask

	if not arg_31_1.id then
		for iter_31_0, iter_31_1 in ipairs(var_31_0) do
			if iter_31_1.state == 1 then
				return true
			end
		end
	else
		for iter_31_2, iter_31_3 in ipairs(var_31_0) do
			if iter_31_3.cfg.id == arg_31_1.id then
				return iter_31_3.state == 1
			end
		end
	end

	return false
end

function ActivityReturnData:hasNewActivity(arg_32_1)
	if self._curId <= 0 or not self:isActivityOpen(self._curId) then
		return false
	end

	return not (g.core.common.Storage:load("activity_rerun.json", true) or {})["season_" .. self._curId]
end

function ActivityReturnData:saveCurActivityLocalData()
	local var_33_0 = g.core.common.Storage:load("activity_rerun.json", true) or {}

	var_33_0["season_" .. self._curId] = true

	g.core.common.Storage:save("activity_rerun.json", var_33_0, true)
end

function ActivityReturnData:hasNormalTaskAward(arg_34_1)
	if self._curId <= 0 or not self:isActivityOpen(self._curId) then
		return false
	end

	local var_34_0 = self:getCurBaseInfo().taskInfo.normalTask

	if not arg_34_1.id then
		for iter_34_0, iter_34_1 in ipairs(var_34_0) do
			if iter_34_1.state == 1 then
				return true
			end
		end
	else
		for iter_34_2, iter_34_3 in ipairs(var_34_0) do
			if iter_34_3.cfg.id == arg_34_1.id then
				return iter_34_3.state == 1
			end
		end
	end

	return false
end

return ActivityReturnData
