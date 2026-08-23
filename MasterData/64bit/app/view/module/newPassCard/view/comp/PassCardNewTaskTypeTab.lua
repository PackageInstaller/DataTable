local var_0_0 = g.core.model.User.gmPassCardData
local PassCardNewTaskTypeTab = class("PassCardNewTaskTypeTab", require("app.fairyGUI.newPassCard.UI_PassCardNewTaskTypeTab"))

function PassCardNewTaskTypeTab:onLoad()
	if self.m_taskType then
		self.m_redPointComp:setShow(var_0_0:isHasTaskReward(self.m_taskType))
	end
end

function PassCardNewTaskTypeTab:setTaskType(arg_2_1)
	self.m_taskType = arg_2_1

	self.m_redPointComp:setShow(var_0_0:isHasTaskReward(arg_2_1))
end

return PassCardNewTaskTypeTab
