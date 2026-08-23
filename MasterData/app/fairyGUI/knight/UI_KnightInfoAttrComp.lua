local var_0_0 = {}

var_0_0.URL = "ui://1rxs0yivk3pnev"

function var_0_0:__ctor()
	self.m_hideBtnController = self:getController("hideBtn")
	self.m_descTitle = self:getChild("descTitle")
	self.m_attr1 = self:getChild("attr1")
	self.m_attr2 = self:getChild("attr2")
	self.m_attr3 = self:getChild("attr3")
	self.m_attr4 = self:getChild("attr4")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.HideBtnCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
