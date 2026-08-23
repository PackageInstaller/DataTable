local BountyTaskRewardCell = class("BountyTaskRewardCell", require("app.fairyGUI.bounty.UI_BountyTaskRewardCell"))

function BountyTaskRewardCell:ctor(arg_1_1)
	self._taskData = nil

	self:_initCell()
	self.getSharedTrans(self, "enter_down", "CommonLongCellList", self)
end

function BountyTaskRewardCell:updateRewardCell(arg_2_1)
	self._taskData = arg_2_1

	self.m_taskTypeController:setSelectedIndex(self._taskData:getRefreshType() - 1)
	self.m_desTxt:setText(self._taskData:getCfg().task_describe)

	local var_2_0, var_2_1 = self._taskData:getProgressValue()
	local var_2_2 = g.core.lang:get(500135, {
		cur = var_2_0,
		max = var_2_1
	})
	local var_2_3 = 2

	if var_2_0 < var_2_1 then
		var_2_2 = g.core.lang:get(304003, {
			num = var_2_0,
			maxNum = var_2_1
		})
		var_2_3 = 0
	elseif self._taskData:canReceive() then
		var_2_3 = 1
	end

	self.m_proTxt:setText(var_2_2)
	self.m_statusController:setSelectedIndex(var_2_3)
	self.m_awardList:setNumItems(#self._taskData:getAward())
end

function BountyTaskRewardCell:_initCell()
	self.m_desTxt:enableRich()
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onRenderAwardList))
	self.m_getBtn:addClickListener(handler(self, self._onGetAwardClick))
end

function BountyTaskRewardCell:_onRenderAwardList(arg_4_1, arg_4_2)
	local var_4_0 = self._taskData:getAward()[arg_4_1 + 1]

	var_4_0.scaleIndex = 2
	var_4_0.hideNum = false

	arg_4_2:updateIcon(var_4_0)
end

function BountyTaskRewardCell:_onGetAwardClick()
	self:dispatchCompEvent("getAward", {
		taskId = self._taskData:getCfg().id
	})
end

return BountyTaskRewardCell
