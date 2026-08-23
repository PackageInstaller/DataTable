local var_0_0 = {}

var_0_0.URL = "ui://i8uevo9v1018gce"

function var_0_0:__ctor()
	self.m_knightLoader = self:getChild("knightLoader")
	self.m_descTxt = self:getChild("descTxt")
	self.m_reviewBtn = self:getChild("reviewBtn")
	self.m_effEnter = self:getChild("effEnter")
	self.m_nameComp = self:getChild("nameComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
	self.m_switchTransition = self:getTransition("switch")
end

return var_0_0
