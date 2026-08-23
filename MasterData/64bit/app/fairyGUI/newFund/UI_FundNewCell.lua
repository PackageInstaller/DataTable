local var_0_0 = {}

var_0_0.URL = "ui://gmpp9vw0h36u1i"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_descTxt = self:getChild("descTxt")
	self.m_lvNumTxt = self:getChild("lvNumTxt")
	self.m_stringLvTxt = self:getChild("stringLvTxt")
	self.m_freeList = self:getChild("freeList")
	self.m_payList = self:getChild("payList")
end

return var_0_0
