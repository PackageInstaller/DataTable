local var_0_0 = {}

var_0_0.URL = "ui://pb5qrmiq9hnm2j"

function var_0_0:__ctor()
	self.m_bg = self:getChild("bg")
	self.m_descTxt = self:getChild("descTxt")
	self.m_iconBg = self:getChild("iconBg")
	self.m_effLoop = self:getChild("effLoop")
	self.m_mahjongLoader = self:getChild("mahjongLoader")
	self.m_effPlay = self:getChild("effPlay")
	self.m_touchArea = self:getChild("touchArea")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
