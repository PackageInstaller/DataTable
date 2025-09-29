-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/graph/assets/StoryContainerEdge.lua

module("logic.extensions.story.core.graph.assets.StoryContainerEdge", package.seeall)

local M = class("StoryContainerEdge", StoryGraphAssetWithArg)

function M:ctor()
	M.super.ctor(self)

	self.containerLinkType = StoryContainerLinkType.None
	self.baseNodeGuid = nil
	self.targetNodeGuid = nil
end

return M
