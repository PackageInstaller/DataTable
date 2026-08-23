local var_0_0 = {}

var_0_0.URL = "ui://pb5qrmiqmi2542"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_bg = self:getChild("bg")
	self.m_iconLoader = self:getChild("iconLoader")
	self.m_numText = self:getChild("numText")
	self.m_qualityLoader = self:getChild("qualityLoader")
	self.m_itemIcon = self:getChild("itemIcon")
end

return var_0_0
