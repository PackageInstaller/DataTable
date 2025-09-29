-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/events/EventFreeCamClose.lua

module("logic.extensions.story.core.logic.events.EventFreeCamClose", package.seeall)

local M = class("EventFreeCamClose", StoryEventBase)

function M:_OnInitCtor()
	return
end

function M:OnEventExecuteInternal()
	local info = self.binder:FindIDPtr(StoryConstDef.FreeCameraTag)

	if not info then
		return
	end

	local inst = info.targetObj

	if goutil.isNil(inst) then
		return
	end

	self.binder:SetProxyPtrActive(StoryConstDef.FreeCameraTag, false)
	goutil.setActive(inst.proxyTarget, false)
end

return M
