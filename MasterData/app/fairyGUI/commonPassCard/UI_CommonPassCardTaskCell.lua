local var_0_0 = {}

var_0_0.URL = "ui://1b29hdofhh9b38"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_itemIcon = self:getChild("itemIcon")
	self.m_scoreTxt = self:getChild("scoreTxt")
	self.m_descTxt = self:getChild("descTxt")
	self.m_numTxt = self:getChild("numTxt")
	self.m_allNumTxt = self:getChild("allNumTxt")
	self.m_taskBtn = self:getChild("taskBtn")
end

var_0_0.StateCtrl = {
	page0 = 3,
	page2 = 4,
	page1 = 2,
	page3 = 5
}

return var_0_0
