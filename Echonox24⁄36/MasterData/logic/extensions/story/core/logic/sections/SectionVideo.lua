-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/sections/SectionVideo.lua

module("logic.extensions.story.core.logic.sections.SectionVideo", package.seeall)

local M = class("SectionVideo", StorySectionBase)

function M:OnSectionEnableInternal()
	local videoCode = self.config:GetArgValue(StoryArgKeyConst.VideoName)
	local isLoop = self.config:GetArgValueBoolean(StoryArgKeyConst.VideoPlayMode)
	local canJump = self.config:GetArgValueBoolean(StoryArgKeyConst.CamJumpVideo)
	local showJumpButton = self.config:GetArgValueBoolean(StoryArgKeyConst.ShowJumpButton)
	local timeArg = self.config:GetArgValue(StoryArgKeyConst.ViedoTimeArg)

	if string.nilorempty(videoCode) then
		return
	end

	local isJumpShot = self:IsJump()

	StoryDispatcher:dispatchEvent(StoryNotifyName.OnVideoEnter, tonumber(videoCode), isLoop, canJump, showJumpButton, timeArg, isJumpShot)
end

function M:OnSectionDisableInternal()
	StoryDispatcher:dispatchEvent(StoryNotifyName.OnVideoExit)
end

return M
