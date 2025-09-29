-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chamber/view/ChamberExchangeView.lua

module("logic.extensions.chamber.view.ChamberExchangeView", package.seeall)

local M = class("ChamberExchangeView", ViewComponent)
local kOffsetX = {
	-15,
	-7,
	4,
	11,
	20,
	31
}

function M:buildUI()
	self._scroll = self:getGoByPath("scrollView"):GetComponent(UIComponentType.ScrollRect)
	self._loopGridView = LoopGridViewHelper.New(self:getGoByPath("scrollView"))

	self._loopGridView:InitGridView(0, self._onCellUpdate, self)

	self._txtName = self:getText("impression_disc_view_1352184164")
	self._imgIcon = self:getImageByPath("objRight/scrollView/ViewPort/content/objTop/imgIcon")
	self._btnConfirm = self:getBtn("impression_disc_view_-724592994")
	self._txtBtnName = self:getText("impression_disc_view_-1833501198")
	self._goRightScroll = self:getGoByPath("objRight/scrollView")
	self._goEntryRoot = self:getGoByPath("objRight/scrollView/ViewPort/content/objMiddle")
	self._txtDesc = self:getTextByPath("objRight/scrollView/ViewPort/content/txtContent")
	self._goEntryItem = goutil.findChild(self._goEntryRoot, "secret_time_impression_effect_item")

	goutil.setActive(self._goEntryItem, false)

	self._goDesc = self:getGoByPath("objRight")
	self._goSlotRoot = self:getGoByPath("objDiscGroup")
	self._arraySlot = {}

	for i = 1, ChamberModel.MAX_SLOT_NUM do
		local slot = {}

		slot.rootGO = goutil.findChild(self._goSlotRoot, string.format("item%s", i))
		slot.click = Astral.UIClickTrigger.Get(goutil.findChild(slot.rootGO, "btnAdd"))
		slot.addGO = goutil.findChild(slot.rootGO, "btnAdd/img1")
		slot.lockGO = goutil.findChild(slot.rootGO, "imgLock")

		table.insert(self._arraySlot, slot)
	end

	self._arrayEntryItem = {}
end

function M:destroyUI()
	self._loopGridView:Dispose()

	self._loopGridView = nil
	self._arraySlot = nil
	self._arrayEntryItem = nil
end

function M:bindEvents()
	self._btnConfirm:AddClickListener(self._onClickBtnConfirm, self)

	for i, slot in ipairs(self._arraySlot) do
		slot.click:AddClickListener(self._onClickSlot, self, i)
	end
end

function M:unbindEvents()
	self._btnConfirm:RemoveClickListener()

	for i, slot in ipairs(self._arraySlot) do
		slot.click:RemoveClickListener()
	end
end

function M:_setEvents(isOn)
	if isOn then
		GlobalDispatcher:addEventListener(EventType.CHAMBER_SLOT_UPDATE, self._onChamberSlotUpdate, self)
		GlobalDispatcher:addEventListener(EventType.CHAMBER_SLOT_MOUNT, self._onChamberSlotMount, self)
		GlobalDispatcher:addEventListener(EventType.CHAMBER_SLOT_UNMOUNT, self._onChamberSlotUnmount, self)
		GlobalDispatcher:addEventListener(EventType.MAIN_SCENE_CLOCK_ANIM_OPEN_FINISHED, self._onClockOpened, self)
		GlobalDispatcher:addEventListener(EventType.MAIN_SCENE_CLOCK_ACTION_FINISHED, self._onClockActionFinished, self)
	else
		GlobalDispatcher:removeEventListener(EventType.CHAMBER_SLOT_UPDATE, self._onChamberSlotUpdate, self)
		GlobalDispatcher:removeEventListener(EventType.CHAMBER_SLOT_MOUNT, self._onChamberSlotMount, self)
		GlobalDispatcher:removeEventListener(EventType.CHAMBER_SLOT_UNMOUNT, self._onChamberSlotUnmount, self)
		GlobalDispatcher:removeEventListener(EventType.MAIN_SCENE_CLOCK_ANIM_OPEN_FINISHED, self._onClockOpened, self)
		GlobalDispatcher:removeEventListener(EventType.MAIN_SCENE_CLOCK_ACTION_FINISHED, self._onClockActionFinished, self)
	end
end

function M:onEnter()
	self._selectedItemUUID = nil
	self._selectedSlotIdx = 0
	self._chamberItems = {}
	self._needPlayItemCellOpenAni = true

	self._loopGridView:SetListItemCount(#self._chamberItems)

	self._forbidOpera = true

	goutil.setActive(self._goSlotRoot, false)
	GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_CLOCK_ANIM_OPEN)

	local isNormalOpen = not self._viewPresentor:getIsBackOpen()

	MainScenePerformUtil.viewCamCtrl(self._viewPresentor:getViewName(), 1, true, isNormalOpen)
	self:selectedSlot(self:_findDefaultSlot(), true)
	self:refreshView()
	self:_playItemOpenAni(true)
	CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_main_yinxiangpandakai)
	self:_setEvents(true)
end

function M:onExit(reasonTyp)
	self:_setEvents(false)
	self:_playItemOpenAni(false)
	CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_main_yinxiangpanguanbi)

	self._selectedItemUUID = nil
	self._selectedSlotIdx = 0

	self._loopGridView:ClearCells()

	self._itemData = nil

	ChamberModel.instance:setIsClockOpen(false)
	ChamberModel.instance:setSelectedIdx(0)
	GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_CLOCK_ANIM_CLOSE)

	local isNormalClose = reasonTyp ~= WindowType.WindowCloseReasonType.QuickCloseType

	MainScenePerformUtil.viewCamCtrl(self._viewPresentor:getViewName(), self._activeIndex, false, isNormalClose)
end

function M:refreshView()
	self:refreshSlot()
	self:refreshDesc()
	self:refreshChamberListView()
end

function M:refreshSlot()
	for i, slot in ipairs(self._arraySlot) do
		local slotMO = ChamberModel.instance:getSlot(i)

		goutil.setActive(slot.lockGO, slotMO:isLock())
		goutil.setActive(slot.addGO, not slotMO:isLock() and slotMO:getItemUUID() == nil)
	end
end

function M:refreshDesc()
	self:_clearEntryItems()

	if self._selectedItemUUID then
		local itemData = ItemModel.instance:getItemDataByUuid(tostring(self._selectedItemUUID))

		IconLoader.setSprite(self._imgIcon, IconType.ItemIcon, itemData:getIcon())

		self._txtName.text = itemData:getName()
		self._txtDesc.text = itemData:getItemDesc()

		local isUsed, idx = ChamberModel.instance:isItemInSlot(self._selectedItemUUID)
		local entryCOs

		if isUsed then
			local mo = ChamberModel.instance:getSlot(idx)

			entryCOs = mo:getEntrys() or {}
		else
			entryCOs = ChamberConfig.instance:getItemEntrysByUuid(self._selectedItemUUID)
		end

		for _, CO in ipairs(entryCOs) do
			local itemGO = goutil.cloneAndSetParent(self._goEntryItem, self._goEntryRoot.transform)

			goutil.setActive(itemGO, true)

			local item = Astral.SimpleLuaComponentContainer.Add(itemGO, ChamberEntryItem)

			item:setEntryCO(CO, isUsed)
			table.insert(self._arrayEntryItem, itemGO)
		end

		local height = 470
		local slotMO = ChamberModel.instance:getSlot(self._selectedSlotIdx)
		local slotItemUuid = slotMO and slotMO:getItemUUID() or nil

		if slotItemUuid then
			if self._selectedItemUUID == slotItemUuid then
				goutil.setActive(self._btnConfirm.gameObject, true)

				self._txtBtnName.text = lang("tip_secret_time_unmount_slot")
			else
				goutil.setActive(self._btnConfirm.gameObject, false)

				height = 540
			end
		else
			if isUsed or self._selectedSlotIdx == 0 then
				goutil.setActive(self._btnConfirm.gameObject, false)

				height = 540
			else
				goutil.setActive(self._btnConfirm.gameObject, true)
			end

			self._txtBtnName.text = lang("tip_secret_time_mount_slot")
		end

		RectTransformUtils.SetHeight(self._goRightScroll.transform, height)
	end
end

function M:_clearEntryItems()
	for _, item in ipairs(self._arrayEntryItem) do
		goutil.destroy(item)
	end

	table.clear(self._arrayEntryItem)
end

function M:refreshChamberListView()
	self._loopGridView:RefreshAllShownItem()
end

function M:_onCellUpdate(curIndex)
	curIndex = curIndex + 1

	local item = self._loopGridView:NewListViewItem("backpack_item")
	local data = self._chamberItems[curIndex]

	self:_addCell(item.gameObject)

	local shower = Astral.SimpleLuaComponentContainer.Get(item.gameObject, BackpackItemCell)

	if shower == nil then
		shower = Astral.SimpleLuaComponentContainer.Add(item.gameObject, BackpackItemCell)

		shower:getComponent("normal"):setClickListener(self._onClickChamberItem, self)
		shower:getComponent("normal"):setOnceLongPressListener(self._onLongPressChamberItem, self)
	end

	shower:updateData(data)
	shower:getComponent("num"):setVisible(false)
	shower:getComponent("normal"):setItemSelect(checknumber(self._selectedItemUUID) == tonumber(data:getUuid()))

	local wearGO = goutil.findChild(item.gameObject, "stateWearing")

	goutil.setActive(wearGO, ChamberModel.instance:isItemInSlot(data:getUuid()))

	return item
end

function M:_addCell(go)
	if not self._itemData then
		self._itemData = {}
	end

	local key = go:GetInstanceID()
	local theItem = self._itemData[key]

	if not theItem then
		theItem = {
			go = go,
			canvasGroup = goutil.addComponentOnce(go, ComponentType.CanvasGroup)
		}

		function theItem.isActive()
			return theItem.go.gameObject.activeSelf
		end

		function theItem.playOpenAni(play, duration, delay)
			theItem.canvasGroup:DOKill(false)

			if play then
				duration = duration or 0.26
				delay = delay or 0
				theItem.canvasGroup.alpha = 0

				theItem.canvasGroup:DOFade(1, duration):SetEase(DG.Tweening.Ease.Linear):SetDelay(delay):SetAutoKill(true)
			else
				theItem.canvasGroup.alpha = 1
			end
		end

		self._itemData[key] = theItem
	end

	theItem.canvasGroup.alpha = self._needPlayItemCellOpenAni and 0 or 1
end

function M:_playItemOpenAni(play)
	if self._cacheTween then
		self._cacheTween:Kill(false)
	end

	self._cacheTween = nil

	if play then
		self._scroll.enabled = false

		local duration = 0.26
		local maxDelay = 0.1
		local index = 1

		for _, cell in pairs(self._itemData or {}) do
			if cell.isActive() then
				local delay = index * 0.05

				delay = delay > 1 and 1 or delay
				maxDelay = maxDelay < delay and delay or maxDelay

				cell.playOpenAni(play, duration, delay)

				index = index + 1
			end
		end

		self._needPlayItemCellOpenAni = false
		self._cacheTween = DoTweenUtil.DelayedCall(maxDelay, function()
			self._scroll.enabled = true
		end)
	else
		for _, cell in pairs(self._itemData or {}) do
			cell.playOpenAni(false)
		end

		self._cacheTween = nil
		self._needPlayItemCellOpenAni = false
		self._scroll.enabled = true
	end
end

function M:selectedSlot(idx, notEvent)
	local slotMO = ChamberModel.instance:getSlot(idx)

	if slotMO:isLock() then
		return
	end

	local id = slotMO:getItemUUID()
	local freeItem = self:_getFirstFreeChamber()

	if not id and not freeItem then
		FloatWordMgr.instance:show(lang("tip_chamber_lang_1"))

		return
	end

	self._selectedSlotIdx = idx

	ChamberModel.instance:setSelectedIdx(self._selectedSlotIdx)

	if not notEvent then
		GlobalDispatcher:dispatchEvent(EventType.CHAMBER_SLOT_SELECTED, self._selectedSlotIdx)
	end

	if id then
		self._selectedItemUUID = id
	else
		self._selectedItemUUID = tonumber(freeItem:getUuid())
	end

	self._loopGridView:RefreshAllShownItem()
	self:refreshDesc()
end

function M:_getFirstFreeChamber()
	for _, item in ipairs(self._chamberItems) do
		if not ChamberModel.instance:isItemInSlot(item:getUuid()) then
			return item
		end
	end
end

function M:_findDefaultSlot()
	local freeItem = self:_getFirstFreeChamber()

	for i = 1, ChamberModel.MAX_SLOT_NUM do
		local slotMO = ChamberModel.instance:getSlot(i)

		if slotMO:getItemUUID() then
			return i
		elseif freeItem then
			return i
		end
	end
end

function M:_onClickChamberItem(cell)
	if self._forbidOpera then
		return
	end

	local data = cell:getData()

	self._selectedItemUUID = tonumber(data:getUuid())

	local isUsed, idx = ChamberModel.instance:isItemInSlot(data:getUuid())

	if isUsed then
		self._selectedSlotIdx = idx
	else
		local slotMO = ChamberModel.instance:getSlot(self._selectedSlotIdx)

		if slotMO and slotMO:getItemUUID() then
			self._selectedSlotIdx = 0
		end
	end

	ChamberModel.instance:setSelectedIdx(self._selectedSlotIdx)
	GlobalDispatcher:dispatchEvent(EventType.CHAMBER_SLOT_SELECTED, self._selectedSlotIdx)
	self._loopGridView:RefreshAllShownItem()
	self:refreshDesc()
end

function M:_onLongPressChamberItem(cell)
	local data = ToolTipsUtil.createItemTipsData(cell:getData(), cell._go)

	ToolTipsMgr.showTips(data.viewName, data)
end

function M:_onClickSlot(eventData, i)
	if self._forbidOpera then
		return
	end

	self:selectedSlot(i)
end

function M:_onClickBtnConfirm()
	if self._forbidOpera then
		return
	end

	local slotMO = ChamberModel.instance:getSlot(self._selectedSlotIdx)
	local slotItemUuid = slotMO and slotMO:getItemUUID() or nil

	if slotItemUuid then
		if self._selectedItemUUID == slotItemUuid then
			self:_actionUnmount()
		end
	else
		local isUsed, idx = ChamberModel.instance:isItemInSlot(self._selectedItemUUID)

		if isUsed then
			-- block empty
		else
			self:_actionMount()
		end
	end
end

function M:_actionMount()
	if self._selectedSlotIdx > 0 then
		ChamberAgent.instance:sendMountRequest(self._selectedSlotIdx, tonumber(self._selectedItemUUID), function()
			self._forbidOpera = true

			CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_main_yinxiangpanzhuangshang)
			GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_CLOCK_ACTION, SeasonEnum.ClockAction.Mount, self._selectedSlotIdx)
		end)
	end
end

function M:_actionUnmount()
	if self._selectedSlotIdx > 0 then
		ChamberAgent.instance:sendUnmountRequest(self._selectedSlotIdx, function()
			self._forbidOpera = true

			CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_main_yinxiangpanxiexia)
			GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_CLOCK_ACTION, SeasonEnum.ClockAction.Unmount, self._selectedSlotIdx)
		end)
	end
end

function M:_actionExchange(downSlot)
	if self._selectedSlotIdx > 0 then
		ChamberAgent.instance:exchange(downSlot, self._selectedSlotIdx, tonumber(self._selectedItemUUID), function()
			self._forbidOpera = true

			GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_CLOCK_ACTION, SeasonEnum.ClockAction.Exchange, self._selectedSlotIdx, downSlot)
		end)
	end
end

function M:_actionExchangeWithSelf(downSlot)
	if self._selectedSlotIdx > 0 then
		ChamberAgent.instance:exchangeWithSelf(downSlot, self._selectedSlotIdx, tonumber(self._selectedItemUUID), function()
			self._forbidOpera = true

			GlobalDispatcher:dispatchEvent(EventType.MAIN_SCENE_CLOCK_ACTION, SeasonEnum.ClockAction.ExchangeWithSelf, self._selectedSlotIdx, downSlot)
		end)
	end
end

function M:_onClockOpened(e, unitClock)
	local posList = unitClock:calculateSlotScreenPos(self._goSlotRoot.transform)

	for i, slot in ipairs(self._arraySlot) do
		local pos = posList[i]

		Astral.TransformUtil.SetLocalPos(slot.rootGO.transform, pos.x + kOffsetX[i], pos.y, 0)
	end

	goutil.setActive(self._goSlotRoot, true)
	self:selectedSlot(self:_findDefaultSlot())

	self._forbidOpera = false
end

function M:_onClockActionFinished()
	self._forbidOpera = false
end

function M:_onChamberSlotUpdate()
	self._chamberItems = {}

	self._loopGridView:SetListItemCount(#self._chamberItems)
	self:selectedSlot(self:_findDefaultSlot())
	self:refreshView()
end

function M:_onChamberSlotMount()
	self:refreshView()
end

function M:_onChamberSlotUnmount()
	self:refreshView()
end

return M
