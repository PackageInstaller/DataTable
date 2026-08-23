local var_0_0 = {}

var_0_0.URL = "ui://vhnpxv25egt14f"

function var_0_0:__ctor()
	self.m_isBuffEmptyController = self:getController("isBuffEmpty")
	self.m_bgPanel = self:getChild("bgPanel")
	self.m_attrList = self:getChild("attrList")
	self.m_content = self:getChild("content")
end

var_0_0.IsBuffEmptyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
