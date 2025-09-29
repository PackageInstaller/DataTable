-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/comm/StoryPositionArgGetter.lua

module("logic.extensions.story.core.comm.StoryPositionArgGetter", package.seeall)

local M = class("StoryPositionArgGetter")

function M:ctor()
	self.isPosCfg = false
	self.posValid = false
	self.posIndex = ""
	self.pos = nil
end

function M:UpdateAsset(node)
	self.posValid = node:GetArgValueBoolean(StoryArgKeyConst.PosValid)
	self.isPosCfg = node:GetArgValueBoolean(StoryArgKeyConst.IsPosCfg)
	self.posIndex = node:GetArgValue(StoryArgKeyConst.PosCfgIndex)
	self.pos = node:GetArgValueVector3(StoryArgKeyConst.Position)
end

return M
