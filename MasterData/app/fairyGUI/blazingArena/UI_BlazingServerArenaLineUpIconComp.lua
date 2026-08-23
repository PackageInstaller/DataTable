local var_0_0 = {}

var_0_0.URL = "ui://7ex6tye9v3rk20"

function var_0_0:__ctor()
	self.m_lineUpStateController = self:getController("lineUpState")
	self.m_isBuffController = self:getController("isBuff")
	self.m_groupController = self:getController("group")
	self.m_iconComp = self:getChild("iconComp")
	self.m_buff = self:getChild("buff")
end

return var_0_0
