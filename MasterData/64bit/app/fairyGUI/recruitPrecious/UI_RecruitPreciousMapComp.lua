local var_0_0 = {}

var_0_0.URL = "ui://hw835jy1dngjq"

function var_0_0:__ctor()
	self.m_isTenController = self:getController("isTen")
	self.m_icon = self:getChild("icon")
	self.m_effectNode1 = self:getChild("effectNode1")
	self.m_effectNode2 = self:getChild("effectNode2")
	self.m_effectNode3 = self:getChild("effectNode3")
	self.m_effectNode4 = self:getChild("effectNode4")
	self.m_effectNode5 = self:getChild("effectNode5")
	self.m_effectNode6 = self:getChild("effectNode6")
	self.m_effectNode7 = self:getChild("effectNode7")
	self.m_effectNode8 = self:getChild("effectNode8")
	self.m_effectNode9 = self:getChild("effectNode9")
	self.m_effectNode10 = self:getChild("effectNode10")
	self.m_enter1Transition = self:getTransition("enter1")
	self.m_backTransition = self:getTransition("back")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
