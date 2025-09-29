-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/recycle/BackpackRecycleView.lua

module("logic.extensions.backpack.view.recycle.BackpackRecycleView", package.seeall)

local M = class("BackpackRecycleView", ViewComponent)
local BackpackChangedType = CommEnum.MainBackpackRefreshType
local QuickSelectType = CommEnum.MainBackpackQuickRecycleType
local QuickSelectItemStatus = CommEnum.BackPackFilterItemStatus
local ShowType = CommEnum.MainBackpackShowType
local cfgItemCell = {
	[ShowType.EquipShowType] = BackpackEquipItemCell,
	[ShowType.D6ShowType] = BackpackD6ItemCell,
	[ShowType.EchoShowType] = BackpackEchoItemCell
}
local SName = lang("tip_recyccle_orange_name")
local AName = lang("tip_recyccle_purple_name")
local BName = lang("tip_recyccle_blue_name")
local CName = lang("tip_recyccle_green_name")
local DName = lang("tip_recyccle_discard_name")
local EquipName = lang("tip_recyccle_xiaoshiqi_name")
local YinziName = lang("tip_recyccle_liumianti_name")
local EchoName = lang("tip_recyccle_echo_name")
local NoName = lang("tip_recyccle_no_name")

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._btnFilter = self:getBtn("backpack_recycle_view_938814839")
	self._btnQuickSelect = self:getBtn("backpack_recycle_view_335196845")
	self._btnRecycle = self:getBtn("backpack_recycle_view_727506294")
	self._btnCancel = self:getBtn("backpack_recycle_view_1854632714")
	self._toggleList = self:getUIComponent("backpack_recycle_view_1161734738", UIComponentType.SpaceXToggle)
	self._listParentGo = goutil.findChild(self.mainGO, "content/list")
	self._filterParentGo = self:getGo("backpack_recycle_view_1300850048")
	self._txtFilter = self:getText("backpack_recycle_view_570466300")
	self._txtCapacity = self:getText("backpack_recycle_view_2016217412")
	self._list = LoopGridViewHelper.New(self:getGo("backpack_recycle_view_1455513067"))

	self._list:InitGridView(0, self._onCellUpdate, self)

	self._recycleAwardlist = LoopGridViewHelper.New(self:getGo("backpack_recycle_view_copy_1320543274"))

	self._recycleAwardlist:InitGridView(0, self._onRecycleAwardCellUpdate, self)

	self._itemCompMap = {}
	self._quickSelectItemViews = {}

	for _, quickType in pairs(QuickSelectType) do
		local quickItem = goutil.findChild(self._filterParentGo, "Content/Item" .. quickType)
		local itemView = Astral.LuaComponentContainer.Add(quickItem, BackpackQuickSelectItem)

		self._quickSelectItemViews[quickType] = itemView
	end

	self._btnMask = self:getBtn("backpack_recycle_view_-853575840")

	goutil.setActive(self._btnMask.gameObject, false)

	self._btnListToggleMask = self:getBtn("backpack_recycle_view_631727447")

	goutil.setActive(self._btnListToggleMask.gameObject, false)
end

function M:destroyUI()
	self._itemCompMap = nil
end

function M:bindEvents()
	self._btnFilter:AddClickListener(self._onClickFilterBtn, self)
	self._btnQuickSelect:AddClickListener(self._onClickQuickSelectBtn, self)
	self._btnRecycle:AddClickListener(self._onClickRecycleBtn, self)
	self._btnCancel:AddClickListener(self._onClickCancleBtn, self)
	self._toggleList:AddListener(self._onToggle, self)
	self._btnMask:AddClickListener(self._onClickMaskBtn, self)
	self._btnListToggleMask:AddClickListener(self._onClickMaskBtn, self)
	GlobalDispatcher:addEventListener(EventType.BACKPACK_PAGE_DATA_CHANGED, self._onBackpackPageDataChanged, self)
	GlobalDispatcher:addEventListener(EventType.BACKPACK_RECYCLE_QUICK_SELECT_ITEM_CLICK, self._onChoseQuickSelectItem, self)
end

function M:unbindEvents()
	self._btnFilter:RemoveClickListener()
	self._btnQuickSelect:RemoveClickListener()
	self._btnRecycle:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
	self._toggleList:RemoveListener()
	self._btnMask:RemoveClickListener()
	self._btnListToggleMask:RemoveClickListener()
	GlobalDispatcher:removeEventListener(EventType.BACKPACK_PAGE_DATA_CHANGED, self._onBackpackPageDataChanged, self)
	GlobalDispatcher:removeEventListener(EventType.BACKPACK_RECYCLE_QUICK_SELECT_ITEM_CLICK, self._onChoseQuickSelectItem, self)
end

function M:onEnter()
	self:initData()
	self:initUI()
end

function M:initData()
	self._showType = MainBackpackModel.instance:getCurShowType()
	self._curItemCls = cfgItemCell[self._showType]
	self._limitCount = ConstConfig.instance:getNumValueByKey(ConstConfigKeyEnum.RecycleLimit)
	self._quickItemsHas = MainBackpackModel.instance:getQuickSelectTypes()
	self._quickSelecResult = {}
	self._listData = {}
	self._recycleEquipsAwards = {}
end

function M:initUI()
	goutil.setActive(self._filterParentGo, false)
	goutil.setActive(self._listParentGo, false)
	goutil.setActive(self._btnMask.gameObject, false)
	goutil.setActive(self._btnListToggleMask.gameObject, false)

	for _, quickType in pairs(QuickSelectType) do
		local item = self._quickSelectItemViews[quickType]
		local status = self:_calItemStatus(quickType)

		item:setData(quickType, self:getQuickSeletStr(quickType))
		item:setStatus(status)
	end

	self._toggleList.IsOn = false

	for selectType = QuickSelectType.C, QuickSelectType.S, -1 do
		if self._quickItemsHas[selectType] then
			self._quickSelecResult[selectType] = true

			self._quickSelectItemViews[selectType]:setStatus(QuickSelectItemStatus.Select)
			self:_refreshQuickFilterText()

			return
		end
	end

	self._txtFilter.text = NoName
	self._txtCapacity.text = "0/" .. self._limitCount

	self._list:SetListItemCount(0)
	self._recycleAwardlist:SetListItemCount(0)
end

function M:onExit()
	MainBackpackModel.instance:setInRecycleListView(false)

	self._quickItems = nil
	self._quickItemsHas = nil
end

function M:_onClickMaskBtn()
	goutil.setActive(self._filterParentGo, false)
	goutil.setActive(self._btnMask.gameObject, false)
	goutil.setActive(self._btnListToggleMask.gameObject, false)
end

function M:_onClickFilterBtn()
	local active = not self._filterParentGo.activeSelf

	goutil.setActive(self._filterParentGo, active)
	goutil.setActive(self._btnMask.gameObject, active)
	goutil.setActive(self._btnListToggleMask.gameObject, active)

	if self._isNeedReset then
		self._isNeedReset = false

		table.clear(self._quickSelecResult)
		self:_refreshList()
		self:_resetItemStatus()
	end
end

function M:_onClickQuickSelectBtn()
	goutil.setActive(self._filterParentGo, false)
	goutil.setActive(self._btnMask.gameObject, false)
	goutil.setActive(self._btnListToggleMask.gameObject, false)

	if not self._hadChanged and not self._isNeedReset then
		return
	end

	GlobalDispatcher:dispatchEvent(EventType.BACKPACK_RECYCLE_QUICK_SELECT_CLICK, self._quickSelecResult)
end

function M:_onClickRecycleBtn()
	if #self._listData < 1 then
		FloatWordMgr.instance:show(lang("tip_backpack_recycle_empty"))

		return
	end

	goutil.setActive(self._filterParentGo, false)

	local isOpen = self:isOpenPrinstallNoticView(self._listData)

	if isOpen then
		ViewMgr.instance:open(ViewName.CharacterPreinstallNoticeView, 1, self._listData, self)
	else
		local param = {
			useItems = self._listData,
			showType = self._showType
		}

		ViewMgr.instance:open(ViewName.ResolveItemTips, param)
	end
end

function M:isOpenPrinstallNoticView(list)
	for k, v in pairs(list) do
		local temp = CharacterPreinstallController.instance:getItemList(v:getUuid())

		if temp then
			return true
		end
	end

	return false
end

function M:_confirmCallbackPreinstall()
	local param = {
		useItems = self._listData,
		showType = self._showType
	}

	ViewMgr.instance:open(ViewName.ResolveItemTips, param)
end

function M:_onClickCancleBtn()
	GlobalDispatcher:dispatchEvent(EventType.BACKPACK_PAGE_EXIT_RECYCLE)
	self:back()
end

function M:_onChoseQuickSelectItem(e, selectType, status)
	if status == QuickSelectItemStatus.Normal then
		self._quickSelecResult[selectType] = true

		self._quickSelectItemViews[selectType]:setStatus(QuickSelectItemStatus.Select)
		self:_refreshQuickFilterText()
	elseif status == QuickSelectItemStatus.Select then
		self._quickSelecResult[selectType] = false

		self._quickSelectItemViews[selectType]:setStatus(QuickSelectItemStatus.Normal)
		self:_refreshQuickFilterText()
	end
end

function M:_onToggle(toggle, isOn)
	if isOn then
		local len = #self._listData

		if len > 0 then
			goutil.setActive(self._listParentGo, true)
			MainBackpackModel.instance:setInRecycleListView(true)
			self._list:SetListItemCount(len)
			self._list:RefreshAllShownItem()

			len = #self._recycleEquipsAwards

			self._recycleAwardlist:SetListItemCount(len)
			self._recycleAwardlist:RefreshAllShownItem()
		else
			FloatWordMgr.instance:show(lang("tip_backpack_recycle_empty"))

			self._toggleList.IsOn = false
		end
	else
		goutil.setActive(self._listParentGo, false)
		MainBackpackModel.instance:setInRecycleListView(false)
	end
end

function M:_onBackpackPageDataChanged(e, changeType)
	if changeType == BackpackChangedType.SwitchPage then
		self:onSwitchPage()
	elseif changeType == BackpackChangedType.RecycleChanged then
		MainBackpackModel.instance:getRecycleItems(self._listData)
		MainBackpackModel.instance:calRecycleGetItems(self._listData, self._recycleEquipsAwards)
		self:_refreshList()
	elseif changeType == BackpackChangedType.RecycleReplied then
		table.clear(self._listData)
		table.clear(self._recycleEquipsAwards)

		self._toggleList.IsOn = false
		self._d6AwardCount = 0

		self:_refreshList()

		self._isNeedReset = true
	end
end

function M:onSwitchPage()
	if MainBackpackModel.instance:isInRecycling() then
		self:onEnter()
	else
		self:back()
	end
end

function M:_refreshList()
	BackpackUtil.sortRecycleItems(self._listData, self._showType == ShowType.EquipShowType)

	local len = #self._listData

	self._txtCapacity.text = len .. "/" .. self._limitCount

	if self._listParentGo.activeSelf then
		self._list:SetListItemCount(len)
		self._list:RefreshAllShownItem()

		len = #self._recycleEquipsAwards

		self._recycleAwardlist:SetListItemCount(len)
		self._recycleAwardlist:RefreshAllShownItem()

		if len < 1 then
			self._toggleList.IsOn = false
		end
	end

	local countInfo = {}

	for _, item in ipairs(self._recycleEquipsAwards) do
		countInfo[item:getItemId()] = item:getCount()
	end

	GlobalDispatcher:dispatchEvent(EventType.BACKPACK_RECYCLE_MONEY_COUNT_CHANGED, countInfo)
end

function M:_onCellUpdate(curIndex)
	curIndex = curIndex + 1

	local item = self._list:NewListViewItem("backpack_item1")
	local itemGo = item.gameObject
	local itemGoId = itemGo:GetInstanceID()
	local oldComp = self._itemCompMap[itemGoId]

	if oldComp and oldComp ~= self._curItemCls then
		Astral.LuaComponentContainer.Remove(itemGo, oldComp)
	end

	local view = Astral.LuaComponentContainer.Add(itemGo, self._curItemCls)

	self._itemCompMap[itemGoId] = self._curItemCls

	local mo = self._listData[curIndex]

	view:updateData(mo)
	view:setSelectEvent(EventType.BACKPACK_ITEM_CLICK_EVENT)

	local isSelected = MainBackpackModel.instance:isRecycleSelected(mo)

	view:onSelect(true, isSelected)

	return item
end

function M:_onRecycleAwardCellUpdate(curIndex)
	curIndex = curIndex + 1

	local item = self._recycleAwardlist:NewListViewItem("backpack_item2")
	local itemGo = item.gameObject
	local view = Astral.LuaComponentContainer.Add(itemGo, ItemCell)
	local mo = self._recycleEquipsAwards[curIndex]

	view:updateData(mo)
	view:setShowSelectedEffect(false)
	view:setIsHideGetWay(true)
	view:onSelect(isSelected)

	return item
end

function M:_resetItemStatus()
	for _, quickType in pairs(QuickSelectType) do
		local item = self._quickSelectItemViews[quickType]
		local last = item:getStatus()

		if last and last == QuickSelectItemStatus.Select then
			item:setStatus(QuickSelectItemStatus.Normal)
		end
	end

	self._quickItemsHas = MainBackpackModel.instance:getQuickSelectTypes()
	self._txtFilter.text = NoName
	self._hadChanged = true
end

function M:_calItemStatus(quickType)
	return self._quickItemsHas[quickType] and QuickSelectItemStatus.Normal or QuickSelectItemStatus.Disable
end

function M:_refreshQuickFilterText()
	local str1 = ""
	local isEmpty = true

	for quickType, result in pairs(self._quickSelecResult) do
		if result then
			isEmpty = false
			str1 = str1 .. "/" .. (quickType == QuickSelectType.S and SName or quickType == QuickSelectType.A and AName or quickType == QuickSelectType.B and BName or quickType == QuickSelectType.C and CName or DName)
		end
	end

	local str2 = self._showType == ShowType.EquipShowType and EquipName or self._showType == ShowType.D6ShowType and YinziName or EchoName

	self._hadChanged = true
	self._txtFilter.text = isEmpty and NoName or string.sub(str1, 2, string.len(str1)) .. str2
end

function M:getQuickSeletStr(quickType)
	local str1 = quickType == QuickSelectType.S and SName or quickType == QuickSelectType.A and AName or quickType == QuickSelectType.B and BName or quickType == QuickSelectType.C and CName or DName
	local str2 = self._showType == ShowType.EquipShowType and EquipName or self._showType == ShowType.D6ShowType and YinziName or EchoName

	return str1 .. str2
end

return M
