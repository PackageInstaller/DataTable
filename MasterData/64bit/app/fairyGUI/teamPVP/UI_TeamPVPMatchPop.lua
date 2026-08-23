local var_0_0 = {}

var_0_0.URL = "ui://akds0szaf4701"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_matchingDiskComp = self:getChild("matchingDiskComp")
	self.m_effDi = self:getChild("effDi")
	self.m_estimateTime = self:getChild("estimateTime")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_player1 = self:getChild("player1")
	self.m_player2 = self:getChild("player2")
	self.m_player3 = self:getChild("player3")
	self.m_player4 = self:getChild("player4")
	self.m_player5 = self:getChild("player5")
	self.m_cancelBtn = self:getChild("cancelBtn")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
