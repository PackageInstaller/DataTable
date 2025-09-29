-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/cell/BackpackPropItemCell.lua

module("logic.extensions.backpack.cell.BackpackPropItemCell", package.seeall)

local M = class("BackpackPropItemCell", BackpackItemCell)

function M:_initComponents()
	M.super._initComponents(self)

	local normalComp = self:getComponent("normal")

	normalComp:setRedPointType(CommEnum.RedPointIconType.Strong)
end

function M:refreshRed()
	local item = self._data

	if not item then
		return false
	end

	local redPoint = self:getComponent("normal"):getRedPoint()
	local isRed = item:getRedPointIsUseableGiftBox()

	goutil.setActive(redPoint, isRed)

	if item:getType() == GameEnum.ItemTypeEnum.PuzzlePiecesItem and item:isShowRedPoint() then
		self:getComponent("normal"):setRedPointType(CommEnum.RedPointIconType.Strong)

		redPoint = self:getComponent("normal"):getRedPoint()

		goutil.setActive(redPoint, true)
	end
end

return M
