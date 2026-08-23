local var_0_0 = {}

var_0_0.URL = "ui://3w60uerptdy210"

function var_0_0:__ctor()
	self.m_progressComp = self:getChild("progressComp")
	self.m_curNum = self:getChild("curNum")
	self.m_maxNum = self:getChild("maxNum")
	self.m_itemLoader = self:getChild("itemLoader")
	self.m_numText = self:getChild("numText")
end

return var_0_0
