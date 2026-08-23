local var_0_0 = {}

var_0_0.URL = "ui://3w60uerptdy21g"

function var_0_0:__ctor()
	self.m_qualityController = self:getController("quality")
	self.m_effectNode = self:getChild("effectNode")
	self.m_touchIcon = self:getChild("touchIcon")
	self.m_effectEnterScreen = self:getChild("effectEnterScreen")
	self.m_effectEnterCrystal = self:getChild("effectEnterCrystal")
	self.m_effectIdle = self:getChild("effectIdle")
	self.m_effectShow = self:getChild("effectShow")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
