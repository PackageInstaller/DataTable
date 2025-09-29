-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/BackpackView.lua

module("logic.extensions.backpack.view.BackpackView", package.seeall)

local BackpackShowType = CommEnum.MainBackpackShowType
local ItemPaddingX = 10
local M = class("BackpackView", ViewComponent)
local index2ShowType = {
	BackpackShowType.PropShowType,
	BackpackShowType.CurrencyShowType,
	BackpackShowType.EquipShowType,
	BackpackShowType.D6ShowType,
	BackpackShowType.EchoShowType,
	BackpackShowType.CardChipShowType,
	BackpackShowType.EchoCardPackType
}
local kSystemOpenEnumList = {
	[table.indexof(index2ShowType, BackpackShowType.D6ShowType)] = GameEnum.SystemEnum.EquipD6,
	[table.indexof(index2ShowType, BackpackShowType.EchoShowType)] = GameEnum.SystemEnum.RoleCarryEcho,
	[table.indexof(index2ShowType, BackpackShowType.CardChipShowType)] = GameEnum.SystemEnum.RoleBreak,
	[table.indexof(index2ShowType, BackpackShowType.EquipShowType)] = GameEnum.SystemEnum.RoleCarryEquip
}
local needRefreshRedList = {
	[BackpackShowType.PropShowType] = true,
	[BackpackShowType.EchoShowType] = true,
	[BackpackShowType.EquipShowType] = true,
	[BackpackShowType.EchoCardPackType] = true
}
local cfg = {
	[BackpackShowType.PropShowType] = {
		itemPaddingY = 54,
		viewUrl = ResName.Backpack_item_detail_tips,
		viewClass = BackpackPropFragmentView,
		cellBehaviorClass = BackpackPropItemCell
	},
	[BackpackShowType.CurrencyShowType] = {
		itemPaddingY = 54,
		viewUrl = ResName.Backpack_item_detail_tips,
		viewClass = BackpackCurrencyFragmentView,
		cellBehaviorClass = BackpackItemCell
	},
	[BackpackShowType.EquipShowType] = {
		itemPaddingY = 10,
		viewUrl = ResName.Backpack_equip_detail_tips,
		viewClass = BackpackEquipmentFragmentView,
		cellBehaviorClass = BackpackEquipItemCell
	},
	[BackpackShowType.D6ShowType] = {
		itemPaddingY = 10,
		viewUrl = ResName.Attriubte_d6_right_tips,
		viewClass = BackpackD6FragmentView,
		cellBehaviorClass = BackpackD6ItemCell
	},
	[BackpackShowType.EchoShowType] = {
		itemPaddingY = 10,
		viewUrl = ResName.Backpack_echo_detail_tips,
		viewClass = BackpackEchoitemFragmentView,
		cellBehaviorClass = BackpackEchoItemCell
	},
	[BackpackShowType.CardChipShowType] = {
		itemPaddingY = 54,
		viewUrl = ResName.Backpack_item_detail_tips,
		viewClass = BackpackPieceFragmentView,
		cellBehaviorClass = BackpackItemCell
	},
	[BackpackShowType.EchoCardPackType] = {
		itemPaddingY = 54,
		viewUrl = ResName.Backpack_item_detail_tips,
		viewClass = BackpackEchoCardPackFragmentView,
		cellBehaviorClass = BackpackEchoCardItemCell
	}
}
local AdjustMax = 2.02
local AdjustMin = 1.76

function M:ctor()
	self._emptyNode = false
	self._hasNode = false
	self._itemCompMap = {}
end

function M:buildUI()
	self:_buildListAndAnimationUI()
	self:_buildRightTabCtrlUI()

	self._canvasGroup = goutil.addComponentOnce(self.mainGO.gameObject, ComponentType.CanvasGroup)
	self._btnRetrieve = self:getBtn("9&com_btn_2_-31477526")
	self._btnRecycleMask1 = self:getBtn("backpack_view_-1101538952")
	self._btnRecycleMask2 = self:getBtn("backpack_view_-1833650150")

	local goQualityGroupBottom = self:getGo("11&quality_group_bottom_-387807289")

	self._qualityGos = {}
	self._qualityGos[GameEnum.QualityEnum.B] = goutil.findChild(goQualityGroupBottom, "qulaityB")
	self._qualityGos[GameEnum.QualityEnum.A] = goutil.findChild(goQualityGroupBottom, "qulaityA")
	self._qualityGos[GameEnum.QualityEnum.S] = goutil.findChild(goQualityGroupBottom, "qulaityS")
	self._goImgLight = goutil.findChild(goQualityGroupBottom, "imgLight")

	goutil.setActive(self._btnRecycleMask1.gameObject, false)
	goutil.setActive(self._btnRecycleMask2.gameObject, false)
end

function M:bindEvents()
	self._btnEmpty:AddClickListener(self._onClickEmpty, self)
	self._btnRetrieve:AddClickListener(self._onClickRetrieve, self)
	self._btnRecycleMask1:AddClickListener(self._onClickRecycleMask, self)
	self._btnRecycleMask2:AddClickListener(self._onClickRecycleMask, self)
	self._btnScrollRect:AddClickListener(self._onClickScrollRect, self)
end

function M:unbindEvents()
	self._btnEmpty:RemoveClickListener()
	self._btnRetrieve:RemoveClickListener()
	self._btnRecycleMask1:RemoveClickListener()
	self._btnRecycleMask2:RemoveClickListener()
	self._btnScrollRect:RemoveClickListener()
end

function M:_tryAdjustUI()
	self._needAdjustUI = GridAdaptUtil.isNeedAdjust(AdjustMax, AdjustMin)

	if self._needAdjustUI then
		LoopListUtils.SetGridColumnCountCount(self._itemGridList:GetLoopGridView(), 5)

		local filter = goutil.findChild(self._hasNode, "filter")

		goutil.setWidth(filter.transform, 680)
	end
end

function M:_buildListAndAnimationUI()
	local itemScroll = self:getGo("backpack_view_copy_245748323")

	self._btnScrollRect = Astral.ButtonAdapter.Get(self:getGo("backpack_view_1773378491"))
	self._scrollRect = itemScroll:GetComponent(UIComponentType.ScrollRect)
	self._itemGridList = LoopGridViewHelper.New(itemScroll)

	self._itemGridList:InitGridView(0, self._onCellUpdate, self)

	local goScroll = self:getGo("backpack_view_copy_64318217")
	local scrollWidth = goutil.getWidth(goScroll.transform)

	if scrollWidth < 795 then
		self._itemGridList:SetGridFixedGroupCount(SuperScrollView.GridFixedType.ColumnCountFixed, 5)
	elseif scrollWidth > 945 then
		self._itemGridList:SetGridFixedGroupCount(SuperScrollView.GridFixedType.ColumnCountFixed, 7)
	end

	self._emptyNode = self:getGo("backpack_view_copy_1913310918")
	self._btnEmpty = Astral.ButtonAdapter.Get(goutil.findChild(self._emptyNode, "empty_unit/btnGain"))
	self._txtEmpty = goutil.findChildTextComponent(self._emptyNode, "empty_unit/txtContent")
	self._hasNode = self:getGo("backpack_view_copy_-1935666063")
	self._listNode = goutil.findChild(self._hasNode, "propScroll")
	self._tipsNode = goutil.findChild(self._hasNode, "tips_Pos")
	self._scrollRecord = {}
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
end

function M:_buildRightTabCtrlUI()
	local adapter = DynamicPagerAdapter.New()

	self._viewPager = ViewPager.New(self._tipsNode)

	self._viewPager:setViewPresentor(self._viewPresentor)
	self._viewPager:setAdapter(adapter)

	self._tabComp = Astral.LuaComponentContainer.Add(self:getGo("left_tab_content_-399612422"), LeftTabComp)

	self._tabComp:setRedPointTypeStrong()

	self._toggleTabControl = ToggleTabControl.New()

	self._toggleTabControl:setViewPager(self._viewPager)
	self._toggleTabControl:setSystemOpen(kSystemOpenEnumList)
	self._tabComp:setActiveTabIndexLst({
		1,
		2,
		3,
		4,
		5,
		6,
		7
	})

	for index, showType in ipairs(index2ShowType) do
		adapter:registerView(cfg[showType].viewUrl, cfg[showType].viewClass)
		self._tabComp:setActiveTabIndex(index)
		self._tabComp:setTabShow(index, true)
		self._toggleTabControl:addToggleTab(self._tabComp:getToggleTab(index))
	end

	self._tabComp:setSystemOpenLst(kSystemOpenEnumList)
	self._tabComp:setTabShow(4, false)
end

function M:setEvent(isAdd)
	if isAdd then
		self._viewPager:setPageChangeCallBack(self._onPageChanged, self)
		GlobalDispatcher:addEventListener(EventType.BACKPACK_PAGE_DATA_CHANGED, self.refreshList, self)
		GlobalDispatcher:addEventListener(EventType.ITEM_EXPIRE_EVENT, self._showExpireInfo, self)
		GlobalDispatcher:addEventListener(EventType.ITEM_MODEL_CHANGED_REDPOINT, self._onRefreshPageRed, self)
		GlobalDispatcher:addEventListener(EventType.BACKPACK_PAGE_EXIT_RECYCLE, self._onRefreshMask, self)
		GlobalDispatcher:addEventListener(EventType.ON_AIRTIGHT_EXIT_TIME_CHANGE, self._onAirtightExitTimeChange, self)
		GlobalDispatcher:addEventListener(EventType.MAIN_SCENE_TO_AIRTIGHT_ANI_FINISHED, self._onToAirtightAniFinished, self)
	else
		GlobalDispatcher:removeEventListener(EventType.BACKPACK_PAGE_DATA_CHANGED, self.refreshList, self)
		GlobalDispatcher:removeEventListener(EventType.ITEM_EXPIRE_EVENT, self._showExpireInfo, self)
		GlobalDispatcher:removeEventListener(EventType.ITEM_MODEL_CHANGED_REDPOINT, self._onRefreshPageRed, self)
		GlobalDispatcher:removeEventListener(EventType.BACKPACK_PAGE_EXIT_RECYCLE, self._onRefreshMask, self)
		GlobalDispatcher:removeEventListener(EventType.ON_AIRTIGHT_EXIT_TIME_CHANGE, self._onAirtightExitTimeChange, self)
		GlobalDispatcher:removeEventListener(EventType.MAIN_SCENE_TO_AIRTIGHT_ANI_FINISHED, self._onToAirtightAniFinished, self)
	end
end

function M:onEnter()
	self:setEvent(true)

	self._redPoints = {}

	MainScenePerformUtil.setBgHeroShow(false, true)
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem)
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Backpack)

	local defaultTabIndex = table.indexof(index2ShowType, MainBackpackModel.instance:getCurShowType())

	self._tabComp:onEnter()
	self._toggleTabControl:selectTab(defaultTabIndex)

	for _, showType in pairs(index2ShowType) do
		self:_refreshPageRed(showType)
	end

	self._tabComp:playGuiAniTab(true, not self._viewPresentor:getIsBackOpen(), defaultTabIndex)
end

function M:onExit(reasonTyp)
	local isNormalClose = reasonTyp ~= WindowType.WindowCloseReasonType.QuickCloseType

	self:setEvent(false)
	self._viewPager:clear()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Backpack)
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem)
	self._tabComp:onExit()
	self._tabComp:playGuiAniTab(false, isNormalClose)

	self._curShowItems = {}
	self._curShowType = false
	self._playingAirtightShow = nil

	self._itemGridList:ClearCells()
	ViewMgr.instance:close(ViewName.BackpackRecycleView)

	for _, tweener in ipairs(self._cacheTweenLst or {}) do
		if tweener then
			tweener:Kill(false)
		end
	end
end

function M:destroyUI()
	MainBackpackModel.instance:clearOperate()
	self._viewPager:destroy()

	self._scrollRecord = nil

	self._itemGridList:Dispose()
end

function M:_setCanvas(alpha, interactable)
	self._canvasGroup.alpha = alpha
	self._canvasGroup.interactable = interactable
end

function M:_onAirtightExitTimeChange(e, exitTimeStamp)
	local nowTime = AirtightRoomModel.instance:getServerTime()

	if exitTimeStamp and nowTime < exitTimeStamp then
		self._playingAirtightShow = true

		ViewBlackFadeController.instance:showGadget(true, 0.1, function()
			self:_setCanvas(0, false)
			MainScenePerformUtil.setHeroShow(MainPerformEnum.ElementPointAdjutant, true, nil, true)
			MainCameraMgr.instance:setCameraVisible(true)
		end, self, "背包,开始密室表演", 0.2, 0.2)
	end
end

function M:_onToAirtightAniFinished()
	if not self._playingAirtightShow then
		return
	end

	self._playingAirtightShow = nil

	ViewBlackFadeController.instance:showGadget(true, 0.1, function()
		MainCameraMgr.instance:setCameraVisible(false)
		MainScenePerformUtil.setHeroShow(MainPerformEnum.ElementPointAdjutant, false, nil, false)
		self:_setCanvas(1, true)
	end, self, "背包,密室表演结束")
end

function M:_onPageChanged(index)
	if self._curShowType then
		self._scrollRecord[self._curShowType] = self._scrollRect.verticalNormalizedPosition
	end

	local showType = index2ShowType[index]

	self._curShowType = showType
	self._curItemCls = cfg[showType].cellBehaviorClass

	self:_refreshRecycleBtn()
	self:_dealLeftTabComp(self._lastIndex, index)
	GlobalDispatcher:dispatchEvent(EventType.BACKPACK_TO_SWITCH_SHOW_TYPE, showType)
end

function M:_dealLeftTabComp(orgIndex, tabIndex)
	local samePage = orgIndex == tabIndex
	local duration = samePage and 0 or 0.3

	duration = orgIndex and math.abs(orgIndex - tabIndex) <= 1 and 0.2 or duration

	self._tabComp:setCanvasGroupShow(false, 0.5, 0.2)
	self._tabComp:MoveSelectMark(tabIndex, duration)

	self._lastIndex = tabIndex
end

function M:refreshList(e, changeType, itemChangeData)
	if changeType == CommEnum.MainBackpackRefreshType.RecycleEnter or changeType == CommEnum.MainBackpackRefreshType.RecycleExit or changeType == CommEnum.MainBackpackShowType.EchoShowType then
		self._refreshType = changeType

		self:_refreshRecycleBtn(changeType)
	end

	if self._cacheCellAniCompLst then
		for _, cell in pairs(self._cacheCellAniCompLst) do
			cell:setAlpha(1)
		end

		for _, tweener in ipairs(self._cacheTweenLst or {}) do
			if tweener then
				tweener:Kill(false)
			end
		end

		self._cacheTweenLst = nil
		self._scrollRect.enabled = true

		table.clear(self._cacheCellAniCompLst)
	else
		self._cacheCellAniCompLst = {}
	end

	self._curShowItems = MainBackpackModel.instance:getCurShownItems()

	local showItemsCount = #self._curShowItems

	self:_dealHasOrEmpty(showItemsCount <= 0)
	self._itemGridList:SetListItemCount(showItemsCount)
	self._itemGridList:RefreshAllShownItem()

	if changeType == CommEnum.MainBackpackRefreshType.SwitchPage then
		local lastPos = self._scrollRecord[self._curShowType]

		if lastPos then
			self._scrollRect.verticalNormalizedPosition = lastPos
		end
	elseif changeType == CommEnum.MainBackpackRefreshType.RecycleEnter then
		ViewMgr.instance:open(ViewName.BackpackRecycleView)
	elseif changeType == CommEnum.MainBackpackRefreshType.ItemModel then
		for _, showType in pairs(index2ShowType) do
			self:_refreshPageRed(showType)
		end
	end

	if showItemsCount > 0 then
		self._needPlayItemCellOpenAni = changeType == CommEnum.MainBackpackRefreshType.SwitchPage or changeType == CommEnum.MainBackpackRefreshType.Filter or changeType == CommEnum.MainBackpackRefreshType.Sort
	end

	self:_playItemOpenAni(self._needPlayItemCellOpenAni)
	self:_refreshQuality()
end

function M:_playItemOpenAni(play)
	self._cacheTweenLst = {}

	if not self._delayTime then
		self._delayTime = {
			0.03,
			0.04,
			0.05
		}
	end

	if play then
		self._scrollRect.enabled = false

		local maxDelay = 0.5
		local oneTimeShowCount = -1
		local len = TableUtil.getLen(self._cacheCellAniCompLst)
		local lastDelayTime = 0
		local thisTimeAddDelay = false

		for _, cell in pairs(self._cacheCellAniCompLst) do
			if len < 13 then
				thisTimeAddDelay = true
			elseif oneTimeShowCount < 0 then
				oneTimeShowCount = math.random(0, 1)
				oneTimeShowCount = oneTimeShowCount - 1
				thisTimeAddDelay = true
			else
				thisTimeAddDelay = false
				oneTimeShowCount = oneTimeShowCount - 1
			end

			local thisTimeDelay = thisTimeAddDelay and self._delayTime[math.random(1, #self._delayTime)] * (len > 12 and maxDelay * 0.5 or maxDelay) or 0
			local delay = lastDelayTime + thisTimeDelay

			delay = maxDelay < delay and maxDelay or delay

			cell:setAlpha(0)

			local tweenDelay = DoTweenUtil.DelayedCall(delay, function()
				cell:setAlpha(1)
				cell:playOpenAni()
			end)

			table.insert(self._cacheTweenLst, tweenDelay)

			lastDelayTime = delay
		end

		self._needPlayItemCellOpenAni = false

		table.insert(self._cacheTweenLst, DoTweenUtil.DelayedCall(maxDelay, function()
			self._scrollRect.enabled = true
		end))
	end
end

function M:_scrollToSelectItem()
	local scorllIndex = MainBackpackModel.instance:getSelecedItemIndex()

	if scorllIndex then
		if self._itemGridList:GetShownItemByItemIndex(scorllIndex) then
			return
		end

		self._itemGridList:MoveToItemIndex(scorllIndex)
	end
end

function M:_onCellUpdate(curIndex)
	curIndex = curIndex + 1

	local item = self._itemGridList:NewListViewItem("backpack_item")
	local itemGo = item.gameObject
	local itemGoId = itemGo:GetInstanceID()
	local oldComp = self._itemCompMap[itemGoId]

	if oldComp and oldComp ~= self._curItemCls then
		Astral.LuaComponentContainer.Remove(itemGo, oldComp)
	end

	local view = Astral.LuaComponentContainer.Add(itemGo, self._curItemCls)

	self._itemCompMap[itemGoId] = self._curItemCls

	local mo = self._curShowItems[curIndex]

	view:updateData(mo)
	view:setSelectEvent(EventType.BACKPACK_ITEM_CLICK_EVENT)

	local isPreview = MainBackpackModel.instance:isPreviewEquip(mo)
	local isSelected = MainBackpackModel.instance:isRecycleSelected(mo)

	view:onSelect(isPreview, isSelected)

	if needRefreshRedList[self._curShowType] then
		view:refreshRed()
	else
		view:hideRed()
	end

	local presetComponent = view:getComponent("preset")

	if presetComponent then
		if self._refreshType == CommEnum.MainBackpackRefreshType.RecycleEnter then
			local isPreset = CharacterPreinstallController.instance:getItemList(mo:getUuid())

			presetComponent:setVisible(isPreset)
		else
			presetComponent:setVisible(false)
		end
	end

	self._cacheCellAniCompLst[itemGoId] = view:getComponent("animation")

	return item
end

function M:_dealHasOrEmpty(isEmpty)
	local filterEmpty = false

	if isEmpty then
		local itemBeforeFilter = MainBackpackModel.instance:getCurShowTypeAllItems()

		filterEmpty = itemBeforeFilter and #itemBeforeFilter > 0
	end

	goutil.setActive(self._emptyNode, isEmpty)
	goutil.setActive(self._hasNode, not isEmpty or filterEmpty)
	goutil.setActive(self._listNode, not isEmpty)
	goutil.setActive(self._tipsNode, not isEmpty)

	if self._emptyNode.activeSelf then
		local emyptTxt = lang("tip_backpack_empty_common")

		if self._curShowType == BackpackShowType.EquipShowType then
			emyptTxt = lang("tip_backpack_empty_equip")

			goutil.setActive(self._btnEmpty.gameObject, true)
		elseif self._curShowType == BackpackShowType.EchoShowType then
			emyptTxt = lang("tip_backpack_empty_echo")

			goutil.setActive(self._btnEmpty.gameObject, true)
		elseif self._curShowType == BackpackShowType.D6ShowType then
			emyptTxt = lang("tip_backpack_empty_d6")

			goutil.setActive(self._btnEmpty.gameObject, true)
		else
			goutil.setActive(self._btnEmpty.gameObject, false)
		end

		self._txtEmpty.text = emyptTxt
	end
end

function M:_onClickEmpty()
	local jumpId = false

	if self._curShowType == BackpackShowType.EquipShowType then
		jumpId = 12000001
	elseif self._curShowType == BackpackShowType.EchoShowType then
		jumpId = 10803004
	elseif self._curShowType == BackpackShowType.D6ShowType then
		jumpId = 12000001
	end

	if jumpId then
		if not SystemJumpController.instance:canJump(jumpId, true) then
			return
		end

		if MainBackpackModel.instance:isInRecycling() then
			GlobalDispatcher:dispatchEvent(EventType.BACKPACK_PAGE_EXIT_RECYCLE)
		end

		GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_EVENT, jumpId)
	end
end

function M:_showExpireInfo(e, uuid)
	local item = ItemModel.instance:getItemDataByUuid(uuid)

	FloatWordMgr.instance:show(string.format(lang("tip_item_expire"), item:getName()))
end

function M:_refreshPageRed(ShowType)
	local isRed = false

	if ShowType == BackpackShowType.PropShowType then
		isRed = MainBackpackModel.instance:isPropGiftRed()
	elseif ShowType == BackpackShowType.EchoShowType then
		isRed = MainBackpackModel.instance:isEchoNewRed()
	end

	self._tabComp:setRedPoint(table.indexof(index2ShowType, ShowType), isRed)
end

function M:_onRefreshPageRed(e, itemType)
	if itemType and (itemType == GameEnum.ItemTypeEnum.PropItemType or itemType == GameEnum.ItemTypeEnum.TreasureBox) then
		self:_refreshPageRed(BackpackShowType.PropShowType)
	end
end

function M:_onClickScrollRect()
	if ViewMgr.instance:isOpen(ViewName.BackpackRecycleView) then
		self:_onClickRecycleMask()
	end
end

function M:_onClickRetrieve()
	GlobalDispatcher:dispatchEvent(EventType.BACKPACK_PAGE_ENTER_RECYCLE)
	goutil.setActive(self._btnRetrieve.gameObject, false)
	goutil.setActive(self._btnRecycleMask1.gameObject, true)
	goutil.setActive(self._btnRecycleMask1.gameObject, true)
end

function M:_onClickRecycleMask()
	ViewMgr.instance:close(ViewName.BackpackRecycleView)
	goutil.setActive(self._btnRecycleMask1.gameObject, false)
	goutil.setActive(self._btnRecycleMask1.gameObject, false)
end

function M:_onRefreshMask()
	goutil.setActive(self._btnRecycleMask1.gameObject, false)
	goutil.setActive(self._btnRecycleMask1.gameObject, false)
end

function M:_refreshRecycleBtn(changeType)
	local curShowType = MainBackpackModel.instance:getCurShowType()
	local isInRecycling = MainBackpackModel.instance:isInRecycling()
	local isCanRecycle = curShowType == CommEnum.MainBackpackShowType.EchoShowType or curShowType == CommEnum.MainBackpackShowType.EquipShowType or curShowType == CommEnum.MainBackpackShowType.D6ShowType

	goutil.setActive(self._btnRetrieve.gameObject, isCanRecycle and not isInRecycling)

	local isRecycleEnter = changeType == CommEnum.MainBackpackRefreshType.RecycleEnter

	goutil.setActive(self._btnRecycleMask1.gameObject, isCanRecycle and isRecycleEnter)
	goutil.setActive(self._btnRecycleMask2.gameObject, isCanRecycle and isRecycleEnter)
end

function M:_refreshQuality()
	local itemData = MainBackpackModel.instance:getCurSelecedItem()
	local quality = itemData and itemData:getQuality() or -1
	local isShow = false

	for k, v in pairs(self._qualityGos) do
		goutil.setActive(v, k == quality)

		if k == quality then
			isShow = true
		end
	end

	goutil.setActive(self._goImgLight, isShow)
end

return M
