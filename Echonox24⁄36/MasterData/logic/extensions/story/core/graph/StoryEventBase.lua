-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/graph/StoryEventBase.lua

module("logic.extensions.story.core.graph.StoryEventBase", package.seeall)

local M = class("StoryEventBase")

function M:ctor()
	self.hasTrigger = false
	self.threshold = 0
	self.config = nil
	self.binder = nil

	self:_OnInitCtor()
end

function M:InitData(bind, asset)
	self.binder = bind
	self.config = asset
	self.threshold = self.config.startTime
end

function M:OnStoryAwake()
	self:OnStoryAwakeInternal()
end

function M:OnEventExecute()
	if self.hasTrigger then
		printError("事件已经触发过，无法重复触发")

		return
	end

	self.hasTrigger = true

	self:OnEventExecuteInternal()
end

function M:OnStoryClean()
	self.hasTrigger = false

	self:OnStoryCleanInternal()
end

function M:OnStoryDestroy()
	self:OnStoryClean()

	self.hasTrigger = false
	self.config = nil
	self.binder = nil
end

function M:_OnInitCtor()
	return
end

function M:OnStoryAwakeInternal()
	return
end

function M:OnEventExecuteInternal()
	return
end

function M:OnStoryCleanInternal()
	return
end

return M
