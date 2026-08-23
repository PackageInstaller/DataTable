local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8lkxd0cs"

function var_0_0:__ctor()
	self.m_bgPic = self:getChild("bgPic")
	self.m_upTransition = self:getTransition("up")
	self.m_showTransition = self:getTransition("show")
	self.m_hideTransition = self:getTransition("hide")
	self.m_showEndTransition = self:getTransition("showEnd")
	self.m_hideEndTransition = self:getTransition("hideEnd")
end

return var_0_0
