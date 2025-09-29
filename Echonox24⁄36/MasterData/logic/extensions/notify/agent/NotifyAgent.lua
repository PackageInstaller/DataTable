-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/notify/agent/NotifyAgent.lua

module("logic.extensions.notify.agent.NotifyAgent", package.seeall)

local M = class("NotifyAgent", BaseAgent)

function M:handleNotifyPush(status, msg)
	if status ~= 0 then
		-- block empty
	end

	for k, v in ipairs(msg.notify) do
		if v.type == ChatExtension_pb.NotifyType.ForceUpdate then
			GlobalDispatcher:dispatchEvent(EventType.HOtUPDATE_FORCE)
		end
	end
end

M.instance = M.New()

return M
