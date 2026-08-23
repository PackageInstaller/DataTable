local var_0_0 = {}

var_0_0.URL = "ui://lm8a5nrug6m3n"

function var_0_0:__ctor()
	self.m_titleLoader = self:getChild("titleLoader")
	self.m_titleEff = self:getChild("titleEff")
	self.m_titleNameLoader = self:getChild("titleNameLoader")
	self.m_line = self:getChild("line")
	self.m_startTimeTxt = self:getChild("startTimeTxt")
	self.m_endTimeTxt = self:getChild("endTimeTxt")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
