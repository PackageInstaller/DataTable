local var_0_0 = {}

var_0_0.URL = "ui://qzlsgbi1jr2h3e"

function var_0_0:__ctor()
	self.m_titleComp = self:getChild("titleComp")
	self.m_textList = self:getChild("textList")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
