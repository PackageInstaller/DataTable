-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/cell/chapter_reward/ChapterRewardTaskCell.lua

module("logic.extensions.welfare.cell.chapter_reward.ChapterRewardTaskCell", package.seeall)

local M = class("ChapterRewardTaskCell", SimpleCellComponent)

function M:ctor(container)
	self.super.ctor(self, container)

	self._taskMO = nil
	self._itemList = {}
end

function M:buildUI()
	self._btnReceive = UIComponentType.ButtonAdapter(goutil.findChild(self._go, "btnReceive"))
	self._btnAccess = UIComponentType.ButtonAdapter(goutil.findChild(self._go, "btnGo"))
	self._textDesc = goutil.findChildTextComponent(self._go, "txtTitle")
	self._goReceive = self._btnReceive.gameObject
	self._goAccess = self._btnAccess.gameObject
	self._goStateDone = goutil.findChild(self._go, "stateDone")
	self._goStateNone = goutil.findChild(self._go, "stateNo")
	self._goItem = goutil.findChild(self._go, "rewardGroup/backpack_item")
	self._transfParent = self._goItem.transform.parent

	goutil.setActive(self._goItem, false)
end

function M:bindEvents()
	self._btnReceive:AddClickListener(self._onClickReceive, self)
	self._btnAccess:AddClickListener(self._onClickAccess, self)
end

function M:unbindEvents()
	self._btnReceive:RemoveClickListener()
	self._btnAccess:RemoveClickListener()
end

function M:bindDispatcherEvent()
	return
end

function M:unbindDispatcherEvent()
	return
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:destroyUI()
	return
end

function M:_setData(taskMo)
	self._taskMO = taskMo
end

function M:_refreshUI()
	self._textDesc.text = self._taskMO:getDesc()

	local canJump = self._taskMO:canJump()
	local taskStatus = self._taskMO:getRewardStatus()

	goutil.setActive(self._goReceive, taskStatus == TaskEnum.TaskState.CanReceive)
	goutil.setActive(self._goStateDone, taskStatus == TaskEnum.TaskState.Finish)
	goutil.setActive(self._goAccess, canJump and taskStatus == TaskEnum.TaskState.Doing)
	goutil.setActive(self._goStateNone, not canJump and taskStatus == TaskEnum.TaskState.Doing)

	for _, item in ipairs(self._itemList) do
		goutil.setActive(item, false)
	end

	local rewardList = self._taskMO:getRewardList()

	for index, reward in ipairs(rewardList) do
		local item = self._itemList[index]

		if item == nil then
			item = goutil.cloneAndSetParent(self._goItem, self._transfParent)
			self._itemList[index] = item
		end

		goutil.setActive(item, true)

		local cell = Astral.SimpleLuaComponentContainer.Add(item, ItemCell)
		local itemData = ItemUtil.createItemData({
			itemId = reward.itemId,
			count = reward.num
		})

		cell:updateData(itemData)
		cell:setShowSelectedEffect(false)
	end
end

function M:_onClickReceive()
	local txtBtn = goutil.findChildTextComponent(self._btnReceive.gameObject, "normal/Text1")

	UserUtil.uploadActivityTabBuryPoint(UserUtil.activityFirstTabName, UserUtil.activitySecondTabName, txtBtn and txtBtn.text or "")

	local taskId = self._taskMO:getId()

	TaskAgent.instance:sendRewardRequest({
		taskId
	})
end

function M:_onClickAccess()
	local txtBtn = goutil.findChildTextComponent(self._btnAccess.gameObject, "Text1")

	UserUtil.uploadActivityTabBuryPoint(UserUtil.activityFirstTabName, UserUtil.activitySecondTabName, txtBtn and txtBtn.text or "")
	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_EVENT, self._taskMO:getJumpId())
end

return M
