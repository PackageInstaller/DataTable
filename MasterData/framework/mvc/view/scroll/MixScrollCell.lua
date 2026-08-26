-- chunkname: @framework/mvc/view/scroll/MixScrollCell.lua

module("framework.mvc.view.scroll.MixScrollCell", package.seeall)

local MixScrollCell = class("MixScrollCell", LuaCompBase)

function MixScrollCell:ctor()
	self._index = nil
	self._go = nil
	self._view = nil
end

function MixScrollCell:init(go)
	return
end

function MixScrollCell:initInternal(go, view)
	self._go = go
	self._view = view
end

function MixScrollCell:addEventListeners()
	return
end

function MixScrollCell:removeEventListeners()
	return
end

function MixScrollCell:onUpdateMO(mo, mixType, param)
	return
end

function MixScrollCell:onSelect(isSelect)
	return
end

function MixScrollCell:onDestroy()
	return
end

return MixScrollCell
