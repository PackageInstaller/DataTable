-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/unit/impl/RogueEvent.lua

module("logic.extensions.roguelike.unit.impl.RogueEvent", package.seeall)

local M = class("RogueEvent", RogueUnitBase)

function M:_initComponents()
	self:_addComponent("mountRoot", BattleUnitCompMountRoot)
	self:_addComponent("transform", RogueCompTransform)
	self:_addComponent("meshModel", RogueUnitCompMeshModel)
	self:_addComponent("eventInfo", RogueUnitCompEventInfo)
end

function M:_init()
	M.super._init(self)
end

function M:OnDestroy()
	goutil.destroy(self.go)
end

return M
