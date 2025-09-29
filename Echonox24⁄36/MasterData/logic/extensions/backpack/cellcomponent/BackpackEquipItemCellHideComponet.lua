-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/cellcomponent/BackpackEquipItemCellHideComponet.lua

module("logic.extensions.backpack.cellcomponent.BackpackEquipItemCellHideComponet", package.seeall)

local M = class("BackpackEquipItemCellHideComponet", BackpackHideComponent)

function M:onInit()
	M.super.setHideGo(self, "backpack_item_-1719482002")
end

return M
