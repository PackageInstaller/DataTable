local var_0_0 = {}

var_0_0.URL = "ui://d5b3cu3goduk38"

function var_0_0:__ctor()
	self.m_hasBaseListController = self:getController("hasBaseList")
	self.m_hasPercentListController = self:getController("hasPercentList")
	self.m_baseAttrList = self:getChild("baseAttrList")
	self.m_line = self:getChild("line")
	self.m_basePercentList = self:getChild("basePercentList")
end

return var_0_0
