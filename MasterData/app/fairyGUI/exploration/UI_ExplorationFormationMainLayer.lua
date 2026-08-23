local var_0_0 = {}

var_0_0.URL = "ui://vhnpxv25b8ef0"

function var_0_0:__ctor()
	self.m_btnTypeController = self:getController("btnType")
	self.m_canSkipController = self:getController("canSkip")
	self.m_mulTeamFormationComp = self:getChild("mulTeamFormationComp")
	self.m_tabList = self:getChild("tabList")
	self.m_challengeBtn = self:getChild("challengeBtn")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_skipTip = self:getChild("skipTip")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.BtnTypeCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.CanSkipCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
