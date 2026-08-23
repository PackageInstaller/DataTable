local var_0_0 = {}

var_0_0.URL = "ui://ziwfw8v5116r741"

function var_0_0:__ctor()
	self.m_emptyController = self:getController("empty")
	self.m_itemComp = self:getChild("itemComp")
	self.m_numTxt = self:getChild("numTxt")
end

return var_0_0
