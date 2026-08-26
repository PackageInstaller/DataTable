-- chunkname: @framework/mvc/view/scroll/ListScrollCell.lua

module("framework.mvc.view.scroll.ListScrollCell", package.seeall)

local ListScrollCell = class("ListScrollCell", LuaCompBase)

function ListScrollCell:ctor()
	self._index = nil
	self._go = nil
	self._view = nil
end

function ListScrollCell:init(go)
	return
end

function ListScrollCell:initInternal(go, view)
	self._go = go
	self._view = view
end

function ListScrollCell:addEventListeners()
	return
end

function ListScrollCell:removeEventListeners()
	return
end

function ListScrollCell:onUpdateMO(mo)
	return
end

function ListScrollCell:onSelect(isSelect)
	return
end

function ListScrollCell:onDestroy()
	return
end

return ListScrollCell
