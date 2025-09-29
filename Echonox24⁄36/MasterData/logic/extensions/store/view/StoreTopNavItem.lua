-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/store/view/StoreTopNavItem.lua

module("logic.extensions.store.view.StoreTopNavItem", package.seeall)

local M = class("StoreTopNavItem")
local ButtonAdapter = Astral.ButtonAdapter

function M:ctor(compContainer)
	self._compContainer = compContainer
	self.go = self._compContainer.gameObject
	self._viewElementsRegistry = ViewElementsRegistry.New(self.go)
	self._trs = self.go.transform
	self._bindTab = false
end

function M:Awake()
	local registry = self._viewElementsRegistry

	self._goSelect = registry:findUIElement("store_top_tab_-843661912")
	self._text = registry:findUIElement("store_top_tab_1880738568", UIComponentType.Text)
	self._text2 = registry:findUIElement("store_top_tab_-59760890", UIComponentType.Text)
	self._tab = self.go:GetComponent(UIComponentType.SpaceXToggle)
	self._goRedPoint = registry:findUIElement("1&red_point_-1414002736")
	self._goLine = registry:findUIElement("store_top_tab_-521117043")
	self._btnClick = ButtonAdapter.Get(self.go)

	self._btnClick:AddClickListener(self._clickSelf, self)
end

function M:_clickSelf()
	if self._clickCallBackFunc then
		self._clickCallBackFunc(self._clickCallBackHandler, self._curIndex, self._btnData, true)
	end
end

function M:setSelectIndex(index)
	self._selectIndex = index
end

function M:setClickCallBack(func, handler)
	self._clickCallBackFunc = func
	self._clickCallBackHandler = handler
end

function M:setRedPointData(keyList)
	local data = {
		dotNode = self._goRedPoint,
		keyList = keyList
	}

	if not self._redDotComponent then
		self._redDotComponent = RedDotModel.instance:createDotView(data)
	else
		self._redDotComponent:updateRedDot(data.keyList)
		RedDotModel.instance:updateKeyParent(data)
	end
end

function M:setCellData(name, btnData, index, group)
	self._curIndex = index

	goutil.setActive(self._goLine, self._curIndex > 1)

	self._btnData = btnData

	if not self._bindTab then
		self._bindTab = true
		self._tab.ToggleGroup = group
	end

	self._tab.IsOn = self._selectIndex == self._curIndex
	self._text.text = name
	self._text2.text = name
end

function M:OnDestroy()
	self._compContainer = nil
	self.go = nil
	self._trs = nil
	self._viewElementsRegistry = nil

	if self._btnClick then
		self._btnClick:RemoveClickListener()
	end

	self._btnClick = nil
	self._btnData = nil
	self._curIndex = nil
	self._tab = nil
	self._bindTab = false
end

return M
