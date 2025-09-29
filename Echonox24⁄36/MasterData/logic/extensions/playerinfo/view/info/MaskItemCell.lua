-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/info/MaskItemCell.lua

module("logic.extensions.playerinfo.view.info.MaskItemCell", package.seeall)

local M = class("MaskItemCell")
local ButtonAdapter = Astral.ButtonAdapter

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
end

function M:Awake()
	local registry = self._viewElementsRegistry

	self._goUsing = registry:findUIElement("player_mask_item_-727091557")
	self._imgSelect = registry:findUIElement("player_mask_item_-444672782", UIComponentType.Image)
	self._imgIcon = registry:findUIElement("player_mask_item_-96070895", UIComponentType.Image)
	self._flagNew = registry:findUIElement("0&new_sigh_291166182")
	self._btnClick = ButtonAdapter.Get(registry:findUIElement("player_mask_item_365859287"))
	self._canvas = self._go:GetComponent(ComponentType.CanvasGroup)

	self._btnClick:AddClickListener(self._clickSelf, self)
	GlobalDispatcher:addEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self._refreshFlags, self)
end

function M:_clickSelf()
	if self._handlerFunc then
		self._handlerFunc(self._handlerobj, self._data.id, self._curIndex)
	end
end

function M:setClick(handlerFunc, handlerObj)
	self._handlerobj = handlerObj
	self._handlerFunc = handlerFunc
end

function M:setCellData(data, index, curId, selectId, isLock)
	self._curIndex = index
	self._data = data

	if data.cfgdata and not string.nilorempty(data.cfgdata.icon) then
		IconLoader.setSprite(self._imgIcon, IconType.ItemIcon, data.cfgdata.icon)
	end

	if isLock then
		self._canvas.alpha = 0.2
	else
		self._canvas.alpha = 1
	end

	goutil.setActive(self._imgSelect.gameObject, selectId == data.id)
	self:_refreshFlags()
end

function M:setUsing(isUsing)
	goutil.setActive(self._goUsing, isUsing)
end

function M:_refreshFlags()
	goutil.setActive(self._flagNew, false)

	local portraitMoList = ItemModel.instance:getItemsByItemId(self._data.id)

	if #portraitMoList > 0 then
		local isShow = portraitMoList[1]:getRedPoint() == CommEnum.ItemRedPoint.New

		goutil.setActive(self._flagNew, isShow)
	end
end

function M:OnDestroy()
	self._compContainer = nil
	self._go = nil

	self._btnClick:RemoveClickListener()

	self._btnClick = nil

	GlobalDispatcher:removeEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self._refreshFlags, self)
end

return M
