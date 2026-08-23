local var_0_0 = {}

var_0_0.URL = "ui://qrucqci6k6jm1kk464"

function var_0_0:__ctor()
	self.m_puzzleInfoComp = self:getChild("puzzleInfoComp")
	self.m_showPicComp = self:getChild("showPicComp")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
