-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/graph/assets/StoryGraphContainerAsset.lua

module("logic.extensions.story.core.graph.assets.StoryGraphContainerAsset", package.seeall)

local M = class("StoryGraphContainerAsset", StoryConfigAssetBase)

function M:ctor()
	M.super.ctor(self)

	self.ShotID = 0
	self.isEnd = false
	self.isAutoNext = false
	self.needFade = false
	self.fadeColor = nil
	self.fadeTime = 2
	self.tracksAssets = {}
end

return M
