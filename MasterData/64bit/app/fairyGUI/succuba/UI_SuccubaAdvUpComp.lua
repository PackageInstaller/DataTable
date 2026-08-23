local var_0_0 = {}

var_0_0.URL = "ui://qzlsgbi1iqj74e"

function var_0_0:__ctor()
	self.m_isStarMaxController = self:getController("isStarMax")
	self.m_isSkillChangeController = self:getController("isSkillChange")
	self.m_advProgressBar = self:getChild("advProgressBar")
	self.m_effDadComp = self:getChild("effDadComp")
	self.m_advLvText = self:getChild("advLvText")
	self.m_skillIcon1 = self:getChild("skillIcon1")
	self.m_skillIcon2 = self:getChild("skillIcon2")
	self.m_baseAttrComp = self:getChild("baseAttrComp")
	self.m_charmBg = self:getChild("charmBg")
	self.m_charmComp = self:getChild("charmComp")
	self.m_costList = self:getChild("costList")
	self.m_advUpBtn = self:getChild("advUpBtn")
	self.m_maxComp = self:getChild("maxComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
	self.m_advanceTransition = self:getTransition("advance")
end

return var_0_0
