-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/systemopen/agent/SystemOpenAgent.lua

module("logic.extensions.systemopen.agent.SystemOpenAgent", package.seeall)

local M = class("SystemOpenAgent", BaseAgent)

function M:ctor()
	self:setExtId(22)
end

function M:sendGetSystemOpenInfoRequest()
	local msg = SystemOpenExtension_pb.GetSystemOpenInfoRequest()

	self:sendMsg(msg)
end

function M:handleGetSystemOpenInfoReply(status, msg)
	if status == 0 then
		SystemOpenModel.instance:initOfflinesIds(msg.offlines)
		self:dealConditionUnlocks(msg.maybeUnlocked)
		SystemOpenController.instance:onSystemOpenStateInit()
	end
end

function M:handleConditionUnlockedPush(status, msg)
	if status == 0 then
		for _, code in ipairs(msg.codes) do
			local needAdd = SystemOpenModel.instance:updateOpenSystemByBitIndex(code, msg.bitIndex)

			if needAdd then
				GlobalDispatcher:dispatchEvent(StringUtil.toUniqueKey(EventType.ON_SYSTEM_OPEN, code), code)
			end
		end

		GlobalDispatcher:dispatchEvent(EventType.ON_SYSTEM_OPEN)
	end
end

function M:dealConditionUnlocks(conditionNOs)
	for k, v in ipairs(conditionNOs) do
		self:updateOpenSystemCondition(v.code, v.bits)
	end
end

function M:updateOpenSystemCondition(code, bits, isDispatcher)
	if SystemOpenFacade.instance:updateOpenSystemCondition(code, bits) and isDispatcher then
		GlobalDispatcher:dispatchEvent(StringUtil.toUniqueKey(EventType.ON_SYSTEM_OPEN, code), code)
	end

	if isDispatcher then
		GlobalDispatcher:dispatchEvent(EventType.ON_SYSTEM_OPEN)
	end
end

function M:handleCloseSystemEntryPush(status, msg)
	if status == 0 then
		SystemOpenModel.instance:removeOpenSystem(msg.codes)
	end
end

M.instance = M.New()

return M
