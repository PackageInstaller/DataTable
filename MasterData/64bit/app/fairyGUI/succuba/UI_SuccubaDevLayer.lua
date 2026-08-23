local var_0_0 = {}

var_0_0.URL = "ui://qzlsgbi1nc3m0"

function var_0_0:__ctor()
	self.m_showSpineController = self:getController("showSpine")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_spineComp = self:getChild("spineComp")
	self.m_devComp = self:getChild("devComp")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
