-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/controlaction/model/ManualMo.lua

module("logic.extensions.controlaction.model.ManualMo", package.seeall)

local M = class("ManualMo")

function M:ctor()
	self._id = 0
	self._taskMoList = false
	self._canHold = false
	self._isHold = false
end

function M:init(dataNO)
	self._id = dataNO.id
	self._canHold = dataNO.canHold
	self._isHold = dataNO.isHold

	if not self._taskMoList then
		self._taskMoList = {}

		local groupCo = ControlActionConfig.instance:getMonitorDungeonGroupCfg(self._id)
		local taskIdList = groupCo.taskId

		printWarn("====ManualMo init task=====", #taskIdList)

		for i, v in ipairs(taskIdList) do
			printWarn("====ManualMo init task ====id= ", v)

			local taskMo = ManualTaskMo.New()

			taskMo:initData(v, 0, false)
			table.insert(self._taskMoList, taskMo)
		end
	end

	for i, v in ipairs(dataNO.tasks) do
		local taskMo = self:_getTaskMo(v.id)

		if taskMo then
			taskMo:initData(v.id, v.count, v.finish)
		end
	end
end

function M:_getTaskMo(taskId)
	for i, v in ipairs(self._taskMoList) do
		if taskId == v:getTaskId() then
			return v
		end
	end

	printError("===not find manual task mo=== taskId= ", taskId)

	return false
end

function M:getId()
	return self._id
end

function M:canHold()
	return self._canHold
end

function M:isHold()
	return self._isHold
end

function M:setIsHold(isHold)
	self._isHold = isHold
end

function M:getTasMokList()
	if self._taskMoList then
		table.sort(self._taskMoList, self._sort)
	end

	return self._taskMoList or {}
end

local SortIndex = {
	CanJump = 2,
	ReadOnly = 3,
	Done = 10,
	CanGetReward = 1
}

local function _genSortIndex(mo)
	if mo:getIsFinish() then
		return SortIndex.Done
	elseif mo:canGetReward() then
		return SortIndex.CanGetReward
	elseif mo:canJump() then
		return SortIndex.CanJump
	else
		return SortIndex.ReadOnly
	end
end

function M._sort(mo1, mo2)
	if _genSortIndex(mo1) ~= _genSortIndex(mo2) then
		return _genSortIndex(mo1) < _genSortIndex(mo2)
	else
		return mo1:getTaskId() < mo2:getTaskId()
	end
end

return M
