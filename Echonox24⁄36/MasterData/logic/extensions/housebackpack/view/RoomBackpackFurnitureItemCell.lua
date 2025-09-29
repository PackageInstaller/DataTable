-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housebackpack/view/RoomBackpackFurnitureItemCell.lua

module("logic.extensions.housebackpack.view.RoomBackpackFurnitureItemCell", package.seeall)

local M = class("RoomBackpackFurnitureItemCell", BackpackItemCell)

function M:_initComponents()
	M.super._initComponents(self)
	self:_addComponent("operate", BackpackOperateComponent)
end

function M:onSelect(isSelected)
	local isDecomposing = RoomBackpackModel.instance:isInRecycling()
	local normalComp = self:getComponent("normal")

	normalComp:setItemSelect(isSelected and not isDecomposing)

	local operateComp = self:getComponent("operate")

	operateComp:setImgOperateGoVisible(isSelected and isDecomposing)
	operateComp:setBtnCutGoVisible(isSelected and isDecomposing)
end

function M:Awake()
	M.super.Awake(self)

	local numComp = self:getComponent("num")

	numComp:setVisible(false)
end

function M:unSelect()
	GlobalDispatcher:dispatchEvent(EventType.ROOM_BACKPACK_RECYCLE_ITEM_SUB_CLICK, self._data:getUuid(), self:getData())
end

return M
