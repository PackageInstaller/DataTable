-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/data/BackpackItemSortData.lua

module("logic.extensions.backpack.data.BackpackItemSortData", package.seeall)

local M = class("BackpackItemSortData")

function M:ctor(MainBackpackSortType, isUp)
	self.sortType = MainBackpackSortType
	self.isUp = isUp or false
end

function M:getName()
	return lang(CommEnum.EquipSortType2Name[self.sortType])
end

return M
