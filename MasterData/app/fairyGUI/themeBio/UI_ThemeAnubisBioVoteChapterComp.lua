local var_0_0 = {}

var_0_0.URL = "ui://i8uevo9vl5qq92"

function var_0_0:__ctor()
	self.m_chapterController = self:getController("chapter")
	self.m_openStateController = self:getController("openState")
	self.m_name = self:getChild("name")
	self.m_effPerfect = self:getChild("effPerfect")
	self.m_effStateIcon = self:getChild("effStateIcon")
	self.m_stateIcon = self:getChild("stateIcon")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_mask = self:getChild("mask")
	self.m_lockTxt = self:getChild("lockTxt")
	self.m_lockFlag = self:getChild("lockFlag")
	self.m_effLock = self:getChild("effLock")
	self.m_enterTransition = self:getTransition("enter")
	self.m_passPerfectTransition = self:getTransition("passPerfect")
end

return var_0_0
