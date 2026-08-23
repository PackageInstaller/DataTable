local var_0_0 = {}

var_0_0.URL = "ui://qrucqci6kze0kk38f"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_resLoader = self:getChild("resLoader")
	self.m_effTurnCard = self:getChild("effTurnCard")
	self.m_effRight = self:getChild("effRight")
	self.m_enterTransition = self:getTransition("enter")
	self.m_rightTransition = self:getTransition("right")
	self.m_turnPlayTransition = self:getTransition("turnPlay")
	self.m_turnPlay2Transition = self:getTransition("turnPlay2")
end

var_0_0.StateCtrl = {
	page1 = 1,
	page0 = 0,
	page2 = 2
}

return var_0_0
