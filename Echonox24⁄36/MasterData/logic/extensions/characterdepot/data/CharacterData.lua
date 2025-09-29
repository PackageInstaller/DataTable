-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterdepot/data/CharacterData.lua

module("logic.extensions.characterdepot.data.CharacterData", package.seeall)

local M = class("CharacterData", CharacterBaseData)

function M:ctor(params)
	M.super.ctor(self, params)
end

return M
