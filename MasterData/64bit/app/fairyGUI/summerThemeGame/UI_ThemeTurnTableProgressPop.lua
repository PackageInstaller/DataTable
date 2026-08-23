local var_0_0 = {}

var_0_0.URL = "ui://qrucqci6p7pmkk38n"

function var_0_0:__ctor()
	self.m_popPanel = self:getChild("popPanel")
	self.m_progressList = self:getChild("progressList")
	self.m_curTurnNumText = self:getChild("curTurnNumText")
	self.m_content = self:getChild("content")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
