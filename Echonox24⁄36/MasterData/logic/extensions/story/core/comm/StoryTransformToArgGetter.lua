-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/comm/StoryTransformToArgGetter.lua

module("logic.extensions.story.core.comm.StoryTransformToArgGetter", package.seeall)

local M = class("StoryTransformToArgGetter")

function M:ctor()
	self.isPosCfg = false
	self.posValid = false
	self.rotValid = false
	self.scalValid = false
	self.posFromIndex = 0
	self.posToIndex = 0
	self.posFrom = nil
	self.posTo = nil
	self.rotationFrom = nil
	self.rotationTo = nil
	self.scaleFrom = nil
	self.scaleTo = nil
end

function M:UpdateAsset(node)
	self.isPosCfg = node:GetArgValueBoolean(StoryArgKeyConst.IsPosCfg)
	self.posValid = node:GetArgValueBoolean(StoryArgKeyConst.PosValid)
	self.rotValid = node:GetArgValueBoolean(StoryArgKeyConst.RotValid)
	self.scalValid = node:GetArgValueBoolean(StoryArgKeyConst.ScaValid)
	self.posFromIndex = node:GetArgValueNumber(StoryArgKeyConst.PosCfgFromIndex)
	self.posToIndex = node:GetArgValueNumber(StoryArgKeyConst.PosCfgToIndex)
	self.posFrom = node:GetArgValueVector3(StoryArgKeyConst.PosFrom)
	self.posTo = node:GetArgValueVector3(StoryArgKeyConst.PosTo)
	self.rotationFrom = node:GetArgValueVector3(StoryArgKeyConst.RotationFrom)
	self.rotationTo = node:GetArgValueVector3(StoryArgKeyConst.RotationTo)
	self.scaleFrom = node:GetArgValueVector3(StoryArgKeyConst.ScaleFrom)
	self.scaleTo = node:GetArgValueVector3(StoryArgKeyConst.ScaleTo)
end

return M
