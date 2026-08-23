local var_0_0 = {}

var_0_0.URL = "ui://2qeh40nkofajmibzf"

function var_0_0:__ctor()
	self.m_hpTxt = self:getChild("hpTxt")
	self.m_awardList = self:getChild("awardList")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
