local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2ighr2p"

function var_0_0:__ctor()
	self.m_soul_tabController = self:getController("soul_tab")
	self.m_Comp_tab1 = self:getChild("Comp_tab1")
	self.m_Comp_tab2 = self:getChild("Comp_tab2")
	self.m_Comp_dev = self:getChild("Comp_dev")
	self.m_Comp_echo = self:getChild("Comp_echo")
end

var_0_0.Soul_tabCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
