local var_0_0 = {}

var_0_0.URL = "ui://c64rm38ylc5n12uytpd"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_descTxt = self:getChild("descTxt")
	self.m_rewardList = self:getChild("rewardList")
	self.m_takeRewardBtn = self:getChild("takeRewardBtn")
	self.m_processTxt = self:getChild("processTxt")
	self.m_timesTxt = self:getChild("timesTxt")
	self.m_complete = self:getChild("complete")
end

var_0_0.StateCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0
}

return var_0_0
