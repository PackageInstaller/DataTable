local var_0_0 = {}

var_0_0.URL = "ui://fu6pxbhwny8215"

function var_0_0:__ctor()
	self.m_selectTagController = self:getController("selectTag")
	self.m_eventNameTxt = self:getChild("eventNameTxt")
	self.m_eventNameTxt2 = self:getChild("eventNameTxt2")
	self.m_lastTimeTxt = self:getChild("lastTimeTxt")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_startBtn = self:getChild("startBtn")
	self.m_eff = self:getChild("eff")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
