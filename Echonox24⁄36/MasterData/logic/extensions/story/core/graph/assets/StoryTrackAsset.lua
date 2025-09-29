-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/graph/assets/StoryTrackAsset.lua

module("logic.extensions.story.core.graph.assets.StoryTrackAsset", package.seeall)

local M = class("StoryTrackAsset", StoryGraphAssetWithArg)

function M:ctor()
	M.super.ctor(self)

	self.actionType = 0
	self.sections = {}
end

return M
