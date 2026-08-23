local var_0_0 = {}

var_0_0.URL = "ui://vhnpxv25egt14e"

function var_0_0:__ctor()
	self.m_isBuffEmptyController = self:getController("isBuffEmpty")
	self.m_popPanel = self:getChild("popPanel")
	self.m_buffList = self:getChild("buffList")
	self.m_attrBtn = self:getChild("attrBtn")
	self.m_iconLoader = self:getChild("iconLoader")
	self.m_nameBgLoader = self:getChild("nameBgLoader")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_descComp = self:getChild("descComp")
	self.m_content = self:getChild("content")
end

var_0_0.IsBuffEmptyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
