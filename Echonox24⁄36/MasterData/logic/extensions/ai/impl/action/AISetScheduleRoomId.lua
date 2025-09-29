-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ai/impl/action/AISetScheduleRoomId.lua

module("logic.extensions.ai.impl.action.AISetScheduleRoomId", package.seeall)

local M = class("AISetScheduleRoomId", AINode)

function M:ctor(context)
	M.super.ctor(self, context)
end

function M:initFromConfig(aiConfigData)
	M.super.initFromConfig(self, aiConfigData)
end

function M:onStart()
	M.super.onStart(self)

	local unit = self:getContext():getUnit()
	local roomId = unit.scheduleModel:getScheduleTargetRoomId()

	if roomId > 0 then
		local mo = HouseNavigationModel.instance:getMOByZoneId(roomId)

		if mo then
			self:getContext():setTargetPos(mo:getRandomPoint(), roomId)
			self:getContext():setUseRandomPos(true)

			return self:onEnd(AIConst.AIStatus.SUCCESS)
		end
	end

	return self:onEnd(AIConst.AIStatus.FAILD)
end

function M:handleEnd()
	return
end

function M:onReset()
	M.super.onReset(self)
end

function M:onRecycle()
	M.super.onRecycle(self)
end

function M:onDestroy()
	M.super.onDestroy(self)
end

return M
