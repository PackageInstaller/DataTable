-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/events/EventLingGan.lua

module("logic.extensions.story.core.logic.events.EventLingGan", package.seeall)

local M = class("EventLingGan", StoryEventBase)

function M:_OnInitCtor()
	return
end

function M:OnEventExecuteInternal()
	local openLingGan = self.config:GetArgValueBoolean(StoryArgKeyConst.OpenLingGan)
	local closeLingGan = self.config:GetArgValueBoolean(StoryArgKeyConst.CloseLingGan)

	if openLingGan then
		StoryFacde.instance:setAfflatuseEffect(openLingGan)
	end

	if closeLingGan then
		StoryFacde.instance:closeAfflatuseMask(closeLingGan)
	end
end

return M
