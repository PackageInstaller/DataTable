-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/unit/comp/RogueUnitCompUIFollow.lua

module("logic.extensions.roguelike.unit.comp.RogueUnitCompUIFollow", package.seeall)

local M = class("RogueUnitCompUIFollow", UnitCompUIFollow)

function M:addFollowGameObject(followType, go)
	M.super.addFollowGameObject(self, followType, go)
end

return M
