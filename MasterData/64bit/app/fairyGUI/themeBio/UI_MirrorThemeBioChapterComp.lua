local var_0_0 = {}

var_0_0.URL = "ui://i8uevo9vj987mw2xfm"

function var_0_0:__ctor()
	self.m_chapterController = self:getController("chapter")
	self.m_openStateController = self:getController("openState")
	self.m_effPerfect = self:getChild("effPerfect")
	self.m_name = self:getChild("name")
	self.m_mask = self:getChild("mask")
	self.m_stateIcon = self:getChild("stateIcon")
	self.m_stateTxt = self:getChild("stateTxt")
	self.m_lockTxt = self:getChild("lockTxt")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_passTransition = self:getTransition("pass")
	self.m_perfectTransition = self:getTransition("perfect")
end

return var_0_0
