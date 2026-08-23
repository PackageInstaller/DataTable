local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88oey4zrrm8"

function var_0_0:__ctor()
	self.m_groupController = self:getController("group")
	self.m_playerList = self:getChild("playerList")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.GroupCtrl = {
	page1 = 1,
	page0 = 0,
	page4 = 4,
	page3 = 3,
	page2 = 2
}

return var_0_0
