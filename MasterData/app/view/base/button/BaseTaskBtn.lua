local var_0_0 = g.core.const.ConstMgr.BASE_CONST.TASK_STATE_TYPE
local BaseTaskBtn = class("BaseTaskBtn", require("app.fairyGUI.base_new.UI_BaseTaskBtn"))

function BaseTaskBtn:setTaskStateType(arg_1_1)
	self.m_stateController:setSelectedIndex(arg_1_1)
	self.m_getTransition:stop()
	self.m_goTransition:stop()

	if arg_1_1 == var_0_0.CAN_RECEIVE then
		self.m_getTransition:play(-1, 0)
	elseif arg_1_1 == var_0_0.GO then
		self.m_goTransition:play(-1, 0)
	end
end

function BaseTaskBtn:getTaskStateType()
	return self.m_stateController:getSelectedIndex()
end

return BaseTaskBtn
