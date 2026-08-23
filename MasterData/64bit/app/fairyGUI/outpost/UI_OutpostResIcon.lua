local var_0_0 = {}

var_0_0.URL = "ui://ziwfw8v5lrhf7bh"

function var_0_0:__ctor()
	self.m_showNumController = self:getController("showNum")
	self.m_quality = self:getChild("quality")
	self.m_numTxt = self:getChild("numTxt")
	self.m_itemIcon = self:getChild("itemIcon")
end

return var_0_0
