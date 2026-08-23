local var_0_0 = {}

var_0_0.URL = "ui://kvb3zneped0j1emigfi"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_knightIcon = self:getChild("knightIcon")
	self.m_artifactIcon = self:getChild("artifactIcon")
end

var_0_0.TypeCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
