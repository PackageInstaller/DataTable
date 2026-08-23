local var_0_0 = {}

var_0_0.URL = "ui://7ex6tye9v3rk30"

function var_0_0:__ctor()
	self.m_isSwitchController = self:getController("isSwitch")
	self.m_btnEffect = self:getChild("btnEffect")
	self.m_redPointComp = self:getChild("redPointComp")
end

return var_0_0
