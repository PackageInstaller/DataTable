local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wr5pq7n"

function var_0_0:__ctor()
	self.m_allGetController = self:getController("allGet")
	self.m_qualityLoader = self:getChild("qualityLoader")
	self.m_itemLoader = self:getChild("itemLoader")
	self.m_itemLoaderMask = self:getChild("itemLoaderMask")
	self.m_numTxt = self:getChild("numTxt")
end

var_0_0.AllGetCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
