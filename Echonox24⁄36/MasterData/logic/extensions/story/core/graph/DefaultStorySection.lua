-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/graph/DefaultStorySection.lua

module("logic.extensions.story.core.graph.DefaultStorySection", package.seeall)

local M = class("DefaultStorySection", StorySectionBase)

function M:OnStoryEnterInternal()
	print("default section enter:" .. self.config.actionType)
end

function M:OnStoryExitInternal()
	print("default section exit:" .. self.config.actionType)
end

function M:OnStoryDestroyInternal()
	print("default section destroy:" .. self.config.actionType)
end

return M
