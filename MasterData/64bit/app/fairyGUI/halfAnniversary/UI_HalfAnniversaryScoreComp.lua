local var_0_0 = {}

var_0_0.URL = "ui://l1121lywsx5s16"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_curItemTxt = self:getChild("curItemTxt")
	self.m_iconLoader = self:getChild("iconLoader")
	self.m_itemNumTxt = self:getChild("itemNumTxt")
end

return var_0_0
