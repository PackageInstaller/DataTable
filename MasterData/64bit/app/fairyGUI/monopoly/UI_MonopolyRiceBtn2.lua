local var_0_0 = {}

var_0_0.URL = "ui://6b52cxc1oky9o"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_enoughController = self:getController("enough")
	self.m_eff = self:getChild("eff")
	self.m_eff2 = self:getChild("eff2")
	self.m_itemIcon = self:getChild("itemIcon")
end

return var_0_0
