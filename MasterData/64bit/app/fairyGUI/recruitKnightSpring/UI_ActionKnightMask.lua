local var_0_0 = {}

var_0_0.URL = "ui://16fa1nlapo2z5m"

function var_0_0:__ctor()
	self.m_centerPosController = self:getController("centerPos")
	self.m_isBlackController = self:getController("isBlack")
	self.m_center = self:getChild("center")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
