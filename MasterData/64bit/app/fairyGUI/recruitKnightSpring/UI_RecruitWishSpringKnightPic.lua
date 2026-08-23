local var_0_0 = {}

var_0_0.URL = "ui://16fa1nlao4an68"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
end

var_0_0.StateCtrl = {
	None = 0,
	selected = 1
}

return var_0_0
