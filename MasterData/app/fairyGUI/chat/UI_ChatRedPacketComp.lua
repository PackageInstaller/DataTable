local var_0_0 = {}

var_0_0.URL = "ui://v9hfyn87u2x5by2y6"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_showText = self:getChild("showText")
	self.m_applyBtn = self:getChild("applyBtn")
	self.m_awardIcon = self:getChild("awardIcon")
	self.m_awardNumText = self:getChild("awardNumText")
	self.m_tipText = self:getChild("tipText")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1,
	page3 = 3
}

return var_0_0
