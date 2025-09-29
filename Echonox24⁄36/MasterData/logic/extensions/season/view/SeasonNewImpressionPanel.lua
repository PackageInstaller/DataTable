-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonNewImpressionPanel.lua

module("logic.extensions.season.view.SeasonNewImpressionPanel", package.seeall)

local M = class("SeasonNewImpressionPanel", SeasonNewPanelBase)

function M:buildUI()
	M.super.buildUI(self)

	local rootGO = goutil.findChild(self._registry:getMainGO(), "objGo")

	self._goEntryRoot = goutil.findChild(rootGO, "scrollView/ViewPort/content/itemGroup")
	self._goEntryItem = goutil.findChild(self._goEntryRoot, "secret_time_impression_item")
	self._goLock = goutil.findChild(rootGO, "objLock")
	self._btnChange = UIComponentType.ButtonAdapter(goutil.findChild(rootGO, "btnReceive"))
	self._btnDetail = UIComponentType.ButtonAdapter(goutil.findChild(rootGO, "btnPromoteLevel"))
	self._arrayEntryItem = {}
end

function M:destroyUI()
	M.super.destroyUI(self)
end

function M:bindEvents()
	self._btnChange:AddClickListener(self._onClickBtnChange, self)
	self._btnDetail:AddClickListener(self._onClickBtnDetail, self)
end

function M:unbindEvents()
	self._btnChange:RemoveClickListener()
	self._btnDetail:RemoveClickListener()
end

function M:_setEvents(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ON_AIRTIGHT_EXIT_TIME_CHANGE, self._updateAirtightTime, self)
		GlobalDispatcher:addEventListener(EventType.CHAMBER_SLOT_UPDATE, self._refreshEntrys, self)
		GlobalDispatcher:addEventListener(EventType.CHAMBER_SLOT_MOUNT, self._refreshEntrys, self)
		GlobalDispatcher:addEventListener(EventType.CHAMBER_SLOT_UNMOUNT, self._refreshEntrys, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ON_AIRTIGHT_EXIT_TIME_CHANGE, self._updateAirtightTime, self)
		GlobalDispatcher:removeEventListener(EventType.CHAMBER_SLOT_UPDATE, self._refreshEntrys, self)
		GlobalDispatcher:removeEventListener(EventType.CHAMBER_SLOT_MOUNT, self._refreshEntrys, self)
		GlobalDispatcher:removeEventListener(EventType.CHAMBER_SLOT_UNMOUNT, self._refreshEntrys, self)
	end
end

function M:onEnter()
	M.super.onEnter(self)
	self:_updateAirtightTime()
	self:_refreshEntrys()
	self:_setEvents(true)
end

function M:onExit()
	self:_setEvents(false)
	self:_clearEntrys()
end

function M:_updateAirtightTime()
	local nowTime = AirtightRoomModel.instance:getServerTime()
	local inAirtightTime = AirtightRoomController.instance:getAirtightTimeInfo(nowTime)

	goutil.setActive(self._goLock, not inAirtightTime)
end

function M:_refreshEntrys()
	self:_clearEntrys()

	local entryCOs = ChamberModel.instance:getAllEntrys()

	for _, CO in ipairs(entryCOs) do
		local item = goutil.cloneAndSetParent(self._goEntryItem, self._goEntryRoot.transform)

		goutil.setActive(item, true)
		goutil.setActive(goutil.findChild(item, "statePositive"), CO:isPositive())
		goutil.setActive(goutil.findChild(item, "stateNegative"), not CO:isPositive())

		local txtPosi = goutil.findChildTextComponent(item, "statePositive/txtContent")

		txtPosi.text = CO:getName()

		local txtPosi = goutil.findChildTextComponent(item, "stateNegative/txtContent")

		txtPosi.text = CO:getName()

		table.insert(self._arrayEntryItem, item)
	end
end

function M:_clearEntrys()
	for _, item in ipairs(self._arrayEntryItem) do
		goutil.destroy(item)
	end

	table.clear(self._arrayEntryItem)
end

function M:_onClickBtnDetail()
	ViewMgr.instance:open(ViewName.ChamberEffectTips)
end

function M:_onClickBtnChange()
	ViewMgr.instance:open(ViewName.ChamberExchange)
end

return M
