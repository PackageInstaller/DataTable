-- chunkname: @framework/mvc/view/scroll/TreeScrollCell.lua

module("framework.mvc.view.scroll.TreeScrollCell", package.seeall)

local TreeScrollCell = class("TreeScrollCell", LuaCompBase)

function TreeScrollCell:ctor()
	self._rootIndex = nil
	self._nodeIndex = nil
	self._go = nil
	self._view = nil
	self._isRoot = nil
	self._isNode = nil
end

function TreeScrollCell:initInternal(go, view)
	self._go = go
	self._view = view
end

function TreeScrollCell:onUpdateRootMOInternal(mo)
	if not self._isRoot then
		self._isRoot = true

		self:initRoot()
	end

	self:onUpdateRootMO(mo)
end

function TreeScrollCell:onUpdateNodeMOInternal(mo)
	if not self._isNode then
		self._isNode = true

		self:initNode()
	end

	self:onUpdateNodeMO(mo)
end

function TreeScrollCell:initRoot()
	return
end

function TreeScrollCell:initNode()
	return
end

function TreeScrollCell:addEventListeners()
	return
end

function TreeScrollCell:removeEventListeners()
	return
end

function TreeScrollCell:onUpdateRootMO(mo)
	return
end

function TreeScrollCell:onUpdateNodeMO(mo)
	return
end

function TreeScrollCell:onSelect(isSelect)
	return
end

function TreeScrollCell:onDestroy()
	return
end

return TreeScrollCell
