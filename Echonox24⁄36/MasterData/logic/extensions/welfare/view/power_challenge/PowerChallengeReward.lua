-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/view/power_challenge/PowerChallengeReward.lua

module("logic.extensions.welfare.view.power_challenge.PowerChallengeReward", package.seeall)

local M = class("PowerChallengeReward", ViewComponent)

function M:buildUI()
	self._btnClose = self:getBtn("0&middle_tips_common_bg_-1205189576")
	self._btnBg = self:getBtn("0&middle_tips_common_bg_-1572128605")
	self._loopLst = LoopListHelper.New(goutil.findChild(self.mainGO, "allContent/scroll"))

	self._loopLst:InitListView(0, self._updateGrid, self)
end

function M:onEnter()
	TaskAgent.instance:sendListTaskRequest(TaskEnum.TaskLabel.PowerChallenge)

	self._planId = self:getFirstParam()
	self._taskList, self._signList = PowerChallengeModel.instance:getTaskSignList(self._planId)

	self._loopLst:SetListItemCount(#self._signList)
	self._loopLst:RefreshAllShownItem()
end

function M:_refreshTaskList()
	self._taskList, self._signList = PowerChallengeModel.instance:getTaskSignList(self._planId)

	self._loopLst:SetListItemCount(#self._signList)
	self._loopLst:RefreshAllShownItem()
end

function M:_updateGrid(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = false

	if type(self._signList[curIndex]) ~= "string" then
		item = self._loopLst:NewListViewItem("power_challenge_reward_item")
		cell = Astral.LuaComponentContainer.Add(item.gameObject, PowerChallengeTaskCell)

		cell:updateData(self._signList[curIndex])
	else
		item = self._loopLst:NewListViewItem("txtTitle")

		local txtTitle = goutil.findChildTextComponent(item.gameObject, "txtDesc")

		txtTitle.text = self._signList[curIndex]
	end

	return item
end

function M:onExit()
	return
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnBg:AddClickListener(self._onClickClose, self)
	GlobalDispatcher:addEventListener(EventType.POWER_CHALLENGE_TASK_REFRESH, self._refreshTaskList, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnBg:RemoveClickListener()
	GlobalDispatcher:removeEventListener(EventType.POWER_CHALLENGE_TASK_REFRESH, self._refreshTaskList, self)
end

function M:_onClickClose()
	self:close()
end

function M:destroyUI()
	self._loopLst:ClearCells()
end

return M
