local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8lzqgm2q"

function var_0_0:__ctor()
	self.m_isDeadController = self:getController("isDead")
	self.m_icon = self:getChild("icon")
	self.m_hpProg = self:getChild("hpProg")
end

var_0_0.IsDeadCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
