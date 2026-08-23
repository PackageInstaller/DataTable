local var_0_0 = {}

var_0_0.URL = "ui://sap1qcktkp6gfrej"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_titleController = self:getController("title")
	self.m_descController = self:getController("desc")
	self.m_titleText = self:getChild("titleText")
	self.m_descText = self:getChild("descText")
	self.m_bigTitleText = self:getChild("bigTitleText")
	self.m_attrComp1 = self:getChild("attrComp1")
	self.m_attrComp2 = self:getChild("attrComp2")
	self.m_attrGroup = self:getChild("attrGroup")
end

return var_0_0
