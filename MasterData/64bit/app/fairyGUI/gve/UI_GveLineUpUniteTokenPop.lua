local var_0_0 = {}

var_0_0.URL = "ui://9n9qtghbruaw4y"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_bgPanel = self:getChild("bgPanel")
	self.m_tabList = self:getChild("tabList")
	self.m_tokenList = self:getChild("tokenList")
	self.m_filterBtn = self:getChild("filterBtn")
	self.m_content = self:getChild("content")
end

return var_0_0
