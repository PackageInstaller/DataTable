local CommanderWorldTaskCell = class("CommanderWorldTaskCell", require("app.fairyGUI.commanderWorld.UI_CommanderWorldTaskCell"))

function CommanderWorldTaskCell:ctor()
	self._taskInfo = {}
	self._rewardData = {}

	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onRenderRewardItem))
	self.m_goBtn:addClickListener(handler(self, self._onClickGoToModule))
	self.m_getAwardBtn:addClickListener(handler(self, self._onClickGetReward))
end

function CommanderWorldTaskCell:_onRenderRewardItem(arg_2_1, arg_2_2)
	arg_2_2:updateIcon({
		type = self._rewardData[arg_2_1 + 1].rewardType,
		value = self._rewardData[arg_2_1 + 1].rewardValue,
		size = self._rewardData[arg_2_1 + 1].rewardSize
	})
end

function CommanderWorldTaskCell:_onClickGetReward()
	g.core.network.GameNetProxy:send_C2S_OrderWorld_TaskAward({
		task_id = self._taskInfo.id
	})
end

function CommanderWorldTaskCell:_onClickGoToModule()
	if self._taskInfo.sourceId > 0 then
		g.view.entrance.ModuleGotoProxy:gotoModule(self._taskInfo.sourceId)
	end
end

function CommanderWorldTaskCell:updateTaskCell(arg_5_1)
	self.m_isGetController:setSelectedIndex(0)

	if arg_5_1.isFinish then
		self.m_isGetController:setSelectedIndex(2)
	end

	if arg_5_1.hasReward then
		self.m_isGetController:setSelectedIndex(1)
	end

	self._taskInfo = self:getCommanderWorldTaskInfo(arg_5_1)
	self._rewardData = self._taskInfo.rewardList or {}

	self.m_awardList:setNumItems(#self._rewardData)
	self.m_taskNumText:setText(self._taskInfo.currentNum .. "/" .. self._taskInfo.goal)
	self.m_taskNameText:setText(g.core.lang:getByString(self._taskInfo.taskDesc, {
		num = self._taskInfo.goal
	}))
	self.m_isDailyController:setSelectedIndex(self._taskInfo.isRefresh and 1 or 0)
end

function CommanderWorldTaskCell:getCommanderWorldTaskInfo(arg_6_1)
	local var_6_0 = {}
	local var_6_1 = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		if not iter_6_1.isFinish then
			var_6_0 = iter_6_1

			break
		end

		if iter_6_1.isFinish and not iter_6_1.isGetReward then
			var_6_0 = iter_6_1

			break
		end

		var_6_1 = iter_6_1
	end

	if not next(var_6_0) then
		var_6_0 = var_6_1
	end

	return var_6_0
end

return CommanderWorldTaskCell
