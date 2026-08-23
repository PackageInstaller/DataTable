local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7nyyldb"

function var_0_0:__ctor()
	self.m_equipIcon = self:getChild("equipIcon")
	self.m_curStage = self:getChild("curStage")
	self.m_nextStage = self:getChild("nextStage")
	self.m_attr1 = self:getChild("attr1")
	self.m_attr2 = self:getChild("attr2")
	self.m_attr3 = self:getChild("attr3")
	self.m_attr4 = self:getChild("attr4")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
