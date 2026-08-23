local var_0_0 = {}

var_0_0.URL = "ui://e2ymx4wayb1z1y"

function var_0_0:__ctor()
	self.m_isFirstController = self:getController("isFirst")
	self.m_isReachController = self:getController("isReach")
	self.m_isAwardController = self:getController("isAward")
	self.m_isBigController = self:getController("isBig")
	self.m_arrow = self:getChild("arrow")
	self.m_effArrow = self:getChild("effArrow")
	self.m_bg = self:getChild("bg")
	self.m_icon = self:getChild("icon")
	self.m_num = self:getChild("num")
	self.m_score = self:getChild("score")
	self.m_effIcon = self:getChild("effIcon")
end

return var_0_0
