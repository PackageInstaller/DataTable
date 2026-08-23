local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88ogywfrrom"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_hasMonsterController = self:getController("hasMonster")
	self.m_knightIcon = self:getChild("knightIcon")
	self.m_hpBar = self:getChild("hpBar")
end

var_0_0.StateCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0
}
var_0_0.HasMonsterCtrl = {
	has = 1,
	none = 0
}

return var_0_0
