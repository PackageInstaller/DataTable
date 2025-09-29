-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/intelligence/CharacterIntelligenceView.lua

module("logic.extensions.charactersystem.view.intelligence.CharacterIntelligenceView", package.seeall)

local M = class("CharacterIntelligenceView", ViewComponent)
local kCellWidth = 178
local HideUITime = 5
local kCellOffSetX = -40
local maxScale = 5
local minScale = 0.3
local lightCode = 3

function M:buildUI()
	self._viewAnim = self.mainGO:GetComponent(typeof(Astral.GUITimelineAniLua))
	self._btnReturn = self:getBtn("4&title_view_-878360263")
	self._btnHome = self:getBtn("4&title_view_1398742689")
	self._btnExplain = self:getBtn("4&title_view_-636449388")
	self._intelligencePanelGo = self:getGo("character_intelligence_view_copy_499045966")
	self._portraitPanelGo = self:getGo("character_intelligence_view_copy_157888335")
	self._btnSwtich = self:getGo("character_intelligence_view_copy_-845246743")
	self._beginPosition = Vector2.New()
	self._dragTrigger = Astral.UIDragTrigger.Get(self._btnSwtich)
	self._bg1 = self:getBigBg("character_intelligence_view_copy_-888202154")
	self._bg2 = self:getBigBg("character_intelligence_view_copy_-294474471")
	self._btnCheck = self:getBtn("character_intelligence_view_copy_173742942")
	self._btnPreViewBattle = self:getBtn("character_intelligence_view_copy_1458695353")
	self._clotheInfoScroll = self:getGo("character_intelligence_view_copy_-1403114466")
	self._clothScroll = self:getGo("character_intelligence_view_copy_944184415")
	self._bgScroll = self:getGo("character_intelligence_view_copy_-586660623")
	self._labSkinDesc = self:getText("character_intelligence_view_copy_990657331")
	self._labDescScroll = self:getUIComponent("character_intelligence_view_copy_-1403114466", UIComponentType.ScrollRect)
	self._buyInfoGO = self:getGo("character_intelligence_view_copy_994376487")
	self._btnBuy = self:getBtn("character_intelligence_view_copy_231753930")
	self._btnWear = self:getBtn("character_intelligence_view_copy_932711720")
	self._wearingTipsGo = self:getGo("character_intelligence_view_copy_1291952942")
	self._labgainTips = self:getText("character_intelligence_view_copy_1140888717")
	self._gainTipGo = self:getGo("character_intelligence_view_copy_280872642")
	self._btnPre = self:getBtn("character_intelligence_view_copy_362237447")
	self._btnNext = self:getBtn("character_intelligence_view_copy_1436479073")
	self._labName = self:getText("character_intelligence_view_copy_-1308674304")
	self._btnCloth = self:getUIComponent("3&right_tab_content_-242000516", UIComponentType.ButtonAdapter)
	self._btnBg = self:getUIComponent("3&right_tab_content_-1578871314", UIComponentType.ButtonAdapter)
	self._togCloth = self:getUIComponent("3&right_tab_content_-242000516", UIComponentType.SpaceXToggle)
	self._togBg = self:getUIComponent("3&right_tab_content_-1578871314", UIComponentType.SpaceXToggle)
	self._toggleGroup = self:getUIComponent("3&right_tab_content_-205429629", UIComponentType.SpaceXToggleGroup)
	self._scroll = Astral.ScrollRectLoop.Get(self._clothScroll)

	self._scroll:InitFix(kScrollDirH, kCellWidth, 480, kCellOffSetX, 0, 1, self._onSkinCellUpdate, self, self._onCellSelect, self)

	self._scroll.TotalCellNum = 0
	self._scrollLayerComp = self._clothScroll:GetComponent(UIComponentType.ScrollRect)
	self._scrollLayerComp.horizontal = false
	self._scrollLayerTransition = goutil.addComponentOnce(self._clothScroll.gameObject, typeof(Astral.ScrollRectTransition))
	self._scrollLayerListViewWidth = goutil.getWidth(self._scrollLayerComp.viewport)
	self._scrollLayerListAdapter = Astral.ScrollRectAdapter.Get(self._clothScroll)
	self._scrollLayerListDragTrigger = Astral.UIDragTrigger.Get(self._clothScroll)
	self._gapCellCount = math.round((self._scrollLayerListViewWidth - kCellWidth) * 0.5 / kCellWidth)
	self._scrollBg = Astral.ScrollRectLoop.Get(self._bgScroll)

	self._scrollBg:InitFix(kScrollDirH, kCellWidth, 480, kCellOffSetX, 0, 1, self._onBgCellUpdate, self, self._onCellSelect, self)

	self._scrollBg.TotalCellNum = 0
	self._scrollBgLayerComp = self._bgScroll:GetComponent(UIComponentType.ScrollRect)
	self._scrollBgLayerComp.horizontal = false
	self._scrollBgLayerTransition = goutil.addComponentOnce(self._bgScroll.gameObject, typeof(Astral.ScrollRectTransition))
	self._scrollBgLayerListViewWidth = goutil.getWidth(self._scrollBgLayerComp.viewport)
	self._scrollBgLayerListAdapter = Astral.ScrollRectAdapter.Get(self._bgScroll)
	self._scrollBgLayerListDragTrigger = Astral.UIDragTrigger.Get(self._bgScroll)

	self:_buildPortaitUI()
end

function M:_buildPortaitUI()
	self._btnReturn1 = self:getBtn("1&title_view_-878360263")
	self._btnReturn2 = self:getBtn("0&title_view_-878360263")
	self._btnHome1 = self:getBtn("1&title_view_1398742689")
	self._btnHome2 = self:getBtn("0&title_view_1398742689")
	self._switch1Btn = self:getBtn("character_intelligence_view_copy_-294450930")
	self._share1Btn = self:getBtn("character_intelligence_view_copy_-276430200")
	self._switch2Btn = self:getBtn("character_intelligence_view_copy_-72232488")
	self._share2Btn = self:getBtn("character_intelligence_view_copy_-96150946")
	self._horizonPanelGo = self:getGo("character_intelligence_view_copy_-945463863")
	self._verticalPanelGo = self:getGo("character_intelligence_view_copy_-1214241268")
	self._uiPanelGo = self:getGo("character_intelligence_view_copy_971980388")
	self._spinePanelGo = self:getGo("character_intelligence_view_copy_-77701169")
	self._spinePanel1Go = self:getGo("character_intelligence_view_copy_-107736097")
	self._spinePanel2Go = self:getGo("character_intelligence_view_copy_-538815516")
	self._rawImgRoleHor = self:getUIComponent("character_intelligence_view_copy_-1393873981", UIComponentType.RawImage)
	self._rawImgRoleVer = self:getUIComponent("character_intelligence_view_copy_-1230965014", UIComponentType.RawImage)
	self._photoUnitVer = PhotoUnit.Get(self._rawImgRoleVer.gameObject)
	self._photo1CenterPointGo = self:getGo("character_intelligence_view_copy_1812731298")
	self._photoSkinCenterPointGo = self:getGo("character_intelligence_view_copy_2037654922")
	self._photo2CenterPointGo = self:getGo("character_intelligence_view_copy_742828889")
	self._touchGo = self:getGo("character_intelligence_view_copy_1260981775")
	self._raycastProxy = RaycastProxy.Get(self._touchGo)

	self._raycastProxy:SetClickListener(self._onRayCastHit, self)
	self._raycastProxy:SetBeginDragListener(self._onBeginDragPortrait, self)
	self._raycastProxy:SetDragListener(self._onDragPortrait, self)
	self._raycastProxy:SetEndDragListener(self._onEndDragPortrait, self)

	self._compositeTouch = UICompositeTouch.Get(self._touchGo)

	local multiTouch = MultiTouchChecker.New()

	multiTouch:AddMultiDragListener(self._onMultiDragListener, self)
	self._compositeTouch:AddChecker(multiTouch)
end

function M:destroyUI()
	self._dragTrigger = nil
	self._btnReturn = nil
	self._btnHome = nil
	self._btnExplain = nil
	self._smallHero = nil
	self._wholeHero = nil
	self._btnCheck = nil
	self._btnPreViewBattle = nil
	self._clotheInfoScroll = nil
	self._clothScroll = nil
	self._labSkinDesc = nil
	self._buyInfoGO = nil
	self._btnBuy = nil
	self._btnWear = nil
	self._wearingTipsGo = nil
	self._labgainTips = nil
	self._btnPre = nil
	self._btnNext = nil
	self._scroll.TotalCellNum = 0
	self._scroll = nil
	self._scrollLayerComp = nil
	self._scrollLayerTransition = nil
	self._scrollLayerListViewWidth = nil
	self._scrollLayerListAdapter = nil
	self._scrollLayerListDragTrigger = nil
	self._gapCellCount = nil
	self._beginPosition = nil
	self._gainTipGo = nil
	self._labName = nil
	self._btnCloth = nil
	self._btnBg = nil
	self._togCloth = nil
	self._togBg = nil
	self._bgScroll = nil

	self._raycastProxy:RemoveClickListener()
	self._raycastProxy:RemoveBeginDragListener()
	self._raycastProxy:RemoveDragListener()
	self._raycastProxy:RemoveEndDragListener()

	self._raycastProxy = nil

	self._compositeTouch:ClearCheckerList()

	self._compositeTouch = nil
	self._viewAnim = nil
end

function M:bindEvents()
	self._btnReturn:AddClickListener(self._onClickReturn, self)
	self._btnHome:AddClickListener(self._onClickHome, self)
	self._btnExplain:AddClickListener(self._onClickExplain, self)
	self._btnBuy:AddClickListener(self._onClickBuySkin, self)
	self._btnWear:AddClickListener(self._onClickWearSkin, self)
	self._btnPreViewBattle:AddClickListener(self._onClickPreViewBattle, self)
	self._btnCheck:AddClickListener(self._onClickCheck, self)
	self._btnPre:AddClickListener(self._onClickPrevious, self)
	self._btnNext:AddClickListener(self._onClickNext, self)
	self._scrollLayerListDragTrigger:AddBeginDragListener(self._onClickDragStart, self, 0)
	self._scrollLayerListDragTrigger:AddEndDragListener(self._onClickDragEnd, self, 0)
	self._scrollLayerListAdapter:AddOnValueChanged(self._scrollSkinLayerListValueChanged, self)
	self._scrollBgLayerListDragTrigger:AddBeginDragListener(self._onClickDragStart, self, 0)
	self._scrollBgLayerListDragTrigger:AddEndDragListener(self._onClickDragEnd, self, 0)
	self._scrollBgLayerListAdapter:AddOnValueChanged(self._scrollBgLayerListValueChanged, self)
	self._dragTrigger:AddBeginDragListener(self._onBeginDrag, self)
	self._dragTrigger:AddEndDragListener(self._onEndDrag, self)
	self._btnCloth:AddClickListener(self._onClickCloth, self)
	self._btnBg:AddClickListener(self._onClickBg, self)
	GlobalDispatcher:addEventListener(EventType.REFRESH_HERO_SKIN_EVENT, self._refreshHeroSkin, self)
	self._btnReturn1:AddClickListener(self._hidePortraitViewWithAnim, self)
	self._btnReturn2:AddClickListener(self._hidePortraitView, self)
	self._btnHome1:AddClickListener(self._onClickHome, self)
	self._btnHome2:AddClickListener(self._onClickHome, self)
	self._switch1Btn:AddClickListener(self._onClickSwitchToVertical, self)
	self._share1Btn:AddClickListener(self._onClickShareBtn, self)
	self._switch2Btn:AddClickListener(self._onClickSwitchToHorizon, self)
	self._share2Btn:AddClickListener(self._onClickShareBtn, self)
	self:registerLocalNotify(EventType.FW_VIEW_ANIMATION_DONE_EVENT, self._animationDoneListener, self)
end

function M:unbindEvents()
	self._btnReturn:RemoveClickListener()
	self._btnHome:RemoveClickListener()
	self._btnExplain:RemoveClickListener()
	self._btnBuy:RemoveClickListener()
	self._btnWear:RemoveClickListener()
	self._btnPreViewBattle:RemoveClickListener()
	self._btnCheck:RemoveClickListener()
	self._btnPre:RemoveClickListener()
	self._btnNext:RemoveClickListener()
	self._btnCloth:RemoveClickListener()
	self._btnBg:RemoveClickListener()
	self._scrollLayerListDragTrigger:RemoveBeginDragListener()
	self._scrollLayerListDragTrigger:RemoveEndDragListener()
	self._scrollLayerListAdapter:RemoveOnValueChanged()
	self._scrollBgLayerListDragTrigger:RemoveBeginDragListener()
	self._scrollBgLayerListDragTrigger:RemoveEndDragListener()
	self._scrollBgLayerListAdapter:RemoveOnValueChanged()
	self._dragTrigger:RemoveBeginDragListener()
	self._dragTrigger:RemoveEndDragListener()
	GlobalDispatcher:removeEventListener(EventType.REFRESH_HERO_SKIN_EVENT, self._refreshHeroSkin, self)
	self._btnReturn1:RemoveClickListener()
	self._btnReturn2:RemoveClickListener()
	self._btnHome1:RemoveClickListener()
	self._btnHome2:RemoveClickListener()
	self._switch1Btn:RemoveClickListener()
	self._share1Btn:RemoveClickListener()
	self._switch2Btn:RemoveClickListener()
	self._share2Btn:RemoveClickListener()
	self:unregisterLocalNotify(EventType.FW_VIEW_ANIMATION_DONE_EVENT, self._animationDoneListener, self)
end

function M:onEnter()
	self._skinList = {}

	self:_reset()
	self:_setDefaultState()

	local viewPageMo = HeroDepotModel.instance:getViewPageMo()

	self._heroData = viewPageMo and viewPageMo.hero or false
	self._index = viewPageMo and viewPageMo.index or 0
	self._allHeroList = viewPageMo and viewPageMo.list or false
	self._maxHeroCount = #self._allHeroList
	self._tabStr = self:getFirstParam()

	local herodata = HeroDepotModel.instance:getHeroInfoByID(self._heroData:getId())

	self._ownHero = herodata ~= nil and herodata ~= false

	self:_reqSkinData(self._heroData:getId())

	local cachePhotoRole

	if cachePhotoRole then
		self._useOtherPhotoHor = true
		self._photoUnitHor = cachePhotoRole
		self._rawImgRoleHor.texture = CharacterSystemModel.instance:getRawImgRole().texture

		self:_refreshSpinPos(self._photoUnitHor, self._photoSkinCenterPointGo.transform, IconType.CharaterIcon)
	else
		self._useOtherPhotoHor = false
		self._photoUnitHor = PhotoUnit.Get(self._rawImgRoleHor.gameObject)
	end

	self:_initBgPanel()
	self:_initPortrait()

	if self._tabStr then
		if self._tabStr == "background" then
			self._toggleGroup:TryActiveChildOn(self._togBg, true)
			self:_onClickBg()
		else
			self._toggleGroup:TryActiveChildOn(self._togCloth, true)
			self:_onClickCloth()
		end
	else
		self._toggleGroup:TryActiveChildOn(self._togCloth, true)
		self:_onClickCloth()
	end

	self._viewAnim:StopTimelineAni()
	self._viewAnim:PlayAniByName("open")
end

function M:onExit()
	self._curSelectSkinId = false
	self._curUseSkinId = false
	self._curSkinMo = false

	if self._useOtherPhotoHor then
		local characterModelId = self._skinList[self._skinIndex]:getModelId()

		if self._heroData:getModelId() ~= characterModelId then
			self:_refreshSpine(true)
		end
	else
		self._photoUnitHor:clear()
	end

	self._photoUnitVer:clear()
	self._bg1:ClearImage()
	self._bg2:ClearImage()
end

function M:_onClickReturn()
	self:back()
	self._viewAnim:StopTimelineAni()
end

function M:_animationDoneListener(e, tagName)
	if tagName == "close" then
		self:back()
	elseif tagName == "chakan" then
		self:_switchCheck()
	end
end

function M:_onClickHome()
	self:close()
	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_TO_MAIN)
end

function M:_onClickExplain()
	return
end

function M:_reqSkinData(heroid)
	if self._ownHero then
		HeroSkinAgent.instance:sendHeroSkinInfoRequest(heroid)
	else
		GlobalDispatcher:dispatchEvent(EventType.REFRESH_HERO_SKIN_EVENT)
	end
end

function M:_initSkinData(isBuy)
	self._skinList = HeroSkinModel.instance:getSkinListByHeroId(self._heroData:getId())

	table.sort(self._skinList, HeroSkinModel.instance.skinSortFunc)

	local curIndex = isBuy and self._skinIndex or 1

	if not isBuy then
		if self._skinList then
			for i = 1, #self._skinList do
				if self._skinList[i]:getIsWear() then
					self._curUseSkinId = self._skinList[i]:getId()
					curIndex = i

					break
				end
			end
		end

		self._curSelectSkinId = self._curUseSkinId
	end

	self._scroll.TotalCellNum = #self._skinList + 2 * self._gapCellCount

	self:updateSkinSelectedIndex(curIndex, false, true)
end

function M:updateSkinSelectedIndex(selectedIndex, animated, isInit)
	if #self._skinList == 0 then
		return
	end

	self:_loadClothesInfo(selectedIndex, isInit)

	selectedIndex = selectedIndex + self._gapCellCount

	local targetX = kCellWidth * (selectedIndex - 0.5) - self._scrollLayerListViewWidth * 0.5

	if not animated then
		self._scroll.HorizontalScrollPixel = targetX
	else
		self._scrollLayerTransition:FocusCellInCenter(selectedIndex - self._gapCellCount, animated)
	end
end

function M:_loadClothesInfo(index, isInit)
	goutil.setActive(self._btnPre.gameObject, index > 1)
	goutil.setActive(self._btnNext.gameObject, index < #self._skinList)

	if self._skinIndex == index and not isInit then
		self:_refreshSkinInfo()

		return
	end

	if index then
		self._skinIndex = index
	end

	local characterModelId = self._skinList[self._skinIndex]:getModelId()
	local transform = self._photoSkinCenterPointGo.transform
	local cutCenterPos = {
		transform.anchoredPosition.x,
		transform.anchoredPosition.y,
		transform.localScale.x,
		transform.localScale.y
	}
	local paramTable = {
		isShowEgg = true,
		isShowEnter = true,
		photo = self._photoUnitHor,
		modelId = characterModelId,
		heroId = self._heroData:getId(),
		cutCenterPos = cutCenterPos,
		iconType = IconType.CharaterIcon,
		skinId = self._skinList[self._skinIndex]:getId(),
		func = self._onRoleSpineLoadedCallBack,
		handle = self,
		param = param
	}

	paramTable.needIgnore = true

	SpineCutShowLoader.showSpineLihuiPhoto(paramTable)
	self:_refreshSkinInfo()
end

function M:_refreshSkinInfo()
	if self._tabIndex == 2 then
		return
	end

	local skinMo = self._skinList[self._skinIndex]

	if not skinMo then
		return
	end

	GlobalDispatcher:dispatchEvent(EventType.SET_TOP_COST_STATE_EVENT, false, nil)

	self._curSkinMo = skinMo

	self:_refreshViewBtn(skinMo)

	self._labName.text = skinMo:getName()
	self._labSkinDesc.text = string.format(skinMo:getDesc(), self._heroData:getName())

	settimer(0.02, self._updateDescScroll, self, false)

	if skinMo:getIsWear() then
		goutil.setActive(self._wearingTipsGo, true)
		goutil.setActive(self._btnWear.gameObject, false)
		goutil.setActive(self._buyInfoGO, false)
		goutil.setActive(self._gainTipGo, false)

		self._labgainTips.text = ""
	elseif skinMo:getIsUnlock() then
		goutil.setActive(self._wearingTipsGo, false)
		goutil.setActive(self._btnWear.gameObject, true)
		goutil.setActive(self._buyInfoGO, false)

		self._labgainTips.text = ""

		goutil.setActive(self._gainTipGo, false)
	else
		goutil.setActive(self._wearingTipsGo, false)
		goutil.setActive(self._btnWear.gameObject, false)
		goutil.setActive(self._gainTipGo, true)

		self._labgainTips.text = skinMo:getWayDesc()
	end
end

function M:_getMoneyShowType(itemid)
	if itemid == CommEnum.CurrencyCodeEnum.YtjjCode then
		return CommEnum.MoneyShowType.OnlySkinShowType
	elseif itemid == CommEnum.CurrencyCodeEnum.LzbCode then
		return CommEnum.MoneyShowType.OnlyMoneyShowType
	elseif itemid == CommEnum.CurrencyCodeEnum.TlCode then
		return CommEnum.MoneyShowType.OnlyDiamondShowType
	end
end

function M:_getColor(cur, need)
	return need <= cur and "#EEEEEE" or "#FF0000"
end

function M:getPrefabSkinItem()
	local path = ResName.Intelligence_cloth_item
	local prefab = self._viewPresentor:getPrefab(path)

	return prefab
end

function M:_onSkinCellUpdate(cellRect, curIndex, prevIndex)
	curIndex = curIndex + 1 - self._gapCellCount

	local obj

	if cellRect.childCount == 0 then
		local prefab = self:getPrefabSkinItem()

		obj = Astral.GameObjectUtil.CloneAndSetParent(prefab, cellRect.transform, nil)
	else
		obj = cellRect:GetChild(0).gameObject
	end

	local list = self._skinList
	local data = list[curIndex]

	if not data then
		obj.gameObject:SetActive(false)

		return
	end

	local maxCount = #self._skinList
	local objBeh = Astral.LuaComponentContainer.Add(obj, CharacterIntelligenceItem)

	objBeh.view = self

	objBeh:setUseAndSelectSkinId(self._curUseSkinId, self._curSelectSkinId)
	objBeh:setCellTransform(cellRect)
	objBeh:updateData(data, curIndex, maxCount)
	objBeh:setClickCallBack(function()
		self:_onClickSkinItem(curIndex)
	end, self)

	obj.name = "item"

	if curIndex >= 1 and curIndex <= #self._skinList then
		obj.gameObject:SetActive(true)
	else
		obj.gameObject:SetActive(false)
	end

	Astral.TransformUtil.SetLocalScale(obj.transform, 1, 1, 1)
	Astral.TransformUtil.SetLocalPos(obj.transform, 0, 0, 0)
	self:_updateSkinCellScale(objBeh)

	self._cacheSkinCellBehaviors[objBeh] = true
end

function M:_refreshHeroSkin(name, isBuy)
	self:_initSkinData(isBuy)
end

function M:_refreshBackground()
	self._bg1:SetImage(string.format("ui/bigbg/charactersystem/background/%d_1.png", self._curSelectBgId), nil, self)
	self._bg2:SetImage(string.format("ui/bigbg/charactersystem/background/%d_2.png", self._curSelectBgId), nil, self)
end

function M:getBgLocalStorage()
	local playerId = PlayerModel.instance:getId()
	local key = "portraitBg" .. playerId

	return Astral.LocalStorage.Instance:GetInt(key, 1601001)
end

function M:setLocalStorage(id)
	local playerId = PlayerModel.instance:getId()
	local key = "portraitBg" .. playerId

	Astral.LocalStorage.Instance:SetInt(key, id)
end

function M:_initBgPanel()
	local curUseBgId = self:getBgLocalStorage()
	local bgList = BackpackConfig.instance:getItemsInfoByTS(16, 1)

	self._bgList = {}

	for i, v in pairs(bgList) do
		local itemData = {}

		itemData.co = v
		itemData.hasGot = ItemModel.instance:getItemCountByItemId(v.id) > 0

		if v.id == 1601001 then
			itemData.hasGot = true
		end

		table.insert(self._bgList, itemData)
	end

	table.sort(self._bgList, function(item1, item2)
		if item1.hasGot == item2.hasGot then
			return item1.co.id < item2.co.id
		else
			return item1.hasGot
		end
	end)

	for i, v in ipairs(self._bgList) do
		if curUseBgId == v.co.id then
			self._curUseBgIndex = i
		end
	end

	self._curUseBgIndex = self._curUseBgIndex and self._curUseBgIndex or 1
	self._curSelectBgIndex = self._curUseBgIndex
	self._curUseBgId = self:getBgLocalStorage()
	self._curSelectBgId = self._curUseBgId

	self:_refreshBackground()

	self._scrollBg.TotalCellNum = #self._bgList + 2 * self._gapCellCount
end

function M:_scrollBgLayerListValueChanged()
	if not self._cacheBgCellBehaviors then
		return
	end

	local centerHorizontalPixel = self._scrollBg.HorizontalScrollPixel + self._scrollBgLayerListViewWidth * 0.5
	local maxDeltaCellHorizontalPixel = kCellWidth * 0.5
	local velocitx = math.abs(self._scrollBgLayerComp.velocity.x)

	if not self._isScrollLayerListDragging and velocitx > 0 and velocitx < 150 then
		self._scrollBgLayerComp:StopMovement()

		for cellBehaviour, _ in pairs(self._cacheBgCellBehaviors) do
			if cellBehaviour:isActive() then
				local deltaPox = cellBehaviour:getPositionX() - centerHorizontalPixel

				if deltaPox >= -maxDeltaCellHorizontalPixel and deltaPox < maxDeltaCellHorizontalPixel then
					local index = cellBehaviour:getIndex()

					self:updateBgSelectedIndex(index, true)
				end
			end
		end
	else
		local minDeltaCellHorizontalPixel = kCellWidth * 0.3

		for cellBehaviour, _ in pairs(self._cacheBgCellBehaviors) do
			self:_updateBgCellScale(cellBehaviour, centerHorizontalPixel, maxDeltaCellHorizontalPixel, minDeltaCellHorizontalPixel)
		end
	end
end

function M:_updateBgCellScale(cellBehaviour, centerHorizontalPixel, maxDeltaCellHorizontalPixel, minDeltaCellHorizontalPixel)
	if not cellBehaviour:isActive() then
		return
	end

	centerHorizontalPixel = centerHorizontalPixel or self._scrollBg.HorizontalScrollPixel + self._scrollBgLayerListViewWidth * 0.5
	maxDeltaCellHorizontalPixel = maxDeltaCellHorizontalPixel or kCellWidth * 0.5
	minDeltaCellHorizontalPixel = minDeltaCellHorizontalPixel or kCellWidth * 0.3

	local deltaPox = cellBehaviour:getPositionX() - centerHorizontalPixel

	if deltaPox >= -maxDeltaCellHorizontalPixel and deltaPox < maxDeltaCellHorizontalPixel then
		if deltaPox >= -minDeltaCellHorizontalPixel and deltaPox <= minDeltaCellHorizontalPixel then
			cellBehaviour:setScale(1)
			cellBehaviour:setAlpha(1)
		else
			local offset = 1 - math.abs(deltaPox / maxDeltaCellHorizontalPixel) * 0.3

			cellBehaviour:setScale(offset)
			cellBehaviour:setAlpha(offset)
		end
	else
		cellBehaviour:setScale(0.82)
		cellBehaviour:setAlpha(0.9)
	end
end

function M:_updateBgPanel(selectedIndex)
	self._curSelectBgIndex = selectedIndex
	self._curSelectBgId = self._bgList[self._curSelectBgIndex].co.id

	goutil.setActive(self._btnPre.gameObject, selectedIndex > 1)
	goutil.setActive(self._btnNext.gameObject, selectedIndex < #self._bgList)
	goutil.setActive(self._buyInfoGO, false)

	local bgCO = BackpackConfig.instance:getItemInfoByItemId(self._curSelectBgId)

	self._labName.text = bgCO.name
	self._labSkinDesc.text = bgCO.desc

	settimer(0.02, self._updateDescScroll, self, false)

	local bg = self._bgList[self._curSelectBgIndex]

	if bg.hasGot then
		if self._curUseBgIndex == self._curSelectBgIndex then
			goutil.setActive(self._btnWear.gameObject, false)
			goutil.setActive(self._gainTipGo, false)
			goutil.setActive(self._wearingTipsGo, true)
		else
			goutil.setActive(self._btnWear.gameObject, true)
			goutil.setActive(self._gainTipGo, false)
			goutil.setActive(self._wearingTipsGo, false)
		end
	else
		goutil.setActive(self._btnWear.gameObject, false)
		goutil.setActive(self._gainTipGo, true)
		goutil.setActive(self._wearingTipsGo, false)

		self._labgainTips.text = bgCO.getway
	end

	self:_refreshBackground()
end

function M:_updateDescScroll()
	local enable = self._labSkinDesc.preferredHeight >= 56

	self._labDescScroll.enabled = enable

	if not enable then
		self._labDescScroll:StopMovement()

		self._labDescScroll.verticalNormalizedPosition = 0
	end
end

function M:updateBgSelectedIndex(selectedIndex, animated, isInit)
	self:_updateBgPanel(selectedIndex)

	selectedIndex = selectedIndex + self._gapCellCount

	local targetX = kCellWidth * (selectedIndex - 0.5) - self._scrollBgLayerListViewWidth * 0.5

	if not animated then
		self._scrollBg.HorizontalScrollPixel = targetX
	else
		self._scrollBgLayerTransition:FocusCellInCenter(selectedIndex - self._gapCellCount, animated)
	end
end

function M:getPrefabBgItem()
	local path = ResName.Intelligence_background_item
	local prefab = self._viewPresentor:getPrefab(path)

	return prefab
end

function M:_onBgCellUpdate(cellRect, curIndex, prevIndex)
	if not self._gapCellCount then
		return
	end

	curIndex = curIndex + 1 - self._gapCellCount

	local obj

	if cellRect.childCount == 0 then
		local prefab = self:getPrefabBgItem()

		obj = Astral.GameObjectUtil.CloneAndSetParent(prefab, cellRect.transform, nil)
	else
		obj = cellRect:GetChild(0).gameObject
	end

	local list = self._bgList
	local data = list[curIndex]

	if not data then
		obj.gameObject:SetActive(false)

		return
	end

	local maxCount = #self._bgList
	local objBeh = Astral.LuaComponentContainer.Add(obj, CharacterBackgroundItem)

	objBeh.view = self

	objBeh:setUseAndSelectBgId(self._curUseBgId, self._curSelectBgId)
	objBeh:setCellTransform(cellRect)
	objBeh:updateData(data, curIndex, maxCount)
	objBeh:setClickCallBack(function()
		self:_onClickBgItem(curIndex)
	end, self)

	obj.name = "item"

	if curIndex >= 1 and curIndex <= #self._bgList then
		obj.gameObject:SetActive(true)
	else
		obj.gameObject:SetActive(false)
	end

	Astral.TransformUtil.SetLocalScale(obj.transform, 1, 1, 1)
	Astral.TransformUtil.SetLocalPos(obj.transform, 0, 0, 0)
	self:_updateBgCellScale(objBeh)

	self._cacheBgCellBehaviors[objBeh] = true
end

function M:_onClickBgItem(curIndex)
	if self._isScrollLayerListDragging then
		return
	end

	self:updateBgSelectedIndex(curIndex, true)
	self._scrollBg:UpdateCells()
end

function M:_onClickShareBtn()
	local shareType = ShareEnum.CG
	local fileName = string.format("CG_%s", self:getId())
	local showToast = true
	local shareOpen = ShareFacade.instance:openShare(shareType, fileName, showToast, self._onShareViewExist, self)
end

function M:_onShareViewExist()
	printWarn("-----onShareViewExist")
end

function M:_setClickSwitchToHorizon()
	self._isHorizon = true

	goutil.setActive(self._horizonPanelGo, true)
	goutil.setActive(self._verticalPanelGo, false)
	goutil.setActive(self._spinePanel1Go, true)
	goutil.setActive(self._spinePanel2Go, false)
	goutil.setActive(self._bg1.gameObject, true)
	goutil.setActive(self._bg2.gameObject, false)
	Astral.TransformUtil.SetLocalPos(self._spinePanelGo.transform, 0, 0, 0)
	Astral.TransformUtil.SetLocalScale(self._spinePanelGo.transform, 1, 1, 1)
end

function M:_onClickSwitchToHorizon()
	self:_setClickSwitchToHorizon()
	self:_refreshSpine(true)
end

function M:_refreshSpine(hor, centerTr)
	local transform = centerTr

	transform = transform or hor and self._photo1CenterPointGo.transform or self._photo2CenterPointGo.transform

	local cutCenterPos = {
		transform.anchoredPosition.x,
		transform.anchoredPosition.y,
		transform.localScale.x,
		transform.localScale.y
	}
	local paramTable = {
		modelId = self._heroData:getModelId(),
		cutCenterPos = cutCenterPos,
		heroId = self._heroData:getId(),
		skinId = self._curSelectSkinId
	}

	paramTable.photo = hor and self._photoUnitHor or self._photoUnitVer
	paramTable.iconType = hor and IconType.CharaterIcon or IconType.CharaterBust
	paramTable.isShowEgg = true
	paramTable.isShowEnter = false
	paramTable.needIgnore = true

	SpineCutShowLoader.showSpineLihuiPhoto(paramTable)
end

function M:_onClickSwitchToVertical()
	self._isHorizon = false

	goutil.setActive(self._horizonPanelGo, false)
	goutil.setActive(self._verticalPanelGo, true)
	goutil.setActive(self._spinePanel1Go, false)
	goutil.setActive(self._spinePanel2Go, true)
	goutil.setActive(self._bg1.gameObject, false)
	goutil.setActive(self._bg2.gameObject, true)
	self:_refreshSpine(false)
	Astral.TransformUtil.SetLocalPos(self._spinePanelGo.transform, 0, 0, 0)
	Astral.TransformUtil.SetLocalScale(self._spinePanelGo.transform, 1, 1, 1)
end

function M:_refreshSpinPos(photoUnit, centerTr, iconType)
	local transform = centerTr
	local cutCenterPos = {
		transform.anchoredPosition.x,
		transform.anchoredPosition.y,
		transform.localScale.x,
		transform.localScale.y
	}
	local paramTable = {
		photo = photoUnit,
		modelId = self._heroData:getModelId(),
		cutCenterPos = cutCenterPos,
		iconType = iconType,
		heroId = self._heroData:getId()
	}

	paramTable.needIgnore = true
	paramTable.needTweenScale = true

	local cutInfo = SpineCutShowLoader.getSpineLiHuiParam(paramTable)
	local localx, localy, scalex, scaley = cutInfo[1], cutInfo[2], cutInfo[3], cutInfo[4]
	local roleUnit = photoUnit:getUnit()

	roleUnit.go.transform:DOKill(false)

	local orgPosX = Astral.TransformUtil.GetLocalPosX(roleUnit.go.transform)
	local orgPosY = Astral.TransformUtil.GetLocalPosY(roleUnit.go.transform)
	local samePos = math.floor(orgPosX * 100) == math.floor(localx * 100)

	if samePos and math.floor(orgPosY * 100) == math.floor(localy * 100) then
		samePos = false
	end

	if samePos then
		return
	end

	roleUnit.go.transform:DOScale(scalex, 0.25):SetEase(DG.Tweening.Ease.Linear)
	roleUnit.go.transform:DOLocalMoveX(localx, 0.25):SetEase(DG.Tweening.Ease.Linear)
	roleUnit.go.transform:DOLocalMoveY(localy, 0.25):SetEase(DG.Tweening.Ease.Linear)
end

function M:_onRayCastHit()
	if self._isBgSelectOpen then
		self._isBgSelectOpen = false

		goutil.setActive(self._bgPanelGo, false)

		return
	end

	if self._isUiHide then
		self:_showPortraitUI()
	else
		self:_hidePortraitUI()
	end
end

function M:_onBeginDragPortrait(x, y, pointerId)
	if self._singlePointerId > 0 then
		self._singlePointerId = -999

		return
	end

	self._singleDragingId = pointerId
	self._startDragGoX = self._spinePanelGo.transform.localPosition.x
	self._startDragGoY = self._spinePanelGo.transform.localPosition.y
	self._startDragScreenX = x
	self._startDragScreenY = y
end

function M:_onDragPortrait(x, y, pointerId)
	self:_hidePortraitUI()

	if self._isMultiDrag then
		return
	end

	if self._singleDragingId ~= pointerId then
		return
	end

	self:_resetHideUiTimer()

	local dx = x - self._startDragScreenX
	local dy = y - self._startDragScreenY
	local positionX = self._startDragGoX + dx
	local positionY = self._startDragGoY + dy

	positionX, positionY = self:_limitPostion(positionX, positionY)

	Astral.TransformUtil.SetLocalPos(self._spinePanelGo.transform, positionX, positionY, 0)
end

function M:_limitPostion(positionX, positionY)
	local scale = self._spinePanelGo.transform.localScale.x

	if scale < 1 then
		scale = 1
	end

	local kx = 55
	local bx = 605
	local ky = 340
	local by = 270
	local maxPositionX = kx * scale + bx
	local minPositionX = -maxPositionX
	local maxPositionY = ky * scale + by
	local minPositionY = -maxPositionX

	if self._isHorizon then
		positionX = maxPositionX < positionX and maxPositionX or positionX
		positionX = positionX < minPositionX and minPositionX or positionX
		positionY = maxPositionY < positionY and maxPositionY or positionY

		if positionY < minPositionY then
			positionY = minPositionY or positionY
		end
	else
		positionX = positionX > maxPositionY * scale and maxPositionY * scale or positionX
		positionX = positionX < minPositionY * scale and minPositionY * scale or positionX
		positionY = positionY > maxPositionX * scale and maxPositionX * scale or positionY
		positionY = positionY < minPositionX * scale and minPositionX * scale or positionY
	end

	return positionX, positionY
end

function M:_limitScale()
	if self._currentScale > maxScale then
		self._currentScale = maxScale
	elseif self._currentScale < minScale then
		self._currentScale = minScale
	end
end

function M:_onEndDragPortrait(x, y, pointerId)
	self._startDragX = nil
	self._startDragY = nil

	if self._singleDragingId == pointerId then
		self._singleDragingId = -999
	end

	self._isMultiDrag = false
end

function M:_onMultiDragListener(centerX, centerY, scale, distance, isFirstMultiDrag)
	self._singlePointerId = -999
	self._isMultiDrag = true

	self:_resetHideUiTimer()

	if isFirstMultiDrag then
		local position = goutil.screenToLocalPos(Vector2.New(centerX, centerY), self.mainGO.transform)
		local positionX = self._spinePanelGo.transform.localPosition.x - position.x
		local positionY = self._spinePanelGo.transform.localPosition.y - position.y

		positionX, positionY = self:_limitPostion(positionX, positionY)
		self._multiDragTargetX = positionX
		self._multiDragTargetY = positionY
		self._lastDistance = distance
		self._currentScale = self._spinePanelGo.transform.localScale.x
	end

	local dDistance = distance - self._lastDistance

	self._lastDistance = distance
	self._scaleChange = 1 + dDistance / 2000

	if self._scaleChange < 0.5 then
		self._scaleChange = 0.5
	end

	self._currentScale = self._currentScale * self._scaleChange

	self:_limitScale()
	Astral.TransformUtil.SetLocalScale(self._spinePanelGo.transform, self._currentScale, self._currentScale, 1)
	self:_slowMoveToCenterWhenMultiDrag()
end

function M:_slowMoveToCenterWhenMultiDrag()
	local positionX, positionY

	self._multiDragTargetX = self._multiDragTargetX * self._scaleChange
	self._multiDragTargetY = self._multiDragTargetY * self._scaleChange
	self._multiDragTargetX, self._multiDragTargetY = self:_limitPostion(self._multiDragTargetX, self._multiDragTargetY)

	local dx = self._multiDragTargetX - self._spinePanelGo.transform.localPosition.x * self._scaleChange
	local dy = self._multiDragTargetY - self._spinePanelGo.transform.localPosition.y * self._scaleChange

	if math.abs(dx) < 50 then
		positionX = self._multiDragTargetX
	elseif math.abs(dx) < 500 then
		if dx < 0 then
			positionX = self._spinePanelGo.transform.localPosition.x * self._scaleChange - 50
		else
			positionX = self._spinePanelGo.transform.localPosition.x * self._scaleChange + 50
		end
	else
		positionX = self._spinePanelGo.transform.localPosition.x * self._scaleChange + dx / 10
	end

	if math.abs(dy) < 50 then
		positionY = self._multiDragTargetY
	elseif math.abs(dy) < 500 then
		if dy < 0 then
			positionY = self._spinePanelGo.transform.localPosition.y * self._scaleChange - 50
		else
			positionY = self._spinePanelGo.transform.localPosition.y * self._scaleChange + 50
		end
	else
		positionY = self._spinePanelGo.transform.localPosition.y * self._scaleChange + dy / 10
	end

	positionX, positionY = self:_limitPostion(positionX, positionY)

	Astral.TransformUtil.SetLocalPos(self._spinePanelGo.transform, positionX, positionY, 0)
end

function M:_resetHideUiTimer()
	removetimer(self._hidePortraitUI, self)
	settimer(HideUITime, self._hidePortraitUI, self, false)
end

function M:_hidePortraitUI()
	removetimer(self._hidePortraitUI, self)
	goutil.setActive(self._uiPanelGo, false)

	self._isUiHide = true
end

function M:_showPortraitUI()
	self._isUiHide = false

	goutil.setActive(self._uiPanelGo, true)
end

function M:_onClickSkinItem(curIndex)
	if self._isScrollLayerListDragging then
		return
	end

	goutil.setActive(self._btnPre.gameObject, curIndex > 1)
	goutil.setActive(self._btnNext.gameObject, curIndex < #self._skinList)

	local itemData = self._skinList[curIndex]

	if itemData then
		if self._curSelectSkinId == itemData:getId() then
			return
		end

		self._curSelectSkinId = itemData:getId()
	end

	self._scroll:UpdateCells()
	self:updateSkinSelectedIndex(curIndex, true)
end

function M:_onClickDragStart()
	self._isScrollLayerListDragging = true
	self._pressDownPosition = MainPlayerInputFacade.instance:getScreenPosition()
end

function M:_onClickDragEnd()
	self._isScrollLayerListDragging = false
	self._pressEndPosition = MainPlayerInputFacade.instance:getScreenPosition()

	local xDistance = self._pressEndPosition.x - self._pressDownPosition.x
	local yDistance = self._pressEndPosition.y - self._pressDownPosition.y

	if yDistance < 0 then
		yDistance = -yDistance
	end

	if xDistance > 0 then
		if xDistance > self._dragOffset and yDistance < xDistance then
			self:_onClickPrevious()
		end
	elseif -xDistance > self._dragOffset and yDistance < -xDistance then
		self:_onClickNext()
	end
end

function M:_onClickPrevious()
	if self._tabIndex == 1 then
		self:_onSkinTabClickPrevious()
	else
		self:_onBgTabClickPrevious()
	end
end

function M:_onClickNext()
	if self._tabIndex == 1 then
		self:_onSkinTabClickNext()
	else
		self:_onBgTabClickNext()
	end
end

function M:_onSkinTabClickPrevious()
	if not self._skinList then
		return
	end

	if #self._skinList == 1 then
		return
	end

	local index = self._skinIndex - 1

	if index <= 0 then
		return
	end

	self:_onClickSkinItem(index)
end

function M:_onSkinTabClickNext()
	if not self._skinList then
		return
	end

	if #self._skinList == 1 then
		return
	end

	local index = self._skinIndex + 1

	if index > #self._skinList then
		return
	end

	self:_onClickSkinItem(index)
end

function M:_onBgTabClickPrevious()
	if not self._bgList then
		return
	end

	if #self._bgList == 1 then
		return
	end

	local index = self._curSelectBgIndex - 1

	if index <= 0 then
		return
	end

	self:_onClickBgItem(index)
end

function M:_onBgTabClickNext()
	if not self._bgList then
		return
	end

	if #self._bgList == 1 then
		return
	end

	local index = self._curSelectBgIndex + 1

	if index > #self._bgList then
		return
	end

	self:_onClickBgItem(index)
end

function M:_reset()
	self._dragOffset = 20
	self._pressDownPosition = 0
	self._pressEndPosition = 0

	table.clear(self._cacheSkinCellBehaviors)

	self._cacheSkinCellBehaviors = {}

	table.clear(self._cacheBgCellBehaviors)

	self._cacheBgCellBehaviors = {}
end

function M:_scrollSkinLayerListValueChanged()
	if not self._cacheSkinCellBehaviors then
		return
	end

	local centerHorizontalPixel = self._scroll.HorizontalScrollPixel + self._scrollLayerListViewWidth * 0.5
	local maxDeltaCellHorizontalPixel = kCellWidth * 0.5
	local velocitx = math.abs(self._scrollLayerComp.velocity.x)

	if not self._isScrollLayerListDragging and velocitx > 0 and velocitx < 150 then
		self._scrollLayerComp:StopMovement()

		for cellBehaviour, _ in pairs(self._cacheSkinCellBehaviors) do
			if cellBehaviour:isActive() then
				local deltaPox = cellBehaviour:getPositionX() - centerHorizontalPixel

				if deltaPox >= -maxDeltaCellHorizontalPixel and deltaPox < maxDeltaCellHorizontalPixel then
					local index = cellBehaviour:getIndex()

					self:updateSkinSelectedIndex(index, true)
				end
			end
		end
	else
		local minDeltaCellHorizontalPixel = kCellWidth * 0.3

		for cellBehaviour, _ in pairs(self._cacheSkinCellBehaviors) do
			self:_updateSkinCellScale(cellBehaviour, centerHorizontalPixel, maxDeltaCellHorizontalPixel, minDeltaCellHorizontalPixel)
		end
	end
end

function M:_updateSkinCellScale(cellBehaviour, centerHorizontalPixel, maxDeltaCellHorizontalPixel, minDeltaCellHorizontalPixel)
	if not cellBehaviour:isActive() then
		return
	end

	centerHorizontalPixel = centerHorizontalPixel or self._scroll.HorizontalScrollPixel + self._scrollLayerListViewWidth * 0.5
	maxDeltaCellHorizontalPixel = maxDeltaCellHorizontalPixel or kCellWidth * 0.5
	minDeltaCellHorizontalPixel = minDeltaCellHorizontalPixel or kCellWidth * 0.3

	local deltaPox = cellBehaviour:getPositionX() - centerHorizontalPixel

	if deltaPox >= -maxDeltaCellHorizontalPixel and deltaPox < maxDeltaCellHorizontalPixel then
		if deltaPox >= -minDeltaCellHorizontalPixel and deltaPox <= minDeltaCellHorizontalPixel then
			cellBehaviour:setScale(1)
			cellBehaviour:setAlpha(1)
		else
			local offset = 1 - math.abs(deltaPox / maxDeltaCellHorizontalPixel) * 0.3

			cellBehaviour:setScale(offset)
			cellBehaviour:setAlpha(offset)
		end
	else
		cellBehaviour:setScale(0.82)
		cellBehaviour:setAlpha(0.9)
	end
end

function M:_onClickBuySkin()
	if self._curNum < self._curNeedNum then
		FloatWordMgr.instance:show(lang("t_prop_not_enough"))

		return
	end

	local dialog = Dialog.showMessage(lang("tip_title"), lang("tip_sure_buy_cloth"))

	dialog:setConfirmListener(self._onSendBuySkin, self)
end

function M:_onSendBuySkin()
	if self._ownHero then
		printWarn("直接购买功能已删除, 请打开商城来购买")
	else
		printWarn("未拥有此角色，屏蔽操作")
	end
end

function M:_onClickWearSkin()
	if self._tabIndex == 1 then
		if self._ownHero then
			local voiceRes = string.format("speech_%s_huanzhuan", self._heroData:getId())

			CriwareAudioFacade.instance:playVoiceByName(voiceRes)
			HeroSkinAgent.instance:sendHeroSkinSetRequest(self._curSelectSkinId, self._heroData:getId())
		else
			printWarn("未拥有此角色，屏蔽操作")
		end
	else
		self._curUseBgIndex = self._curSelectBgIndex
		self._curUseBgId = self._bgList[self._curUseBgIndex].co.id

		self:setLocalStorage(self._curUseBgId)
		self:_updateBgPanel(self._curUseBgIndex)
		self._scrollBg:UpdateCells()
	end
end

function M:_onClickPreViewBattle()
	FloatWordMgr.instance:show(lang("tip_function_not_unlocked"))
end

function M:_onClickCheck()
	self._viewAnim:StopTimelineAni()
	self._viewAnim:PlayAniByName("chakan")
end

function M:_switchCheck()
	if self._curSkinMo and not self._curSkinMo:getIsUnlock() then
		FloatWordMgr.instance:show(lang("tip_not_preview_not_cloth"))

		return
	end

	self:_getPortraitPos()
	self:_showPortraitView()
end

function M:_getPortraitPos()
	local transform = self._photo1CenterPointGo.transform
	local cutCenterPos = {
		transform.anchoredPosition.x,
		transform.anchoredPosition.y,
		transform.localScale.x,
		transform.localScale.y
	}
	local paramTable = {
		photo = self._photoUnitHor,
		modelId = self._heroData:getModelId(),
		cutCenterPos = cutCenterPos,
		iconType = IconType.CharaterIcon,
		heroId = self._heroData:getId(),
		skinId = self._curSelectSkinId
	}

	self._checkCutInfo = SpineCutShowLoader.getSpineLiHuiParam(paramTable)

	local transform = self._photoSkinCenterPointGo.transform
	local cutCenterPos = {
		transform.anchoredPosition.x,
		transform.anchoredPosition.y,
		transform.localScale.x,
		transform.localScale.y
	}
	local paramTable = {
		photo = self._photoUnitHor,
		modelId = self._heroData:getModelId(),
		cutCenterPos = cutCenterPos,
		iconType = IconType.CharaterIcon,
		heroId = self._heroData:getId(),
		skinId = self._curSelectSkinId
	}

	self._skinCutInfo = SpineCutShowLoader.getSpineLiHuiParam(paramTable)
end

function M:_showPortraitView()
	goutil.setActive(self._intelligencePanelGo, false)
	goutil.setActive(self._portraitPanelGo, true)

	self._isMultiDrag = false
	self._singlePointerId = -999
	self._isHorizon = true
	self._isUiHide = false

	self:_resetHideUiTimer()

	local go = self._photoUnitHor._unit.go

	go.transform:DOKill(false)

	local targetPos = Vector3.New(self._checkCutInfo[1], self._checkCutInfo[2], 0)

	go.transform:DOLocalMove(targetPos, 0.3)
end

function M:_hidePortraitViewWithAnim()
	self._viewAnim:StopTimelineAni()
	self._viewAnim:PlayAniByName("chakan_close")
	goutil.setActive(self._intelligencePanelGo, true)
	goutil.setActive(self._portraitPanelGo, false)
	self:updateSkinSelectedIndex(self._skinIndex, false)
	removetimer(self._hidePortraitUI, self)

	local go = self._photoUnitHor._unit.go

	go.transform:DOKill(false)

	local targetPos = Vector3.New(self._skinCutInfo[1], self._skinCutInfo[2], 0)

	go.transform:DOLocalMove(targetPos, 0.3)
	self._spinePanelGo.transform:DOKill(false)
	self._spinePanelGo.transform:DOLocalMove(Vector3.New(0, 0, 0), 0.3)
	self._spinePanelGo.transform:DOScale(Vector3.New(1, 1, 1), 0.3)
end

function M:_hidePortraitView()
	self._viewAnim:StopTimelineAni()
	self._viewAnim:PlayAniByName("chakan_close")
	self:_onClickSwitchToHorizon()
	goutil.setActive(self._intelligencePanelGo, true)
	goutil.setActive(self._portraitPanelGo, false)
	self:updateSkinSelectedIndex(self._skinIndex, false)
	removetimer(self._hidePortraitUI, self)

	local go = self._photoUnitHor._unit.go

	go.transform:DOKill(false)

	local targetPos = Vector3.New(self._skinCutInfo[1], self._skinCutInfo[2], 0)

	go.transform.localPosition = targetPos
end

function M:_initPortrait()
	self:_setClickSwitchToHorizon()
	goutil.setActive(self._intelligencePanelGo, true)
	goutil.setActive(self._portraitPanelGo, false)
	self:updateSkinSelectedIndex(self._skinIndex, false)
	removetimer(self._hidePortraitUI, self)
end

function M:_refreshViewBtn(data)
	goutil.setActive(self._btnPreViewBattle.gameObject, data:getSkillEffect() == 1)
	goutil.setActive(self._btnCheck.gameObject, data:getIsUnlock())
end

function M:_onBeginDrag(evt)
	self._beginPosition:Set(0, 0)
	self._beginPosition:Add(evt.position)
end

function M:_onEndDrag(evt)
	local position = evt.position
	local deltaX = position.x - self._beginPosition.x

	if deltaX >= 10 then
		if self._index > 1 then
			self._index = self._index - 1

			self:_getHeroByIndex(self._index)
		end
	elseif deltaX <= -10 and self._index < self._maxHeroCount then
		self._index = self._index + 1

		self:_getHeroByIndex(self._index)
	end
end

function M:_getHeroByIndex(index)
	self._heroData = self._allHeroList[index]

	HeroDepotModel.instance:setViewPageMo({
		hero = self._heroData,
		index = index,
		list = self._allHeroList
	})
	self:_reqSkinData(self._heroData:getId())
	GlobalDispatcher:dispatchEvent(EventType.CHARACTER_VIEW_SWITCH)
end

function M:_onClickCloth()
	self._viewAnim:StopTimelineAni()
	self._viewAnim:PlayAniByName("qiehuan")
	self:_setClothState(true)
	self:updateSkinSelectedIndex(self._skinIndex, true)
end

function M:_onClickBg()
	self._viewAnim:StopTimelineAni()
	self._viewAnim:PlayAniByName("qiehuan")
	self:_setClothState(false)
	self:updateBgSelectedIndex(self._curSelectBgIndex, true)
end

function M:_setDefaultState()
	self._togBg.IsOn = false

	if self._togBg.IsOn then
		self:_setClothState(false)
	end

	if self._togCloth.IsOn then
		self:_setClothState(true)
	end
end

function M:_setClothState(active)
	self._tabIndex = active and 1 or 2

	goutil.setActive(self._clothScroll, active)
	goutil.setActive(self._bgScroll, not active)
end

function M:_openLight()
	LightMgr.instance:turnOn(lightCode)
end

function M:_closeLight()
	LightMgr.instance:turnOff(lightCode)
end

return M
