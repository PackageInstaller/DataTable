-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/equipdungeon/TeachingDungeonItemCell.lua

module("logic.extensions.dungeon.view.equipdungeon.TeachingDungeonItemCell", package.seeall)

local M = class("TeachingDungeonItemCell", ItemCell)

function M:_initComponents()
	M.super._initComponents(self)
	self:_addComponent("reward", ReceiveStatusComponent)
end

return M
