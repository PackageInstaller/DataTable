local var_0_0 = {}

var_0_0.URL = "ui://14huq3sffd6dv"

function var_0_0:__ctor()
	self.m_touchComp = self:getChild("touchComp")
	self.m_knightPicComp = self:getChild("knightPicComp")
	self.m_levelText = self:getChild("levelText")
	self.m_attrList = self:getChild("attrList")
	self.m_passiveIcon = self:getChild("passiveIcon")
	self.m_skillName = self:getChild("skillName")
	self.m_skillDesc = self:getChild("skillDesc")
	self.m_effTitle = self:getChild("effTitle")
	self.m_effFeedback = self:getChild("effFeedback")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
