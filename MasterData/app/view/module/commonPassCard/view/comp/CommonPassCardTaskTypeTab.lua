local var_0_0 = g.core.model.User.commonPassCardDataMgr
local CommonPassCardTaskTypeTab = class("CommonPassCardTaskTypeTab", require("app.fairyGUI.commonPassCard.UI_CommonPassCardTaskTypeTab"))

function CommonPassCardTaskTypeTab:onLoad()
	if self.m_taskType then
		self.m_redPointComp:setShow(self._commonPassCardData:isHasTaskReward(self.m_taskType))
	end
end

function CommonPassCardTaskTypeTab:setTaskType(arg_2_1, arg_2_2)
	self.m_taskType = arg_2_1
	self._actId = arg_2_2
	self._commonPassCardData = var_0_0:getPassCardData(self._actId)

	self.m_redPointComp:setShow(self._commonPassCardData:isHasTaskReward(arg_2_1))
	self:setVisible(#self._commonPassCardData:getTaskByResetType(arg_2_1) > 0)
end

return CommonPassCardTaskTypeTab
