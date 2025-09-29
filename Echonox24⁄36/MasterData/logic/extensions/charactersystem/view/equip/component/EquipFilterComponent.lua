-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/component/EquipFilterComponent.lua

module("logic.extensions.charactersystem.view.equip.component.EquipFilterComponent", package.seeall)

local M = class("EquipFilterComponent")

function M:ctor(imageContainer)
	self._compContainer = imageContainer
	self._mainGo = self._compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self._mainGo)

	goutil.setActive(self._mainGo, false)

	self._suitSelectIndex = nil
	self._diceSelectIndex = nil
	self._diceSelectList = {}

	self:build()
end

function M:build()
	self._btnClose = self._registry:getBtn("d6_filter_tips_114644139")
	self._btnFilterConfirm = self._registry:getBtn("0&btn_middle_-31477526")
	self._btnFilterClear = self._registry:getBtn("d6_filter_tips_copy_2090503282")
	self._goBottom = self._registry:getGo("d6_filter_tips_copy_-612206513")
	self._goFilterSelected = self._registry:getGo("d6_filter_tips_copy_-1584597871")
	self._txtSuitName = self._registry:getText("d6_filter_tips_copy_-1352778691")
	self._goSelectDiceList = self._registry:getGo("d6_filter_tips_copy_2135579018")
	self._goDiceSelectItem = goutil.findChild(self._goSelectDiceList, "diceItem")

	goutil.setActive(self._goDiceSelectItem, false)
	goutil.setActive(self._txtSuitName.gameObject, true)
	goutil.setActive(self._goSelectDiceList, true)

	self._goSuitList = self._registry:getGo("d6_filter_tips_copy_478587778")

	local goSuitScroll = goutil.findChild(self._goSuitList, "suitScroll")

	self._suitList = LoopListHelper.New(goSuitScroll)

	self._suitList:InitListView(0, self._onSuitCellUpdate, self)

	self._goDiceList = self._registry:getGo("d6_filter_tips_copy_550261990")

	local goDiceScroll = goutil.findChild(self._goDiceList, "d6Scroll")

	self._diceList = LoopListHelper.New(goDiceScroll)

	self._diceList:InitListView(0, self._onDiceCellUpdate, self)

	local goTab = self._registry:getGo("d6_filter_tips_copy_-1702521394")

	self._tabFilterList = {}
	self._tabBarGroup = goutil.addComponentOnce(goTab, UIComponentType.SpaceXToggleGroup)

	local toggleComp = false

	for i = 1, 2 do
		toggleComp = goutil.findChild(goTab, "tab" .. i):GetComponent(UIComponentType.SpaceXToggle)

		table.insert(self._tabFilterList, toggleComp)
	end
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickCloseBtn, self)
	self._btnFilterConfirm:AddClickListener(self._onClickConfirmBtn, self)
	self._btnFilterClear:AddClickListener(self._onClickClearBtn, self)

	for index, toggleComp in ipairs(self._tabFilterList) do
		toggleComp:AddListener(function(_, isOn)
			if isOn then
				self:_dealFilterToggleClick(index)
			end
		end, nil)
	end
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnFilterConfirm:RemoveClickListener()
	self._btnFilterClear:RemoveClickListener()

	for _, toggleComp in ipairs(self._tabFilterList) do
		toggleComp:RemoveListener()
	end
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.EQUIP_WEARING_SUIT_CLICK_EVENT, self._handleClickSuit, self)
		GlobalDispatcher:addEventListener(EventType.EQUIP_WEARING_DICE_CLICK_EVENT, self._handleClickDice, self)
	else
		GlobalDispatcher:removeEventListener(EventType.EQUIP_WEARING_SUIT_CLICK_EVENT, self._handleClickSuit, self)
		GlobalDispatcher:removeEventListener(EventType.EQUIP_WEARING_DICE_CLICK_EVENT, self._handleClickDice, self)
	end
end

function M:onEnter()
	self:_setEvent(true)
end

function M:onExit()
	self:_setEvent(false)
end

function M:onDestroy()
	return
end

function M:setData(suitListData, diceListData, curPart, lastEquipSuitData, lastDices)
	self._selectEquipSuitData = lastEquipSuitData
	self._diceSelectList = lastDices or {}

	if self._selectEquipSuitData or TableUtil.getLen(self._diceSelectList) > 0 then
		goutil.setActive(self._goBottom, true)
	else
		goutil.setActive(self._goBottom, false)
	end

	self._suitListData = suitListData
	self._diceListData = diceListData
	self._curPart = curPart

	if self._tabFilterList[1].IsOn then
		self:_dealFilterToggleClick(1)
	end

	self._tabFilterList[1].IsOn = true
end

function M:_onSuitCellUpdate(curIndex)
	local data = self._suitListData[curIndex + 1]
	local item = self._suitList:NewListViewItem("suitItem")
	local shower = Astral.LuaComponentContainer.Add(item.gameObject, EquipSuitFilterItem)

	shower:updateData(data, self._curPart)
	shower:setClickEvent(EventType.EQUIP_WEARING_SUIT_CLICK_EVENT)

	local isSelected = self._selectEquipSuitData and data:getId() == self._selectEquipSuitData:getId() or false

	shower:setSelect(isSelected)

	return item
end

function M:_onDiceCellUpdate(curIndex)
	local data = self._diceListData[curIndex + 1]
	local item = self._diceList:NewListViewItem("d6_fitter_item")
	local shower = Astral.LuaComponentContainer.Add(item.gameObject, EquipDiceFilterItem)

	shower:updateData(data)
	shower:setClickEvent(EventType.EQUIP_WEARING_DICE_CLICK_EVENT)

	local isSelected = self._diceSelectList[data:getAttrId()]

	shower:setSelect(isSelected)

	if isSelected then
		self._diceSelectIndex = curIndex + 1
	end

	return item
end

function M:_dealFilterToggleClick(index)
	self._curToggleIndex = index
	self._isSuit = index == 1

	goutil.setActive(self._goSuitList, self._isSuit)
	goutil.setActive(self._goDiceList, not self._isSuit)

	if self._isSuit then
		self._suitList:SetListItemCount(#self._suitListData)
		self._suitList:RefreshAllShownItem()

		local index = 0

		if self._selectEquipSuitData then
			for i = 1, #self._suitListData do
				if self._suitListData[i]:getId() == self._selectEquipSuitData:getId() then
					index = i - 1

					break
				end
			end
		end

		self._suitList:MoveToItemIndex(index)
	else
		self._diceList:SetListItemCount(#self._diceListData)
		self._diceList:RefreshAllShownItem()

		local index = 0

		if TableUtil.getLen(self._diceSelectList) > 0 then
			for k, v in pairs(self._diceSelectList) do
				for i = 1, #self._diceListData do
					if self._diceListData[i]:getAttrId() == k then
						index = i - 1

						break
					end
				end

				break
			end
		end

		self._diceList:MoveToItemIndex(index)
	end

	self:_refreshSuit()
end

function M:_onClickCloseBtn()
	goutil.setActive(self._mainGo, false)
end

function M:_onClickConfirmBtn()
	goutil.setActive(self._mainGo, false)
	GlobalDispatcher:dispatchEvent(EventType.EQUIP_WEARING_FILTER_CLICK_EVENT, self._selectEquipSuitData, self._diceSelectList)
end

function M:_handleClickSuit(e, equipSuitData, add)
	self._selectEquipSuitData = add and equipSuitData or nil

	goutil.setActive(self._goBottom, true)
	self:_refreshSuit()
end

function M:_handleClickDice(e, diceAttrMO, add)
	local id = diceAttrMO:getAttrId()

	self._diceSelectList[id] = add and diceAttrMO or nil

	goutil.setActive(self._goBottom, true)
	self:_refreshSuit()
end

function M:_onClickClearBtn()
	self._suitSelectIndex = nil
	self._diceSelectIndex = nil
	self._selectEquipSuitData = nil
	self._diceSelectList = {}

	self:_dealFilterToggleClick(self._curToggleIndex)
	self:_refreshSuit()
	GlobalDispatcher:dispatchEvent(EventType.EQUIP_WEARING_FILTER_CLICK_EVENT, self._selectEquipSuitData, self._diceSelectList)
end

function M:_refreshSuit()
	self._diceSelectList = self._diceSelectList or {}

	local lenght = TableUtil.getLen(self._diceSelectList)
	local show = false

	if self._selectEquipSuitData or lenght > 0 then
		show = true
	end

	goutil.setActive(self._goFilterSelected, show)

	if show then
		self._txtSuitName.text = self._selectEquipSuitData and self._selectEquipSuitData:getName() or ""

		if lenght > 0 and self._selectEquipSuitData then
			self._txtSuitName.text = self._txtSuitName.text .. ","
		end

		RectTransformUtils.ForceRebuildLayoutImmediate(self._txtSuitName.gameObject.transform)
		self:_updataSelectDiceItems()
	end
end

function M:_updataSelectDiceItems()
	if not self._filterDiceItems then
		self._filterDiceItems = {}
	end

	local i = 1

	for k, v in pairs(self._diceSelectList) do
		if i > 9 then
			break
		end

		if not self._filterDiceItems[i] then
			local go = goutil.clone(self._goDiceSelectItem)

			goutil.addChildToParent(go, self._goSelectDiceList)

			local item = Astral.LuaComponentContainer.Add(go, EquipDiceIconSimplifyItem)

			self._filterDiceItems[i] = item
		end

		self._filterDiceItems[i]:updateIcon(v)
		self._filterDiceItems[i]:setActive(true)

		i = i + 1
	end

	for j = i, #self._filterDiceItems do
		self._filterDiceItems[j]:setActive(false)
	end
end

return M
