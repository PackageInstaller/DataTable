-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/EquipIntensifyViewItem.lua

module("logic.extensions.charactersystem.view.equip.EquipIntensifyViewItem", package.seeall)

local M = class("EquipIntensifyViewItem", ItemCell)

function M:_initComponents()
	self:_addComponent("normal", ItemCellComponet)
	self:_addComponent("num", BackpackNumComponent)
	self:_addComponent("lock", LockComponent)
	self:_addComponent("breakpoint", BreakPointComponent)
	self:_addComponent("levelNum", LevelComponent)
	self:_addComponent("animation", BackpackAnimationComponent)
	self:_addComponent("operate", LongClickComponent)
	self:_addComponent("preset", PresetComponent)
end

return M
