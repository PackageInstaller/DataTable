local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bn9z8d4"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_stateController = self:getController("state")
	self.m_popPanel = self:getChild("popPanel")
	self.m_icon1 = self:getChild("icon1")
	self.m_icon2 = self:getChild("icon2")
	self.m_confirmBtn = self:getChild("confirmBtn")
	self.m_subAddNumComp = self:getChild("subAddNumComp")
	self.m_nameText = self:getChild("nameText")
	self.m_valueText = self:getChild("valueText")
	self.m_content = self:getChild("content")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.TypeCtrl = {
	page6 = 6,
	page5 = 5,
	page4 = 4,
	page3 = 3,
	page2 = 2,
	page1 = 1,
	page0 = 0
}
var_0_0.StateCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
