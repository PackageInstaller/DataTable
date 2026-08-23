local var_0_0 = {}

var_0_0.URL = "ui://x323b22nje0ch"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_skillNumController = self:getController("skillNum")
	self.m_attr1 = self:getChild("attr1")
	self.m_attr2 = self:getChild("attr2")
	self.m_attr3 = self:getChild("attr3")
	self.m_attr4 = self:getChild("attr4")
	self.m_descText = self:getChild("descText")
	self.m_nameComp = self:getChild("nameComp")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.StateCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.SkillNumCtrl = {
	page1 = 1,
	page0 = 0,
	page4 = 4,
	page3 = 3,
	page2 = 2
}

return var_0_0
