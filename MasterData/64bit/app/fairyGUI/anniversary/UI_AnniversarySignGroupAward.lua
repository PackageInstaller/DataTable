local var_0_0 = {}

var_0_0.URL = "ui://pb5qrmiq9hnm2h"

function var_0_0:__ctor()
	self.m_isAwardController = self:getController("isAward")
	self.m_iconComp = self:getChild("iconComp")
	self.m_star = self:getChild("star")
	self.m_star1 = self:getChild("star1")
	self.m_getBigTransition = self:getTransition("getBig")
end

return var_0_0
