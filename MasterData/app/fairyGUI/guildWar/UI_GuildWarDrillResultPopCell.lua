local var_0_0 = {}

var_0_0.URL = "ui://m1cmgw9mqr81m7d"

function var_0_0:__ctor()
	self.m_showGroupController = self:getController("showGroup")
	self.m_groupNameText = self:getChild("groupNameText")
	self.m_guildList = self:getChild("guildList")
end

var_0_0.ShowGroupCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
