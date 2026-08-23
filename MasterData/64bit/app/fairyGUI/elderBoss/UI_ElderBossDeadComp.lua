local var_0_0 = {}

var_0_0.URL = "ui://8cx1i074f9832i"

function var_0_0:__ctor()
	self.m_isHaveLuckyController = self:getController("isHaveLucky")
	self.m_openController = self:getController("open")
	self.m_killedEff = self:getChild("killedEff")
	self.m_playerNameTxt = self:getChild("playerNameTxt")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.IsHaveLuckyCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.OpenCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
