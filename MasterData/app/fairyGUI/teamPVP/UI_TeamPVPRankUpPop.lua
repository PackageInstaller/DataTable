local var_0_0 = {}

var_0_0.URL = "ui://akds0szaasmv38"

function var_0_0:__ctor()
	self.m_rankUpBgComp = self:getChild("rankUpBgComp")
	self.m_rankLoader = self:getChild("rankLoader")
	self.m_effLevelUp = self:getChild("effLevelUp")
	self.m_enterATransition = self:getTransition("enterA")
	self.m_enterBTransition = self:getTransition("enterB")
	self.m_enterCTransition = self:getTransition("enterC")
	self.m_enterDTransition = self:getTransition("enterD")
end

return var_0_0
