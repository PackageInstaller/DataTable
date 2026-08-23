local var_0_0 = {}

var_0_0.URL = "ui://lpxuu9tar06jo"

function var_0_0:__ctor()
	self.m_state1Controller = self:getController("state1")
	self.m_state2Controller = self:getController("state2")
	self.m_stateRealController = self:getController("stateReal")
	self.m_eff = self:getChild("eff")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_state1Txt = self:getChild("state1Txt")
	self.m_state2Txt = self:getChild("state2Txt")
	self.m_restartBtn = self:getChild("restartBtn")
	self.m_state3Txt = self:getChild("state3Txt")
	self.m_ignoreBtn = self:getChild("ignoreBtn")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
