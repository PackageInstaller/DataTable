-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/view/StoreLeftNavItem.lua

module("logic.extensions.store.view.StoreLeftNavItem", package.seeall)

local M = class("StoreLeftNavItem")
local ButtonAdapter = Astral.ButtonAdapter

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._trs = self._go.transform
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
	self._bindTab = false
end

function M:Awake()
	local registry = self._viewElementsRegistry

	self._txtNameActive = registry:findUIElement("store_left_tab_719045029", UIComponentType.Text)
	self._txtNameUnActive = registry:findUIElement("store_left_tab_759914930", UIComponentType.Text)
	self._btnClick = ButtonAdapter.Get(registry:findUIElement("store_left_tab_2137731651"))

	self._btnClick:AddClickListener(self._clickSelf, self)

	self._tab = registry:findUIElement("store_left_tab_2137731651", UIComponentType.SpaceXToggle)
end

function M:_clickSelf()
	if self._clickCallBackFunc then
		local id = self._isRecommend and self._storeData.code or self._storeData:getId()
		local tabId = self._isRecommend and 1001 or self._storeData:getTabId()

		self._clickCallBackFunc(self._clickCallBackHandler, tabId, id, true)
	end
end

function M:setSelectState(isSelect)
	self._tab.IsOn = isSelect
end

function M:setCellData(data, index, group, isRecommend)
	self._curIndex = index
	self._storeData = data
	self._isRecommend = isRecommend

	if not self._bindTab then
		self._bindTab = true

		self:_setTabGroup(group)
	end

	self:_updateCellInfo(data)
end

function M:setClickCallBack(func, handler)
	self._clickCallBackFunc = func
	self._clickCallBackHandler = handler
end

function M:_updateCellInfo(data)
	self._txtNameActive.text = self._isRecommend and data.name or data:getName()
	self._txtNameUnActive.text = self._isRecommend and data.name or data:getName()
end

function M:_setTabGroup(group)
	self._tab.ToggleGroup = group
end

function M:OnDestroy()
	self._compContainer = nil
	self._go = nil
	self._trs = nil
	self._viewElementsRegistry = nil
	self._txtNameActive = nil
	self._txtNameUnActive = nil

	if self._btnClick then
		self._btnClick:RemoveClickListener()
	end

	self._btnClick = nil
	self._btnData = nil
	self._curIndex = nil
	self._tab = nil
	self._bindTab = false
	self._clickCallBackFunc = nil
	self._clickCallBackHandler = nil
end

return M
