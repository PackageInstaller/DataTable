local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8lkxd0co"

function var_0_0:__ctor()
	self.m_icon = self:getChild("icon")
	self.m_effectNode = self:getChild("effectNode")
	self.m_effectNode2 = self:getChild("effectNode2")
	self.m_upTransition = self:getTransition("up")
	self.m_showTransition = self:getTransition("show")
	self.m_hideTransition = self:getTransition("hide")
	self.m_showEndTransition = self:getTransition("showEnd")
	self.m_hideEndTransition = self:getTransition("hideEnd")
end

return var_0_0
