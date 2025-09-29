-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/events/EventModelShowClose.lua

module("logic.extensions.story.core.logic.events.EventModelShowClose", package.seeall)

local M = class("EventModelShowClose", StoryEventBase)

function M:_OnInitCtor()
	return
end

function M:OnEventExecuteInternal()
	local refUID = self.config:GetArgValue(StoryArgKeyConst.RefTargetID)

	self.binder:SetProxyPtrVisible(refUID, false, false)

	local m_proxyInst = self.binder:GetGameObjectInstProxy(refUID)
	local _storyEntry = StoryController.instance:getCurStoryEntry()

	if _storyEntry and _storyEntry:IsRogue() and m_proxyInst then
		StoryDispatcher:dispatchEvent(StoryNotifyName.RogueDestory, m_proxyInst)
	end
end

return M
