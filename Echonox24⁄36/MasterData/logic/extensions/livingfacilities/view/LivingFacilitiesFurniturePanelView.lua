-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/livingfacilities/view/LivingFacilitiesFurniturePanelView.lua

module("logic.extensions.livingfacilities.view.LivingFacilitiesFurniturePanelView", package.seeall)

local M = class("LivingFacilitiesFurniturePanelView")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self._mainGo)

	self:_buildUI()
end

function M:_buildUI()
	self._btnStore = Astral.ButtonAdapter.Get(self._registry:findUIElement("room_live_furniture_panel_519947074"))
	self._btnPreinstall = Astral.ButtonAdapter.Get(self._registry:findUIElement("room_live_furniture_panel_1282848019"))
	self._tabList = {
		self._registry:findUIElement("room_live_furniture_panel_43835566", UIComponentType.SpaceXToggle),
		self._registry:findUIElement("room_live_furniture_panel_976346841", UIComponentType.SpaceXToggle),
		self._registry:findUIElement("room_live_furniture_panel_108737410", UIComponentType.SpaceXToggle),
		self._registry:findUIElement("room_live_furniture_panel_1690297748", UIComponentType.SpaceXToggle),
		self._registry:findUIElement("room_live_furniture_panel_481525286", UIComponentType.SpaceXToggle)
	}
	self._tabSelectNumList = {}
	self._tabNormalNumList = {}

	for i, tabToggle in ipairs(self._tabList) do
		local normalNum = goutil.findChildTextComponent(tabToggle.gameObject, "normal/txtNum")
		local selectNum = goutil.findChildTextComponent(tabToggle.gameObject, "select/txtNum")

		table.insert(self._tabSelectNumList, selectNum)
		table.insert(self._tabNormalNumList, normalNum)
	end

	self._type1 = self._registry:findUIElement("room_live_furniture_panel_988431820")
	self._liveFurnitureScrollGo = self._registry:findUIElement("room_live_furniture_panel_1078688545")
	self._furnitureLoopList = LoopListHelper.New(self._liveFurnitureScrollGo)

	self._furnitureLoopList:InitListView(0, self._updateFurnitureCell, self)

	self._btnFilter = Astral.ButtonAdapter.Get(self._registry:findUIElement("room_live_furniture_panel_68356378"))
	self._btnRecycle = Astral.ButtonAdapter.Get(self._registry:findUIElement("room_live_furniture_panel_1668713312"))
	self._btnReset = Astral.ButtonAdapter.Get(self._registry:findUIElement("room_live_furniture_panel_23663026"))
	self._btnSave = Astral.ButtonAdapter.Get(self._registry:findUIElement("room_live_furniture_panel_1627371290"))
	self._goUnableSave = self._registry:findUIElement("room_live_furniture_panel_-1228087638")
	self._type2 = self._registry:findUIElement("room_live_furniture_panel_778711534")
	self._liveTemplateScrollGo = self._registry:findUIElement("room_live_furniture_panel_354292507")
	self._templateLoopList = LoopListHelper.New(self._liveTemplateScrollGo)

	self._templateLoopList:InitListView(0, self._updateTemplateCell, self)

	self._btnCollect = Astral.ButtonAdapter.Get(self._registry:findUIElement("room_live_furniture_panel_705488513"))

	goutil.setActive(self._btnCollect.gameObject, false)

	self._btnUsing = Astral.ButtonAdapter.Get(self._registry:findUIElement("room_live_furniture_panel_1586484607"))
	self._themeScrollGo = self._registry:findUIElement("room_live_furniture_panel_995020829")
	self._themeLoopList = LoopListHelper.New(self._themeScrollGo)

	self._themeLoopList:InitListView(0, self._updateThemeCell, self)

	self._themeBtnText = self._registry:findUIElement("room_live_furniture_panel_1901821374", UIComponentType.Text)
	self._btnTheme = Astral.ButtonAdapter.Get(self._registry:findUIElement("room_live_furniture_panel_140419656"))
	self._btnDelete = Astral.ButtonAdapter.Get(self._registry:findUIElement("room_live_furniture_panel_1741141898"))
	self._subFilterGo = self._registry:findUIElement("room_live_furniture_panel_1235535867")
	self._subFilterItemGo = self._registry:findUIElement("room_live_furniture_panel_2025637301")
	self._templeTabList = {
		self._registry:findUIElement("room_live_furniture_panel_2142930728", UIComponentType.SpaceXToggle),
		self._registry:findUIElement("room_live_furniture_panel_1600148020", UIComponentType.SpaceXToggle)
	}
	self._btnHideUI = Astral.ButtonAdapter.Get(self._registry:findUIElement("room_live_furniture_panel_297806366"))
end

function M:_bindEvents()
	self._btnStore:AddClickListener(self._onClickBtnStore, self)
	self._btnPreinstall:AddClickListener(self._onClickBtnPreinstall, self)

	for i, tab in ipairs(self._tabList) do
		tab:AddListener(function(view, toggle, isOn)
			if isOn then
				self:_onClickTab(i)
			end
		end, self)
	end

	self._btnFilter:AddClickListener(self._onClickBtnFilter, self)
	self._btnRecycle:AddClickListener(self._onClickBtnRecycle, self)
	self._btnReset:AddClickListener(self._onClickBtnReset, self)
	self._btnSave:AddClickListener(self._onClickBtnSave, self)
	self._btnCollect:AddClickListener(self._onClickBtnCollect, self)
	self._btnUsing:AddClickListener(self._onClickBtnUsing, self)
	self._btnTheme:AddClickListener(self._onClickBtnTheme, self)

	for i, tab in ipairs(self._templeTabList) do
		tab:AddListener(function(view, toggle, isOn)
			if isOn then
				self:_onClickTempleTab(i)
			end
		end, self)
	end

	self._btnHideUI:AddClickListener(self._onClickBtnHideUI, self)
	self._btnDelete:AddClickListener(self._onClickBtnDelete, self)
end

function M:_unbindEvents()
	self._btnStore:RemoveClickListener()
	self._btnPreinstall:RemoveClickListener()

	for i, tab in ipairs(self._tabList) do
		tab:RemoveListener()
	end

	for i, tab in ipairs(self._templeTabList) do
		tab:RemoveListener()
	end

	for i, toggle in ipairs(self._toggleList) do
		toggle:RemoveListener()
	end

	self._btnFilter:RemoveClickListener()
	self._btnRecycle:RemoveClickListener()
	self._btnReset:RemoveClickListener()
	self._btnSave:RemoveClickListener()
	self._btnCollect:RemoveClickListener()
	self._btnUsing:RemoveClickListener()
	self._btnTheme:RemoveClickListener()

	for i, click in ipairs(self._themeClickList) do
		click:RemoveClickListener()
	end

	self._btnHideUI:RemoveClickListener()
	self._btnDelete:RemoveClickListener()
end

function M:onEnter()
	self._themeClickList = {}
	self._templeShowerList = {}
	self._furnitureShowerList = {}

	self:_bindEvents()
	self:_setEvent(true)

	self._themeList = LivingFacilitiesFurniThemeModel.instance:getAllTheme()
	self._themeBtnText.text = lang("tip_all_theme")

	LivingFacilitiesFurnitureController.instance:setFilterCondition({
		theme = 0
	})
	self:resetClickTab()
	self:_refreshSaveBtn()
end

function M:resetClickTab()
	self._tabList[1].IsOn = true

	self:_onClickTab(1)
end

function M:onExit()
	self:_setEvent(false)
	self:_unbindEvents()

	for i, shower in ipairs(self._templeShowerList) do
		shower:onExit()
	end

	for i, shower in ipairs(self._furnitureShowerList) do
		shower:onExit()
	end

	self._furnitureLoopList:ClearCells()
	self._templateLoopList:ClearCells()
	self._themeLoopList:ClearCells()
end

function M:OnDestroy()
	self:_destroyUI()
end

function M:_setEvent(add)
	if add then
		HouseDispatcher:addEventListener(HouseEventType.LIVE_TEMPLE_SELECT, self._selectTemple, self)
		HouseDispatcher:addEventListener(HouseEventType.LIVE_HIDE_ALL_UI, self._hideAllUI, self)
		HouseDispatcher:addEventListener(HouseEventType.LIVE_FURNITURE_REFRESH, self._onEditFurniture, self)
		HouseDispatcher:addEventListener(HouseEventType.LIVE_TEMPLE_REFRESH, self._onhandleTempleRefresh, self)
		HouseDispatcher:addEventListener(HouseEventType.LIVE_TEMPLE_ICON_RELOAD_FINISH, self._onhandleTempleRefresh, self)
		HouseDispatcher:addEventListener(HouseEventType.LIVE_TEMPLE_APPLY, self._applyTemple, self)
		HouseDispatcher:addEventListener(HouseEventType.ON_FURNITURE_PRODUCT_FINISH, self._onFurnitureProduct, self)
		HouseDispatcher:addEventListener(HouseEventType.FURNITURE_SAVE_STATE_CHANGE, self._refreshSaveBtn, self)
		HouseDispatcher:addEventListener(HouseEventType.LIVE_TEMPLE_DELETE, self._onTempleDelete, self)
	else
		HouseDispatcher:removeEventListener(HouseEventType.LIVE_TEMPLE_SELECT, self._selectTemple, self)
		HouseDispatcher:removeEventListener(HouseEventType.LIVE_HIDE_ALL_UI, self._hideAllUI, self)
		HouseDispatcher:removeEventListener(HouseEventType.LIVE_FURNITURE_REFRESH, self._onEditFurniture, self)
		HouseDispatcher:removeEventListener(HouseEventType.LIVE_TEMPLE_REFRESH, self._onhandleTempleRefresh, self)
		HouseDispatcher:removeEventListener(HouseEventType.LIVE_TEMPLE_ICON_RELOAD_FINISH, self._onhandleTempleRefresh, self)
		HouseDispatcher:removeEventListener(HouseEventType.LIVE_TEMPLE_APPLY, self._applyTemple, self)
		HouseDispatcher:removeEventListener(HouseEventType.ON_FURNITURE_PRODUCT_FINISH, self._onFurnitureProduct, self)
		HouseDispatcher:removeEventListener(HouseEventType.FURNITURE_SAVE_STATE_CHANGE, self._refreshSaveBtn, self)
		HouseDispatcher:removeEventListener(HouseEventType.LIVE_TEMPLE_DELETE, self._onTempleDelete, self)
	end
end

function M:_destroyUI()
	self._registry:cleanRegistry()

	self._registry = nil

	self._furnitureLoopList:Dispose()

	self._furnitureLoopList = nil

	self._templateLoopList:Dispose()

	self._templateLoopList = nil

	self._themeLoopList:Dispose()

	self._themeLoopList = nil
	self._compContainer = nil
	self._mainGo = nil
	self._btnHideUI = nil
end

function M:_onClickBtnStore()
	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_EVENT, 10800001)
end

function M:_onClickBtnPreinstall()
	goutil.setActive(self._type1, false)
	goutil.setActive(self._type2, true)

	local toggleGroup = self._tabList[1].ToggleGroup

	toggleGroup:SetAllTogglesOff()

	if self._templeTabList[1].IsOn == true then
		self:_refreshMouldView()
	else
		self._templeTabList[1].IsOn = true
	end

	goutil.setActive(self._btnDelete.gameObject, not self._isMould)
end

function M:_onClickTempleTab(index)
	if index == 1 then
		self:_refreshMouldView()
	elseif index == 2 then
		LivingRoomFurnitureUtil.instance:tryReloadAllTemplateIcon()
		self:_tryResetRoomFurniture()
		self:_refreshTemplateView()
	end

	goutil.setActive(self._btnDelete.gameObject, not self._isMould)
end

function M:_onClickTab(index)
	self:_tryResetRoomFurniture()

	self._index = index

	goutil.setActive(self._type1, true)
	goutil.setActive(self._type2, false)
	self:_refreshSubTab()
	self:_refreshFurniture()
end

function M:_refreshSubTab()
	self._toggleList = {}

	local subTabList = HouseEnum.FurnitureSubTypeName[self._index]

	for i = 0, self._subFilterGo.transform.childCount - 1 do
		local obj = goutil.findChild(self._subFilterGo, "filter_" .. i + 1)

		goutil.setActive(obj, false)
	end

	for i, subTab in ipairs(subTabList) do
		local obj = goutil.findChild(self._subFilterGo, "filter_" .. i)

		if not obj then
			obj = goutil.clone(self._subFilterItemGo, "filter_" .. i)

			goutil.addChildToParent(obj, self._subFilterGo)
		end

		goutil.setActive(obj, true)

		local name1 = goutil.findChildTextComponent(obj, "normal/Text")
		local name2 = goutil.findChildTextComponent(obj, "select/Text")

		name1.text = subTab
		name2.text = subTab

		local toggle = obj:GetComponent(UIComponentType.SpaceXToggle)

		if i == 1 then
			toggle.IsOn = true
		end

		toggle:RemoveListener()
		toggle:AddListener(function()
			if toggle.IsOn then
				self._subIndex = i

				goutil.setActive(self._type1, true)
				goutil.setActive(self._type2, false)
				self:_refreshFurnitureList()
				self:_refreshFurnitureView()
			end
		end, self)
		table.insert(self._toggleList, toggle)
	end

	self._subIndex = 1
end

function M:_refreshFurnitureList()
	self._showFurnitureList = {}

	local subType = LivingFacilitiesFurnitureController.instance:getFurnitureSubType(self._index, self._subIndex)
	local furnitureList = LivingFacilitiesZoneController.instance:getCacheCurrentFurniture()

	for i, furniture in ipairs(furnitureList) do
		if LivingFacilitiesFurnitureController.instance:isFitCondition(furniture) and furniture:getSubType() == subType then
			table.insert(self._showFurnitureList, furniture)
		end
	end

	self:_sortFurniture()
end

function M:_sortFurniture()
	local zoneMo = LivingFacilitiesZoneController.instance:getCurrentZoneMo()
	local curRoomType = zoneMo:getType()

	table.sort(self._showFurnitureList, function(dataA, dataB)
		if dataA:getCanUse(curRoomType) and not dataB:getCanUse(curRoomType) then
			return true
		elseif not dataA:getCanUse(curRoomType) and dataB:getCanUse(curRoomType) then
			return false
		end

		if dataA:getCount() > 0 and dataB:getCount() == 0 then
			return true
		elseif dataA:getCount() == 0 and dataB:getCount() > 0 then
			return false
		end

		return dataA:getItemId() < dataB:getItemId()
	end)
end

function M:_refreshFurnitureView()
	self._furnitureLoopList:SetListItemCount(#self._showFurnitureList, true)
	self._furnitureLoopList:RefreshAllShownItem()
end

function M:_updateFurnitureCell(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._furnitureLoopList:NewListViewItem("live_furniture_item")
	local showFurnitureInfo = self._showFurnitureList[curIndex]
	local shower = Astral.LuaComponentContainer.Add(item.gameObject, LivingFurnitureNormalItemCell)

	shower:setPreviewStatus(false)
	shower:setCellData(showFurnitureInfo, curIndex)
	table.insert(self._furnitureShowerList, shower)

	return item
end

function M:_onClickBtnFilter()
	return
end

function M:_onClickBtnRecycle()
	LivingFacilitiesZoneController.instance:removeAllClothEdit()
end

function M:_onClickBtnReset()
	LivingFacilitiesZoneController.instance:revokeAllClothEdit()
end

function M:_onClickBtnSave()
	if HouseFurnitureModel.instance:canSaveFurniture() then
		LivingFacilitiesFurnitureController.instance:saveFurnituresRequest()
	end
end

function M:_refreshSaveBtn()
	local canSave = HouseFurnitureModel.instance:canSaveFurniture()

	goutil.setActive(self._btnSave.gameObject, canSave)
	goutil.setActive(self._goUnableSave, not canSave)
end

function M:_refreshMouldView()
	self._isMould = true

	local zoneMo = LivingFacilitiesZoneController.instance:getCurrentZoneMo()

	self._templateList = LivingFacilitiesZoneModel.instance:getMouldList(zoneMo:getType())

	self._templateLoopList:SetListItemCount(#self._templateList, true)
end

function M:_refreshTemplateView()
	self._isMould = false

	local zoneMo = LivingFacilitiesZoneController.instance:getCurrentZoneMo()
	local templateCount = zoneMo:getFtCount()

	self._templateList = LivingFacilitiesZoneModel.instance:getTempleByType(zoneMo:getType())

	self._templateLoopList:SetListItemCount(templateCount, true)
end

function M:_updateTemplateCell(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local isSelected = false

	if self._isMould then
		isSelected = curIndex == self._selectedMouldIndex
	else
		isSelected = curIndex == self._selectedCollectIndex
	end

	local item = self._templateLoopList:NewListViewItem("live_template_item")
	local templateInfo = self._templateList[curIndex]
	local shower = Astral.LuaComponentContainer.Add(item.gameObject, LivingFacilitiesTempleItemCell)

	shower:setTempleStatus(self._isMould)
	shower:setCellData(templateInfo, curIndex)
	shower:refreshSelectStatus(isSelected)
	table.insert(self._templeShowerList, shower)

	return item
end

function M:_updateThemeCell(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._themeLoopList:NewListViewItem("theme_tab")
	local themeInfo = self._themeList[curIndex]
	local clickImg = goutil.findChild(item, "imgTheme")
	local textTheme = goutil.findChildTextComponent(item, "Text")
	local click = Astral.UIClickTrigger.Get(clickImg)

	click:AddClickListener(function()
		self._themeBtnText.text = themeInfo:getName()

		goutil.setActive(self._themeScrollGo, false)
		LivingFacilitiesFurnitureController.instance:setFilterCondition({
			theme = themeInfo:getId()
		})
		self:_refreshFurniture()
	end)
	table.insert(self._themeClickList, click)

	textTheme.text = themeInfo:getName()

	return item
end

function M:_onClickBtnCollect()
	if self._selectedCollectIndex > 0 then
		ViewMgr.instance:open(ViewName.LivingMoudleCollectTips, self._selectedCollectIndex)
	else
		FloatWordMgr.instance:show(lang("tip_live_furniture_lang_1"))
	end
end

function M:_onClickBtnUsing()
	local selectedIndex = self._isMould and self._selectedMouldIndex or self._selectedCollectIndex

	if selectedIndex > 0 then
		local tempInfo = self._templateList[selectedIndex]

		if tempInfo then
			ViewMgr.instance:open(ViewName.LivingFacilitiesStaticsTips, tempInfo)
		else
			FloatWordMgr.instance:show(lang("tip_live_furniture_lang_2"))
		end
	else
		FloatWordMgr.instance:show(lang("tip_not_select_prefab"))
	end
end

function M:_onClickBtnDelete()
	if self._selectedCollectIndex > 0 then
		local dialog = Dialog.showWarnMessage(lang("tip_title"), lang("tip_live_furniture_lang_3"))

		dialog:setConfirmListener(function()
			local zoneMo = LivingFacilitiesZoneController.instance:getCurrentZoneMo()
			local type = zoneMo:getType()

			HouseAgent.instance:sendDeleteFurnitureTemplateRequest(type, self._selectedCollectIndex)
		end, self)
	else
		FloatWordMgr.instance:show(lang("tip_live_furniture_lang_1"))
	end
end

function M:_onClickBtnTheme()
	local isActive = self._themeScrollGo.activeSelf

	goutil.setActive(self._themeScrollGo, not isActive)
	self:_refreshThemeView()
end

function M:_refreshThemeView()
	self._themeList = LivingFacilitiesFurniThemeModel.instance:getAllTheme()

	self._themeLoopList:SetListItemCount(#self._themeList, true)
end

function M:_selectTemple(e, index)
	local selectedIndex = self._isMould and self._selectedMouldIndex or self._selectedCollectIndex

	if selectedIndex == index then
		self:_tryResetRoomFurniture()
	else
		local tempInfo = self._templateList[index]

		if tempInfo then
			if self._isMould then
				self._selectedMouldIndex = index
				self._selectedCollectIndex = 0
			else
				self._selectedMouldIndex = 0
				self._selectedCollectIndex = index
			end

			LivingFacilitiesZoneController.instance:showTemplate(tempInfo:getFurnitureList())
		elseif self._isMould == false then
			ViewMgr.instance:open(ViewName.LivingMoudleCollectTips, index)
		end
	end

	self._templateLoopList:RefreshAllShownItem()
end

function M:_tryResetRoomFurniture()
	self._selectedCollectIndex = 0
	self._selectedMouldIndex = 0

	LivingFacilitiesZoneController.instance:resetWhenInPlaceTemple()
end

function M:_applyTemple()
	self._selectedCollectIndex = 0
	self._selectedMouldIndex = 0

	self._templateLoopList:RefreshAllShownItem()
end

function M:_onTempleDelete()
	self._selectedCollectIndex = 0
	self._selectedMouldIndex = 0

	LivingFacilitiesZoneController.instance:resetWhenInPlaceTemple()
	self._templateLoopList:RefreshAllShownItem()
end

function M:_hideAllUI(e, isHide)
	if not isHide then
		self:_refreshFurnitureNum()
		self._furnitureLoopList:RefreshAllShownItem()
	end
end

function M:_refreshFurniture()
	self:_refreshFurnitureList()
	self:_refreshFurnitureView()
	self:_refreshFurnitureNum()
end

function M:_onEditFurniture(e, isAll)
	if isAll then
		self:_refreshFurniture()
	else
		self._furnitureLoopList:RefreshAllShownItem()
		self:_refreshFurnitureNum()
	end
end

function M:_onhandleTempleRefresh()
	self._templateLoopList:RefreshAllShownItem()
end

function M:_refreshFurnitureNum()
	local tempNumList = {}
	local furnitureList = LivingFacilitiesZoneController.instance:getCacheCurrentFurniture()

	for i, furniture in ipairs(furnitureList) do
		if LivingFacilitiesFurnitureController.instance:isFitCondition(furniture) then
			local subFirstType = math.floor(furniture:getSubType() / 100)

			tempNumList[subFirstType] = tempNumList[subFirstType] and tempNumList[subFirstType] + furniture:getCount() or furniture:getCount()
		end
	end

	for i, v in ipairs(self._tabSelectNumList) do
		self._tabSelectNumList[i].text = tempNumList[i] or 0
		self._tabNormalNumList[i].text = tempNumList[i] or 0
	end
end

function M:_onClickBtnHideUI()
	LivingFacilitiesZoneController.instance:hideAllUI(false)
end

function M:_onFurnitureProduct()
	self:_refreshFurniture()
	self._templateLoopList:RefreshAllShownItem()
end

return M
