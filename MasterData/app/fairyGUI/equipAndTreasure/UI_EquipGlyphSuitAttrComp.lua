local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7qdh744"

function var_0_0:__ctor()
	self.m_isShowTtileController = self:getController("isShowTtile")
	self.m_title = self:getChild("title")
	self.m_titleGroup = self:getChild("titleGroup")
	self.m_attr1 = self:getChild("attr1")
	self.m_attr2 = self:getChild("attr2")
	self.m_attr3 = self:getChild("attr3")
	self.m_attrsGroup = self:getChild("attrsGroup")
end

var_0_0.IsShowTtileCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
