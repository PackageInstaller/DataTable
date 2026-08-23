local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bnq5wd1v5dssh"

function var_0_0:__ctor()
	self.m_closePanel = self:getChild("closePanel")
	self.m_autoDiskComp = self:getChild("autoDiskComp")
	self.m_effDi = self:getChild("effDi")
	self.m_levelTxt = self:getChild("levelTxt")
	self.m_resDescTxt = self:getChild("resDescTxt")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
