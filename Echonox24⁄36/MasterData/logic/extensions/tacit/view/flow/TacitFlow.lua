-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tacit/view/flow/TacitFlow.lua

module("logic.extensions.tacit.view.flow.TacitFlow", package.seeall)

local M = class("TacitFlow", DungeonBattleFlow)

function M:ctor()
	M.super.ctor(self)
	self.model:setIsNotReturnDungeon(false)
end

return M
