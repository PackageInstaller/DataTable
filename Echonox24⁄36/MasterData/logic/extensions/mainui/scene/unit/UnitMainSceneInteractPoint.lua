-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/scene/unit/UnitMainSceneInteractPoint.lua

module("logic.extensions.mainui.scene.unit.UnitMainSceneInteractPoint", package.seeall)

local M = class("UnitMainSceneInteractPoint", ReusableUnitBase)

function M:ctor(componetContainer)
	M.super.ctor(self, componetContainer)
end

function M:reset()
	M.super.reset(self)
end

function M:getId()
	return self.id
end

function M:setPointId(point)
	self.pointId = point
end

function M:getPointId()
	return self.pointId
end

function M:setElementId(elementId)
	self._elementId = elementId
end

function M:getElementId()
	return self._elementId
end

function M:getTag()
	return UnitTag.Untagged
end

function M:getLayer()
	return SceneLayer.Unit_Value
end

function M:_initComponents()
	self:_addComponent("ui", UnitCompInteractPointUI)
	self:_addComponent("uiFollow", UnitCompUIFollow)
end

function M:OnDestroy()
	M.super.OnDestroy(self)
end

return M
