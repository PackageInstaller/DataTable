-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tacit/model/TacitTargetTaskMO.lua

module("logic.extensions.tacit.model.TacitTargetTaskMO", package.seeall)

local M = class("TacitTargetTaskMO")

function M:ctor(cfg, heroId)
	self._heroId = heroId
	self._id = cfg.code
	self._jumpId = cfg.jumpId

	local itemId, number = ItemUtil.parseCostStr(cfg.reward)

	if itemId then
		self._rewardInfo = {
			itemId = itemId,
			num = number
		}
	else
		self._rewardInfo = false
	end

	self._tacitExp = cfg.tacitExp
	self._maxCount = 1
	self._isTaskGroup = false
	self._taskDesc = false

	if not string.nilorempty(cfg.param) and cfg.content > 0 then
		local newParam = string.gsub(cfg.param, "${heroCode}", heroId)

		self._taskDesc, self._maxCount, self._isTaskGroup = TaskUtil.parseContent(cfg.content, newParam, heroId)
	end

	if type(self._maxCount) ~= "number" then
		self._maxCount = tonumber(self._maxCount)
	end

	if not string.nilorempty(cfg.desc) then
		self._taskDesc = cfg.desc
	end

	self._curCount = 0
	self._canGetReward = false
	self._hasFinish = false
end

function M:updateByAgent(data)
	self._id = data.id
	self._curCount = data.count
	self._hasFinish = data.finish
	self._canGetReward = tonumber(self._curCount) >= tonumber(self._maxCount)
end

function M:updateData(id, count, finish)
	self._id = id
	self._curCount = count
	self._hasFinish = finish
	self._canGetReward = tonumber(self._curCount) >= tonumber(self._maxCount)
end

function M:getId()
	return self._id
end

function M:getCurCount()
	return 0
end

function M:getMaxCount()
	return self._maxCount
end

function M:getRewardTb()
	return self._rewardInfo
end

function M:getTacitExp()
	return self._tacitExp
end

function M:getDesc()
	return self._taskDesc
end

function M:getJumpId()
	return self._jumpId
end

function M:getCurCount()
	return self._curCount
end

function M:getMaxCount()
	return self._maxCount
end

function M:getCanReward()
	return self._canGetReward or false
end

function M:setFinish()
	self._hasFinish = true
end

function M:getHasFinish()
	return self._hasFinish
end

function M:getHeroId()
	return self._heroId
end

return M
