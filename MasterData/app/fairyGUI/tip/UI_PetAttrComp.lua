local var_0_0 = {}

var_0_0.URL = "ui://sap1qcktka4afreg"

function var_0_0:__ctor()
	self.m_isMaxController = self:getController("isMax")
	self.m_curAttrComp = self:getChild("curAttrComp")
	self.m_nextAttrValue = self:getChild("nextAttrValue")
	self.m_addAttrValue = self:getChild("addAttrValue")
	self.m_nextGroup = self:getChild("nextGroup")
end

return var_0_0
