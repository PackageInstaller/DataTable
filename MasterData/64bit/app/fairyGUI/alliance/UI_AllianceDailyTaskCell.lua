local var_0_0 = {}

var_0_0.URL = "ui://lom3h0lcjyex4a"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_taskNameTxt = self:getChild("taskNameTxt")
	self.m_progressTxt = self:getChild("progressTxt")
	self.m_descTips = self:getChild("descTips")
	self.m_awardList = self:getChild("awardList")
	self.m_costLoader = self:getChild("costLoader")
	self.m_costNumTxt = self:getChild("costNumTxt")
	self.m_gotoBtn = self:getChild("gotoBtn")
end

var_0_0.StateCtrl = {
	page4 = 4,
	page3 = 3,
	page2 = 2,
	page1 = 1,
	page0 = 0
}

return var_0_0
