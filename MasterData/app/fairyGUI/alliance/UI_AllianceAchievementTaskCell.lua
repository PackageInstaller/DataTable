local var_0_0 = {}

var_0_0.URL = "ui://lom3h0lcjyex4b"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_taskNameTxt = self:getChild("taskNameTxt")
	self.m_descTxt = self:getChild("descTxt")
	self.m_awardList = self:getChild("awardList")
	self.m_curTxt = self:getChild("curTxt")
	self.m_goalTxt = self:getChild("goalTxt")
	self.m_gotoBtn = self:getChild("gotoBtn")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1,
	page3 = 3
}

return var_0_0
