-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/events/EventUIFullEfxClose.lua

module("logic.extensions.story.core.logic.events.EventUIFullEfxClose", package.seeall)

local M = class("EventUIFullEfxClose", StoryEventBase)

function M:_OnInitCtor()
	return
end

function M:OnEventExecuteInternal()
	local instUID = self.config:GetArgValue(StoryArgKeyConst.RefTargetID)

	self.binder:SetProxyPtrVisible(instUID, false, false)

	local proxyInst = self.binder:GetGameObjectInstProxy(instUID)

	if proxyInst then
		proxyInst.proxyTarget.transform:SetParent(self.binder.BinderRoot.transform)
		StoryUtils.ResetTransform(proxyInst.proxyTarget)
	end

	StoryDispatcher:dispatchEvent(StoryNotifyName.UIFullEfxRTEvent, false, nil)
end

function M:OnStoryCleanInternal()
	return
end

return M
