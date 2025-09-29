-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chamber/view/ChamberTestView.lua

module("logic.extensions.chamber.view.ChamberTestView", package.seeall)

local M = class("ChamberTestView", ViewComponent)

function M:buildUI()
	self._btnClose = self:getBtnByPath("middle_tips_common_bg/btnClose")
	self._dictSlot = {}

	for i = 1, ChamberModel.MAX_SLOT_NUM do
		local slotGO = self:getGoByPath("allContent/top/chamber_" .. i)
		local slot = Astral.SimpleLuaComponentContainer.Add(slotGO, ChamberSlotItem)

		slot:setIndex(i)
		slot:setClickCallback(self._onClickSlot, self)

		self._dictSlot[i] = slot
	end

	self._loopGridView = LoopGridViewHelper.New(self:getGoByPath("allContent/middle/itemScroll"))

	self._loopGridView:InitGridView(0, self._onCellUpdate, self)

	self._btnMount = self:getBtnByPath("allContent/btnMount")
	self._btnUnmount = self:getBtnByPath("allContent/btnUnmount")
end

function M:destroyUI()
	self._loopGridView:Dispose()

	self._loopGridView = nil
end

function M:bindEvents()
	self._btnClose:AddClickListener(self.close, self)
	self._btnMount:AddClickListener(self._onClickBtnMount, self)
	self._btnUnmount:AddClickListener(self._onClickBtnUnmount, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnMount:RemoveClickListener()
	self._btnUnmount:RemoveClickListener()
end

function M:_setEvents(isOn)
	if isOn then
		GlobalDispatcher:addEventListener(EventType.CHAMBER_SLOT_UPDATE, self._onChamberSlotUpdate, self)
	else
		GlobalDispatcher:removeEventListener(EventType.CHAMBER_SLOT_UPDATE, self._onChamberSlotUpdate, self)
	end
end

function M:onEnter()
	self._selectedItemUUID = nil
	self._selectedSlotIdx = 0

	self:refreshView()
	self:_setEvents(true)
end

function M:onExit()
	self._selectedItemUUID = nil
	self._selectedSlotIdx = 0

	self:_setEvents(false)
	self._loopGridView:ClearCells()
end

function M:refreshView()
	self:refreshSlot()
	self:refreshChamberListView()
end

function M:refreshSlot()
	for i, slot in pairs(self._dictSlot) do
		local slotMO = ChamberModel.instance:getSlot(i)

		slot:setItemUUID(slotMO:getItemUUID())
		slot:setSelected(self._selectedSlotIdx == i)
	end
end

function M:refreshChamberListView()
	self._chamberItems = {}

	self._loopGridView:SetListItemCount(#self._chamberItems)
	self._loopGridView:RefreshAllShownItem()
end

function M:_onCellUpdate(curIndex)
	curIndex = curIndex + 1

	local item = self._loopGridView:NewListViewItem("backpack_item")
	local data = self._chamberItems[curIndex]
	local shower = Astral.SimpleLuaComponentContainer.Get(item.gameObject, BackpackItemCell)

	if shower == nil then
		shower = Astral.SimpleLuaComponentContainer.Add(item.gameObject, BackpackItemCell)

		shower:getComponent("normal"):setClickListener(self._onClickChamberItem, self)
		shower:getComponent("normal"):setOnceLongPressListener(self._onLongPressChamberItem, self)
	end

	shower:updateData(data)
	shower:getComponent("num"):setVisible(false)
	shower:getComponent("normal"):setItemSelect(self._selectedItemUUID == data:getUuid())
	shower:getComponent("usingType"):setUsingGoVisible(ChamberModel.instance:isItemInSlot(data:getUuid()))

	return item
end

function M:_onClickChamberItem(cell)
	local data = cell:getData()

	self._selectedItemUUID = data:getUuid()

	self._loopGridView:RefreshAllShownItem()
end

function M:_onLongPressChamberItem(cell)
	local data = ToolTipsUtil.createItemTipsData(cell:getData(), cell._go)

	ToolTipsMgr.showTips(data.viewName, data)
end

function M:_onClickSlot(idx)
	self._selectedSlotIdx = idx

	self:refreshSlot()
end

function M:_onClickBtnMount()
	if self._selectedSlotIdx == 0 then
		FloatWordMgr.instance:show("请选择槽位")

		return
	end

	if not self._selectedItemUUID then
		FloatWordMgr.instance:show("请选择印象盘")

		return
	end

	if ChamberModel.instance:isItemInSlot(self._selectedItemUUID) then
		FloatWordMgr.instance:show("该印象盘已被使用")

		return
	end

	local slotMO = ChamberModel.instance:getSlot(self._selectedSlotIdx)

	if slotMO:getItemUUID() then
		FloatWordMgr.instance:show("请先卸下槽位里的印象盘")
	else
		ChamberAgent.instance:sendMountRequest(self._selectedSlotIdx, tonumber(self._selectedItemUUID))
	end
end

function M:_onClickBtnUnmount()
	if self._selectedSlotIdx == 0 then
		FloatWordMgr.instance:show("请选择槽位")

		return
	end

	local slotMO = ChamberModel.instance:getSlot(self._selectedSlotIdx)

	if slotMO:getItemUUID() then
		ChamberAgent.instance:sendUnmountRequest(self._selectedSlotIdx)
	else
		FloatWordMgr.instance:show("该槽位里没有印象盘可被卸下")
	end
end

function M:_onChamberSlotUpdate()
	self:refreshView()
end

return M
