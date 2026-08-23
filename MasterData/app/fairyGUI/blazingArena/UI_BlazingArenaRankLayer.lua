local var_0_0 = {}

var_0_0.URL = "ui://7ex6tye9now7x"

function var_0_0:__ctor()
	self.m_tabSelController = self:getController("tabSel")
	self.m_rankList = self:getChild("rankList")
	self.m_seasonAwardList = self:getChild("seasonAwardList")
	self.m_rankPreText = self:getChild("rankPreText")
	self.m_rankText = self:getChild("rankText")
	self.m_tipsText = self:getChild("tipsText")
	self.m_myAwardList = self:getChild("myAwardList")
	self.m_topBarComp = self:getChild("topBarComp")
end

return var_0_0
