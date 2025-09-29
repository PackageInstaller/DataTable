-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/view/role_experience/RoleExperienceItemCell.lua

module("logic.extensions.welfare.view.role_experience.RoleExperienceItemCell", package.seeall)

local M = class("RoleExperienceItemCell", ListBinderCell)

function M:ctor(compContainer)
	M.super.ctor(self, compContainer)

	self._roleExperienceItemData = {}
	self._actId = nil
	self._itemData = nil
	self._receiveState = nil
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
	self:_addComponent("lock", LockComponent)
	self:_addComponent("reward", ReceiveStatusComponent)
	self:_addComponent("num", BackpackNumComponent)
end

function M:updateData(actId, itemId, itemCount, isLock, receiveState)
	self._actId = actId
	self._receiveState = receiveState

	local activityData = ActivityModel.instance:getActivityById(actId)

	table.clear(self._roleExperienceItemData)

	self._roleExperienceItemData.itemId = itemId
	self._roleExperienceItemData.count = itemCount
	self._roleExperienceItemData.isLocked = isLock

	local itemData = ItemUtil.createItemData(self._roleExperienceItemData)

	self._itemData = itemData

	local itemCellComp = self:getComponent("normal")

	itemCellComp:updateData(itemData)

	local lockComp = self:getComponent("lock")

	lockComp:updateData(itemData)

	local rewardComp = self:getComponent("reward")

	rewardComp:setRewardStatus(receiveState)

	local numComp = self:getComponent("num")

	numComp:updateData(itemData)
	goutil.setActive(self.go_red_point, receiveState == CommEnum.RewardEnum.CanGot)
end

function M:dealSelect()
	if self._receiveState == CommEnum.RewardEnum.CanGot then
		RoleExperienceAgent.instance:sendGetHeroEarlyAccessRewardRequest(self._actId)
	else
		self:_showItemTips()
	end
end

function M:_showItemTips()
	local cellIndex = 0
	local showTips = true
	local showTipsPassEvent = false

	GlobalDispatcher:dispatchEvent(EventType.ITEM_NORMAL_MARK_TYPE, self._itemData, self.go_icon, cellIndex, showTips, showTipsPassEvent)
end

function M:OnDestroy()
	M.super.OnDestroy(self)

	self._roleExperienceItemData = nil
	self._itemData = nil
	self._registry = nil
	self._receiveState = nil
end

return M
