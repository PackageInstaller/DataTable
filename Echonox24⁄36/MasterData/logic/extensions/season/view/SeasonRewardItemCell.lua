-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonRewardItemCell.lua

module("logic.extensions.season.view.SeasonRewardItemCell", package.seeall)

local M = class("SeasonRewardItemCell", ListBinderCell)

function M:ctor(compContainer)
	M.super.ctor(self, compContainer)

	self._seasonRewardItemData = {}
	self._itemData = nil
	self._registry = ViewElementsRegistry.New(compContainer.gameObject)
end

function M:Awake()
	self.go_icon = self._registry:findUIElement("rewards_detail_item_-2041880288")
	self.go_red_point = self._registry:findUIElement("1&red_point_-1414002736")

	M.super.Awake(self)
end

function M:_initComponents()
	M.super._initComponents(self)
	self:_addComponent("normal", ItemCellComponet)
	self:_addComponent("reward", ReceiveStatusComponent)
	self:_addComponent("num", BackpackNumComponent)
	self:_addComponent("receiveLock", LockReceiveComponent)
end

function M:updateData(rewardItemMo, receiveState)
	table.clear(self._seasonRewardItemData)

	local itemId = rewardItemMo:getCode()
	local itemCount = rewardItemMo:getNum()

	self._seasonRewardItemData.itemId = itemId
	self._seasonRewardItemData.count = itemCount

	local isLock = rewardItemMo:isVip() and not SeasonModel.instance:isVip() or false
	local itemData = ItemUtil.createItemData(self._seasonRewardItemData)

	itemData:setIsReceiveLock(isLock)

	self._itemData = itemData

	local itemCellComp = self:getComponent("normal")

	itemCellComp:updateData(itemData)

	local rewardComp = self:getComponent("reward")

	rewardComp:setRewardStatus(receiveState)

	local numComp = self:getComponent("num")

	numComp:updateData(itemData)

	local lockComp = self:getComponent("receiveLock")

	lockComp:updateData(itemData)
end

function M:dealSelect()
	local data = ToolTipsUtil.createItemTipsData(self._itemData, self._go)

	ToolTipsMgr.showTips(data.viewName, data)
end

function M:setVisible(value)
	goutil.setActive(self._go, value)
end

function M:OnDestroy()
	M.super.OnDestroy(self)

	self._roleExperienceItemData = nil
	self._itemData = nil
	self._registry = nil
end

return M
