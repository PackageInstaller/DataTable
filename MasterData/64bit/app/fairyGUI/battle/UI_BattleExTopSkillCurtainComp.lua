local var_0_0 = {}

var_0_0.URL = "ui://dj6vjom2gi2ib2"

function var_0_0:__ctor()
	self.m_sideTypeController = self:getController("sideType")
	self.m_elementalController = self:getController("elemental")
	self.m_is_leaderController = self:getController("is_leader")
	self.m_criSprite = self:getChild("criSprite")
	self.m_skillNameText = self:getChild("skillNameText")
	self.m_iconLoader = self:getChild("iconLoader")
	self.m_efficon = self:getChild("efficon")
	self.m_enterTransition = self:getTransition("enter")
	self.m_enterMrTransition = self:getTransition("enterMr")
end

var_0_0.SideTypeCtrl = {
	left = 0,
	right = 1
}
var_0_0.ElementalCtrl = {
	page5 = 5,
	page4 = 4,
	page3 = 3,
	page2 = 2,
	page1 = 1,
	page0 = 0
}
var_0_0.Is_leaderCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
