-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/events/EventSwitchCameraVisible.lua

module("logic.extensions.story.core.logic.events.EventSwitchCameraVisible", package.seeall)

local M = class("EventSwitchCameraVisible", StoryEventBase)

function M:_OnInitCtor()
	self.m_handle = StoryHandleSwitchCamera.New()
end

function M:OnEventExecuteInternal()
	local refUID = self.config:GetArgValue(StoryArgKeyConst.RefTargetID)

	self.m_handle:Handle(refUID, self.binder)
end

return M
