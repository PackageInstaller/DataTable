local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wm4g0bl"

function var_0_0:__ctor()
	self.m_emptyController = self:getController("empty")
	self.m_itemIcon = self:getChild("itemIcon")
	self.m_lastNumTxt = self:getChild("lastNumTxt")
	self.m_curProbabilityTxt = self:getChild("curProbabilityTxt")
end

var_0_0.EmptyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
