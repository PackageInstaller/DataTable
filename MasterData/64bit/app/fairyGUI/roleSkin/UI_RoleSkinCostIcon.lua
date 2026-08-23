local var_0_0 = {}

var_0_0.URL = "ui://x323b22nrnx71n"

function var_0_0:__ctor()
	self.m_isEnoughController = self:getController("isEnough")
	self.m_costIcon = self:getChild("costIcon")
	self.m_numText = self:getChild("numText")
end

var_0_0.IsEnoughCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
