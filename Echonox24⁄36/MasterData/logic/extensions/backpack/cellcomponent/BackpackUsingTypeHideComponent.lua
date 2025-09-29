-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/cellcomponent/BackpackUsingTypeHideComponent.lua

module("logic.extensions.backpack.cellcomponent.BackpackUsingTypeHideComponent", package.seeall)

local M = class("BackpackUsingTypeHideComponent", BackpackHideComponent)

function M:onInit()
	M.super.setHideGo(self, "backpack_item_142192069")
end

return M
