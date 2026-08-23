local var_0_0 = {}

var_0_0.URL = "ui://akds0szamabq5h"

function var_0_0:__ctor()
	self.m_showKnight2 = self:getChild("showKnight2")
	self.m_showKnight3 = self:getChild("showKnight3")
	self.m_showKnight1 = self:getChild("showKnight1")
	self.m_userName1 = self:getChild("userName1")
	self.m_userName2 = self:getChild("userName2")
	self.m_userName3 = self:getChild("userName3")
	self.m_touchComp = self:getChild("touchComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
