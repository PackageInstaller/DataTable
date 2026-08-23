local var_0_0 = {}

var_0_0.URL = "ui://sap1qcktq6wffrew"

function var_0_0:__ctor()
	self.m_isMaxController = self:getController("isMax")
	self.m_bgPanel = self:getChild("bgPanel")
	self.m_attrList1 = self:getChild("attrList1")
	self.m_attrList2 = self:getChild("attrList2")
	self.m_content = self:getChild("content")
end

return var_0_0
