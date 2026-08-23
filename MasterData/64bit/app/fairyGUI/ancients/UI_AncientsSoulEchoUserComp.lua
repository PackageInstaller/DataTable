local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2unko3i"

function var_0_0:__ctor()
	self.m_statusController = self:getController("status")
	self.m_knightIcon = self:getChild("knightIcon")
	self.m_Comp_name = self:getChild("Comp_name")
	self.m_Txt_fightValue = self:getChild("Txt_fightValue")
end

var_0_0.StatusCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0,
	page3 = 3
}

return var_0_0
