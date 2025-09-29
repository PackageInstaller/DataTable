-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/MasterTrainingTask/model/MasterTrainingTaskMo.lua

module("logic.extensions.MasterTrainingTask.model.MasterTrainingTaskMo", package.seeall)

local M = class("MasterTrainingTaskMo")

function M:ctor()
	return
end

function M:updateFromServer(taskNo)
	local id = taskNo.id

	self:refreshCfg(id)

	self._id = id
	self._count = taskNo.count
	self._finish = taskNo.finish
end

function M:refreshCfg(id)
	if self._id == nil or self._id ~= id then
		local cfg = MasterTrainingTaskConfig.instance:getConfigByTaskid(id)

		self._param = cfg and cfg.param or ""
		self._content = cfg and cfg.content or 0
		self._jumpId = cfg and cfg.jump or ""
		self._jumpId = string.nilorempty(self._jumpId) and 0 or tonumber(self._jumpId)
		self._reward = cfg and cfg.reward or ""

		if not string.nilorempty(self._param) and self._content > 0 then
			local taskDesc, maxCount, isTaskGroup = TaskUtil.parseContent(self._content, self._param)

			self._maxCount = maxCount
		end
	end
end

function M:getId()
	return self._id
end

function M:getCount()
	return self._count
end

function M:setIsFinish(isFinish)
	self._finish = isFinish
end

function M:getIsFinish()
	return self._finish
end

function M:getMaxCnt()
	return self._maxCount or 1
end

function M:getJumpId()
	return self._jumpId
end

function M:canJump()
	return not string.nilorempty(self:getJumpId())
end

function M:canGetReward()
	return self:getCount() >= self:getMaxCnt()
end

function M:getRewardItemData()
	if not self._rewardItemData then
		local itemId, itemCount = NewbieTaskConfig.instance:str2ItemIdCount(self._reward)

		self._rewardItemData = ItemUtil.createItemData({
			itemId = itemId
		})

		self._rewardItemData:setCount(itemCount)
	end

	return self._rewardItemData
end

return M
