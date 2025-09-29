-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/comm/StoryAnimationArgGetter.lua

module("logic.extensions.story.core.comm.StoryAnimationArgGetter", package.seeall)

local M = class("StoryAnimationArgGetter")

function M:ctor()
	self.baseAnimName = nil
	self.headAnimName = nil
	self.armAnimName = nil
	self.legAnimName = nil
end

function M:UpdateAsset(config)
	self.baseAnimName = config:GetArgValue(StoryArgKeyConst.ModelAniBase)
	self.headAnimName = config:GetArgValue(StoryArgKeyConst.ModelAniHead)
	self.armAnimName = config:GetArgValue(StoryArgKeyConst.ModelAniArm)
	self.legAnimName = config:GetArgValue(StoryArgKeyConst.ModelAniLeg)
end

return M
