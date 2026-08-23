local var_0_0 = {}

var_0_0.URL = "ui://i8uevo9vl5qq9r"

function var_0_0:__ctor()
	self.m_worldHold = self:getChild("worldHold")
	self.m_criComp = self:getChild("criComp")
	self.m_touchMap = self:getChild("touchMap")
	self.m_taskPart = self:getChild("taskPart")
	self.m_topBar = self:getChild("topBar")
	self.m_voteBtn = self:getChild("voteBtn")
	self.m_raceTxtComp = self:getChild("raceTxtComp")
	self.m_autoComp = self:getChild("autoComp")
	self.m_pickupComp = self:getChild("pickupComp")
	self.m_directionComp = self:getChild("directionComp")
	self.m_headBtn = self:getChild("headBtn")
	self.m_exitBtn = self:getChild("exitBtn")
	self.m_reviewBtn = self:getChild("reviewBtn")
	self.m_bagBtn = self:getChild("bagBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_hideTransition = self:getTransition("hide")
end

return var_0_0
