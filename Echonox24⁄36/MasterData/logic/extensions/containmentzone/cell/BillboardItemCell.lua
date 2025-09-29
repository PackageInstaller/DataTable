-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/containmentzone/cell/BillboardItemCell.lua

module("logic.extensions.containmentzone.cell.BillboardItemCell", package.seeall)

local M = class("BillboardItemCell", UIReusableLuaBehavior)

function M:buildUI()
	self._txtHint = goutil.findChildTextComponent(self.mainGO, "txtHint")
	self._imgIcon = goutil.findChildImageComponent(self.mainGO, "imgBillboard")
	self._goSelect = goutil.findChild(self.mainGO, "imgSelect")
	self._txtSelect = goutil.findChildTextComponent(self.mainGO, "imgSelect/Image1/txtNum")
	self._btnSelect = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "click"))
end

function M:destroyUI()
	self._txtHint = nil
	self._imgIcon = nil
	self._goSelect = nil
	self._txtSelect = nil
	self._btnSelect = nil
	self._id = nil
	self._handler = nil
end

function M:bindEvents()
	self._btnSelect:AddClickListener(self._onClick, self)
end

function M:unbindEvents()
	self._btnSelect:RemoveClickListener()
end

function M:onEnter()
	self:setSelect(false)
end

function M:onExit()
	self._handler = nil
end

function M:setSelect(selected)
	self._isSelected = selected

	goutil.setActive(self._goSelect, selected)
end

function M:getIsSelected()
	return self._isSelected
end

function M:setId(id)
	self._id = id
end

function M:getId()
	return self._id
end

function M:setHint(content)
	self._txtHint.text = content
end

function M:setSelectNum(content)
	self._txtSelect.text = content
end

function M:setIcon(protomerId, billboardId)
	ContainmentUtil.changeBillBoardIcon(self._imgIcon, protomerId, 1, billboardId)
end

function M:setHandler(handler)
	self._handler = handler
end

function M:_onClick()
	self._handler:onBillBoardItemClick(self)
end

return M
