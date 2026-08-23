local var_0_0 = {}

var_0_0.URL = "ui://ziwfw8v5rcut26"

function var_0_0:__ctor()
	self.m_canAwardController = self:getController("canAward")
	self.m_icon = self:getChild("icon")
	self.m_taskNameTxt = self:getChild("taskNameTxt")
	self.m_taskProgTxt = self:getChild("taskProgTxt")
	self.m_effNode = self:getChild("effNode")
end

return var_0_0
