-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/CharacterEquipItemCell.lua

module("logic.extensions.charactersystem.view.equip.CharacterEquipItemCell", package.seeall)

local M = class("CharacterEquipItemCell", ListBinderCell)

function M:_initComponents()
	self:_addComponent("normal", ItemCellComponet)
	self:_addComponent("num", BackpackNumComponent)
	self:_addComponent("level", LevelComponent)
	self:_addComponent("holeCount", HoleCountComponent)
	self:_addComponent("equip", BackpackEquipItemCellComponet)
	self:_addComponent("animation", BackpackAnimationComponent)
	self:_addComponent("operate", BackpackOperateHideComponent)

	local normalComp = self:getComponent("normal")

	normalComp:setRedPointType(CommEnum.RedPointIconType.New)
end

function M:dealSelect()
	EquipController.instance:setSelectedEquipMo(self._data)
end

function M:onSelect(isSelected)
	local normalComp = self:getComponent("normal")

	normalComp:setItemSelect(isSelected)
end

function M:refreshEquipDetailRed()
	local item = self._data

	if not item then
		return false
	end

	local redPoint = self:getComponent("normal"):getRedPoint()
	local isRed = item:getRedPointIsNew()

	goutil.setActive(redPoint, isRed)
end

return M
