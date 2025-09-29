-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/EquipIntensifyView.lua

module("logic.extensions.charactersystem.view.equip.EquipIntensifyView", package.seeall)

local M = class("EquipIntensifyView", ViewComponent)
local kAttributeMaxNum = 4
local coinId = CommEnum.CurrencyCodeEnum.LzbCode

function M:buildUI()
	self._goGridList = self:getGo("equip_function_view_copy_687383730")

	local itemScroll = self:getGo("equip_function_view_copy_1450231555")

	self._scrollRect = itemScroll:GetComponent(UIComponentType.ScrollRect)
	self._itemGridList = LoopGridViewHelper.New(itemScroll)

	self._itemGridList:InitGridView(0, self._onCellUpdate, self)

	local goScroll = self:getGo("equip_function_view_copy_687383730")
	local scrollWidth = goutil.getWidth(goScroll.transform)

	if scrollWidth < 705 then
		self._itemGridList:SetGridFixedGroupCount(SuperScrollView.GridFixedType.ColumnCountFixed, 4)
	elseif scrollWidth > 846 then
		self._itemGridList:SetGridFixedGroupCount(SuperScrollView.GridFixedType.ColumnCountFixed, 6)
	end

	self._emptyNode = self:getGo("equip_function_view_copy_796131512")
	self._btnEmpty = Astral.ButtonAdapter.Get(goutil.findChild(self._emptyNode, "empty_unit/btnGain"))
	self._btnIntensify = self:getBtn("20&btn_middle_-31477526")
	self._imgEquipIcon = self:getImage("equip_function_view_-1722134145")
	self._goModel = self:getGo("equip_function_view_1690503805")

	local imageGo = self:getGo("equip_function_view_-1761726206")

	self._equipModelComponent = Astral.LuaComponentContainer.Add(imageGo, EquipModelComponent)
	self._btnQuickAdd = self:getBtn("19&com_btn_2_-31477526")
	self._btnFilter = self:getBtn("18&common_filter_1257874372")
	self._btnFilterMask = self:getBtn("18&common_filter_-2087941579")
	self._txtBtnFilter = self:getText("18&common_filter_1277082477")
	self._goFilterParent = self:getGo("18&common_filter_1899392441")
	self._rectFilter = self._goFilterParent:GetComponent(UIComponentType.RectTransform)
	self._globalTouchTrigger = Astral.UIGlobalTouchTrigger.Get(self._goFilterParent)
	self._goUp = self:getGo("18&common_filter_-1610409428")
	self._goDown = self:getGo("18&common_filter_47580719")

	goutil.setActive(self._goUp, false)
	goutil.setActive(self._goDown, true)

	self._quickSelectItemViews = {}

	for key, name in pairs(EquipEnum.QualityEnum) do
		local quickItem = goutil.findChild(self._goFilterParent, "Content/Item" .. key)
		local itemView = Astral.LuaComponentContainer.Add(quickItem, EquipQuickSelectItem)

		self._quickSelectItemViews[key] = itemView
	end

	self._txtLevel = self:getText("equip_function_view_-2142308314")
	self._txtLevelAdd = self:getText("equip_function_view_1240373595")
	self._goMaxExp = self:getGo("equip_function_view_387092128")
	self._txtExpAdd = self:getText("equip_function_view_1781231126")
	self._txtQuickBtn = self:getText("19&com_btn_2_1478048452")
	self._txtNum = self:getText("equip_function_view_-1315953214")
	self._imgExpBar = self:getImage("equip_function_view_-351809046")
	self._imgExpAdd = self:getImage("equip_function_view_2047051969")
	self.go_com_price = self:getGo("25&com_price_1317146225")
	self._costCell = PrefabReferenceUtil.createCurrencyCostLuaCell(self.go_com_price)
	self._goMaxText = self:getGo("equip_function_view_-496795958")
	self._goBottom = self:getGo("equip_function_view_1161104297")
	self._attributeRootList = {}
	self._attributeTxtList = {}
	self._attrNumTxtList = {}
	self._attrNumTxt2List = {}
	self._goAttr = goutil.findChild(self.mainGO, "intensify_view/strengthenTipsPos/node/attributeList")

	for i = 1, kAttributeMaxNum do
		local attributeRoot = goutil.findChild(self._goAttr, "attribute_" .. i)
		local attributeTxt = goutil.findChildTextComponent(attributeRoot, "txtAttribute")
		local attrNumTxt = goutil.findChildTextComponent(attributeRoot, "txtNum")
		local attrNumTxt2 = goutil.findChildTextComponent(attributeRoot, "txtNum2")

		table.insert(self._attributeRootList, attributeRoot)
		table.insert(self._attributeTxtList, attributeTxt)
		table.insert(self._attrNumTxtList, attrNumTxt)
		table.insert(self._attrNumTxt2List, attrNumTxt2)
	end

	self._goDiceLayout = self:getGo("equip_function_view_-765885123")
	self._goDice = goutil.findChild(self._goDiceLayout, "d6_attribute_item1")

	goutil.setActive(self._goDice, false)

	self._diceItemList = {}
	self._goFilterSelected = self:getGo("equip_function_view_-1931124853")
	self._txtFilterName = self:getText("equip_function_view_-320515253")
	self._goSelectDiceList = self:getGo("equip_function_view_1480027413")
	self._goDiceItem = goutil.findChild(self._goSelectDiceList, "diceItem")

	goutil.setActive(self._goDiceItem, false)

	self._goItemTips = self:getGo("equip_function_view_1908941258")
	self._goMask = self:getGo("equip_function_view_117771831")
	self._txtSelectTips = self:getText("equip_function_view_396598760")
	self._txtSelectTips.text = lang("tip_equip_intensify_select_s")
	self._txtQuickBtn.text = lang("tip_equip_btn_quick")
end

function M:bindEvents()
	self._btnEmpty:AddClickListener(self._onClickEmpty, self)
	self._btnFilter:AddClickListener(self._onClickFilter, self)
	self._btnFilterMask:AddClickListener(self._onClickFilterMask, self)
	self._btnQuickAdd:AddClickListener(self._onClickQuickAdd, self)
	self._btnIntensify:AddClickListener(self._onClickIntensify, self)
	self._globalTouchTrigger:AddIgnoreTargetListener(self._onGlobalClick, self)
	GlobalDispatcher:addEventListener(EventType.EQUIP_INTESIFY_DETAIL_UPDATE, self._handleUpdateView, self)
end

function M:unbindEvents()
	self._btnEmpty:RemoveClickListener()
	self._btnFilter:RemoveClickListener()
	self._btnFilterMask:RemoveClickListener()
	self._btnQuickAdd:RemoveClickListener()
	self._btnIntensify:RemoveClickListener()
	self._globalTouchTrigger:RemoveIgnoreTargetListener()
	GlobalDispatcher:removeEventListener(EventType.EQUIP_INTESIFY_DETAIL_UPDATE, self._handleUpdateView, self)
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.EQUIP_WEARING_FILTER_CLICK_EVENT, self._handleEquipFilter, self)
		GlobalDispatcher:addEventListener(EventType.EQUIP_QUICK_SELECT_CLICK, self._handleQuickSelect, self)
		GlobalDispatcher:addEventListener(EventType.EQUIP_WEARING_SORT_ITEM_CLICK, self._handleClickSortItem, self)
		GlobalDispatcher:addEventListener(EventType.EQUIP_INFO_REFRESH, self._handleIntensifySuccess, self)
		GlobalDispatcher:addEventListener(EventType.EQUIP_ITEM_TIPS_STATE, self._handleTipsViewStateChange, self)
		GlobalDispatcher:addEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self._handleEquipInfoChanged, self)
		GlobalDispatcher:addEventListener(EventType.EQUIP_REVEAL_DICE_ClOSE, self._handleRevealDiceViewClose, self)
	else
		GlobalDispatcher:removeEventListener(EventType.EQUIP_WEARING_FILTER_CLICK_EVENT, self._handleEquipFilter, self)
		GlobalDispatcher:removeEventListener(EventType.EQUIP_QUICK_SELECT_CLICK, self._handleQuickSelect, self)
		GlobalDispatcher:removeEventListener(EventType.EQUIP_WEARING_SORT_ITEM_CLICK, self._handleClickSortItem, self)
		GlobalDispatcher:removeEventListener(EventType.EQUIP_INFO_REFRESH, self._handleIntensifySuccess, self)
		GlobalDispatcher:removeEventListener(EventType.EQUIP_ITEM_TIPS_STATE, self._handleTipsViewStateChange, self)
		GlobalDispatcher:removeEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self._handleEquipInfoChanged, self)
		GlobalDispatcher:removeEventListener(EventType.EQUIP_REVEAL_DICE_ClOSE, self._handleRevealDiceViewClose, self)
	end
end

function M:onEnter()
	self:_setEvent(true)
	self._equipModelComponent:onEnter()

	self._sortMo = self._viewPresentor:getSortMo()

	EquipIntensifyController.instance:setSortFun(self._sortMo)
	goutil.setActive(self._goMask, false)
	self._costCell:updateData(coinId)
end

function M:onExit()
	self:_setEvent(false)
	self._itemGridList:ClearCells()
	self._equipModelComponent:onExit()

	if self._tweener then
		self._tweener:Kill(false)
	end
end

function M:destroyUI()
	self._attributeRootList = nil
	self._attributeTxtList = nil
	self._attrNumTxtList = nil

	self._itemGridList:Dispose()
	self._equipModelComponent:OnDestroy()
end

function M:_handleUpdateView(e, equipmentData, tabIndex)
	if tabIndex ~= EquipEnum.IntensifyViewPage.Intensify then
		return
	end

	self._equipmentData = equipmentData

	self:_refreshData()
	self:_refreshView()
end

function M:_handleEquipFilter(e, equipSuitData, dices)
	self._filterEquipSuitData = equipSuitData

	local filterSuitId = equipSuitData and equipSuitData:getId() or CommEnum.CommonAll

	self._filterEquipDices = dices or {}

	EquipIntensifyController.instance:setEquipFilterCfgSuit(filterSuitId)
	EquipIntensifyController.instance:setEquipFilterCfgDices(self._filterEquipDices)
	self:_refreshData()
	self:_refreshView()
end

function M:_handleClickSortItem(e, BackpackItemSortData)
	self._sortMo = BackpackItemSortData

	EquipIntensifyController.instance:setSortFun(self._sortMo)
	self:_refreshData()
	self:_refreshView()
end

function M:_handleQuickSelect(e, quality, isSelect)
	self._quickSelectQuality = isSelect and quality or 0

	self:_setQuickSelectQuality(self._quickSelectQuality)

	for quality, qualityName in pairs(EquipEnum.QualityEnum) do
		local item = self._quickSelectItemViews[quality]

		item:setStatus(self._quickSelectQuality == quality)
	end

	self:_refreshBtnFilterLab()
end

function M:_handleEquipInfoChanged(e)
	self:_refreshData(true)
	self:_refreshView()
end

function M:_handleIntensifySuccess(e)
	if not self:_tryOpenDiceRevealView() then
		self:_refreshData()
		self:_playIntensifyAnimation()
	end
end

function M:_playIntensifyAnimation()
	if not self._lastEquipmentData then
		self:_refreshAfterPlayAnimation()

		return
	end

	local curTotalEXp = self._equipmentData:getCurTotalExp()
	local lastTotalEXp = self._lastEquipmentData:getCurTotalExp()
	local totalAddEXp = curTotalEXp - lastTotalEXp

	if totalAddEXp <= 0 then
		self:_refreshAfterPlayAnimation()

		return
	end

	local attrList = self._equipmentData:getAttrList()
	local oldAttrList = self._lastEquipmentData:getAttrList()
	local startValue = {}
	local addValue = {}
	local startLevel = self._lastEquipmentData:getLevel()

	self._txtLevel.text = startLevel

	goutil.setActive(self._txtLevelAdd.gameObject, false)
	goutil.setActive(self._txtExpAdd.gameObject, false)
	goutil.setActive(self._goMask, true)

	local expNextLv = self._lastEquipmentData:getLevelUpNeedExp(startLevel)
	local startExp = self._lastEquipmentData:getCurrentExp()

	self._imgExpBar.fillAmount = startExp / expNextLv
	self._imgExpAdd.fillAmount = 0
	self._curLevel = startLevel

	for i = 1, kAttributeMaxNum do
		if i <= #attrList then
			startValue[i] = oldAttrList[i]:getValue()
			addValue[i] = attrList[i]:getValue() - oldAttrList[i]:getValue()
			self._attrNumTxtList[i].text = startValue[i]

			goutil.setActive(self._attrNumTxt2List[i].gameObject, false)
		end
	end

	if self._tweener then
		self._tweener:Kill(false)
	end

	self._tweener = DoTweenUtil.To(0, 1, 1, function(value)
		for i = 1, kAttributeMaxNum do
			if i <= #attrList then
				self._attrNumTxtList[i].text = math.floor(startValue[i] + addValue[i] * value)
			end
		end

		local addEXp = totalAddEXp * value
		local curLevel = self._lastEquipmentData:getUpgradeLevel(addEXp)

		if self._curLevel ~= curLevel then
			self._txtLevel.text = curLevel
			expNextLv = self._lastEquipmentData:getLevelUpNeedExp(curLevel)
			startExp = startExp - self._lastEquipmentData:getLevelUpNeedExp(self._curLevel)
			self._curLevel = curLevel
		end

		local curExp = addEXp + startExp

		if expNextLv == 0 then
			self._imgExpBar.fillAmount = 1
		else
			self._imgExpBar.fillAmount = curExp / expNextLv
		end
	end)

	self._tweener:SetTarget(self._goAttr)
	self._tweener:OnComplete(function()
		self:_refreshAfterPlayAnimation()
	end)
end

function M:_handleRevealDiceViewClose(e)
	self:_refreshData()
	self:_playIntensifyAnimation()
end

function M:_refreshAfterPlayAnimation()
	self:_refreshData()
	self:_refreshView()

	self._lastEquipmentData = nil

	goutil.setActive(self._goMask, false)
end

function M:_handleTipsViewStateChange(e, isEnter)
	local value = isEnter and 0 or 1

	for i = 1, #self._diceItemList do
		self._diceItemList[i]:setAlpha(value)
	end
end

function M:_refreshBtnFilterLab()
	local str = ""
	local key = EquipEnum.QualityEnum[self._quickSelectQuality]

	if key then
		local qualityName = lang(key)

		str = langF("tip_euqip_intensify_quick_select", qualityName)
	end

	self._isUnselectFilter = str == ""
	self._txtBtnFilter.text = self._isUnselectFilter and lang("tip_recyccle_no_name") or str
end

function M:_refreshData(isOnlyUpdateItems)
	self._itemList = EquipIntensifyController.instance:getCanIntensifyMaterials(self._equipmentData:getUuid())

	if not isOnlyUpdateItems then
		self._itemUseData = {}

		for i = 1, #self._itemList do
			local item = self._itemList[i]
			local id = item:getUuid()
			local isMultiple = EquipIntensifyController.instance:isMultipleItem(item)
			local count = isMultiple and ItemModel.instance:getItemCountByItemId(item:getItemId()) or 1

			self._itemUseData[id] = {
				isManualSelect = false,
				hasAddCount = 0,
				itemCount = count,
				isMultiple = isMultiple,
				itemData = item
			}
		end

		self._quickSelectQuality = self:_getQuickSelectQuality()
	else
		for i = 1, #self._itemList do
			local id = self._itemList[i]:getUuid()
			local userData = self._itemUseData[id]

			if userData then
				userData.hasAddCount = userData.itemData:getIsLock() and 0 or userData.hasAddCount
			end
		end
	end
end

function M:_refreshView(notForceRefresh)
	self._addExp = self:_getAddTotalExp()
	self._targetLevel = self._equipmentData:getUpgradeLevel(self._addExp)
	self._maxLv = self._equipmentData:getMaxLevel()
	self._isMaxLv = self._equipmentData:isMaxLv()

	self:_refreshExp()
	self:_refreshAttr()
	self:_refreshDice()

	if not notForceRefresh then
		self:_refreshQuickSelect()
		self:_refreshGridListView()
		self:_refreshModelView()
		self:_refreshFilter()
	end

	self:_onClickFilterMask()
	self:_refreshSelectTips()
end

function M:_refreshFilter()
	self._filterEquipDices = self._filterEquipDices or {}

	local lenght = TableUtil.getLen(self._filterEquipDices)

	goutil.setActive(self._goFilterSelected, false)

	local show = false

	if self._filterEquipSuitData or lenght > 0 then
		show = true
	end

	goutil.setActive(self._goFilterSelected, show)

	if show then
		goutil.setActive(self._txtFilterName.gameObject, self._filterEquipSuitData ~= nil)

		self._txtFilterName.text = self._filterEquipSuitData and self._filterEquipSuitData:getName() or ""

		if lenght > 0 and self._filterEquipSuitData then
			self._txtFilterName.text = self._txtFilterName.text .. ","
		end

		self:_updataSelectDiceItems()
	end
end

function M:_updataSelectDiceItems()
	if not self._filterDiceItems then
		self._filterDiceItems = {}
	end

	local i = 1

	for k, v in pairs(self._filterEquipDices) do
		if i > 9 then
			break
		end

		if not self._filterDiceItems[i] then
			local go = goutil.clone(self._goDiceItem)

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

function M:_refreshGridListView()
	goutil.setActive(self._goGridList, not self._isMaxLv)

	if not self._isMaxLv then
		local showItemsCount = #self._itemList

		goutil.setActive(self._emptyNode, showItemsCount <= 0)
		self._itemGridList:SetListItemCount(showItemsCount)
		self._itemGridList:RefreshAllShownItem()
	end
end

function M:_refreshModelView()
	goutil.setActive(self._goModel, self._isMaxLv)

	if not self._isMaxLv then
		return
	end

	self._equipModelComponent:setEquipData(self._equipmentData)
	self._equipModelComponent:setModelPos(EquipUtil.EquipIntensifyModelPos)
	self._equipModelComponent:refreshView()
end

function M:_refreshQuickSelect()
	if not self._quickSelectQuality then
		self._quickSelectQuality = self:_getQuickSelectQuality()
	end

	for quality, qualityName in pairs(EquipEnum.QualityEnum) do
		local item = self._quickSelectItemViews[quality]
		local name = langF("tip_euqip_intensify_quick_select", lang(qualityName))

		item:setData(quality, name)
		item:setStatus(self._quickSelectQuality == quality)
	end

	self:_refreshBtnFilterLab()
end

function M:_refreshExp()
	local curLevel = self._equipmentData:getLevel()

	self._txtLevel.text = curLevel

	local lvUp = self._targetLevel - curLevel

	self._txtLevelAdd.text = lvUp

	goutil.setActive(self._txtLevelAdd.gameObject, lvUp > 0)

	self._txtExpAdd.text = self._addExp > 0 and string.format("+%s", self._addExp) or ""
	self._goldNeed = EquipIntensifyController.instance:getCurrencyPerExp() * self._addExp
	self._goldHas = ItemModel.instance:getItemCountByItemId(coinId)

	local color = self._goldNeed > self._goldHas and "FF5C63" or "E4E4E4"

	self._costCell:setCostCount(self._goldNeed, color)

	local expNextLv = self._equipmentData:getLevelUpNeedExp(curLevel)
	local expEquip = self._equipmentData:getCurrentExp()

	if curLevel == self._maxLv then
		self._txtNum.text = "Max"
		self._imgExpBar.fillAmount = 1
	else
		self._txtNum.text = string.format("%s/%s", expEquip, expNextLv)
		self._imgExpBar.fillAmount = expEquip / expNextLv
	end

	if curLevel < self._targetLevel then
		self._imgExpAdd.fillAmount = 1
	else
		self._imgExpAdd.fillAmount = (expEquip + self._addExp) / expNextLv
	end

	IconLoader.setSprite(self._imgEquipIcon, IconType.EquipIcon, self._equipmentData:getIcon())
	goutil.setActive(self._goMaxText, self._isMaxLv)
	goutil.setActive(self._goBottom, not self._isMaxLv)
	goutil.setActive(self._goMaxExp, self._isMaxLv)
end

function M:_refreshSelectTips()
	goutil.setActive(self._txtSelectTips.gameObject, false)

	if self._goFilterParent.activeSelf then
		return
	end

	for k, v in pairs(self._itemUseData) do
		if v.hasAddCount > 0 and not v.isMultiple then
			local isNotS = v.itemData:getQuality() ~= GameEnum.QualityEnum.S
			local hasIntensify = v.itemData:getLevel() > 1

			if isNotS and hasIntensify then
				goutil.setActive(self._txtSelectTips.gameObject, true)

				return
			end
		end
	end
end

function M:_refreshAttr()
	local attrList = self._equipmentData:getAttrList()
	local attrAddListCur = self._equipmentData:getTargetLevelAttrList(self._equipmentData:getLevel())
	local attrAddListNew = self._equipmentData:getTargetLevelAttrList(self._targetLevel)

	for i = 1, kAttributeMaxNum do
		goutil.setActive(self._attributeRootList[i], i <= #attrList)

		if i <= #attrList then
			self._attributeTxtList[i].text = attrList[i]:getName()
			self._attrNumTxtList[i].text = attrList[i]:getValue()

			local attrId = attrList[i]:getAttrId()
			local addValue = attrAddListNew[attrId] - attrAddListCur[attrId]

			if addValue and addValue > 0 then
				self._attrNumTxt2List[i].text = addValue + attrList[i]:getValue()

				goutil.setActive(self._attrNumTxt2List[i].gameObject, true)
			else
				goutil.setActive(self._attrNumTxt2List[i].gameObject, false)
			end
		end
	end
end

function M:_refreshDice()
	local totalNum = self._equipmentData:getExtraDiceAttrNum()

	if self._equipmentData:hasOriginalD6() then
		totalNum = totalNum + 1
	end

	local enhances = {}
	local diceList = self._equipmentData:getAllDiceAttr()
	local unlockLevelList = EquipmentConfig.instance:getConstNumList("DiceAttrUnlockLevels")
	local index = 1

	for i = index, totalNum do
		if not self._diceItemList[i] then
			local d6AttributeItemGo = goutil.clone(self._goDice)

			goutil.addChildToParent(d6AttributeItemGo, self._goDiceLayout)

			local item = Astral.LuaComponentContainer.Add(d6AttributeItemGo, EquipDiceItem)

			self._diceItemList[i] = item
		end

		local diceAttrMO = diceList[i]

		if diceAttrMO then
			self._diceItemList[i]:setData(EquipEnum.DiceStatus.Unlock, diceAttrMO)

			if diceAttrMO:isEnhanced() then
				local enhanceType = diceAttrMO:getEnhanceType()

				if enhances[enhanceType] then
					table.insert(enhances[enhanceType], index)
				else
					enhances[enhanceType] = {
						index
					}
				end
			end
		else
			local unlockLevel = self._equipmentData:hasOriginalD6() and unlockLevelList[i - 1] or unlockLevelList[i]
			local status = unlockLevel <= self._targetLevel and EquipEnum.DiceStatus.CanUnLock or EquipEnum.DiceStatus.Lock

			self._diceItemList[i]:setData(status, diceAttrMO, unlockLevel)
		end

		self._diceItemList[index]:closeEnhanceAni()
		self._diceItemList[index]:setVisible(true)
		self._diceItemList[index]:setAlpha(1)

		index = index + 1
	end

	for _, v in pairs(enhances) do
		local enhanceNum = #v

		if enhanceNum and enhanceNum > 1 then
			for k, itemIndex in ipairs(v) do
				local itemView = self._diceItemList[itemIndex]

				itemView:playEnhanceAni()
			end
		end
	end

	for i = index, #self._diceItemList do
		self._diceItemList[i]:setVisible(false)
	end

	goutil.setActive(self._diceLineGo, totalNum > 0)
end

function M:_onCellUpdate(curIndex)
	curIndex = curIndex + 1

	local itemData = self._itemList[curIndex]
	local useData = self._itemUseData[itemData:getUuid()]
	local count = useData.itemCount
	local hasAddCount = useData.hasAddCount
	local item = self._itemGridList:NewListViewItem("backpack_item")
	local itemGo = item.gameObject
	local shower = Astral.SimpleLuaComponentContainer.Get(itemGo, EquipIntensifyViewItem)

	if not shower then
		shower = Astral.SimpleLuaComponentContainer.Add(itemGo, EquipIntensifyViewItem)

		shower:getComponent("normal"):setClickListener(self._onItemClick, self)

		local compOperate = shower:getComponent("operate")

		compOperate:onInit()
		compOperate:setAddCallback(self._onItemAdd, self)
		compOperate:setReduceCallback(self._onItemMinus, self)
	end

	shower:updateData(itemData)
	shower:setShowTipsPassEvent(false)
	shower:setShowSelectedEffect(false)

	local isPreset = CharacterPreinstallController.instance:getItemList(itemData:getUuid())

	shower:getComponent("preset"):setVisible(isPreset)
	shower:getComponent("num"):setNumBgNodeVisible(false)
	shower:getComponent("num"):setCountText(count > 0 and count or tostring(count))
	shower:setIsHideGetWay(true)
	shower:getComponent("animation"):setAlpha(count > 0 and hasAddCount <= count and 1 or 0.5)
	self:_updateCellOperate(shower)

	return item
end

function M:_updateCellOperate(cell)
	local itemData = cell:getData()
	local useData = self._itemUseData[itemData:getUuid()]
	local hasAddCount = useData.hasAddCount
	local compOperate = cell:getComponent("operate")

	compOperate:setCount(hasAddCount)
	compOperate:setBtnCutMoreGoVisible(useData.isMultiple)
	compOperate:setCountGoVisible(useData.isMultiple)
	compOperate:setBtnCutGoVisible(not useData.isMultiple)
	compOperate:setImgOperateGoVisible(hasAddCount > 0)
end

function M:_onItemClick(cell)
	local itemData = cell:getData()
	local id = itemData:getUuid()
	local useData = self._itemUseData[id]

	if useData.isMultiple then
		self:_onItemAdd(cell)
	else
		if useData.hasAddCount <= 0 and useData.itemData:getIsLock() then
			FloatWordMgr.instance:show(lang("tip_euqip_intensify_cant_select"))
		end

		local addCount = 1

		if useData.hasAddCount > 0 or useData.itemData:getIsLock() then
			addCount = 0
		end

		if addCount > 0 and self:_checkAdd() then
			useData.hasAddCount = addCount
			useData.isManualSelect = true
		end

		self:_updateCellOperate(cell)
		self:_refreshView(true)
		self:_openTipsView(itemData)
	end
end

function M:_openTipsView(itemData)
	local data = {}

	data.itemData = itemData
	data.isHideLock = false
	data.obj = self._goItemTips

	if ViewMgr.instance:isOpen(ViewName.EquipIntensifyItemTipsView) then
		GlobalDispatcher:dispatchEvent(EventType.EventType.EQUIP_ITEM_TIPS_REFRESH, data)
	else
		ViewMgr.instance:open(ViewName.EquipIntensifyItemTipsView, data)
	end
end

function M:_checkAdd(notShowTips)
	local totalExp = 0

	for k, v in pairs(self._itemUseData) do
		if v.hasAddCount > 0 then
			local exp = EquipIntensifyController.instance:getPerItemExp(v.itemData)

			totalExp = totalExp + v.hasAddCount * exp
		end
	end

	local needExp = self._equipmentData:getMaxLevelUpExp()

	if needExp < totalExp then
		if not notShowTips then
			FloatWordMgr.instance:show(lang("tip_euqip_intensity_reach_max"))
		end

		return false
	end

	return true
end

function M:_getAddTotalExp()
	local totalExp = 0

	for k, v in pairs(self._itemUseData) do
		if v.hasAddCount > 0 then
			local exp = EquipIntensifyController.instance:getPerItemExp(v.itemData)

			totalExp = totalExp + v.hasAddCount * exp
		end
	end

	return totalExp
end

function M:_onItemAdd(cell)
	local itemData = cell:getData()
	local uuid = itemData:getUuid()
	local useData = self._itemUseData[uuid]
	local wantedAdd = useData.hasAddCount + 1
	local enoughToAdd = wantedAdd <= useData.itemCount

	if not useData.isMultiple then
		self:_openTipsView(itemData)
	end

	if not enoughToAdd then
		return
	end

	if not self:_checkAdd() then
		return
	end

	self._itemUseData[uuid].hasAddCount = wantedAdd

	self:_updateCellOperate(cell)
	self:_refreshView(true)
end

function M:_onItemMinus(cell)
	local itemData = cell:getData()
	local uuid = itemData:getUuid()
	local useData = self._itemUseData[uuid]
	local wantedAdd = useData.hasAddCount - 1

	if wantedAdd < 0 then
		return
	end

	self._itemUseData[uuid].hasAddCount = wantedAdd

	self:_updateCellOperate(cell)
	self:_refreshView(true)
end

function M:_onClickEmpty()
	local jumpId = 12000001

	if not SystemJumpController.instance:canJump(jumpId, true) then
		return
	end

	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_EVENT, jumpId)
end

function M:_onClickFilter()
	local show = not self._goFilterParent.activeSelf

	goutil.setActive(self._goFilterParent, show)
	goutil.setActive(self._goUp, show)
	goutil.setActive(self._goDown, not show)
	goutil.setActive(self._btnFilterMask.gameObject, show)
	self:_refreshSelectTips()
end

function M:_onClickFilterMask()
	goutil.setActive(self._goFilterParent, false)
	goutil.setActive(self._btnFilterMask.gameObject, false)
	goutil.setActive(self._goUp, false)
	goutil.setActive(self._goDown, true)
	self:_refreshSelectTips()
end

function M:_getQuickAddTargetLevel()
	local level = self._equipmentData:getLevel()

	if level < 10 then
		return 10
	elseif level < 20 then
		return 20
	else
		return 30
	end

	return level > self._equipmentData:getMaxLevel() and self._equipmentData:getMaxLevel() or level
end

function M:_onClickQuickAdd()
	self:_onClickFilterMask()

	self._perExpCostGold = EquipIntensifyController.instance:getCurrencyPerExp()
	self._goldHas = ItemModel.instance:getItemCountByItemId(coinId)

	local targetLevel = self:_getQuickAddTargetLevel()

	self._needExp = self._equipmentData:getTargetLevelUpExp(targetLevel)
	self._curTotalExp = self:_getCurAddUseExp()

	if self._curTotalExp >= self._needExp then
		FloatWordMgr.instance:show(lang("tip_quick_add_max"))

		return
	elseif self._perExpCostGold * self._curTotalExp > self._goldHas then
		FloatWordMgr.instance:show(lang("tip_quick_add_not_enough"))

		return
	end

	self._hasCanAddItem = false
	self._addNum = 0
	self._lzbEnough = true

	local itemList = EquipIntensifyController.instance:getIntensifyItemList()

	for i = 1, #itemList do
		local useData = self._itemUseData[itemList[i]:getUuid()]
		local exp = EquipIntensifyController.instance:getPerItemExp(useData.itemData)

		for i = useData.hasAddCount + 1, useData.itemCount do
			self._hasCanAddItem = true

			local isSuccessAdd = self:_tryAddExp(exp, useData)

			if not isSuccessAdd then
				break
			end
		end
	end

	local equipList = EquipIntensifyController.instance:getIntensifyEquipList()

	for i = 1, #equipList do
		local useData = self._itemUseData[equipList[i]:getUuid()]
		local quality = useData.itemData:getQuality()
		local exp = EquipIntensifyController.instance:getPerItemExp(useData.itemData)
		local isPreset = CharacterPreinstallController.instance:getItemList(useData.itemData:getUuid())
		local isLock = useData.itemData:getIsLock()

		if quality <= self._quickSelectQuality and not isPreset and not isLock and useData.hasAddCount < 1 then
			self._hasCanAddItem = true

			local isSuccessAdd = self:_tryAddExp(exp, useData)

			if not isSuccessAdd then
				break
			end
		end
	end

	local diceList = EquipIntensifyController.instance:getIntensifyDiceList()

	for i = 1, #diceList do
		local useData = self._itemUseData[diceList[i]:getUuid()]
		local quality = useData.itemData:getQuality()
		local exp = EquipIntensifyController.instance:getPerItemExp(useData.itemData)

		if quality <= self._quickSelectQuality and useData.hasAddCount < 1 then
			local isSuccessAdd = self:_tryAddExp(exp, useData)

			if not isSuccessAdd then
				break
			end
		end
	end

	if not self._hasCanAddItem then
		local tips = self._curTotalExp > 0 and lang("tip_quick_add_all") or lang("tip_quick_add_null")

		FloatWordMgr.instance:show(tips)
	elseif self._addNum <= 0 and not self._lzbEnough then
		FloatWordMgr.instance:show(lang("tip_quick_add_not_enough"))
	elseif self._addNum <= 0 then
		FloatWordMgr.instance:show(lang("tip_quick_add_all"))
	end

	self:_refreshView()
end

function M:_getCurAddUseExp()
	local curAddExp = 0

	for uuid, v in pairs(self._itemUseData) do
		if v.hasAddCount > 0 then
			local exp = EquipIntensifyController.instance:getPerItemExp(v.itemData)

			curAddExp = curAddExp + exp * v.hasAddCount
		end
	end

	return curAddExp
end

function M:_tryAddExp(addExp, useData)
	if self._curTotalExp > self._needExp then
		return false
	end

	local totalExp = self._curTotalExp + addExp
	local totalCost = totalExp * self._perExpCostGold

	if totalCost <= self._goldHas then
		useData.hasAddCount = useData.hasAddCount + 1
		useData.isManualSelect = false
		self._addNum = self._addNum + 1
		self._curTotalExp = totalExp

		return true
	else
		self._lzbEnough = false

		return false
	end
end

function M:_onClickIntensify()
	local costMaterials = {}
	local costEquipUuids = {}
	local costDiceUuids = {}
	local hasSelect = false
	local hasPresetEquip = false
	local recycleEquips = {}

	for uuid, v in pairs(self._itemUseData) do
		if v.hasAddCount > 0 then
			hasSelect = true

			if v.isMultiple then
				local itemId = v.itemData:getItemId()

				costMaterials[itemId] = v.hasAddCount
			elseif v.itemData:getType() == GameEnum.ItemTypeEnum.EquipItemType then
				table.insert(costEquipUuids, uuid)
				table.insert(recycleEquips, v.itemData)

				local isPreset = CharacterPreinstallController.instance:getItemList(uuid)

				if isPreset then
					hasPresetEquip = true
				end
			else
				table.insert(costDiceUuids, uuid)
			end
		end
	end

	if not hasSelect then
		FloatWordMgr.instance:show(lang("tip_euqip_intensity_select"))

		return
	end

	if self._goldNeed > self._goldHas then
		FloatWordMgr.instance:show(lang("tip_role_ugrade_gold_less"))

		return
	end

	self._costMaterials = costMaterials
	self._costEquipUuids = costEquipUuids
	self._costDiceUuids = costDiceUuids

	if hasPresetEquip then
		ViewMgr.instance:open(ViewName.CharacterPreinstallNoticeView, 1, recycleEquips, self, lang("tip_character_preinstall_notice_intensify"))
	else
		self:_confirmCallbackPreinstall()
	end
end

function M:_confirmCallbackPreinstall()
	self._lastEquipmentData = clone(self._equipmentData)

	EquipmentAgent.instance:sendEquipStrengthenRequest(self._equipmentData:getUuid(), self._costMaterials, self._costEquipUuids, self._costDiceUuids)
end

function M:_tryOpenDiceRevealView(e)
	if not self._lastEquipmentData then
		return false
	end

	local equipmentData = ItemModel.instance:getItemDataByUuid(self._lastEquipmentData:getUuid())

	if not equipmentData then
		return false
	end

	if #self._lastEquipmentData:getAllDiceAttr() < #equipmentData:getAllDiceAttr() then
		ViewMgr.instance:open(ViewName.EquipDiceRevealView, equipmentData, self._lastEquipmentData)

		return true
	end

	return false
end

function M:_onGlobalClick(screenX, screenY)
	if not self._pos then
		self._pos = Vector3.New(screenX, screenY, 0)
	else
		self._pos:Set(screenX, screenY, 0)
	end

	local isClickFilter = GameUtils.isInUIRange(self._pos, self._rectFilter)

	if not isClickFilter then
		self:_onClickFilterMask()
	end
end

function M:_getQuickSelectQuality()
	return PlayerModel.instance:getLocalStorageInt(EquipEnum.LocalStorageKey.QuickSelect, GameEnum.QualityEnum.C)
end

function M:_setQuickSelectQuality(quality)
	PlayerModel.instance:setLocalStorageInt(EquipEnum.LocalStorageKey.QuickSelect, quality or GameEnum.QualityEnum.C)
end

return M
