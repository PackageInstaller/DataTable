-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/new/ChangeEquipViewNew.lua

module("logic.extensions.charactersystem.view.equip.new.ChangeEquipViewNew", package.seeall)

local M = class("ChangeEquipViewNew", ViewComponent)
local defaultSortType = CommEnum.MainBackpackSortType.Level
local xEffexPos = {
	-95,
	-18,
	171
}
local yEffexPos = {
	113,
	95,
	95
}
local yAniName = {
	"01",
	"02",
	"03"
}

function M:buildUI()
	local goRoleCombat = goutil.findChild(self.mainGO, "secrecyIndex").gameObject

	self._roleCombatCell = Astral.SimpleLuaComponentContainer.Add(goRoleCombat, RoleCombatCell)
	self._compareMask = goutil.findChild(self.mainGO, "imgContrastMask")

	local imageGo = self:getGo("0&equip_main_panel_1501905091")

	self._equipModelComponent = Astral.LuaComponentContainer.Add(imageGo, ChangeEquipSuitModelComponent)

	local equipDetailGo = self:getGo("2&backpack_equip_detail_tips_copy_154087081")

	self._equipDetailComp = Astral.LuaComponentContainer.Add(equipDetailGo, EquipChangeDetailInfoComponentNew)

	local selfEquipDetailGo = self:getGo("3&backpack_equip_detail_tips_copy_154087081")

	self._equipDetailCompSelf = Astral.LuaComponentContainer.Add(selfEquipDetailGo, EquipDetailInfoComponentNew)

	self._equipDetailCompSelf:buildUI()
	self._equipDetailCompSelf:setEquipUsing(true)

	local equipScrollGo = self:getGo("equip_properties_overview_view_copy_-2042845628")

	self._scrollRect = equipScrollGo:GetComponent(UIComponentType.ScrollRect)
	self._equipScrollRect = equipScrollGo:GetComponent(UIComponentType.ScrollRect)
	self._equipScrollList = LoopGridViewHelper.New(equipScrollGo)

	self._equipScrollList:InitGridView(0, self._onEquipCellUpdate, self)

	self._equipEmptyGo = self:getGo("equip_properties_overview_view_copy_-714355258")
	self._filterRoot = self:getGo("4&common_filter_-55329758")
	self._filterCanvasGroup = self._filterRoot:GetComponent(ComponentType.CanvasGroup)
	self._btnMask = Astral.ButtonAdapter.Get(goutil.findChild(self._filterRoot, "click"))
	self._btnEmptyClick = Astral.ButtonAdapter.Get(goutil.findChild(self._equipEmptyGo, "empty_unit/btnGain"))

	goutil.setActive(self._btnMask.gameObject, false)

	local tabList = self:getGo("equip_properties_overview_view_copy_-216132886")

	self._tabBarList = {}
	self._redGo = {}
	self._tabBarGroup = goutil.addComponentOnce(tabList, UIComponentType.SpaceXToggleGroup)

	local toggleComp = false

	for i = 1, 3 do
		toggleComp = goutil.findChild(tabList, "btn" .. i):GetComponent(UIComponentType.SpaceXToggle)

		table.insert(self._tabBarList, toggleComp)

		local redPointGo = goutil.findChild(tabList, "redPoint" .. i)

		table.insert(self._redGo, redPointGo)
		goutil.setActive(redPointGo, false)
	end

	self._btnSuit = self:getBtn("4&common_filter_1742265756")
	self._suitCanvas = self._btnSuit.gameObject:GetComponent(ComponentType.CanvasGroup)
	self._suitText = self:getText("4&common_filter_1499640258")
	self._suitListGo = self:getGo("4&common_filter_621413802")
	self._suitTrans = self._suitListGo.transform
	self._suitItemTrans = goutil.findChild(self._suitListGo, "view/content").transform
	self._suitList = LoopListHelper.New(self._suitListGo)

	self._suitList:InitListView(0, self._onSuitCellUpdate, self)

	self._suitUpGo = goutil.findChild(self._btnSuit.gameObject, "content/up")
	self._suitDownGo = goutil.findChild(self._btnSuit.gameObject, "content/down")
	self._btnSort = self:getBtn("4&common_filter_-1115847681")
	self._sortCanvas = self._btnSort.gameObject:GetComponent(ComponentType.CanvasGroup)
	self._sortText = self:getText("4&common_filter_-250765097")
	self._sortItemsParent = goutil.findChild(self._btnSort.gameObject, "Template")
	self._sortUpGo = goutil.findChild(self._btnSort.gameObject, "content/up")
	self._sortDownGo = goutil.findChild(self._btnSort.gameObject, "content/down")
	self._sortItems = {}
	self._sortItemTemp = goutil.findChild(self._sortItemsParent, "Content/Item1")

	goutil.setActive(self._sortItemTemp, false)

	local itemsParent = goutil.findChild(self._sortItemsParent, "Content")

	for i = 1, 3 do
		local sortItem = goutil.clone(self._sortItemTemp)

		goutil.setActive(sortItem, true)
		goutil.addChildToParent(sortItem, itemsParent)

		local itemView = Astral.LuaComponentContainer.Add(sortItem, BackpackSortItemNew)

		itemView:setData(BackpackItemSortData.New(i, false))
		itemView:setEvent(EventType.EQUIP_WEARING_SORT_ITEM_CLICK)
		table.insert(self._sortItems, itemView)

		if i == defaultSortType then
			itemView:setSelect(true)

			self._sortMo = itemView:getData()
		else
			itemView:setSelect(false)
		end
	end

	goutil.setActive(self._sortItemsParent, false)

	self._btnCompare = self:getBtn("equip_properties_overview_view_copy_1529284885")
	self._btnHideCompare = self:getBtn("equip_properties_overview_view_copy_460618587")
	self._goEquipted = self:getGo("equip_properties_overview_view_copy_2082996933")

	goutil.setActive(self._goEquipted, false)
	goutil.setActive(self._btnCompare.gameObject, false)
	goutil.setActive(self._btnHideCompare.gameObject, false)

	self._btnListGo = goutil.findChild(self.mainGO, "btnList")
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self._suitTitleName = lang("tip_equip_suit_change")
	self._needPlayItemAniMaxIndex = 15
end

function M:bindEvents()
	self._btnSuit:AddClickListener(self._onClickSuitBtn, self)
	self._btnSort:AddClickListener(self._onClickSortBtn, self)
	self._btnCompare:AddClickListener(self._onClickCompareBtn, self)
	self._btnHideCompare:AddClickListener(self._onClickHideCompareBtn, self)
	self._btnMask:AddClickListener(self._onClickMaskBtn, self)
	self._equipDetailComp:bindEvents()
	self._equipDetailCompSelf:bindEvents()
	self._btnEmptyClick:AddClickListener(self._onClickEmpty, self)

	for index, toggleComp in ipairs(self._tabBarList) do
		toggleComp:AddListener(function(_, isOn)
			if isOn then
				self:_dealToggleClick(index)
			end
		end, nil)
	end

	GlobalDispatcher:addEventListener(EventType.EQUIP_SELECT_CELL, self._handleEquipSelect, self)
	GlobalDispatcher:addEventListener(EventType.EQUIP_MODEL_DRAG_PART, self._onDragPartChanged, self)
	GlobalDispatcher:addEventListener(EventType.EQUIP_WEARING_SUIT_CLICK_EVENT, self._onClickEquipSuitItem, self)
	GlobalDispatcher:addEventListener(EventType.EQUIP_WEARING_SORT_ITEM_CLICK, self._onClickSortItem, self)
	GlobalDispatcher:addEventListener(EventType.EQUIP_WEARED_SUCECESS, self._onEquipWeared, self)
	GlobalDispatcher:addEventListener(EventType.EQUIP_TAKE_OFF_SUCECESS, self._onEquipTakeOff, self)
	GlobalDispatcher:addEventListener(EventType.EQUIP_INFO_REFRESH, self._onEquipInfoChanged, self)
	GlobalDispatcher:addEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self._onEquipInfoChanged, self)
end

function M:unbindEvents()
	self._btnSuit:RemoveClickListener()
	self._btnSort:RemoveClickListener()
	self._btnCompare:RemoveClickListener()
	self._btnHideCompare:RemoveClickListener()
	self._btnMask:RemoveClickListener()
	self._equipDetailComp:unbindEvents()
	self._equipDetailCompSelf:unbindEvents()
	self._btnEmptyClick:RemoveClickListener()

	for _, toggleComp in ipairs(self._tabBarList) do
		toggleComp:RemoveListener()
	end

	GlobalDispatcher:removeEventListener(EventType.EQUIP_SELECT_CELL, self._handleEquipSelect, self)
	GlobalDispatcher:removeEventListener(EventType.EQUIP_MODEL_DRAG_PART, self._onDragPartChanged, self)
	GlobalDispatcher:removeEventListener(EventType.EQUIP_WEARING_SUIT_CLICK_EVENT, self._onClickEquipSuitItem, self)
	GlobalDispatcher:removeEventListener(EventType.EQUIP_WEARING_SORT_ITEM_CLICK, self._onClickSortItem, self)
	GlobalDispatcher:removeEventListener(EventType.EQUIP_WEARED_SUCECESS, self._onEquipWeared, self)
	GlobalDispatcher:removeEventListener(EventType.EQUIP_TAKE_OFF_SUCECESS, self._onEquipTakeOff, self)
	GlobalDispatcher:removeEventListener(EventType.EQUIP_INFO_REFRESH, self._onEquipInfoChanged, self)
	GlobalDispatcher:removeEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self._onEquipInfoChanged, self)
end

function M:onEnter()
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Backpack)
	self:setRetPoint()

	self._heroData = EquipController.instance:getOperateHero()

	self._equipModelComponent:onEnter()

	local index = EquipController.instance:getEquipSelectIndex()

	if self._tabBarList[index].IsOn then
		self:_dealToggleClick(index)
	else
		self._tabBarList[index].IsOn = true
	end

	self._equipModelComponent:setHeroData(self._heroData)
	self:_refreshSuit()
	self:_refreshSort()
	self:_refreshATKInfo()
	goutil.setActive(self._suitUpGo, false)
	goutil.setActive(self._suitDownGo, true)
end

function M:onExit()
	self._equipModelComponent:onExit()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Backpack)

	self._lastIndex = nil
end

function M:_refreshEquipList(autoSelect, isPlayAni)
	local sortFun = BackpackUtil.getSortFun(self._sortMo)

	self._equipMoList = EquipController.instance:getFilterEquipMoList(sortFun, autoSelect)

	self._equipScrollList:SetListItemCount(#self._equipMoList)
	self:_refreshEquipListShownItems(isPlayAni)
	self:_refreshEmpty()

	if autoSelect then
		self:_refreshCurSelectMo()
	end
end

function M:_refreshEmpty()
	self._isEmpty = #self._equipMoList == 0

	goutil.setActive(self._equipEmptyGo, self._isEmpty)
	goutil.setActive(self._btnListGo, not self._isEmpty)
	self._equipDetailComp:setEmpty(self._isEmpty)

	self._suitCanvas.alpha = self._isEmpty and 0.2 or 1
	self._sortCanvas.alpha = self._isEmpty and 0.2 or 1
end

function M:_refreshCurSelectMo()
	if self._isEmpty then
		return
	end

	local equipMo = EquipController.instance:getSelectedEquipMo()

	self._equipDetailComp:setHeroAndPart(self._heroData, EquipEnum.PartTypeList[self._lastIndex])
	self._equipDetailComp:setEquipData(equipMo)

	if self._curPartWeared then
		if self._curPartWeared:getUuid() == equipMo:getUuid() then
			goutil.setActive(self._goEquipted, true)
			goutil.setActive(self._btnCompare.gameObject, false)
			goutil.setActive(self._btnHideCompare.gameObject, false)

			if self._equipDetailCompSelf:isVisible() then
				self._equipDetailCompSelf:setVisible(false)
				goutil.setActive(self._compareMask, false)
			end
		else
			local isComparing = self._equipDetailCompSelf:isVisible()

			goutil.setActive(self._goEquipted, false)
			goutil.setActive(self._btnCompare.gameObject, not isComparing)
			goutil.setActive(self._btnHideCompare.gameObject, isComparing)
		end
	else
		goutil.setActive(self._goEquipted, false)
		goutil.setActive(self._btnCompare.gameObject, false)
		goutil.setActive(self._btnHideCompare.gameObject, false)
	end
end

function M:_refreshWearedEquip()
	local heroEquips = self._heroData:getHeroEquipData()

	self._curPartWeared = heroEquips:getEquipByPart(EquipEnum.PartTypeList[self._lastIndex])

	self._equipDetailCompSelf:setEquipData(self._curPartWeared)
	self._equipDetailCompSelf:setVisible(false)
	goutil.setActive(self._compareMask, false)
end

function M:_refreshSort()
	if self._sortMo then
		self._sortText.text = self._sortMo:getName()

		local isUp = self._sortMo.isUp

		goutil.setActive(self._sortUpGo, isUp)
		goutil.setActive(self._sortDownGo, not isUp)

		for sortType, item in ipairs(self._sortItems) do
			item:setSelect(sortType == self._sortMo.sortType)
		end
	end
end

function M:_refreshSuit()
	local suitMo = self._suitMo

	if suitMo then
		self._curSuitId = suitMo:getId()
		self._suitText.text = suitMo:getName()
	else
		self._curSuitId = CommEnum.CommonAll
		self._suitText.text = self._suitTitleName
	end

	goutil.setActive(self._suitListGo, false)
end

function M:destroyUI()
	self._equipModelComponent:onDestroy()
end

function M:_onClickSuitBtn()
	if self._isEmpty then
		return
	end

	local sortActive = self._sortItemsParent.activeSelf

	if sortActive then
		goutil.setActive(self._sortItemsParent, false)
		goutil.setActive(self._btnMask.gameObject, false)

		return
	end

	local active = not self._isEmpty and not self._suitListGo.activeSelf

	goutil.setActive(self._suitListGo, active)
	goutil.setActive(self._btnMask.gameObject, active)
	goutil.setActive(self._suitUpGo, active)
	goutil.setActive(self._suitDownGo, not active)

	if active then
		self._suitDatas = EquipController.instance:getSuitList()

		self._suitList:SetListItemCount(#self._suitDatas)
		self._suitList:RefreshAllShownItem()

		if self._suitSelectIndex then
			self._suitList:MoveToItemIndex(self._suitSelectIndex, 46)
		end
	end
end

function M:ajustSuitListHight()
	local height = RectTransformUtils.GetHeight(self._suitItemTrans)

	RectTransformUtils.SetHeight(self._suitTrans, height + 30)
end

function M:_onClickSortBtn()
	if self._isEmpty then
		return
	end

	local suitActive = self._suitListGo.activeSelf

	if suitActive then
		goutil.setActive(self._suitListGo, false)
		goutil.setActive(self._btnMask.gameObject, false)

		return
	end

	local active = not self._sortItemsParent.activeSelf

	goutil.setActive(self._sortItemsParent, active)
	goutil.setActive(self._btnMask.gameObject, active)
end

function M:_onClickMaskBtn()
	goutil.setActive(self._btnMask.gameObject, false)
	goutil.setActive(self._suitListGo, false)
	goutil.setActive(self._sortItemsParent, false)
end

function M:_onClickCompareBtn()
	goutil.setActive(self._btnCompare.gameObject, false)
	goutil.setActive(self._btnHideCompare.gameObject, true)
	goutil.setActive(self._compareMask, true)
	self._equipDetailCompSelf:setVisible(true)
	self._equipDetailCompSelf:checkSuitAni()
end

function M:_onClickHideCompareBtn()
	goutil.setActive(self._btnCompare.gameObject, true)
	goutil.setActive(self._btnHideCompare.gameObject, false)
	goutil.setActive(self._compareMask, false)
	self._equipDetailCompSelf:setVisible(false)
end

function M:_dealToggleClick(index)
	if self._lastIndex and self._lastIndex == index then
		return
	end

	if self._lastIndex then
		self:playGuiAni("open" .. yAniName[self._lastIndex] .. "-" .. yAniName[index])
	end

	self._lastIndex = index

	EquipController.instance:setEquipFilterCfgPartType(EquipEnum.PartTypeList[index])

	if not EquipController.instance:isPartEquipHasSuitId(EquipEnum.PartTypeList[index], self._curSuitId) then
		self._curSuitId = CommEnum.CommonAll
		self._suitText.text = self._suitTitleName

		EquipController.instance:setEquipFilterCfgSuit(self._curSuitId)
	end

	self:_onPartChanged()
end

function M:_onClickSortItem(e, BackpackItemSortData)
	if not BackpackItemSortData then
		printError("排序数据为空，请检查")

		return
	end

	self._sortMo = BackpackItemSortData

	table.sort(self._equipMoList, BackpackUtil.getSortFun(self._sortMo))
	self:_refreshSort()
	self:_refreshEquipListShownItems(true)
end

function M:_onClickEquipSuitItem(e, suitMo)
	if not suitMo then
		printError("套装筛选数据为空，请检查")

		return
	end

	self._suitMo = suitMo

	EquipController.instance:setEquipFilterCfgSuit(suitMo:getId())
	self:_refreshSuit()

	self._scrollRect.verticalNormalizedPosition = 1

	self:_refreshEquipList(true, true)
end

function M:_onClickEmpty()
	local jumpId = 12000001

	if not SystemJumpController.instance:canJump(jumpId, true) then
		return
	end

	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_EVENT, jumpId)
end

function M:_onEquipInfoChanged(e)
	self:_refreshEquipList()
	self:_refreshCurSelectMo()
	self:_refreshATKInfo()
end

function M:_onDragPartChanged(e, isLeft)
	local oldPart = self._lastIndex

	if isLeft then
		if oldPart > 1 then
			oldPart = oldPart - 1
		else
			oldPart = 3
		end
	elseif oldPart < 3 then
		oldPart = oldPart + 1
	else
		oldPart = 1
	end

	self._tabBarGroup:TryActiveChildOn(self._tabBarList[oldPart], true)
end

function M:_onPartChanged()
	self._scrollRect.verticalNormalizedPosition = 1

	self:_refreshEquipList(true, true)
	self:_refreshWearedEquip()
	self:_refreshCurSelectMo()
	self._equipModelComponent:setCurOperatePos(self._lastIndex)
end

function M:_onEquipWeared(e)
	self:_refreshEquipList()
	self:_refreshWearedEquip()
	self:_refreshCurSelectMo()
	self._equipModelComponent:refreshView()
	self._equipDetailComp:checkSuitAniOnWeard()
	self:_refreshATKInfo()
	self:_refEquipPartRedPoint()

	local suitId = self._heroData:getHeroEquipData():getAvailableSuitId()

	if suitId then
		ToolTipsMgr.showCharacterTopToast(lang("tip_equip_suit_active"), CommEnum.CharacterTopToastIcon.Succ, 1)
	end
end

function M:_onEquipTakeOff(e)
	self:_refreshEquipList()
	self:_refreshWearedEquip()
	self:_refreshCurSelectMo()
	self._equipModelComponent:refreshView()
	self:_refreshATKInfo()
	self:_refEquipPartRedPoint()
end

function M:_handleEquipSelect()
	self:_refreshEquipListShownItems()
	self:_refreshCurSelectMo()
	self._equipModelComponent:refreshOperatePos()
end

function M:_onEquipCellUpdate(curIndex, row, column)
	curIndex = curIndex + 1

	local item = self._equipScrollList:NewListViewItem("backpack_item")

	Astral.TransformUtil.SetLocalScale(item.gameObject.transform, 1.09, 1.09, 1)

	local view = Astral.LuaComponentContainer.Add(item.gameObject, CharacterEquipItemCell)
	local mo = self._equipMoList[curIndex]

	view:updateData(mo)
	view:refreshEquipDetailRed()

	local selectedMo = EquipController.instance:getSelectedEquipMo()
	local isSelected = selectedMo and mo:getUuid() == selectedMo:getUuid()

	view:onSelect(isSelected)

	if self._needPlayItemCellOpenAni and curIndex <= self._needPlayItemAniMaxIndex then
		self._itemShowerCache[curIndex] = view

		view:getComponent("animation"):setAlpha(0)
	else
		view:getComponent("animation"):setAlpha(1)
	end

	return item
end

function M:_onSuitCellUpdate(curIndex)
	local data = self._suitDatas[curIndex + 1]
	local item = self._suitList:NewListViewItem("Item1")
	local shower = Astral.LuaComponentContainer.Add(item.gameObject, EquipSuitFilterItemNew)

	shower:updateData(data)
	shower:setClickEvent(EventType.EQUIP_WEARING_SUIT_CLICK_EVENT)

	local isSelected = data:getId() == self._curSuitId

	shower:setSelect(isSelected)

	if isSelected then
		self._suitSelectIndex = curIndex + 1
	end

	return item
end

function M:playGuiAni(name)
	self._guiAnimation:StopTimelineAni()

	if not string.nilorempty(name) then
		self._guiAnimation:PlayAniByName(name)
	end
end

function M:setRetPoint()
	for index = 1, EquipEnum.MaxPartType do
		RedDotModel.instance:createDotView({
			dotNode = self._redGo[index],
			keyList = {
				string.format("%s_%s", RedDotType.ERedDotKey.EQUIPMENT, index)
			}
		})
	end
end

function M:_refEquipPartRedPoint()
	if self._heroData then
		local heroEquips = self._heroData:getHeroEquipData()

		if heroEquips then
			heroEquips:checkForRedPoint()
		end
	end
end

function M:_playChangeEffect()
	if not EquipController.instance:getSelectedEquipMo() then
		return
	end

	RectTransformUtils.SetAnchoredPosition(self._changeParticle.transform, xEffexPos[self._lastIndex], yEffexPos[self._lastIndex])
	AnimationUtils.UIParticlePlay(self._changeParticle)
end

function M:_refreshATKInfo()
	local viewPageMo = HeroDepotModel.instance:getViewPageMo()
	local heroData = viewPageMo and viewPageMo.hero or false

	self._roleCombatCell:updateHeroData(heroData)
end

function M:_refreshEquipListShownItems(playAni)
	for _, tweener in ipairs(self._cacheTweenLst or {}) do
		if tweener then
			tweener:Kill(false)
		end
	end

	self._needPlayItemCellOpenAni = playAni
	self._itemShowerCache = {}
	self._cacheTweenLst = {}

	EquipController.instance:setCurEquipFirst(self._equipMoList, self._lastIndex)
	self._equipScrollList:RefreshAllShownItem()

	if playAni then
		local maxDelay = 0.1

		self._equipScrollRect.enabled = false

		for index, shower in ipairs(self._itemShowerCache or {}) do
			local delay = index * 0.05

			delay = delay > 1 and 1 or delay
			maxDelay = maxDelay < delay and delay or maxDelay

			local tweenDelay = DoTweenUtil.DelayedCall(delay, function()
				shower:getComponent("animation"):setAlpha(1)
				shower:getComponent("animation"):playOpenAni()
			end)

			table.insert(self._cacheTweenLst, tweenDelay)
		end

		self._itemShowerCache = nil
		self._needPlayItemCellOpenAni = false

		table.insert(self._cacheTweenLst, DoTweenUtil.DelayedCall(maxDelay, function()
			self._equipScrollRect.enabled = true
		end))
	else
		for index, shower in ipairs(self._itemShowerCache or {}) do
			shower:getComponent("animation"):setAlpha(1)
		end

		self._cacheTweenLst = nil
		self._itemShowerCache = nil
		self._needPlayItemCellOpenAni = false
		self._equipScrollRect.enabled = true
	end
end

return M
