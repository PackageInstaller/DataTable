-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/unit/impl/RogueRole.lua

module("logic.extensions.roguelike.unit.impl.RogueRole", package.seeall)

local M = class("RogueRole", RogueUnitBase)

function M:_initComponents()
	self:_addComponent("mountRoot", BattleUnitCompMountRoot)
	self:_addComponent("transform", RogueCompTransform)
	self:_addComponent("roleProp", RogueUnitCompRoleProp)
	self:_addComponent("dice", RogueUnitCompDices)
	self:_addComponent("buff", RogueUnitCompBuffs)
	self:_addComponent("meshModelMover", BattleUnitCompMeshModelMover)
	self:_addComponent("meshModel", RogueUnitCompMeshModel)
	self:_addComponent("uiFollow", UnitCompUIFollow)
	self:_addComponent("infoBar", RogueUnitCompRoleInfoBar)
	self:_addComponent("material", RogueUnitCompMaterial)
end

return M
