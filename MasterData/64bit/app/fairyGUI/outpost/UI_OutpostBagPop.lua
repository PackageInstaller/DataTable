local var_0_0 = {}

var_0_0.URL = "ui://ziwfw8v5m98fx7hj"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_popPanel = self:getChild("popPanel")
	self.m_bagList = self:getChild("bagList")
	self.m_content = self:getChild("content")
end

return var_0_0
