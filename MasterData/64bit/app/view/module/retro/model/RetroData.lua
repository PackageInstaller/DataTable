local var_0_0 = g.core.config.activity_retro_display_info
local var_0_1 = g.core.config.activity_retro_info
local var_0_2 = g.core.config.activity_retro_box_info
local var_0_3 = g.core.config.activity_retro_box_content_info
local var_0_4 = g.core.const.ConstMgr.RetroConst
local RetroData = class("RetroData", require("app.core.model.BaseData"))
local RetroTaskData = require("app.view.module.retro.model.RetroTaskData")

function RetroData:ctor()
	self:initData()
end

function RetroData:initData()
	self._actId = 1
	self._actStartTime = 0
	self._actEndTime = 0
	self._isHaveRedPoint = false
	self._allRefreshTime = 0
	self._lastRefreshTime = 0
	self._boxData = {}
	self._boxAwardIds = {}
	self._taskData = RetroTaskData.new()
	self._boxGroupMap = {}
	self._boxContentGroupMap = {}
	self._guaranteeTimeMap = {}
	self._curNotifyState = false

	self:_initBoxGroupConfig()
end

function RetroData:_initBoxGroupConfig()
	self._boxGroupMap = {}

	for iter_3_0, iter_3_1 in var_0_2.ipairs() do
		self._boxGroupMap[iter_3_1.group] = self._boxGroupMap[iter_3_1.group] or {}

		table.insert(self._boxGroupMap[iter_3_1.group], iter_3_1)
	end

	self._boxContentGroupMap = {}

	for iter_3_2, iter_3_3 in var_0_3.ipairs() do
		self._boxContentGroupMap[iter_3_3.group] = self._boxContentGroupMap[iter_3_3.group] or {}

		table.insert(self._boxContentGroupMap[iter_3_3.group], iter_3_3)
	end
end

function RetroData:getBoxConfigByGroup(arg_4_1)
	return self._boxGroupMap[arg_4_1]
end

function RetroData:getBoxContentConfigByGroup(arg_5_1)
	return self._boxContentGroupMap[arg_5_1]
end

function RetroData:getOneBoxCfgById(arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(self._boxConfig) do
		if iter_6_1.quality == arg_6_1 then
			return iter_6_1
		end
	end
end

function RetroData:getBoxCfgByQuality(arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(self._boxConfig) do
		if iter_7_1.quality == arg_7_1 then
			return iter_7_1
		end
	end
end

function RetroData:getBoxGuaranteeTimeByQuality(arg_8_1)
	return math.max((self:getBoxCfgByQuality(arg_8_1).guarantee_times or 0) - ((not self._guaranteeTimeMap[arg_8_1] or nil) and 0), 0)
end

function RetroData:isGetBoxAward(arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(self._boxAwardIds) do
		if iter_9_1.index == arg_9_1 then
			return true, iter_9_1.awards
		end
	end

	return false, nil
end

function RetroData:getSvrRandBoxData()
	return self._boxData
end

function RetroData:onS2CRedPoint(arg_11_1)
	self._isHaveRedPoint = arg_11_1.is_hint

	if arg_11_1.activity then
		self._actId = arg_11_1.activity.sub_id or 0
		self._actStartTime = arg_11_1.activity.start_time or 0
		self._actEndTime = arg_11_1.activity.end_time or 0
		self._activityCfg = var_0_1.get(self._actId)

		self._taskData:initTaskData(self._activityCfg.task_group)

		self._boxConfig = self:getBoxConfigByGroup(self._activityCfg.box_group)
	end
end

function RetroData:onS2CRetroGetInfo(arg_12_1)
	if arg_12_1.retro then
		self._actId = arg_12_1.retro.sub_id
		self._allRefreshTime = arg_12_1.retro.refresh_times
		self._lastRefreshTime = arg_12_1.retro.last_refresh_time
		self._boxData = arg_12_1.retro.boxes
		self._activityCfg = var_0_1.get(self._actId)
		self._boxConfig = self:getBoxConfigByGroup(self._activityCfg.box_group)

		if arg_12_1.retro.box_guarantee_times then
			self._guaranteeTimeMap = {}

			for iter_12_0, iter_12_1 in ipairs(arg_12_1.retro.box_guarantee_times) do
				self._guaranteeTimeMap[iter_12_1.id] = self._guaranteeTimeMap[iter_12_1.id] or {}
				self._guaranteeTimeMap[iter_12_1.id] = iter_12_1.num
			end
		end
	end

	if arg_12_1.retro_box_awards then
		self._boxAwardIds = arg_12_1.retro_box_awards
	end

	if arg_12_1.tasks then
		self._taskData:updateTaskData(arg_12_1.tasks)

		self._isHaveRedPoint = false
	end
end

function RetroData:onS2CRetroBoxAward(arg_13_1)
	if arg_13_1.tp == 1 then
		table.insert(self._boxAwardIds, {
			index = arg_13_1.index,
			awards = arg_13_1.awards
		})

		if #self._boxAwardIds == 9 then
			self:refreshAllBoxes(arg_13_1.boxes)
		end
	elseif arg_13_1.tp == 2 then
		self:refreshAllBoxes(arg_13_1.boxes)
	end

	if arg_13_1.box_guarantee_times then
		for iter_13_0, iter_13_1 in ipairs(arg_13_1.box_guarantee_times) do
			self._guaranteeTimeMap[iter_13_1.id] = self._guaranteeTimeMap[iter_13_1.id] or iter_13_1.num
			self._guaranteeTimeMap[iter_13_1.id] = iter_13_1.num
		end
	end
end

function RetroData:onS2CRetroRefreshBox(arg_14_1)
	self._allRefreshTime = self._allRefreshTime + 1

	self:refreshAllBoxes(arg_14_1.boxes)
end

function RetroData:refreshAllBoxes(arg_15_1)
	self._boxData = arg_15_1
	self._boxAwardIds = {}
end

function RetroData:setNotifyState(arg_16_1)
	self._curNotifyState = arg_16_1
end

function RetroData:isNotifyState()
	return self._curNotifyState
end

function RetroData:setNotifyBuyCostTips(arg_18_1)
	self._buyCostTips = arg_18_1
end

function RetroData:isNotifyBuyCostTips()
	return self._buyCostTips
end

function RetroData:getOneKeyCost()
	local var_20_0 = {}

	for iter_20_0, iter_20_1 in ipairs(self._boxData) do
		local var_20_1 = self:getOneBoxCfgById(iter_20_1)

		if not self:isGetBoxAward(iter_20_0 - 1) then
			local var_20_2 = false

			for iter_20_2, iter_20_3 in ipairs(var_20_0) do
				if iter_20_3.type == var_20_1.open_type and iter_20_3.value == var_20_1.open_value then
					iter_20_3.size = iter_20_3.size + var_20_1.open_size
					var_20_2 = true
				end
			end

			if not var_20_2 and var_20_1.open_size > 0 then
				table.insert(var_20_0, {
					type = var_20_1.open_type,
					value = var_20_1.open_value,
					size = var_20_1.open_size
				})
			end
		end
	end

	return var_20_0
end

function RetroData:getRetroDisplayInfo()
	return (var_0_0.get(self._actId))
end

function RetroData:isActOpen(arg_22_1)
	arg_22_1 = arg_22_1 or self._actId

	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.ACTIVITY_RETRO) then
		return false
	end

	if self._actId == arg_22_1 then
		local var_22_0 = g.core.common.ServerTime:getTime()

		if var_22_0 >= self._actStartTime and var_22_0 < self._actEndTime then
			return true
		end
	end

	return false
end

function RetroData:getActEndTime(arg_23_1)
	return (self._actId == arg_23_1 or nil) and self._actEndTime
end

function RetroData:checkRetroActIsOpen(arg_24_1)
	if not self:isActOpen(arg_24_1) then
		return false, 0
	end

	return true, self._actEndTime
end

function RetroData:onS2CRetroTaskAward(arg_25_1)
	self._taskData:onTaskAward(arg_25_1.task_id)
end

function RetroData:getRetroActId()
	return self._actId
end

function RetroData:getRetroActivityCfg()
	return self._activityCfg
end

function RetroData:getRetroOpenBoxFreeTime()
	return self._activityCfg.refresh_free_times - self._allRefreshTime
end

function RetroData:isFreeTime()
	return self:getRetroOpenBoxFreeTime() > 0
end

function RetroData:isHaveSuperBoxNoAwards()
	for iter_30_0, iter_30_1 in ipairs(self._boxData) do
		if not self:isGetBoxAward(iter_30_0 - 1) and self:getOneBoxCfgById(iter_30_1).quality == var_0_4.BOX_QUALITY.SUPER then
			return true
		end
	end

	return false
end

function RetroData:getTaskData()
	return self._taskData
end

function RetroData:isCanRewardTask()
	if self._isHaveRedPoint then
		return true
	end

	return self._taskData:isCanRewardTask()
end

function RetroData:isCanRewardStageTask()
	if self._isHaveRedPoint then
		return true
	end

	return self._taskData:isCanRewardStageTask()
end

return RetroData
