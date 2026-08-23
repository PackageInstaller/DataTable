local var_0_0 = {}

var_0_0.URL = "ui://akds0szaf470d"

function var_0_0:__ctor()
	self.m_isRobotController = self:getController("isRobot")
	self.m_isCaptainController = self:getController("isCaptain")
	self.m_infoBtn = self:getChild("infoBtn")
	self.m_kickBtn = self:getChild("kickBtn")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
