-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/cellcomponent/LevelHideComponent.lua

module("logic.extensions.backpack.cellcomponent.LevelHideComponent", package.seeall)

local M = class("LevelHideComponent", BackpackHideComponent)

function M:onInit()
	M.super.setHideGo(self, "backpack_item_108093803")
end

return M
