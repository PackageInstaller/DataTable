-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/unit/impl/BattleAdditionalTerrainUnit.lua

module("logic.battle.unit.impl.BattleAdditionalTerrainUnit", package.seeall)

local BattleAdditionalTerrainUnit = class("BattleAdditionalTerrainUnit", BattleUnitBase)

function BattleAdditionalTerrainUnit:getUnitType()
	return BattleEnum.UnitType.Terrain
end

function BattleAdditionalTerrainUnit:getTag()
	return UnitTag.Player
end

function BattleAdditionalTerrainUnit:getLayer()
	return SceneLayer.Unit_Value
end

function BattleAdditionalTerrainUnit:_initComponents()
	self:_addComponent("property", BattleUnitCompProperty)
	self:_addComponent("transform", BattleUnitCompTransform)
	self:_addComponent("mountRoot", BattleUnitCompMountRoot)
	self:_addComponent("terrainModel", BattleUnitCompTerrainModel)
	self:_addComponent("mover", BattleUnitCompMover)
	self:_addComponent("terrainModelMover", BattleUnitCompTerrainModelMover)
	self:_addComponent("rectangle", BattleUnitCompTerrainRectangle)
	self:_addComponent("skill", BattleUnitCompSkills)
end

function BattleAdditionalTerrainUnit:destroyUnit()
	self.terrainModel:playClearAnimation()
end

function BattleAdditionalTerrainUnit:setVisible(isActive)
	return
end

function BattleAdditionalTerrainUnit:getEditorDisplayName()
	local property = self.property

	return property:getEntityCode()
end

return BattleAdditionalTerrainUnit
