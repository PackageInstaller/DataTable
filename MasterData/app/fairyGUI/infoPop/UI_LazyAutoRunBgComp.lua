local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bnq5wd1v5dssu"

function var_0_0:__ctor()
	self.m_closePanel = self:getChild("closePanel")
	self.m_effBg = self:getChild("effBg")
	self.m_levelTxt = self:getChild("levelTxt")
	self.m_stopBtn = self:getChild("stopBtn")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
