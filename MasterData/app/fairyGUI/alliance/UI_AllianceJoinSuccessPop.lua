local var_0_0 = {}

var_0_0.URL = "ui://lom3h0lcg2dc53"

function var_0_0:__ctor()
	self.m_isLeaderController = self:getController("isLeader")
	self.m_flag = self:getChild("flag")
	self.m_allianceName = self:getChild("allianceName")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.IsLeaderCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
