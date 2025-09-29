-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housemain/model/HouseTaskMo.lua

module("logic.extensions.housemain.model.HouseTaskMo", package.seeall)

local M = class("HouseTaskMo")

function M:ctor()
	return
end

function M:updateFromServer(taskNo)
	local id = taskNo.id

	self._isLimitTask = false

	self:refreshCfg(id)

	self._id = id
	self._count = taskNo.count
	self._finish = taskNo.finish
end

function M:refreshCfg(id)
	if self._id == nil or self._id ~= id then
		local cfg = HouseConfig.instance:getConfigByKey(ConfigName.HouseTask, id)
		local taskText = cfg and cfg.text or nil

		if cfg then
			self._label = cfg.label
			self._name = cfg.name
			self._taskDesc = cfg.text
			self._content = cfg.content
			self._param = cfg.param
			self._startTime = cfg.startTime
			self._endTime = cfg.endTime
			self._noShow = cfg.noShow
		else
			printError(string.format("无法从[%s]找到[%s]的配置", ConfigName.HouseTask, id))

			self._name = ""
			self._taskDesc = ""
		end

		self._maxCount = 1
		self._rewardId = cfg and checknumber(cfg.reward) or 0
		self._exp = cfg and cfg.exp or 0
		self._jumpId = cfg and cfg.jump or ""
		self._priority = cfg and cfg.priority or 0
		self._preTask = cfg and cfg.preTask or 0
		self._isOnline = cfg and cfg.isOnline or 0

		if not string.nilorempty(self._param) and self._content > 0 then
			local taskDesc, maxCount, isTaskGroup = TaskUtil.parseContent(self._content, self._param)

			if not string.nilorempty(taskDesc) then
				self._taskDesc = taskDesc
			end

			self._maxCount = maxCount
		end

		if not string.nilorempty(taskText) then
			self._taskDesc = taskText
		end
	end
end

function M:getId()
	return self._id
end

function M:getLabelTyp()
	return self._label
end

function M:getCount()
	return self._count
end

function M:getFinishCnt()
	return self:getCount()
end

function M:getPreTask()
	return self._preTask or 0
end

function M:setIsFinish(isFinish)
	self._finish = isFinish
end

function M:getIsFinish()
	return self._finish
end

function M:getMaxCnt()
	return self._maxCount
end

function M:getExp()
	return self._exp
end

function M:getName()
	return self._name
end

function M:getDesc()
	return self._taskDesc
end

function M:getJumpId()
	return self._jumpId
end

function M:canJump()
	return not string.nilorempty(self:getJumpId())
end

function M:getPriority()
	return self._priority
end

function M:getIsNoShow()
	return self._noShow
end

function M:getIsOnline()
	return self._isOnline == 1
end

function M:getStartTime()
	return self._startTime
end

function M:getEndTime()
	return self._endTime
end

function M:isExpired()
	local canOnLine = false
	local beginT = false
	local endT = false

	if not string.nilorempty(self._startTime) then
		beginT = TimeUtil.instance:dateStr2TimeStamp(self._startTime)
	end

	if not string.nilorempty(self._endTime) then
		endT = TimeUtil.instance:dateStr2TimeStamp(self._endTime)
	end

	if beginT then
		if endT then
			if endT > ServerTime.now() and beginT <= ServerTime.now() then
				canOnLine = true
				self._isLimitTask = true
			end
		elseif beginT <= ServerTime.now() then
			canOnLine = true
		end
	elseif endT then
		if endT > ServerTime.now() then
			canOnLine = true
			self._isLimitTask = true
		end
	else
		canOnLine = true
	end

	return not canOnLine
end

function M:getIsLimitTask()
	return self._isLimitTask
end

function M:canGetReward()
	return self:getFinishCnt() >= self:getMaxCnt()
end

function M:getTaskState()
	local taskState = HouseMainEnum.TaskState

	if self:getIsFinish() then
		taskState = taskState.Finish
	else
		taskState = self:canGetReward() and taskState.CanReceived or taskState.Running
	end

	return taskState
end

function M:getRewardList()
	if not self._rewardList then
		self._rewardList = self:_parseReward()
	end

	return self._rewardList
end

function M:_parseReward()
	local rewardId = tonumber(self._rewardId)
	local rewardCO = RewardConfig.instance:getRewardCfgByCode(rewardId)
	local tempList = {}
	local exp = self:getExp()

	if exp > 0 then
		local expItemId = HouseConfig.instance:getHouseConst("HouseConstructExpItem").numValue

		table.insert(tempList, {
			itemId = expItemId,
			num = exp
		})
	end

	if rewardCO then
		for i, v in ipairs(rewardCO.reward and rewardCO.reward or {}) do
			table.insert(tempList, {
				itemId = v.code,
				num = v.num
			})
		end
	end

	return tempList
end

return M
