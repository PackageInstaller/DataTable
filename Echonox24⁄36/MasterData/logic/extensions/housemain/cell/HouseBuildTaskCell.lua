-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housemain/cell/HouseBuildTaskCell.lua

module("logic.extensions.housemain.cell.HouseBuildTaskCell", package.seeall)

local M = class("HouseBuildTaskCell", UIReusableLuaBehavior)

M.maxRewardShowNum = 2

function M:buildUI()
	self._viewElementsRegistry = ViewElementsRegistry.New(self.mainGO)

	local registry = self._viewElementsRegistry

	self._txtSmallTitle = registry:findUIElement("build_task_item_-1233743420", UIComponentType.Text)
	self._txtTaskDesc = registry:findUIElement("build_task_item_-551886017", UIComponentType.Text)
	self._rectTrRewardRoot = registry:findUIElement("build_task_item_-961280589", UIComponentType.RectTransform)
	self._goRewardItem = registry:findUIElement("rewards_detail_item_2141037416")

	goutil.setActive(self._goRewardItem, false)

	self._btnJump = UIComponentType.ButtonAdapter(registry:findUIElement("build_task_item_1231923529"))
	self._btnGet = UIComponentType.ButtonAdapter(registry:findUIElement("build_task_item_-109781726"))
	self._goFinish = registry:findUIElement("build_task_item_1381958563")
end

function M:destroyUI()
	self._viewElementsRegistry = nil
	self._handler = nil
	self._txtSmallTitle = nil
	self._txtTaskDesc = nil
	self._rectTrRewardRoot = nil
	self._goRewardItem = nil
	self._btnJump = nil
	self._btnGet = nil
	self._goFinish = nil

	for key, value in pairs(self._cellItem or {}) do
		value:destroyUI()
	end

	self._cellItem = nil
end

function M:bindEvents()
	self._btnJump:AddClickListener(self._onClickJump, self)
	self._btnGet:AddClickListener(self._onClickGet, self)
end

function M:unbindEvents()
	self._btnJump:RemoveClickListener()
	self._btnGet:RemoveClickListener()
end

function M:onEnter()
	return
end

function M:onExit()
	self._handler = nil
	self._taskTyp = nil
	self._curIndex = nil
	self._id = nil
	self._jumpId = nil

	for key, value in pairs(self._cellItem or {}) do
		value:onExit()
	end
end

function M:_onClickJump()
	if self._handler then
		self._handler:onTaskClickJump(self)
	end
end

function M:_onClickGet()
	if self._handler then
		self._handler:onTaskClickGet(self)
	end
end

function M:getTaskTyp()
	return self._taskTyp
end

function M:getId()
	return self._id
end

function M:getJumpId()
	return self._jumpId
end

function M:setHandler(handler)
	self._handler = handler
end

function M:setCellData(itemData, taskTyp, curIndex)
	self._taskTyp = taskTyp
	self._curIndex = curIndex
	self._id = itemData:getId()
	self._jumpId = itemData:getJumpId()
	self._txtSmallTitle.text = itemData:getName()

	self:updateDesc(itemData)
	self:updateReward(itemData)
	self:setState(itemData)
end

function M:setState(itemData)
	local intState = 0
	local taskState = HouseMainEnum.TaskState

	if itemData:getIsFinish() then
		intState = taskState.Finish
	else
		intState = itemData:canGetReward() and taskState.CanReceived or taskState.Running
	end

	goutil.setActive(self._btnJump.gameObject, intState == taskState.Running and itemData:canJump())
	goutil.setActive(self._btnGet.gameObject, intState == taskState.CanReceived)
	goutil.setActive(self._goFinish, intState == taskState.Finish)
end

function M:updateDesc(itemData)
	local desc = itemData:getDesc()
	local finishCnt = itemData:getFinishCnt()
	local maxCnt = itemData:getMaxCnt()

	self._txtTaskDesc.text = string.format("%s(%s/%d)", desc, finishCnt, maxCnt)
end

function M:updateReward(itemData)
	local rewardLst = itemData:getRewardList()
	local len = rewardLst and #rewardLst or 0
	local root = self._rectTrRewardRoot

	while root.childCount < len + 1 do
		goutil.cloneAndSetParent(self._goRewardItem, root)
	end

	for i = 1, root.childCount - 1 do
		local tmpGo = root:GetChild(i).gameObject
		local show = i <= len

		if i > self.maxRewardShowNum then
			show = false
		end

		if show then
			local item = rewardLst[i]
			local itemData = ItemUtil.createItemData({
				itemId = item.itemId
			})

			itemData:setCount(item.num)

			local shower = Astral.SimpleLuaComponentContainer.Add(tmpGo, HoldRewardItemCell)

			shower:setCellData(itemData, i)
			shower:setNumBgNodeVisible(false)
			shower:setHandler(self)
			shower:setSignShow(CommEnum.BackPackItemSignTyp.None)
			shower:setIsShowTips(true)
			shower:setShowSelectedEffect(false)
			shower:setIsShowTipsPassEvent(false)

			if not self._cellItem then
				self._cellItem = {}
			end

			self._cellItem[tmpGo:GetInstanceID()] = shower
		end

		goutil.setActive(tmpGo, show)
	end
end

return M
