local var_0_0 = {}

var_0_0.URL = "ui://m1cmgw9mh7n524"

function var_0_0:__ctor()
	self.m_groupStateController = self:getController("groupState")
	self.m_isDrillStateController = self:getController("isDrillState")
	self.m_serverNameText = self:getChild("serverNameText")
	self.m_rankText = self:getChild("rankText")
	self.m_guildNameText = self:getChild("guildNameText")
	self.m_scoreText = self:getChild("scoreText")
end

var_0_0.GroupStateCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0
}
var_0_0.IsDrillStateCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
