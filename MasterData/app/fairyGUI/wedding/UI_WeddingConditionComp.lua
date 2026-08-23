local var_0_0 = {}

var_0_0.URL = "ui://14huq3sfhob8p"

function var_0_0:__ctor()
	self.m_isReachController = self:getController("isReach")
	self.m_itemLoader = self:getChild("itemLoader")
	self.m_descText = self:getChild("descText")
	self.m_tipText = self:getChild("tipText")
	self.m_getBtn = self:getChild("getBtn")
end

return var_0_0
