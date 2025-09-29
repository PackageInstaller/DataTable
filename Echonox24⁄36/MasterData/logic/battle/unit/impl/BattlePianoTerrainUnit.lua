-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/unit/impl/BattlePianoTerrainUnit.lua

module("logic.battle.unit.impl.BattlePianoTerrainUnit", package.seeall)

local BattlePianoTerrainUnit = class("BattlePianoTerrainUnit", BattleUnitBase)

function BattlePianoTerrainUnit:getUnitType()
	return BattleEnum.UnitType.Terrain
end

function BattlePianoTerrainUnit:getTag()
	return UnitTag.Player
end

function BattlePianoTerrainUnit:getLayer()
	return SceneLayer.Unit_Value
end

function BattlePianoTerrainUnit:_initComponents()
	self:_addComponent("property", BattleUnitCompProperty)
	self:_addComponent("mountRoot", BattleUnitCompMountRoot)
	self:_addComponent("terrainModel", BattleUnitCompPianoTerrainModel)
end

function BattlePianoTerrainUnit:destroyUnit()
	self.terrainModel:playClearAnimation()
end

return BattlePianoTerrainUnit
