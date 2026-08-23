local var_0_0 = {}

var_0_0.URL = "ui://pb5qrmiq9hnm2g"

function var_0_0:__ctor()
	self.m_isGetController = self:getController("isGet")
	self.m_iconLoader = self:getChild("iconLoader")
	self.m_zhezhao = self:getChild("zhezhao")
	self.m_eff = self:getChild("eff")
	self.m_getNewTransition = self:getTransition("getNew")
	self.m_scaleOnceTransition = self:getTransition("scaleOnce")
end

return var_0_0
