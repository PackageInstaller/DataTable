-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newbietask/model/NewbieTaskModel.lua

module("logic.extensions.newbietask.model.NewbieTaskModel", package.seeall)

local M = class("NewbieTaskModel", BaseModel)

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self:onReset()
end

function M:onReset()
	self._curUnlockMaxDay = 1
	self._taskMoLst = {}
	self._stepPointReceive = {
		{},
		{}
	}
end

function M:isNewbieTaskActive(showLockTips)
	local canshow = SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.NewbieTask, showLockTips)

	if not canshow then
		return
	end

	if self:allTaskFinish() and self:allStepRewardReceived() then
		return false
	end

	return true
end

function M:hasCanReward(includeStepReward)
	local has = false

	if self:isNewbieTaskActive(false) then
		local maxDay = NewbieTaskConfig.instance:getMaxDay()

		for i = 1, maxDay do
			has = has or self:getHasTaskCanRewardInTargetDay(i)
		end
	end

	if includeStepReward and not has then
		local stepRewardLst = NewbieTaskConfig.instance:getStepRewardLst()
		local maxStepPoint = #stepRewardLst

		for i = 1, maxStepPoint do
			if not has then
				local cfg = stepRewardLst[i]
				local stepPoint = cfg.stepPoint
				local group = cfg.group
				local rewardStatus = self:getStepPointRewardStatus(stepPoint, group)

				if rewardStatus == CommEnum.RewardEnum.CanGot then
					has = true
				end
			end
		end
	end

	return has
end

function M:allTaskFinish()
	local maxDay = NewbieTaskConfig.instance:getMaxDay()

	if maxDay > self:getCurUnlockMaxDay() then
		return false
	end

	return self:allUnlockTaskFinish()
end

function M:allUnlockTaskFinish()
	local allFinish = true

	for taskId, mo in pairs(self._taskMoLst or {}) do
		if not mo:getIsFinish() then
			allFinish = false

			break
		end
	end

	return allFinish
end

function M:allStepRewardReceived()
	local allReceived = true
	local cfgStepLst = NewbieTaskConfig.instance:getStepRewardLst()

	for _, cfg in ipairs(cfgStepLst) do
		if not self:isStepPointReceive(cfg.stepPoint, cfg.group) then
			allReceived = false

			break
		end
	end

	return allReceived
end

function M:getCurUnlockMaxDay()
	return self._curUnlockMaxDay
end

function M:getDefaultShowOpenDay()
	local openDay = 1
	local curMaxDay = self:getCurUnlockMaxDay()

	if self:allUnlockTaskFinish() then
		return curMaxDay
	end

	openDay = self:getDefaultOpenDayWithStart(1)

	return openDay
end

function M:getDefaultOpenDayWithStart(start)
	local openDay = start
	local curMaxDay = self:getCurUnlockMaxDay()
	local findDay = false

	for i = start, curMaxDay do
		openDay = i

		local cfgLst = NewbieTaskConfig.instance:getTaskLst(openDay)

		for _, cfg in ipairs(cfgLst) do
			local rewardStatus = self:getTaskRewardStatus(cfg.id)

			if rewardStatus == NewbieTaskConfig.TaskState.CanReceive or rewardStatus == NewbieTaskConfig.TaskState.Doing then
				findDay = true

				break
			end
		end

		if findDay then
			break
		end
	end

	return openDay
end

function M:updateStepPointReceiveLst(stepPointLst)
	if not stepPointLst then
		return
	end

	for i, v in ipairs(stepPointLst) do
		for _, value in ipairs(v.stepPoint) do
			self._stepPointReceive[v.group][value] = 1
		end
	end
end

function M:isStepPointReceive(stepPointId, group)
	return self._stepPointReceive[group][stepPointId] ~= nil
end

function M:getStepPointRewardStatus(stepPoint, group)
	local rewardStatus = CommEnum.RewardEnum.CanNotGot

	if self:isStepPointReceive(stepPoint, group) then
		rewardStatus = CommEnum.RewardEnum.HasGot
	elseif stepPoint <= self:getCurStepPoint(group) then
		rewardStatus = CommEnum.RewardEnum.CanGot
	end

	return rewardStatus
end

function M:getCurStepPoint(group)
	local stepPointItemId = NewbieTaskConfig.instance:getWeekCurrencyId(group)

	return ItemModel.instance:getItemCountByItemId(stepPointItemId)
end

function M:getTaskMo(id)
	return self._taskMoLst[id]
end

function M:updateTaskLst(taskLst)
	local realTaskIdLst = {}
	local num = 0

	if taskLst and #taskLst > 0 then
		for _, taskNo in ipairs(taskLst) do
			local taskId = taskNo.id

			self:updateTask(taskNo)

			realTaskIdLst[taskId] = 1
			num = num + 1
		end
	end

	if num == 0 then
		self._taskMoLst = {}
	else
		for taskId, _ in pairs(self._taskMoLst) do
			if not realTaskIdLst[taskId] then
				self._taskMoLst[taskId] = nil
			end
		end
	end
end

function M:updateTask(taskNo)
	local taskId = taskNo.id

	if not self._taskMoLst[taskId] then
		self._taskMoLst[taskId] = NewbieTaskMo.New()
	end

	local theMo = self:getTaskMo(taskId)

	theMo:updateFromServer(taskNo)

	local cfg = NewbieTaskConfig.instance:getConfigByKey(ConfigName.NewbieTask, taskId)

	if cfg and cfg.openDay > self._curUnlockMaxDay then
		self._curUnlockMaxDay = cfg.openDay
	end
end

function M:getTaskMoLst(openDay)
	local lst = {}
	local cfgLst = NewbieTaskConfig.instance:getTaskLst(openDay)

	for _, cfg in ipairs(cfgLst) do
		local theMo = self:getTaskMo(cfg.id)

		table.insert(lst, theMo)
	end

	if #lst > 0 then
		table.sort(lst, function(a, b)
			local statusA = self:getTaskRewardStatus(a:getId())
			local statusB = self:getTaskRewardStatus(b:getId())

			if statusA ~= statusB then
				return statusB < statusA
			elseif a:getPriority() ~= b:getPriority() then
				return a:getPriority() > b:getPriority()
			else
				return a:getId() > b:getId()
			end
		end)
	end

	return lst
end

function M:getHasTaskCanRewardInTargetDay(openDay)
	local canReward = false
	local cfgLst = NewbieTaskConfig.instance:getTaskLst(openDay)

	for _, cfg in ipairs(cfgLst) do
		if not canReward then
			local status = self:getTaskRewardStatus(cfg.id)

			if status == NewbieTaskConfig.TaskState.CanReceive then
				canReward = true
			end
		end
	end

	return canReward
end

function M:getTaskRewardStatus(id)
	local taskMo = self:getTaskMo(id)

	if not taskMo then
		return NewbieTaskConfig.TaskState.Doing
	end

	if taskMo:getIsFinish() then
		return NewbieTaskConfig.TaskState.IsReceived
	elseif taskMo:canGetReward() then
		return NewbieTaskConfig.TaskState.CanReceive
	else
		return NewbieTaskConfig.TaskState.Doing
	end
end

function M:canTaskSendServerToReward(id)
	local taskMo = self:getTaskMo(id)

	if taskMo then
		if not taskMo:getIsOnline() then
			printWarn(string.format("任务[%d]尚未上线", id))

			return false
		end

		if taskMo:getIsFinish() then
			printWarn(string.format("任务[%d]已完成不能重复完成", id))

			return false
		end

		if not taskMo:canGetReward() then
			printWarn(string.format("任务[%d]未达标不能完成[%s/%s]", id, taskMo:getCount(), taskMo:getMaxCnt()))

			return false
		end

		return true
	else
		printWarn(string.format("没有任务[%d]的数据不能完成", id))

		return false
	end
end

function M:recordJumpWeekDay(week, day)
	self._recordWeek = week
	self._recordDay = day
end

function M:getRecordJump()
	return self._recordWeek, self._recordDay
end

function M:clearRecord()
	self:recordJumpWeekDay(false, false)
end

function M:getFinishDays()
	local firstWeek = {}
	local secondWeek = {}
	local maxDay = NewbieTaskConfig.instance:getMaxDay()

	for i = 1, maxDay do
		local allFinish = self:getIsFinishDay(i)

		if allFinish then
			if i <= 7 then
				table.insert(firstWeek, i)
			else
				table.insert(secondWeek, i)
			end
		end
	end

	return firstWeek, secondWeek
end

function M:getIsFinishDay(day)
	if day > self._curUnlockMaxDay then
		return false
	end

	local lst = self:getTaskMoLst(day)
	local allFinish = true

	for _, mo in pairs(lst) do
		if not mo:getIsFinish() then
			allFinish = false

			break
		end
	end

	return allFinish
end

M.instance = M.New()

return M
