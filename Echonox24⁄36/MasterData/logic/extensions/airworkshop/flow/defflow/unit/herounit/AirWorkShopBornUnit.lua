-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/unit/herounit/AirWorkShopBornUnit.lua

module("logic.extensions.airworkshop.flow.defflow.unit.herounit.AirWorkShopBornUnit", package.seeall)

local M = class("AirWorkShopBornUnit", AirWorkShopBuildingUnit)

function M:_initComponents()
	self:_addComponent("mountRoot", BattleUnitCompMountRoot)
	self:_addComponent("effectPlayer", AirWorkUnitCompEffectPlayer)
	self:_addComponent("meshModel", AirWorkBuildingUnitCompMeshModel)
	self:_addComponent("property", AirWorkUnitCompBornProperty)
	self:_addComponent("transform", AirWorkUnitCompTransform)
	self:_addComponent("uiFollow", BattleUnitCompUIFollow)
	self:_addComponent("uiBloodFollow", BattleUnitCompBloodFollow)
	self:_addComponent("mover", BattleUnitCompMover)
	self:_addComponent("meshModelMover", AirWorkUnitCompMeshModelMover)
	self:_addComponent("uiProxy", AirWorkBuildingCompUIProxy)
end

return M
