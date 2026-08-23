local var_0_0 = {}

var_0_0.URL = "ui://tbm73rkgu1l65ibo9"

function var_0_0:__ctor()
	self.m_templateController = self:getController("template")
	self.m_icon = self:getChild("icon")
	self.m_des = self:getChild("des")
	self.m_pro = self:getChild("pro")
	self.m_itemIcon = self:getChild("itemIcon")
	self.m_itemNumTxt = self:getChild("itemNumTxt")
	self.m_proTxt = self:getChild("proTxt")
	self.m_btn = self:getChild("btn")
	self.m_desText = self:getChild("desText")
end

var_0_0.TemplateCtrl = {
	iconTemp = 0,
	txtTemp = 1
}

return var_0_0
