local var_0_0 = {}

var_0_0.URL = "ui://2egchbz1npa53o"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_bgPanel = self:getChild("bgPanel")
	self.m_attrList = self:getChild("attrList")
	self.m_content = self:getChild("content")
end

var_0_0.IsEmptyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
