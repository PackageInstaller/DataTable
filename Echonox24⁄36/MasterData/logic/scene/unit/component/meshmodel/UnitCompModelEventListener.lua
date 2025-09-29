-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/unit/component/meshmodel/UnitCompModelEventListener.lua

module("logic.scene.unit.component.meshmodel.UnitCompModelEventListener", package.seeall)

local M = class("UnitCompModelEventListener", UnitComponentBase)

function M:ctor(unit)
	M.super.ctor(self, unit)
end

function M:onInit()
	self._animEventListener = false

	self._unit:addInnerEventListener(UnitActionType.MeshModelLoaded, self._onMeshModelLoaded, self)
end

function M:onReset()
	if self._animEventListener then
		self._animEventListener:RemoveListener()

		self._animEventListener = false
	end
end

function M:onDestroy()
	self:onReset()
	self._unit:removeInnerEventListener(UnitActionType.MeshModelLoaded, self._onMeshModelLoaded, self)
end

function M:_onMeshModelLoaded()
	local goInst = self._unit.meshModel:getInst()

	if goInst then
		self._animEventListener = Astral.AnimationEventListener.Get(goInst)

		self._animEventListener:AddListener(self._onAnimationEvent, self)
	end
end

function M:_onAnimationEvent(animEvent)
	local eventName = animEvent.stringParameter
	local animationName = animEvent.animatorClipInfo.clip.name

	self._unit:dispatchInnerEvent(UnitActionType.AnimationEvent, eventName, animationName)
end

return M
