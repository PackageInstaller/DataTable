-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/scene/unit/UnitCompMainSceneTimelineAniBase.lua

module("logic.extensions.mainui.scene.unit.UnitCompMainSceneTimelineAniBase", package.seeall)

local M = class("UnitCompMainSceneTimelineAniBase", UnitComponentBase)

function M:ctor(unit)
	M.super.ctor(self, unit)
end

function M:getCompName()
	return "base"
end

function M:onInit()
	M.super.onInit(self)
	self._unit.meshModel:registerTimelineAni(self:getCompName(), self)
	self:onReset()
	self:setEvent(true)
end

function M:onDestroy()
	M.super.onDestroy(self)
	self:onReset()
	self:clear()
end

function M:isDestroyed()
	if self._unit then
		return self._unit:isDestroyed()
	end

	return true
end

function M:onReset()
	self:setEvent(false)
end

function M:onReuse()
	self:setEvent(true)
end

function M:clear()
	return
end

function M:setEvent(add)
	if add then
		self._unit:addInnerEventListener(UnitActionType.MainSceneMeshSetBody, self._handleOnMeshSetBody, self)
		self._unit:addInnerEventListener(UnitActionType.MeshModelLoaded, self._handleOnMeshModelLoaded, self)
		self._unit:addInnerEventListener(UnitActionType.MainSceneHeroAniPlay, self._handleAniPlay, self)
		self._unit:addInnerEventListener(UnitActionType.AnimationEvent, self._handleAnimationEvent, self)
	else
		self._unit:removeInnerEventListener(UnitActionType.MainSceneMeshSetBody, self._handleOnMeshSetBody, self)
		self._unit:removeInnerEventListener(UnitActionType.MeshModelLoaded, self._handleOnMeshModelLoaded, self)
		self._unit:removeInnerEventListener(UnitActionType.MainSceneHeroAniPlay, self._handleAniPlay, self)
		self._unit:removeInnerEventListener(UnitActionType.AnimationEvent, self._handleAnimationEvent, self)
	end
end

function M:_handleOnMeshSetBody()
	self:onMeshSetBody()
end

function M:_handleOnMeshModelLoaded()
	self:onMeshModelLoaded()
end

function M:_handleAniPlay(eventUid, unitActionType, animState)
	if self:isDestroyed() then
		return
	end

	self:onAnimStatePlay(animState)
end

function M:_handleAnimationEvent(eventUid, unitActionType, eventName, animationName)
	if self:isDestroyed() then
		return
	end

	self:onAnimationEvent(eventName, animationName)
end

function M:onMeshSetBody()
	self:clear()
end

function M:onMeshModelLoaded()
	return
end

function M:onAnimStatePlay(animState)
	return
end

function M:onAnimationEvent(eventName, animationName)
	return
end

function M:playTimelineAni(animState)
	return false
end

return M
