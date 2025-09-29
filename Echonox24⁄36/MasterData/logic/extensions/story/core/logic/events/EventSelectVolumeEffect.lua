-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/events/EventSelectVolumeEffect.lua

module("logic.extensions.story.core.logic.events.EventSelectVolumeEffect", package.seeall)

local M = class("EventSelectVolumeEffect", StoryEventBase)

function M:_OnInitCtor()
	return
end

function M:OnEventExecuteInternal()
	local _storyEntry = StoryController.instance:getCurStoryEntry()

	if not _storyEntry then
		return
	end

	local rootGo = _storyEntry.root

	if goutil.isNil(rootGo) then
		printWarn("rootGo is nil")

		return
	end

	local volumeRoot = goutil.findChild(rootGo, "volumeroot")

	self._volumrRootGo = volumeRoot

	if goutil.isNil(volumeRoot) then
		return
	end

	if volumeRoot then
		goutil.clearChildren(volumeRoot)
	end

	local volumeEffectName = self.config:GetArgValue(StoryArgKeyConst.VolumeEffect)

	if string.nilorempty(volumeEffectName) then
		return
	end

	self._volumeUrl = StoryLogicResPathUtils.GetVolumeUrl(volumeEffectName)
	self._loader = StoryLoader.New()

	self._loader:addUrl(self._volumeUrl)
	self._loader:startLoad(self._loadComplete, self)
end

function M:_loadComplete(res)
	local volumeRes = self._loader:GetRes(self._volumeUrl)
	local vlumeAsset = volumeRes:GetMainAsset()

	if vlumeAsset then
		self._voumeGo = goutil.cloneAndSetParent(vlumeAsset, self._volumrRootGo.transform, vlumeAsset.name)

		StoryUtils.ResetTransform(self._voumeGo)
	end
end

function M:_closeLoader()
	if self._loader then
		self._loader:dispose()
	end

	self._loader = nil
end

return M
