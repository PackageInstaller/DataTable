-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/graph/assets/StoryGraphAssetNode.lua

module("logic.extensions.story.core.graph.assets.StoryGraphAssetNode", package.seeall)

local M = class("StoryGraphAssetNode", StoryGraphAssetWithArg)

function M:ctor()
	M.super.ctor(self)

	self.actionType = 0
	self.startTime = 0
	self.endTime = 0
	self.startTimeMs = 0
	self.endTimeMs = 0
end

return M
