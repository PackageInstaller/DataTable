local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8lqcekfr"

function var_0_0:__ctor()
	self.m_isMaxController = self:getController("isMax")
	self.m_curTxt = self:getChild("curTxt")
	self.m_maxTxt = self:getChild("maxTxt")
	self.m_knightList = self:getChild("knightList")
	self.m_topBarComp = self:getChild("topBarComp")
end

var_0_0.IsMaxCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
