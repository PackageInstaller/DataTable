local var_0_0 = {}

var_0_0.URL = "ui://sap1qcktnyylfreo"

function var_0_0:__ctor()
	self.m_isMaxController = self:getController("isMax")
	self.m_bgPanel = self:getChild("bgPanel")
	self.m_attrList = self:getChild("attrList")
	self.m_attr1 = self:getChild("attr1")
	self.m_attr2 = self:getChild("attr2")
	self.m_attr3 = self:getChild("attr3")
	self.m_attr4 = self:getChild("attr4")
	self.m_content = self:getChild("content")
end

return var_0_0
