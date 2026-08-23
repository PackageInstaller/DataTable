local var_0_0 = {}

var_0_0.URL = "ui://akds0szaq47q4z"

function var_0_0:__ctor()
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_knightSpineDad = self:getChild("knightSpineDad")
	self.m_shopBtn = self:getChild("shopBtn")
	self.m_rankBtn = self:getChild("rankBtn")
	self.m_userName = self:getChild("userName")
	self.m_showComp1 = self:getChild("showComp1")
	self.m_showComp2 = self:getChild("showComp2")
	self.m_showComp3 = self:getChild("showComp3")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
