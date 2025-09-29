-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hacktool/view/HackToolConsoleView.lua

module("logic.extensions.hacktool.view.HackToolConsoleView", package.seeall)

local M = class("HackToolConsoleView")

function M:ctor(container)
	self._go = container.gameObject
	self._emptyClick = Astral.UIClickTrigger.Get(goutil.findChild(self._go, "emptyCast"))
	self._data = {}
end

function M:Awake()
	self:init()
end

function M:init()
	local itemScroll = goutil.findChild(self._go, "Scroll")

	self._loopList = LoopListHelper.New(itemScroll)

	self._loopList:InitListView(0, self._updateCell, self)
	self:bindEvents()
end

function M:bindEvents()
	self._emptyClick:AddClickListener(self._onClickEmpty, self)
end

function M:unbindEvents()
	self._emptyClick:RemoveClickListener()
end

function M:OnDestroy()
	self:unbindEvents()
end

function M:refreshData(text)
	self._data = QuickAddHackItemUtil.instance:filter(text)

	self._loopList:SetListItemCount(#self._data)
	self._loopList:RefreshAllShownItem()
end

function M:_updateCell(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._loopList:NewListViewItem("item")
	local conf = self._data[curIndex]
	local itemView = Astral.LuaComponentContainer.Add(item.gameObject, ConsoleItem)

	itemView:updateData(conf)
	itemView:setHandler(self.onClickItem, self)

	return item
end

function M:onClickItem(id)
	if self._input then
		self._input:SetText(id)
	end

	goutil.setActive(self._go, false)
end

function M:setInput(inputGo)
	self._input = inputGo
end

function M:getMainGO()
	return self._go
end

function M:_onClickEmpty()
	goutil.setActive(self._go, false)
end

return M
