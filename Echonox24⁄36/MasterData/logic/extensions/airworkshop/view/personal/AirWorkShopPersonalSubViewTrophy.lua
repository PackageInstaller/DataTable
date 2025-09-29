-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/personal/AirWorkShopPersonalSubViewTrophy.lua

module("logic.extensions.airworkshop.view.personal.AirWorkShopPersonalSubViewTrophy", package.seeall)

local M = class("AirWorkShopPersonalSubViewTrophy")

M.TabType = {
	Icon = 2,
	List = 1
}

function M:ctor(compContainer)
	self._registry = ViewElementsRegistry.New(compContainer.gameObject)
end

function M:isPageTypeMatch(pageType)
	return pageType == AirWorkShopEnum.PersonalPageType.Trophy
end

function M:setActive(active, pageIndex)
	self:prepareData()

	self._isActive = active

	goutil.setActive(self:getPageGo(), active)

	self._activeIndex = nil

	if active then
		self._toggleTabControl:selectTab(M.TabType.List)
		self:_tryGetNewFormServer(pageIndex)
	end
end

function M:getActive()
	return self._isActive
end

function M:Awake()
	self:buildUI()
	self:bindEvents()
end

function M:OnDestroy()
	self:unbindEvents()
	self:destroyUI()
end

function M:buildUI()
	local registry = self:getRegistry()

	self._goPage = registry:findUIElement("air_workshop_personal_page_view_-1572158329")
	self._toggleTabControl = ToggleTabControl.New()

	self._toggleTabControl:setViewPager(self)
	self._toggleTabControl:addToggleTab(registry:findUIElement("air_workshop_personal_page_view_1988637174", UIComponentType.SpaceXToggle))
	self._toggleTabControl:addToggleTab(registry:findUIElement("air_workshop_personal_page_view_-1922514732", UIComponentType.SpaceXToggle))

	self._scrollGroup = {
		[M.TabType.List] = {
			scroll = registry:findUIElement("air_workshop_personal_page_view_1326696381", UIComponentType.ScrollRect)
		},
		[M.TabType.Icon] = {
			scroll = registry:findUIElement("air_workshop_personal_page_view_86130750", UIComponentType.ScrollRect)
		}
	}
	self._columnNum = 6
	self._scrollGroup[M.TabType.List].loopLst = LoopListHelper.New(self._scrollGroup[M.TabType.List].scroll.gameObject)

	self._scrollGroup[M.TabType.List].loopLst:InitListView(0, self._onCellListUpdate, self)

	self._scrollGroup[M.TabType.Icon].loopLst = LoopStaggeredGridViewHelper.New(self._scrollGroup[M.TabType.Icon].scroll.gameObject)

	self._scrollGroup[M.TabType.Icon].loopLst:InitStaggeredGridView(0, 0, 0, self._columnNum, 150, self._onCellIconUpdate, self)

	self._hasCount = {}
	self._cupItem = {}
end

function M:destroyUI()
	removetimer(self._resetIconList, self)
	self:setHandler(nil)

	if self._registry then
		self._registry:cleanRegistry()

		self._registry = false
	end

	self._toggleTabControl:destroy()

	self._toggleTabControl = nil

	for _, comps in pairs(self._scrollGroup or {}) do
		if comps.loopLst then
			comps.loopLst:Dispose()

			comps.loopLst = nil
		end
	end

	for _, value in pairs(self._itemData or {}) do
		value.destroyUI()
	end

	self._itemData = nil

	for _, value in pairs(self._itemIconData or {}) do
		if value.destroyUI then
			value.destroyUI()
		end
	end

	self._itemIconData = nil
	self._hasCount = nil
	self._cupItem = nil
	self._cfgLst = nil
	self._moLst = nil
	self._moLstIndex = nil
	self._moLstIcon = nil
	self._moLstIconIndex = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onExit(reasonType)
	removetimer(self._resetIconList, self)
end

function M:setHandler(handler)
	self._handler = handler
end

function M:getHandler()
	return self._handler
end

function M:getPageGo()
	return self._goPage
end

function M:getRegistry()
	return self._registry
end

function M:getPageIndex()
	return self._activeIndex
end

function M:refreshView(msg, pageIndex)
	self._cupItem = {
		[GameEnum.ItemTypeEnum.AirSeasonCup] = {},
		[GameEnum.ItemTypeEnum.AirAchievementCup] = {}
	}
	self._hasCount = {}

	for _, AirCupNO in ipairs(msg.seasonCup or {}) do
		if AirCupNO.id and AirCupNO.id > 0 then
			local type = GameEnum.ItemTypeEnum.AirSeasonCup

			self._cupItem[type][AirCupNO.id] = AirCupNO

			local count = self._hasCount[type] or 0

			self._hasCount[type] = count + 1
		end
	end

	for _, AirCupNO in ipairs(msg.achievementCup or {}) do
		if AirCupNO.id and AirCupNO.id > 0 then
			local type = GameEnum.ItemTypeEnum.AirAchievementCup

			self._cupItem[type][AirCupNO.id] = AirCupNO

			local count = self._hasCount[type] or 0

			self._hasCount[type] = count + 1
		end
	end

	self:refreshLoopList(self._activeIndex)
end

function M:getCupData(type, id)
	local data

	if self._cupItem and self._cupItem[type] then
		data = self._cupItem[type][id]
	end

	return data
end

function M:getCupCount(itemType)
	local hasCount = self._hasCount[itemType] or 0
	local totalCount = self._totalCount[itemType] or 0

	return hasCount, totalCount
end

function M:setPage(tabIndex)
	local orgIndex = self._activeIndex or -1
	local needReflash = orgIndex ~= tabIndex

	self._activeIndex = tabIndex

	if needReflash then
		for _type, comps in pairs(self._scrollGroup or {}) do
			goutil.setActive(comps.scroll.gameObject, _type == tabIndex)
		end

		self:refreshLoopList(tabIndex)
	end
end

function M:refreshLoopList(tabIndex)
	local loopList = self._scrollGroup[tabIndex].loopLst
	local scroll = self._scrollGroup[tabIndex].scroll

	if M.TabType.List == tabIndex then
		local moLst = self._moLst

		if loopList:GetLoopListView().ItemTotalCount ~= #moLst then
			loopList:SetListItemCount(#moLst, true)
		else
			loopList:RefreshAllShownItem()
		end
	else
		local moLst = self._moLstIcon

		loopList:SetListItemCount(#moLst, true)
		loopList:RefreshAllShownItem()
		removetimer(self._resetIconList, self)
		settimer(0, self._resetIconList, self, false)
	end

	scroll.verticalNormalizedPosition = 1

	RectTransformUtils.ForceRebuildLayoutImmediate(scroll.transform)
end

function M:_resetIconList()
	if not self._scrollGroup or not self._scrollGroup[M.TabType.Icon] or not self._scrollGroup[M.TabType.Icon].loopLst then
		return
	end

	if self._activeIndex ~= M.TabType.Icon then
		return
	end

	local loopList = self._scrollGroup[M.TabType.Icon].loopLst

	if loopList:GetLoopStaggeredGridView().ItemTotalCount > 0 then
		loopList:GetLoopStaggeredGridView():MovePanelToItemIndex(0, 0)
	end
end

function M:prepareData()
	if self._moLst then
		return
	end

	local function addItemTypeCfgLst(ItemTypeEnum, tableLst)
		local itemCfgLst = BackpackConfig.instance:getItemsInfoByType(ItemTypeEnum)

		table.sort(itemCfgLst, function(a, b)
			local priorityA = a.priority or 0
			local priorityB = b.priority or 0

			if priorityA ~= priorityB then
				return priorityB < priorityA
			end

			return a.id < b.id
		end)
		TableUtil.addRange(tableLst, itemCfgLst)

		return #itemCfgLst
	end

	self._cfgLst = {}
	self._totalCount = {}
	self._totalCount[GameEnum.ItemTypeEnum.AirAchievementCup] = addItemTypeCfgLst(GameEnum.ItemTypeEnum.AirAchievementCup, self._cfgLst)

	local columnNum = self._columnNum

	self._moLst = {}
	self._moLstIndex = {}
	self._moLstIcon = {}
	self._moLstIconIndex = {}

	local _cacaheObj

	for k, v in ipairs(self._cfgLst) do
		if not _cacaheObj or _cacaheObj ~= v.type then
			if #self._moLstIcon ~= 0 then
				local needDataNum = #self._moLstIcon % columnNum

				if needDataNum ~= 0 then
					needDataNum = columnNum - needDataNum

					for i = 1, needDataNum do
						table.insert(self._moLstIcon, {
							isFakeData = true,
							type = v.type
						})
					end
				end
			end

			table.insert(self._moLstIcon, {
				isTitle = true,
				type = v.type
			})
			table.insert(self._moLst, {
				isTitle = true,
				type = v.type
			})

			for i = 1, columnNum - 1 do
				table.insert(self._moLstIcon, {
					isFakeData = true,
					isTitle = true,
					type = v.type
				})
			end

			_cacaheObj = v.type
		end

		table.insert(self._moLstIcon, {
			isFakeData = false,
			isTitle = false,
			type = v.type,
			cfg = v
		})
		table.insert(self._moLst, {
			isFakeData = false,
			isTitle = false,
			type = v.type,
			cfg = v
		})

		self._moLstIconIndex[v.id] = #self._moLstIcon
		self._moLstIndex[v.id] = #self._moLst
	end
end

function M:_onCellListUpdate(curIndex)
	curIndex = curIndex + 1

	local data = self._moLst[curIndex]
	local isTitle = data.isTitle
	local prefabName = isTitle and "trophy_title" or "trophy_long_strip_item"
	local loopList = self._scrollGroup[self:getPageIndex()].loopLst
	local item = loopList:NewListViewItem(prefabName)

	self:_updateListCell(item.gameObject, data, isTitle)

	return item
end

function M:_updateListCell(go, data, isTitle)
	if not self._itemData then
		self._itemData = {}
	end

	local key = go:GetInstanceID()
	local theItem = self._itemData[key]

	if not theItem then
		theItem = {
			go = go,
			canvasGroup = goutil.addComponentOnce(go, ComponentType.CanvasGroup),
			goContent = goutil.findChild(go, "content").gameObject
		}

		if isTitle then
			theItem.txtTitle = goutil.findChildTextComponent(go, "content/txtTitle")
			theItem.txtProgress = goutil.findChildTextComponent(go, "content/txtProgress")

			function theItem.destroyUI()
				return
			end
		else
			theItem.goReceive = goutil.findChild(go, "content/stateReceived")
			theItem.txtGainTime = goutil.findChildTextComponent(go, "content/stateReceived/txtGetTime")
			theItem.goUnclaimed = goutil.findChild(go, "content/stateUnclaimed")
			theItem.txtGainWay = goutil.findChildTextComponent(go, "content/stateUnclaimed/txtGetWay")
			theItem.txtName = goutil.findChildTextComponent(go, "content/txtName")
			theItem.txtContent = goutil.findChildTextComponent(go, "content/txtContent")
			theItem.imgIcon = goutil.findChildImageComponent(go, "content/btnIcon")
			theItem.btnIcon = UIComponentType.ButtonAdapter(goutil.findChild(go, "content/btnIcon").gameObject)

			function theItem.getData()
				return theItem.data
			end

			theItem.btnIcon:AddClickListener(function()
				self:_onCellLstClickIcon(theItem.getData(), theItem.go)
			end, self)

			function theItem.destroyUI()
				theItem.btnIcon:RemoveClickListener()
			end
		end

		self._itemData[key] = theItem
	end

	theItem.data = data

	if isTitle then
		theItem.txtTitle.text = lang(string.format("tip_air_cup_title_%s", data.type))

		local hasCount, totalCount = self:getCupCount(data.type)

		theItem.txtProgress.text = string.format("%s/%s", hasCount, totalCount)
	else
		local cfg = BackpackConfig.instance:getItemInfoByItemId(data.cfg.id)
		local cupData = self:getCupData(cfg.type, data.cfg.id)

		if cupData then
			theItem.txtGainTime.text = ServerTime.formatTimeServerLook(cupData.time * 0.001, "%Y/%m/%d")
		else
			theItem.txtGainWay.text = cfg and cfg.cupGetWay or ""
		end

		goutil.setActive(theItem.goReceive, cupData)
		goutil.setActive(theItem.goUnclaimed, not cupData)

		theItem.canvasGroup.alpha = cupData and 1 or 0.4
		theItem.txtName.text = cfg and cfg.name or ""
		theItem.txtContent.text = cfg and cfg.desc or ""

		IconLoader.setSpriteByItemType(theItem.imgIcon, cfg.type, ItemUtil.getItemCoIcon(cfg))
	end
end

function M:_onCellLstClickIcon(data, go)
	if data and not data.isFakeData then
		local id = data.cfg.id
		local itemData = ItemUtil.createItemData({
			itemId = id
		})
		local cellIndex = 0
		local showTips = true
		local showTipsPassEvent = false
		local isHideGetWay = true
		local isHideLock = true

		GlobalDispatcher:dispatchEvent(EventType.ITEM_NORMAL_MARK_TYPE, itemData, go.gameObject, cellIndex, showTips, showTipsPassEvent, isHideGetWay, isHideLock)
	end
end

function M:_onCellIconClickIcon(data, go)
	if data and not data.isFakeData then
		local id = data.cfg.id
		local itemData = ItemUtil.createItemData({
			itemId = id
		})
		local cellIndex = 0
		local showTips = true
		local showTipsPassEvent = false
		local isHideGetWay = true
		local isHideLock = true

		GlobalDispatcher:dispatchEvent(EventType.ITEM_NORMAL_MARK_TYPE, itemData, go.gameObject, cellIndex, showTips, showTipsPassEvent, isHideGetWay, isHideLock)
	end
end

function M:_onCellIconUpdate(index)
	index = index + 1

	local data = self._moLstIcon[index]
	local isTitle = data.isTitle
	local showItem = not data.isFakeData
	local prefabName = data.isTitle and "trophy_title" or "trophy_grid_item"
	local loopList = self._scrollGroup[self:getPageIndex()].loopLst
	local item = loopList:NewListViewItem(prefabName)

	self:_updateIconCell(item.gameObject, data, isTitle)

	return item
end

function M:_updateIconCell(go, data, isTitle)
	if not self._itemIconData then
		self._itemIconData = {}
	end

	local key = go:GetInstanceID()
	local theItem = self._itemIconData[key]

	if not theItem then
		theItem = {
			go = go,
			goContent = goutil.findChild(go, "content").gameObject
		}

		if isTitle then
			theItem.txtTitle = goutil.findChildTextComponent(go, "content/txtTitle")
			theItem.txtProgress = goutil.findChildTextComponent(go, "content/txtProgress")

			function theItem.destroyUI()
				return
			end
		else
			theItem.canvasGroupContent = goutil.addComponentOnce(goutil.findChild(go, "content").gameObject, ComponentType.CanvasGroup)
			theItem.imgIcon = goutil.findChildImageComponent(go, "content/imgIcon")
			theItem.btnIcon = UIComponentType.ButtonAdapter(goutil.findChild(go, "content/btnClick").gameObject)

			function theItem.getData()
				return theItem.data
			end

			theItem.btnIcon:AddClickListener(function()
				self:_onCellIconClickIcon(theItem.getData(), theItem.go)
			end, self)

			function theItem.destroyUI()
				theItem.btnIcon:RemoveClickListener()
			end
		end

		self._itemIconData[key] = theItem
	end

	theItem.data = data

	goutil.setActive(theItem.goContent, not data.isFakeData)

	if not data.isFakeData then
		if isTitle then
			theItem.txtTitle.text = lang(string.format("tip_air_cup_title_%s", data.type))

			local hasCount, totalCount = self:getCupCount(data.type)

			theItem.txtProgress.text = string.format("%s/%s", hasCount, totalCount)
		else
			local cfg = BackpackConfig.instance:getItemInfoByItemId(data.cfg.id)
			local cupData = self:getCupData(cfg.type, data.cfg.id)

			theItem.canvasGroupContent.alpha = cupData and 1 or 0.4

			IconLoader.setSpriteByItemType(theItem.imgIcon, cfg.type, ItemUtil.getItemCoIcon(cfg))
		end
	end
end

function M:_tryGetNewFormServer(pageIndex)
	local handler = self:getHandler()
	local userId = handler:getUserId()

	AirWorkShopAtkAgent.instance:sendGetAirCupPageRequest(userId)
end

return M
