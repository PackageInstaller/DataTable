local var_0_0 = {}

var_0_0.URL = "ui://ami25kgyna8hd"

function var_0_0:__ctor()
	self.m_mainRoleController = self:getController("mainRole")
	self.m_knightCardComp = self:getChild("knightCardComp")
	self.m_qualityIcon = self:getChild("qualityIcon")
end

var_0_0.MainRoleCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
