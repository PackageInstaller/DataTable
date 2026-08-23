local var_0_0 = {}

var_0_0.URL = "ui://m1cmgw9meg6lm5j"

function var_0_0:__ctor()
	self.m_strategyController = self:getController("strategy")
	self.m_stateController = self:getController("state")
	self.m_showChooseController = self:getController("showChoose")
	self.m_showStrategyController = self:getController("showStrategy")
	self.m_guildCampController = self:getController("guildCamp")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_effectNode = self:getChild("effectNode")
	self.m_strategyIconLoader = self:getChild("strategyIconLoader")
	self.m_effectAttackNode = self:getChild("effectAttackNode")
	self.m_cityNameTxt = self:getChild("cityNameTxt")
	self.m_guildNameTxt = self:getChild("guildNameTxt")
	self.m_serverNameTxt = self:getChild("serverNameTxt")
	self.m_strategyBtn_0 = self:getChild("strategyBtn_0")
	self.m_strategyBtn_1 = self:getChild("strategyBtn_1")
	self.m_strategyBtn_2 = self:getChild("strategyBtn_2")
	self.m_enterTransition = self:getTransition("enter")
	self.m_closeTransition = self:getTransition("close")
end

var_0_0.StrategyCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0
}
var_0_0.StateCtrl = {
	page4 = 4,
	page3 = 3,
	page2 = 2,
	page1 = 1,
	page0 = 0
}
var_0_0.ShowChooseCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ShowStrategyCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.GuildCampCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0
}

return var_0_0
