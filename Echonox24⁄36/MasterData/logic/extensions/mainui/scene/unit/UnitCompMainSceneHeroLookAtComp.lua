-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/scene/unit/UnitCompMainSceneHeroLookAtComp.lua

module("logic.extensions.mainui.scene.unit.UnitCompMainSceneHeroLookAtComp", package.seeall)

local M = class("UnitCompMainSceneHeroLookAtComp", UnitComponentBase)

M.BlockLookAtData = {
	[MainPerformEnum.AnimFullName.ShafaIdle] = 1
}

function M:ctor(unit)
	M.super.ctor(self, unit)
end

function M:onInit()
	self:onReset()
	self:setEvent(true)
end

function M:onDestroy()
	self:onReset()
	self:setEvent(false)
end

function M:isDestroyed()
	if self._unit then
		return self._unit:isDestroyed()
	end

	return true
end

function M:onReset()
	self:setEvent(false)
	self:clear()
end

function M:onReuse()
	self:setEvent(true)
end

function M:clear()
	if self._lookAtComp then
		self._lookAtComp:clear()
	end

	self._lastAnimState = nil
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.MAIN_SCENE_HERO_SET_LOOK_AT_WEIGHT, self._handleSetLookAtWeight, self)
		self._unit:addInnerEventListener(UnitActionType.MeshModelLoaded, self._handleOnMeshModelLoaded, self)
		self._unit:addInnerEventListener(UnitActionType.MainSceneHeroAniPlay, self._handleHeroAniPlay, self)
	else
		GlobalDispatcher:removeEventListener(EventType.MAIN_SCENE_HERO_SET_LOOK_AT_WEIGHT, self._handleSetLookAtWeight, self)
		self._unit:removeInnerEventListener(UnitActionType.MeshModelLoaded, self._handleOnMeshModelLoaded, self)
		self._unit:addInnerEventListener(UnitActionType.MainSceneHeroAniPlay, self._handleHeroAniPlay, self)
	end
end

function M:_handleSetLookAtWeight(evt, info)
	if not info.weight then
		return
	end

	if self:isDestroyed() then
		return
	end

	if self._unit:getPointId() ~= info.pointId then
		return
	end

	if not self._lookAtComp then
		return
	end

	self._lookAtComp:setWeight(info.weight)
end

function M:_handleOnMeshModelLoaded(eventUid, unitActionType, modelGo)
	self:clear()

	if not modelGo or goutil.isNil(modelGo) then
		return
	end

	self._lookAtComp = Astral.SimpleLuaComponentContainer.Add(modelGo.gameObject, UnitCompHeroLookAtIK)
end

function M:_handleHeroAniPlay(eventUid, unitActionType, animState)
	if self:isDestroyed() then
		return
	end

	if not self._lookAtComp then
		return
	end

	if self._lastAnimState == animState then
		return
	end

	self._lastAnimState = animState

	local lookAtEnable = false
	local lookAtData

	if not M.BlockLookAtData[animState] then
		lookAtData = MainPerformEnum.AnimLookAtIKData[animState]

		if lookAtData then
			lookAtEnable = true
		end
	end

	self._lookAtComp:setEnableLookAtIk(lookAtEnable, lookAtData)
end

return M
