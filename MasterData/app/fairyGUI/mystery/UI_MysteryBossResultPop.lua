local var_0_0 = {}

var_0_0.URL = "ui://f0eypm8eohqs47"

function var_0_0:__ctor()
	self.m_isHavePosAwardController = self:getController("isHavePosAward")
	self.m_rankTxt = self:getChild("rankTxt")
	self.m_rankAwardList = self:getChild("rankAwardList")
	self.m_posAwardList = self:getChild("posAwardList")
	self.m_giveUpBtn = self:getChild("giveUpBtn")
	self.m_getAwardBtn = self:getChild("getAwardBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
