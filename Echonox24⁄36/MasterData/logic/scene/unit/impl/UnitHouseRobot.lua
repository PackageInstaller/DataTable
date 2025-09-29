-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/unit/impl/UnitHouseRobot.lua

module("logic.scene.unit.impl.UnitHouseRobot", package.seeall)

local M = class("UnitHouseRobot", ReusableUnitBase)

function M:ctor(componetContainer)
	M.super.ctor(self, componetContainer)
end

function M:getTag()
	return UnitTag.Npc
end

function M:getLayer()
	return SceneLayer.Unit_Value
end

function M:_initComponents()
	self:_addComponent("mountRoot", UnitCompMountRoot)
	self:_addComponent("meshModel", HouseUnitCompMeshModel)
	self:_addComponent("navMesh", UnitCompNavMesh)
	self:_addComponent("navMeshMover", UnitCompNavMeshMover)
	self:_addComponent("material", UnitCompModelMaterial)
	self:_addComponent("mountBinder", UnitCompModelMountBinder)
end

function M:OnDestroy()
	M.super.OnDestroy(self)
end

function M:Update()
	self.navMeshMover:update()
end

return M
