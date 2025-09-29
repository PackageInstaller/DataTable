-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/info/PlayerBusinessCardItem.lua

module("logic.extensions.playerinfo.view.info.PlayerBusinessCardItem", package.seeall)

local M = class("PlayerBusinessCardItem")
local ButtonAdapter = Astral.ButtonAdapter

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
end

function M:Awake()
	local registry = self._viewElementsRegistry

	self._imgFrame = registry:findUIElement("business_card_select_item_-2024132490", UIComponentType.Image)
	self._imgCard = registry:findUIElement("business_card_select_item_-435311054", UIComponentType.Image)
	self._imgIcon = registry:findUIElement("player_mask_item_-96070895", UIComponentType.Image)
	self._goUsing = registry:findUIElement("player_mask_item_-727091557")
	self._goSelect = registry:findUIElement("player_mask_item_-444672782")
	self._goLock = registry:findUIElement("business_card_select_item_-909798115")
	self._goFlagNew = registry:findUIElement("0&new_sigh_291166182")
	self._btnClick = ButtonAdapter.Get(registry:findUIElement("player_mask_item_365859287"))
	self._canvasGroup = goutil.findChild(self._go, "content"):GetComponent(ComponentType.CanvasGroup)

	self:_bindEvents()
end

function M:_bindEvents()
	GlobalDispatcher:addEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self._refreshFlags, self)
	self._btnClick:AddClickListener(self._clickSelf, self)
end

function M:_unbindEvents()
	GlobalDispatcher:removeEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self._refreshFlags, self)
	self._btnClick:RemoveClickListener()
end

function M:_clickSelf()
	if self._handlerFunc then
		self._handlerFunc(self._handlerobj, self._data.id, self._curIndex, self._iconType)
	end
end

function M:setClick(handlerFunc, handlerObj)
	self._handlerobj = handlerObj
	self._handlerFunc = handlerFunc
end

function M:setCellData(data, iconType, index, selectId, isLock, dataType)
	self._iconType = iconType
	self._curIndex = index
	self._data = data

	if dataType == IconType.PlayerInfoMask and data.cfgdata and not string.nilorempty(data.cfgdata.icon) then
		IconLoader.setSprite(self._imgIcon, iconType, data.cfgdata.icon)
	end

	if dataType == IconType.PlayerInfoCard and data.cfgdata and not string.nilorempty(data.cfgdata.icon1) then
		IconLoader.setSprite(self._imgCard, iconType, data.cfgdata.icon1)
	end

	if dataType == IconType.PlayerInfoFrame and data.cfgdata and not string.nilorempty(data.cfgdata.icon1) then
		IconLoader.setSprite(self._imgFrame, iconType, data.cfgdata.icon1)
	end

	goutil.setActive(self._imgIcon.gameObject, dataType == IconType.PlayerInfoMask)
	goutil.setActive(self._imgCard.gameObject, dataType == IconType.PlayerInfoCard)
	goutil.setActive(self._imgFrame.gameObject, dataType == IconType.PlayerInfoFrame)
	goutil.setActive(self._goLock, isLock)
	goutil.setActive(self._goSelect, selectId == data.id)

	self._canvasGroup.alpha = isLock and 0.2 or 1

	self:_refreshFlags()
end

function M:setUsing(isUsing)
	goutil.setActive(self._goUsing, isUsing)
end

function M:_refreshFlags()
	goutil.setActive(self._goFlagNew, false)

	local portraitMoList = ItemModel.instance:getItemsByItemId(self._data.id)

	if #portraitMoList > 0 then
		local isShow = portraitMoList[1]:getRedPoint() == CommEnum.ItemRedPoint.New

		goutil.setActive(self._flagNew, isShow)
	end
end

function M:OnDestroy()
	self:_unbindEvents()

	self._compContainer = nil
	self._go = nil
	self._btnClick = nil
end

return M
