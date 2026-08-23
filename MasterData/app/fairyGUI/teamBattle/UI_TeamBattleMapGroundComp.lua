local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8lehcvhv"

function var_0_0:__ctor()
	self.m_icon = self:getChild("icon")
	self.m_upTransition = self:getTransition("up")
	self.m_hideTransition = self:getTransition("hide")
	self.m_showTransition = self:getTransition("show")
	self.m_showEndTransition = self:getTransition("showEnd")
	self.m_hideEndTransition = self:getTransition("hideEnd")
end

return var_0_0
