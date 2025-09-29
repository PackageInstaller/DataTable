-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/cell/ShopItemCell.lua

module("logic.extensions.backpack.cell.ShopItemCell", package.seeall)

local M = class("ShopItemCell", ListBinderCell)

function M:ctor(compContainer)
	M.super.ctor(self, compContainer)

	self._isShowTips = true
	self._isShowSelectedEffect = true
	self._showTipsPassEvent = true
	self._isCanClick = true
end

function M:_initComponents()
	self:_addComponent("normal", ShopTipItemCell)
	self:_addComponent("num", BackpackNumComponent)
end

function M:getGo()
	return self._go
end

function M:setIsShowTips(showTips)
	self._isShowTips = showTips
end

function M:setShowTipsPassEvent(isPassEvent)
	self._showTipsPassEvent = isPassEvent
end

function M:setShowSelectedEffect(isShow)
	self._isShowSelectedEffect = isShow
end

function M:onSelect(isSelected)
	if self._isShowSelectedEffect then
		local normalComp = self:getComponent("normal")

		normalComp:setItemSelect(isSelected)
	end
end

function M:setCanClick(isCanClickTips)
	self._isCanClick = isCanClickTips
end

function M:dealSelect()
	if not self._isCanClick then
		return
	end

	if not self._data then
		return
	end

	local normalComp = self:getComponent("normal")

	self:onSelect(not normalComp:getItemSelect())
	GlobalDispatcher:dispatchEvent(self._data:getItemMarkType(), self._data, self._go, self._cellIndex, self._isShowTips, self._isShowSelectedEffect)
end

return M
