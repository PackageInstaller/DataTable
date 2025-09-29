-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/model/behavior/BehaviorData.lua

module("logic.extensions.house.model.behavior.BehaviorData", package.seeall)

local M = class("BehaviorData")

function M:ctor(type)
	self._type = type or HouseEnum.BehaviorType.None
	self._workStatus = nil
	self._id = 0

	self:initAiData()
end

function M:setId(id)
	self._id = id
end

function M:getId()
	return self._id
end

function M:getType()
	return self._type
end

function M:setWorkStatus(workStatus)
	self._workStatus = workStatus
end

function M:getWorkStatus()
	return self._workStatus
end

function M:initAiData()
	self.targetPos = nil
	self.targetRoomId = nil
	self.step = nil
	self.useRandomPos = true
	self.mode = HouseEnum.WorkStatusMode.Normal
end

return M
