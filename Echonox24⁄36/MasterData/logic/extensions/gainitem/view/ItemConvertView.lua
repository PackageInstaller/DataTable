-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gainitem/view/ItemConvertView.lua

module("logic.extensions.gainitem.view.ItemConvertView", package.seeall)

local M = class("ItemConvertView", ViewComponent)
local YPosH = 127
local YPosL = 77

function M:ctor()
	self._contentGo = false
	self._btnClose = false
	self._itemDataLst = {}
	self._itemAni = false
end

function M:buildUI()
	self._txtTitle = self:getUIComponent("gain_item_-2029049070", UIComponentType.Text)
	self._contentGo = self:getGo("gain_item_1182321935")
	self._btnClose = self:getBtn("gain_item_-980585392")
	self._itemTemplate = goutil.findChild(self._contentGo, "backpack_item")

	goutil.setActive(self._itemTemplate.gameObject, false)

	self._scrollRect = self:getUIComponent("gain_item_1651144003", UIComponentType.ScrollRect)
	self._scrollTransform = self._scrollRect.transform
	self._emptyRaycast = self:getUIComponent("gain_item_1178808476", UIComponentType.EmptyRaycast)
end

function M:bindEvents()
	self._btnClose:AddClickListener(self.checkClose, self)
end

function M:checkClose()
	self._viewPresentor:onClickOutside()
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
end

function M:onEnter()
	self._scrollRect.verticalNormalizedPosition = 1

	local info = self:getFirstParam() or {}

	self._txtTitle.text = lang("item_convert_title")

	local itemListData = info or {}

	self:_duelReciveItemLst(itemListData)
	CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_generic_gain)
	self:_setEvent(true)
end

function M:onExit()
	self:releaseTween()

	self._itemCache = nil

	for i = 1, self._contentGo.transform.childCount - 1 do
		local itemGo = self._contentGo.transform:GetChild(i).gameObject

		goutil.destroy(itemGo)
	end

	self._itemDataLst = nil

	self:_setEvent(false)
end

function M:destroyUI()
	goutil.clearChildren(self._contentGo)
end

function M:_setEvent(isOn)
	if isOn then
		GlobalDispatcher:addEventListener(EventType.ITEM_NORMAL_MARK_TYPE, self.handleItemNormalMarkType, self)
		self:registerLocalNotify(EventType.ON_UI_TIMELINE_JUMP_TO_END, self._handleOnUITimelineJumpToEnd, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ITEM_NORMAL_MARK_TYPE, self.handleItemNormalMarkType, self)
		GlobalDispatcher:removeEventListener(EventType.D6_INFO_REFRESH, self._refreshLstShow, self)
		self:unregisterLocalNotify(EventType.ON_UI_TIMELINE_JUMP_TO_END, self._handleOnUITimelineJumpToEnd, self)
	end
end

function M:handleItemNormalMarkType(e, data, go)
	if goutil.isNil(go) then
		return
	end

	local goInstanceId = go:GetInstanceID()

	for instanceId, cacheItemCell in pairs(self._itemCache or {}) do
		if instanceId ~= goInstanceId then
			cacheItemCell:onSelect(false)
		end
	end
end

function M:_handleOnUITimelineJumpToEnd()
	self:_stopAni()
end

function M:_duelReciveItemLst(itemListData)
	local len = itemListData and #itemListData or 0

	if len > 0 then
		if not self._itemDataLst then
			self._itemDataLst = {}
		end

		for key, value in ipairs(itemListData) do
			table.insert(self._itemDataLst, value)
		end
	end

	self:_refreshLstShow()
end

function M:_refreshLstShow()
	local itemGo, cell = false, false
	local itemDataLst = self:_duelEnergyItem(self._itemDataLst)

	itemDataLst = self:_duelItemNoShow(itemDataLst)
	itemDataLst = self:_dealFurnitureStack(itemDataLst)

	local len = itemDataLst and #itemDataLst or 0

	if len > 0 then
		table.sort(itemDataLst, ItemUtil.commonSortFunc)
	end

	self._emptyRaycast.enabled = len > 12

	local rootTrans = self._contentGo.transform

	while len > rootTrans.childCount - 1 do
		itemGo = goutil.clone(self._itemTemplate)

		goutil.addChildToParent(itemGo, self._contentGo)
	end

	if not self._itemAni then
		self._itemAni = {}
	end

	for i = 1, rootTrans.childCount - 1 do
		itemGo = rootTrans:GetChild(i).gameObject

		local itemData = itemDataLst[i]

		cell = Astral.LuaComponentContainer.Add(itemGo, GainItemCell)

		cell:updateData(itemData)
		cell:setShowSelectedEffect(false)
		cell:onSelect(false)
		cell:setNumVisibleInGainItem()
		cell:getComponent("num"):setTextColor(Astral.ColorUtil.ParseColor("#BEBEBE"))
		cell:getComponent("num"):setVisible(ItemUtil.canShowNumInGain(itemData:getItemId()))
		cell:getComponent("num"):setNumBgNodeVisible(false)

		local compSign = cell:getComponent("sign")

		if not compSign then
			cell:_addComponent("sign", ItemSignComponent)

			compSign = cell:getComponent("sign")

			compSign:onInit()
		end

		if self._showRewardTag then
			local rewardTag = itemData:getRewardTag()

			compSign:setSignShow(rewardTag == CommEnum.BackPackItemSignTyp.Main and CommEnum.BackPackItemSignTyp.First or rewardTag, true)
		else
			compSign:hideAllSign()
		end

		if not self._itemCache then
			self._itemCache = {}
		end

		self._itemCache[itemGo:GetInstanceID()] = cell

		table.insert(self._itemAni, cell)
		goutil.setActive(itemGo, true)

		itemGo:GetComponent(ComponentType.CanvasGroup).alpha = 0
	end

	self:_playAni()
end

function M:_playAni()
	self:releaseTween()

	if not self._itemAni then
		return
	end

	local delayTime = 0

	for _, ani in ipairs(self._itemAni) do
		delayTime = delayTime + 0.2

		local tweenDelay = DoTweenUtil.DelayedCall(delayTime, function()
			ani:getGo():GetComponent(ComponentType.CanvasGroup).alpha = 1

			AnimationUtils.SetPlaySpeed(ani:getGo():GetComponent(ComponentType.Animation), 2)
			ani:getComponent("animation"):playAnim("backpack_item_conversion_open")
		end)

		table.insert(self._cacheTweenLst, tweenDelay)
	end

	self._itemAni = false
end

function M:_stopAni()
	self:releaseTween()

	for _, cell in pairs(self._itemCache or {}) do
		cell:getComponent("animation"):resetToLastFrame()

		cell:getGo():GetComponent(ComponentType.CanvasGroup).alpha = 1
	end
end

function M:releaseTween()
	for _, tweener in ipairs(self._cacheTweenLst or {}) do
		if tweener then
			tweener:Kill(false)
		end
	end

	self._cacheTweenLst = {}
end

function M:_duelEnergyItem(dataLst)
	local lst = {}
	local energyCount = 0
	local len = dataLst and #dataLst or 0

	if len > 0 then
		for index, value in ipairs(dataLst) do
			if value:getItemId() == CommEnum.CurrencyCodeEnum.TlCode then
				energyCount = energyCount + value:getCount()
			else
				table.insert(lst, value)
			end
		end
	end

	if energyCount > 0 then
		printWarn(string.format(lang("tip_gain_item_energy"), energyCount))
		ToolTipsMgr.showHealthGetActionTimeTipsView(energyCount)
	end

	return lst
end

function M:_duelItemNoShow(dataLst)
	local lst = {}
	local len = dataLst and #dataLst or 0

	if len > 0 then
		for index, value in ipairs(dataLst) do
			if not CommEnum.NoShowInGainViewItem[value:getItemId()] then
				table.insert(lst, value)
			end
		end
	end

	return lst
end

function M:_dealFurnitureStack(dataLst)
	local lst = {}
	local len = dataLst and #dataLst or 0

	if len > 0 then
		local furnitureMap = {}

		for index, value in ipairs(dataLst) do
			if value:getType() == GameEnum.ItemTypeEnum.FurnitureItemType then
				local itemId = value:getItemId()

				if not furnitureMap[itemId] then
					furnitureMap[itemId] = FurnitureStackData.New({
						count = 1,
						itemId = itemId
					})
				end

				furnitureMap[itemId]:addFurniture(tonumber(value:getUuid()))
			else
				table.insert(lst, value)
			end
		end

		for _, _data in pairs(furnitureMap) do
			table.insert(lst, _data)
		end
	end

	return lst
end

return M
