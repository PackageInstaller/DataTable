local var_0_0 = {}

var_0_0.URL = "ui://0xhekt5ig73zp"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_knightItem = self:getChild("knightItem")
	self.m_item = self:getChild("item")
	self.m_indexTxt = self:getChild("indexTxt")
	self.m_nameTxt = self:getChild("nameTxt")
end

return var_0_0
