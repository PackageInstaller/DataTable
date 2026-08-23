local var_0_0 = {}

var_0_0.URL = "ui://ziwfw8v5116r73o"

function var_0_0:__ctor()
	self.m_isSelectController = self:getController("isSelect")
	self.m_itemComp = self:getChild("itemComp")
	self.m_subBtn = self:getChild("subBtn")
	self.m_addBtn = self:getChild("addBtn")
	self.m_reduceBtn = self:getChild("reduceBtn")
	self.m_numTxt = self:getChild("numTxt")
end

return var_0_0
