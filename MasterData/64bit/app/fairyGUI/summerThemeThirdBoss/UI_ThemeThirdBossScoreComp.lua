local var_0_0 = {}

var_0_0.URL = "ui://aeavo6obl1fx1t"

function var_0_0:__ctor()
	self.m_scoreStateController = self:getController("scoreState")
	self.m_maxHeigh = self:getChild("maxHeigh")
	self.m_bar = self:getChild("bar")
	self.m_cellRoot = self:getChild("cellRoot")
end

var_0_0.ScoreStateCtrl = {
	page0 = 0,
	page2 = 5,
	page1 = 1
}

return var_0_0
