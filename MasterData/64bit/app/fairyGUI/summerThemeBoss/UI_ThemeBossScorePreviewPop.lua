local var_0_0 = {}

var_0_0.URL = "ui://44qiyyomie5x2"

function var_0_0:__ctor()
	self.m_effBg = self:getChild("effBg")
	self.m_curScoreText = self:getChild("curScoreText")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_previewList = self:getChild("previewList")
	self.m_backTransition = self:getTransition("back")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
