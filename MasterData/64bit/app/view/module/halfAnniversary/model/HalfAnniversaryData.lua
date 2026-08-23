local var_0_0 = g.core.const.ConstMgr.FUNCTION_TYPE
local var_0_1 = g.core.config.function_info
local var_0_2 = g.core.config.welfarefund_reward_info
local var_0_3 = g.core.config.welfarefund_turn_info
local var_0_4 = g.core.config.welfarefund_task_info
local var_0_5 = g.core.common.ModuleUnlock
local var_0_6 = g.core.common.ServerTime
local var_0_7 = g.core.model.User.bagData
local var_0_8 = g.core.common.Goods
local HalfAnniversaryData = class("HalfAnniversaryData", require("app.core.model.BaseData"))

function HalfAnniversaryData:ctor()
	self:initData()
end

function HalfAnniversaryData:initData()
	self._activityId = 1
	self._activityStartTime = 0
	self._activityEndTime = 0
	self._taskList = {}
	self._scoreAwardIds = {}
	self._pointAwardInfo = {}
end

function HalfAnniversaryData:onS2CWelfarefundGetInfo(arg_3_1)
	self._activityId = arg_3_1.activity_id or 0
	self._activityStartTime = arg_3_1.start_time or 0
	self._activityEndTime = arg_3_1.end_time or 0
	self._days = arg_3_1.days or 0
	self._taskList = arg_3_1.task_list or {}
	self._scoreAwardIds = arg_3_1.score_awards or {}

	self:_initPointAwardsCfg()
	self:sortTaskList()
end

function HalfAnniversaryData:onS2CFlushRedPoint(arg_4_1)
	self:onS2CWelfarefundGetInfo(arg_4_1)
end

function HalfAnniversaryData:onS2CWelfarefundGetAward(arg_5_1)
	if arg_5_1.id then
		for iter_5_0, iter_5_1 in ipairs(self._taskList) do
			if iter_5_1.id == arg_5_1.id then
				iter_5_1.awarded = true
			end
		end
	end

	self:sortTaskList()
end

function HalfAnniversaryData:onS2CWelfarefundGetScoreAward(arg_6_1)
	if arg_6_1.id then
		table.insert(self._scoreAwardIds, arg_6_1.id)
	end
end

function HalfAnniversaryData:onS2CWelfarefundNotifyTask(arg_7_1)
	self._taskList = arg_7_1.task_list or {}

	self:sortTaskList()
end

function HalfAnniversaryData:sortTaskList()
	if self._taskList and next(self._taskList) then
		table.sort(self._taskList, function(arg_9_0, arg_9_1)
			local var_9_0 = self:getTaskStateNum(arg_9_0.id)
			local var_9_1 = self:getTaskStateNum(arg_9_1.id)

			if var_9_0 ~= var_9_1 then
				return var_9_1 < var_9_0
			end

			local var_9_2 = var_0_4.fetch(arg_9_0.id)
			local var_9_3 = var_0_4.fetch(arg_9_1.id)

			if var_9_2 and var_9_3 and var_9_2.order ~= var_9_3.order then
				return var_9_2.order < var_9_3.order
			end

			return false
		end)
	end
end

function HalfAnniversaryData:getTaskStateNum(arg_10_1)
	local var_10_0 = 1
	local var_10_1 = var_0_4.fetch(arg_10_1)
	local var_10_2 = self:getTaskInfo(arg_10_1)

	if var_10_2 and var_10_1 then
		if not var_10_2.awarded and var_10_2.value >= var_10_1.task_value then
			var_10_0 = 2
		elseif var_10_2.awarded then
			var_10_0 = 0
		end
	end

	return var_10_0
end

function HalfAnniversaryData:getTaskInfo(arg_11_1)
	if next(self._taskList) then
		for iter_11_0, iter_11_1 in ipairs(self._taskList) do
			if iter_11_1.id == arg_11_1 then
				return iter_11_1
			end
		end
	end

	return nil
end

function HalfAnniversaryData:onS2CWelfarefundBuyScore(arg_12_1)
	return
end

function HalfAnniversaryData:isActivityOpen(arg_13_1)
	if not var_0_5:isModuleUnlock(var_0_0.HALF_ANNIVERSARY) then
		return false
	end

	local var_13_0 = var_0_6:getTime()

	if var_13_0 < self._activityStartTime or var_13_0 > self._activityEndTime then
		return false
	end

	if (arg_13_1 or self._activityId) ~= self._activityId then
		return false
	end

	return true
end

function HalfAnniversaryData:getHalfAnniversaryBtnInfo()
	return {
		activity_id = self._activityId,
		activity_type = var_0_0.HALF_ANNIVERSARY,
		start_time = self._activityStartTime,
		end_time = self._activityEndTime,
		icon_path = var_0_1.get(var_0_0.HALF_ANNIVERSARY).icon,
		goto_module = g.view.entrance.HALF_ANNIVERSARY
	}
end

function HalfAnniversaryData:getActivityStartTime()
	return self._activityStartTime
end

function HalfAnniversaryData:getActivityEndTime()
	return self._activityEndTime
end

function HalfAnniversaryData:getActivityTaskInfo()
	return self._taskList
end

function HalfAnniversaryData:getActivityOpenDays()
	return self._days
end

function HalfAnniversaryData:_initPointAwardsCfg()
	if next(self._pointAwardInfo) then
		return
	end

	local var_19_0 = var_0_2.match(function(arg_20_0)
		return arg_20_0.turn_id == self._activityId
	end)

	if var_19_0 and next(var_19_0) then
		self._pointAwardInfo = var_19_0
	end
end

function HalfAnniversaryData:getMapPointAwardsCfg()
	return self._pointAwardInfo
end

function HalfAnniversaryData:getHalfYearActivityCfg()
	return (var_0_3.get(self._activityId))
end

function HalfAnniversaryData:getAllScoreAwards()
	local var_23_0 = {}

	local function var_23_1(arg_24_0)
		local var_24_0 = {}

		for iter_24_0 = 1, 3 do
			if arg_24_0["reward_type_" .. iter_24_0] > 0 then
				table.insert(var_24_0, {
					type = arg_24_0["reward_type_" .. iter_24_0],
					value = arg_24_0["reward_value_" .. iter_24_0],
					size = arg_24_0["reward_size_" .. iter_24_0]
				})
			end
		end

		return var_24_0
	end

	for iter_23_0, iter_23_1 in ipairs(self._pointAwardInfo) do
		local var_23_2 = self:isGetScoreAward(iter_23_1.id)
		local var_23_3 = var_23_1(iter_23_1)

		for iter_23_2 = 1, #var_23_3 do
			if not var_23_2 then
				table.insert(var_23_0, {
					needScore = iter_23_1.need_point,
					awards = var_23_3[iter_23_2]
				})
			end
		end
	end

	return var_23_0
end

function HalfAnniversaryData:isGetScoreAward(arg_25_1)
	for iter_25_0, iter_25_1 in ipairs(self._scoreAwardIds) do
		if iter_25_1 == arg_25_1 then
			return true
		end
	end

	return false
end

function HalfAnniversaryData:getLastUnLockPointId()
	return (next(self._scoreAwardIds) or nil) and self._scoreAwardIds[#self._scoreAwardIds]
end

function HalfAnniversaryData:getMovePosByScore(arg_27_1)
	local var_27_0 = 1
	local var_27_1 = 1
	local var_27_2 = 0
	local var_27_3 = 0

	for iter_27_0 = 1, #self._pointAwardInfo do
		if arg_27_1 >= self._pointAwardInfo[iter_27_0].need_point then
			var_27_0 = self._pointAwardInfo[iter_27_0].point_num
			var_27_2 = self._pointAwardInfo[iter_27_0].need_point

			if self._pointAwardInfo[iter_27_0 + 1] then
				var_27_3 = self._pointAwardInfo[iter_27_0 + 1].need_point
			end
		end
	end

	if var_27_3 - var_27_2 > 0 then
		var_27_1 = (arg_27_1 - var_27_2) / (var_27_3 - var_27_2)
		var_27_1 = (arg_27_1 - var_27_2) / (var_27_3 - var_27_2) >= 0.3 and var_27_1 < 0.6 and 2 or var_27_1 >= 0.6 and var_27_1 < 1 and 3 or 1
	end

	return var_27_0, var_27_1
end

function HalfAnniversaryData:getEnterMapStartPos()
	local var_28_0 = self:getLastUnLockPointId()
	local var_28_1 = 1
	local var_28_2 = 1

	if var_28_0 > 0 then
		local var_28_3 = var_0_2.get(var_28_0).point_num

		var_28_1, var_28_2 = self:getMovePosByScore((var_0_7:getCountById(var_0_8.TYPE_ITEM, self:getHalfYearActivityCfg().item_id)))

		if var_28_3 < var_28_1 then
			var_28_1 = var_28_3
		end
	end

	return var_28_1, var_28_2
end

function HalfAnniversaryData:isHaveScoreAwards()
	if next(self._pointAwardInfo) and self:isActivityOpen() then
		local var_29_0 = var_0_7:getCountById(var_0_8.TYPE_ITEM, self:getHalfYearActivityCfg().item_id)

		for iter_29_0, iter_29_1 in ipairs(self._pointAwardInfo) do
			if var_29_0 >= iter_29_1.need_point and not self:isGetScoreAward(iter_29_1.id) then
				return true
			end
		end
	end

	return false
end

function HalfAnniversaryData:isHaveTaskAwards()
	if next(self._taskList) and self:isActivityOpen() then
		for iter_30_0, iter_30_1 in ipairs(self._taskList) do
			if iter_30_1.value >= g.core.config.welfarefund_task_info.get(iter_30_1.id).task_value and not iter_30_1.awarded then
				return true
			end
		end
	end

	return false
end

function HalfAnniversaryData:getTimeData()
	return self._activityStartTime or 0, self._activityEndTime or 0, self._activityEndTime or 0
end

return HalfAnniversaryData
