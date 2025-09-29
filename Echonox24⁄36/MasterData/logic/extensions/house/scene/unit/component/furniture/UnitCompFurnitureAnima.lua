-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/scene/unit/component/furniture/UnitCompFurnitureAnima.lua

module("logic.extensions.house.scene.unit.component.furniture.UnitCompFurnitureAnima", package.seeall)

local M = class("UnitCompFurnitureAnima", UnitComponentBase)

function M:ctor(unit)
	M.super.ctor(self, unit)
end

function M:onInit()
	self._timelineAnimation = nil

	self._unit:addInnerEventListener(UnitActionType.FurnitureLoaded, self._onFurnitureLoaded, self)
end

function M:onReuse()
	return
end

function M:onReset()
	self:clear()
end

function M:onDestroy()
	self._unit:removeInnerEventListener(UnitActionType.FurnitureLoaded, self._onFurnitureLoaded, self)
	self:onReset()
end

function M:clear()
	self._timelineAnimation = nil
end

function M:play(name)
	if self._timelineAnimation then
		self._timelineAnimation:PlayAniByName(name)
	end
end

function M:_onFurnitureLoaded()
	self:clear()

	local goInst = self._unit.resLoader:getGO()

	if goInst then
		self._timelineAnimation = goutil.addComponentOnce(goInst, typeof(Astral.GUITimelineAniLua))
	end
end

return M
