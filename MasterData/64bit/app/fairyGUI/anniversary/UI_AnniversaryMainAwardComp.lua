local var_0_0 = {}

var_0_0.URL = "ui://pb5qrmiqhtdj4o"

function var_0_0:__ctor()
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_nameText = self:getChild("nameText")
	self.m_iconLoader = self:getChild("iconLoader")
	self.m_numText = self:getChild("numText")
	self.m_awardGroup = self:getChild("awardGroup")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
