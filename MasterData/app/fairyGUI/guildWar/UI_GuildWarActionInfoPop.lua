local var_0_0 = {}

var_0_0.URL = "ui://m1cmgw9muncv2a"

function var_0_0:__ctor()
	self.m_emptyController = self:getController("empty")
	self.m_popPanel = self:getChild("popPanel")
	self.m_infoList = self:getChild("infoList")
	self.m_content = self:getChild("content")
end

var_0_0.EmptyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
