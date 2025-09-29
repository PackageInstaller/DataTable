-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/containmentzone/cell/HoldRewardItemCell.lua

module("logic.extensions.containmentzone.cell.HoldRewardItemCell", package.seeall)

local M = class("HoldRewardItemCell", ListBinderCell)

function M:ctor(compContainer)
	M.super.ctor(self, compContainer)

	self._isShowTips = true
	self._isShowSelectedEffect = true
	self._isShowTipsPassEvent = true
end

function M:_initComponents()
	self:_addComponent("normal", ItemCellComponet)
	self:_addComponent("num", BackpackNumComponent)
	self:_addComponent("sign", ItemSignComponent)
end

function M:setHandler(handler)
	self._handler = handler
end

function M:setShowSelectedEffect(isShow)
	self._isShowSelectedEffect = isShow
end

function M:setIsShowTips(showTips)
	self._isShowTips = showTips
end

function M:setIsShowTipsPassEvent(passEvent)
	self._isShowTipsPassEvent = passEvent
end

function M:getMainGo()
	return self._go
end

function M:setCellData(itemData, index)
	if itemData == nil then
		return
	end

	self._cellIndex = index
	self._itemData = itemData

	local normalComp = self:getComponent("normal")

	normalComp:updateData(self._itemData)
	normalComp:setItemSelect(false)
	self:getComponent("num"):updateData(self._itemData)
end

function M:setNumShow(show, content)
	local numComp = self:getComponent("num")

	if show then
		numComp:setCountText(content)
	end

	numComp:setVisible(show)
end

function M:setNumBgNodeVisible(visible)
	local numComp = self:getComponent("num")

	numComp:setNumBgNodeVisible(visible)
end

function M:setSignShow(backPackItemSignTyp)
	local comp = self:getComponent("sign")

	comp:hideAllSign()
	comp:setSignShow(backPackItemSignTyp, true)
end

function M:setCanRewardEff(show)
	if self._effCanReward == nil then
		local viewRegistry = self:getViewElementsRegistry()

		self._effCanReward = viewRegistry:findUIElement("backpack_item_2142689521")
	end

	goutil.setActive(self._effCanReward, show)
end

function M:onExit()
	self._itemData = nil
	self._handler = nil
	self._goMarkFirstSign = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:destroyUI()
	return
end

function M:setMarkFirstSign(show)
	if self._goMarkFirstSign == nil then
		local viewRegistry = self:getViewElementsRegistry()

		self._goMarkFirstSign = viewRegistry:findUIElement("rewards_detail_item_1708769659")
	end

	goutil.setActive(self._goMarkFirstSign.gameObject, show)
end

function M:dealSelect()
	local normalComp = self:getComponent("normal")

	self:onSelect(not normalComp:getItemSelect())
	GlobalDispatcher:dispatchEvent(self._itemData:getItemMarkType(), self._itemData, self._go, self._cellIndex, self._isShowTips, self._isShowTipsPassEvent)
end

function M:onSelect(isSelected)
	if self._isShowSelectedEffect then
		self:setItemSelect(isSelected)

		if self._handler and self._handler.onRewardItemSelect then
			self._handler:onRewardItemSelect(self)
		end
	end
end

function M:setItemSelect(isSelected)
	if not self._isShowSelectedEffect then
		isSelected = false
	end

	self:getComponent("normal"):setItemSelect(isSelected)
end

return M
