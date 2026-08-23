local var_0_0 = {}

var_0_0.URL = "ui://ziwfw8v5oqgsx7fg"

function var_0_0:__ctor()
	self.m_buttonController = self:getController("button")
	self.m_isThousandController = self:getController("isThousand")
	self.m_isAddAttrController = self:getController("isAddAttr")
	self.m_attrType = self:getChild("attrType")
	self.m_attrName = self:getChild("attrName")
	self.m_attrValue = self:getChild("attrValue")
	self.m_changeValue = self:getChild("changeValue")
end

return var_0_0
