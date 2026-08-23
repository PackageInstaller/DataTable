local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7psjm97"

function var_0_0:__ctor()
	self.m_expTreasureController = self:getController("expTreasure")
	self.m_addComp = self:getChild("addComp")
	self.m_checkBtn = self:getChild("checkBtn")
	self.m_quickStrengthBtn = self:getChild("quickStrengthBtn")
	self.m_resNumComp = self:getChild("resNumComp")
end

var_0_0.ExpTreasureCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
