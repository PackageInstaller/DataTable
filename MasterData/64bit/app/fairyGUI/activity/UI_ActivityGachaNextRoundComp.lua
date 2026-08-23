local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wu4uucm"

function var_0_0:__ctor()
	self.m_roundStateController = self:getController("roundState")
	self.m_eff = self:getChild("eff")
end

var_0_0.RoundStateCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0
}

return var_0_0
