-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housemain/model/HouseTaskModel.lua

module("logic.extensions.housemain.model.HouseTaskModel", package.seeall)

local M = class("HouseTaskModel", BaseModel)

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self:onReset()
end

function M:onReset()
	self._houseLevel = 1
	self._houseExp = 0
	self._houseLevelReceive = 0
	self._taskMoLst = {}
end

function M:setHouseLevel(level)
	self._houseLevel = level
end

function M:getHouseLevel()
	return self._houseLevel
end

function M:canReceiveLvReward()
	return self:getHouseLevelReceive() < self:getHouseLevel()
end

function M:setHouseExp(exp)
	self._houseExp = exp
end

function M:getHouseExp()
	return self._houseExp
end

function M:setHouseLevelReceive(received)
	self._houseLevelReceive = received

	HouseDispatcher:dispatchEvent(HouseEventType.HOUSE_LEVEL_INFO_CHANGE)
end

function M:getHouseLevelReceive()
	return self._houseLevelReceive
end

function M:getExpInfo(lv, nowExp)
	local showExp = nowExp
	local showExpRequire = 0
	local cfgNowLv = HouseConfig.instance:getConfigByKey(ConfigName.HouseLevel, lv)

	if lv == 1 then
		showExpRequire = cfgNowLv.exp
	else
		local cfgLst = HouseConfig.instance:getConfigList(ConfigName.HouseLevel)
		local maxLv = #cfgLst

		if lv ~= maxLv then
			local cfgPreLv = HouseConfig.instance:getConfigByKey(ConfigName.HouseLevel, lv - 1)

			if cfgPreLv then
				showExp = nowExp - cfgPreLv.exp
				showExpRequire = cfgNowLv.exp - cfgPreLv.exp
			else
				printError(string.format("从[%s]无法找到lv[%d]的配置", ConfigName.HouseLevel, lv - 1))
			end
		end
	end

	return showExp, showExpRequire
end

function M:getNowExpLv(nowExp)
	local lv = 0
	local cfgLst = HouseConfig.instance:getConfigList(ConfigName.HouseLevel)

	for _, cfg in ipairs(cfgLst or {}) do
		if cfg.exp ~= 0 and nowExp >= cfg.exp and lv <= cfg.houseLv then
			lv = cfg.houseLv
		end
	end

	lv = lv + 1

	return lv
end

function M:getMaxLv()
	if not self._maxLv then
		self._maxLv = 1

		local cfgLst = HouseConfig.instance:getConfigList(ConfigName.HouseLevel)

		for _, value in ipairs(cfgLst or {}) do
			if value.houseLv >= self._maxLv then
				self._maxLv = value.houseLv
			end
		end
	end

	return self._maxLv
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
		self._taskMoLst[taskId] = HouseTaskMo.New()
	end

	local theMo = self:getTaskMo(taskId)

	theMo:updateFromServer(taskNo)
end

function M:onTaskRewardReceived(tasksIds)
	for _, taskId in ipairs(tasksIds or {}) do
		local theMo = self:getTaskMo(taskId)

		if theMo then
			theMo:setIsFinish(true)
		end
	end
end

function M:onTaskSchedulePush(taskNO)
	local id = taskNO.id
	local cfg = HouseConfig.instance:getConfigByKey(ConfigName.HouseTask, id)

	if cfg then
		self:updateTask(taskNO)
	end
end

function M:getTaskLst()
	local list = {}

	if self._taskMoLst then
		for taskId, houseTaskMo in pairs(self._taskMoLst or {}) do
			if houseTaskMo:getLabelTyp() == TaskExtension_pb.TaskLabel.HouseDaily and self:canTaskShow(taskId) and self:isPreTaskFinish(taskId) then
				table.insert(list, houseTaskMo)
			end
		end
	end

	return list
end

function M:getAchievementLst()
	local list = {}

	if self._taskMoLst then
		for taskId, houseTaskMo in pairs(self._taskMoLst or {}) do
			if houseTaskMo:getLabelTyp() == TaskExtension_pb.TaskLabel.HouseTask and self:canTaskShow(taskId) and self:isPreTaskFinish(taskId) then
				table.insert(list, houseTaskMo)
			end
		end
	end

	return list
end

function M:getTaskMo(id)
	return self._taskMoLst[id]
end

function M:getTaskOrAchievenmentCanRewardCount()
	local count = 0

	if self._taskMoLst then
		for taskId, houseTaskMo in pairs(self._taskMoLst or {}) do
			if self:canTaskShow(taskId) and not houseTaskMo:getIsFinish() and houseTaskMo:canGetReward() then
				count = count + 1
			end
		end
	end

	return count
end

function M:canTaskShow(id)
	local houseTaskMo = self:getTaskMo(id)

	if houseTaskMo == nil then
		printWarn(string.format("<color=#00CC00>任务[%d]无数据，不显示</color>", id))

		return false
	end

	if houseTaskMo:getIsNoShow() then
		return false
	end

	if not houseTaskMo:getIsOnline() then
		return false
	end

	if houseTaskMo:isExpired() then
		return false
	end

	if not self:isPreTaskFinish(id) then
		return false
	end

	return true
end

function M:canTaskSendServerToReward(id)
	local houseTaskMo = self:getTaskMo(id)

	if houseTaskMo then
		if houseTaskMo:getIsNoShow() then
			printWarn(string.format("任务[%d]配置为noShow,理论上不能完成", id))

			return false
		end

		if not houseTaskMo:getIsOnline() then
			printWarn(string.format("任务[%d]尚未上线", id))

			return false
		end

		if houseTaskMo:getIsFinish() then
			printWarn(string.format("任务[%d]已完成不能重复完成", id))

			return false
		end

		if not houseTaskMo:canGetReward() then
			printWarn(string.format("任务[%d]未达标不能完成[%s/%s]", id, houseTaskMo:getFinishCnt(), houseTaskMo:getMaxCnt()))

			return false
		end

		if houseTaskMo:isExpired() then
			printWarn(string.format("任务[%d]已失效[%s ~ %s]", id, houseTaskMo:getStartTime(), houseTaskMo:getEndTime()))
			FloatWordMgr.instance:show(lang("tip_task_not_work"))

			return false
		end

		if not self:isPreTaskFinish(id) then
			printWarn(string.format("任务[%d]前置任务未完成", id))

			return false
		end

		return true
	else
		printWarn(string.format("没有任务[%d]的数据不能完成", id))

		return false
	end
end

function M:isPreTaskFinish(houseTaskId)
	local curMo = self:getTaskMo(houseTaskId)

	if not curMo then
		return false
	end

	local preTaskId = curMo:getPreTask() or 0

	if preTaskId > 0 then
		local preAch = self:getTaskMo(preTaskId)

		return preAch and preAch:getIsFinish()
	end

	return true
end

function M.sortAchievement(taskA, taskB)
	if taskA:getIsFinish() ~= taskB:getIsFinish() then
		return not taskA:getIsFinish()
	end

	if taskA:canGetReward() ~= taskB:canGetReward() then
		return taskA:canGetReward()
	end

	if taskA:getPriority() ~= taskB:getPriority() then
		return taskA:getPriority() > taskB:getPriority()
	end

	return taskA:getId() < taskB:getId()
end

M.instance = M.New()

return M
