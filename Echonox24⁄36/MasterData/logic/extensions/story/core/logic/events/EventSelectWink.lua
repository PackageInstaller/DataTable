-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/events/EventSelectWink.lua

module("logic.extensions.story.core.logic.events.EventSelectWink", package.seeall)

local M = class("EventSelectWink", StoryEventBase)

function M:OnEventExecuteInternal()
	local characterRefId = self.config:GetArgValue(StoryArgKeyConst.RefTargetID)
	local m_proxyInst = self.binder:GetGameObjectInstProxy(characterRefId)

	if not m_proxyInst then
		return
	end

	local characterTarget = m_proxyInst.target

	if goutil.isNil(characterTarget) then
		return
	end

	local morpherPlayer = MorpherPlayerAdapter.Get(characterTarget)

	if not morpherPlayer then
		return
	end

	local isRandomRate = self.config:GetArgValueBoolean(StoryArgKeyConst.BlinkRamdom)
	local openWink = self.config:GetArgValueBoolean(StoryArgKeyConst.OpenWink)
	local winkSpeed = self.config:GetArgValueNumber(StoryArgKeyConst.BlinkSpeed)

	if isRandomRate then
		local minRate = self.config:GetArgValueNumber(StoryArgKeyConst.MinBlinkRate)
		local maxRate = self.config:GetArgValueNumber(StoryArgKeyConst.MaxBlinkRate)

		morpherPlayer:UpdateEyeBlinkRate(minRate, maxRate)
	else
		local winkRate = self.config:GetArgValueNumber(StoryArgKeyConst.WinkRate)

		morpherPlayer:SetFixedBlinkRate(winkRate)
	end

	if morpherPlayer then
		morpherPlayer:SetEyeBlinkInfo(winkSpeed, 0.1)
		morpherPlayer:SetEyeBlinkState(openWink)
	end
end

return M
