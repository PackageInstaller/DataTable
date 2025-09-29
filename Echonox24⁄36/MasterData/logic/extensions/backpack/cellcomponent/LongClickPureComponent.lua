-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/cellcomponent/LongClickPureComponent.lua

module("logic.extensions.backpack.cellcomponent.LongClickPureComponent", package.seeall)

local M = class("LongClickPureComponent", CellBaseComponent)
local longClickTriggerTime = 0.4

function M:onInit()
	local registry = self._cell:getViewElementsRegistry()

	self._btnLongClick = OnceLongPressTrigger.Get(registry:findUIElement("rewards_detail_item_1370605741"))

	self._btnLongClick:SetTriggerTime(longClickTriggerTime)
	self._btnLongClick:AddClickListener(self._onClickItem, self)
	self._btnLongClick:AddLongPressListener(self._longClickSelect, self)
	self._btnLongClick:AddLongPressExitListener(self._onLongClickSelectExit, self)
end

function M:_onClickItem()
	self._cell:dealSelect()
end

function M:_longClickSelect()
	self._cell:dealLongSelect()
end

function M:_onLongClickSelectExit()
	self._cell:dealLongSelectExit()
end

function M:onDestroy()
	M.super.onDestroy(self)
	self._btnLongClick:RemoveClickListener()
	self._btnLongClick:RemoveClickListener()
	self._btnLongClick:RemoveClickListener()
end

return M
