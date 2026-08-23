local var_0_0 = {}

var_0_0.URL = "ui://1b29hdofjaqt52"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_stateController = self:getController("state")
	self.m_itemLoader = self:getChild("itemLoader")
	self.m_rewardList = self:getChild("rewardList")
	self.m_rechargeBtn = self:getChild("rechargeBtn")
	self.m_extTeamGroup = self:getChild("extTeamGroup")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.TypeCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.StateCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
