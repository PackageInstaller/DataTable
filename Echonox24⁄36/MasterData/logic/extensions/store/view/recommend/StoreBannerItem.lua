-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/view/recommend/StoreBannerItem.lua

module("logic.extensions.store.view.recommend.StoreBannerItem", package.seeall)

local StoreBannerItem = class("StoreBannerItem")
local ButtonAdapter = Astral.ButtonAdapter

function StoreBannerItem:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
end

function StoreBannerItem:Awake()
	local registry = self._viewElementsRegistry

	self._btnClick = ButtonAdapter.Get(registry:findUIElement("store_banner_item_-318656919"))

	self._btnClick:AddClickListener(self._clickSelf, self)
end

function StoreBannerItem:_clickSelf()
	if self._clickCallBack then
		self._clickCallBack(self._handler, self._data.code)
	end
end

function StoreBannerItem:setCellData(data)
	self._data = data
end

function StoreBannerItem:setClickCallBack(fun, handle)
	self._clickCallBack = fun
	self._handler = handle
end

function StoreBannerItem:_onImageGuideLoaded()
	return
end

function StoreBannerItem:OnDestroy()
	self._compContainer = nil
	self._go = nil
	self._viewElementsRegistry = nil

	self._btnClick:RemoveClickListener()

	self._btnClick = nil
	self._clickCallBack = nil
	self._handler = nil
	self._data = nil
end

return StoreBannerItem
