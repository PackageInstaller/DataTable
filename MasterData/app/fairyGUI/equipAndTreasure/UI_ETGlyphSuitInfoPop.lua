local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7nnz07w"

function var_0_0:__ctor()
	self.m_isActiveController = self:getController("isActive")
	self.m_bgPanel = self:getChild("bgPanel")
	self.m_title1 = self:getChild("title1")
	self.m_unActiveText = self:getChild("unActiveText")
	self.m_hasActiveAttrList = self:getChild("hasActiveAttrList")
	self.m_title2 = self:getChild("title2")
	self.m_suitAttrList = self:getChild("suitAttrList")
	self.m_content = self:getChild("content")
end

var_0_0.IsActiveCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
