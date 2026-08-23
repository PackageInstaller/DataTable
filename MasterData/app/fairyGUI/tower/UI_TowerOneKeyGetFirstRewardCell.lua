local var_0_0 = {}

var_0_0.URL = "ui://foyq921sxc1b68"

function var_0_0:__ctor()
	self.m_isResultShowController = self:getController("isResultShow")
	self.m_hasUserController = self:getController("hasUser")
	self.m_countTxt = self:getChild("countTxt")
	self.m_passOrderText = self:getChild("passOrderText")
	self.m_rewardList = self:getChild("rewardList")
	self.m_userIcon = self:getChild("userIcon")
	self.m_userNameText = self:getChild("userNameText")
	self.m_serverNameText = self:getChild("serverNameText")
	self.m_powerText = self:getChild("powerText")
	self.m_resultList = self:getChild("resultList")
end

var_0_0.IsResultShowCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.HasUserCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
