local var_0_0 = {}

var_0_0.URL = "ui://fqn2vo16mt0bg"

function var_0_0:__ctor()
	self.m_isFinishController = self:getController("isFinish")
	self.m_taskProBgLoader = self:getChild("taskProBgLoader")
	self.m_taskProTaskTxt = self:getChild("taskProTaskTxt")
	self.m_taskDesTxt = self:getChild("taskDesTxt")
end

return var_0_0
