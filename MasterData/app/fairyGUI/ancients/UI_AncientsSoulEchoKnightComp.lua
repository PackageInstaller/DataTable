local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2unko3j"

function var_0_0:__ctor()
	self.m_statusController = self:getController("status")
	self.m_Comp_star = self:getChild("Comp_star")
	self.m_Comp_name = self:getChild("Comp_name")
	self.m_Comp_knight = self:getChild("Comp_knight")
	self.m_Btn_change = self:getChild("Btn_change")
	self.m_lockTxt = self:getChild("lockTxt")
end

var_0_0.StatusCtrl = {
	page2 = 2,
	page1 = 1,
	page4 = 4,
	page0 = 0,
	page3 = 3
}

return var_0_0
