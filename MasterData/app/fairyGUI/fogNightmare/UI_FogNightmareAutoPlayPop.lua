local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88oe10p9rrt0"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_maskClick = self:getChild("maskClick")
	self.m_effPopbg = self:getChild("effPopbg")
	self.m_effComTitle = self:getChild("effComTitle")
	self.m_floorText = self:getChild("floorText")
	self.m_autoTipText = self:getChild("autoTipText")
	self.m_autoIcon = self:getChild("autoIcon")
	self.m_stopBtn = self:getChild("stopBtn")
	self.m_effPopTitle = self:getChild("effPopTitle")
	self.m_content = self:getChild("content")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.StateCtrl = {
	wait = 1,
	normal = 0
}

return var_0_0
