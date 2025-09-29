-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/core/logic/events/EventSwitchDepthOfField.lua

module("logic.extensions.story.core.logic.events.EventSwitchDepthOfField", package.seeall)

local M = class("EventSwitchDepthOfField", StoryEventBase)

function M:_OnInitCtor()
	return
end

function M:OnEventExecuteInternal()
	self._isOpen = self.config:GetArgValueBoolean(StoryArgKeyConst.SwitchVolume)

	self:_updateOutlineDepth()

	if self._isOpen then
		VolumeMgr.instance:turnOn(VolumeName.StroyComm, self._onLoadFinish, self)
	else
		VolumeMgr.instance:turnOff(VolumeName.StroyComm)
		SpaceX.OptimizerMgr.Instance:ForceUpdateVolume()
	end
end

function M:_updateOutlineDepth()
	local existOutline = StoryModel.instance:getFeature(RendererFeatureName.Outline)

	if not existOutline then
		SpaceX.OutlineFeatureUtils.UpdateOutlineDepth(self._isOpen and true or false)
	end
end

function M:_onLoadFinish(volumUnit)
	local distance = self.config:GetArgValueNumber(StoryArgKeyConst.DepthOfFieldDistance)
	local focalLength = self.config:GetArgValueNumber(StoryArgKeyConst.DepthOfFieldFocalLength)

	if volumUnit then
		local volumeObj = volumUnit:getVolumeGo()

		if volumeObj and not goutil.isNil(volumeObj) then
			local volumeComp = volumeObj:GetComponent(ComponentType.Volume)

			if volumeComp and not goutil.isNil(volumeComp) then
				SpaceX.VolumeUtils.SetDepthOfFieldEffect(volumeComp, distance, focalLength)
			end
		end
	end

	SpaceX.OptimizerMgr.Instance:ForceUpdateVolume()
end

return M
