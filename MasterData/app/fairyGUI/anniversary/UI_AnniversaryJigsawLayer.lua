local var_0_0 = {}

var_0_0.URL = "ui://pb5qrmiqjg04r"

function var_0_0:__ctor()
	self.m_signComp = self:getChild("signComp")
	self.m_bigAwardComp = self:getChild("bigAwardComp")
	self.m_shareBtn = self:getChild("shareBtn")
	self.m_jigsawBg = self:getChild("jigsawBg")
	self.m_group1 = self:getChild("group1")
	self.m_group2 = self:getChild("group2")
	self.m_group3 = self:getChild("group3")
	self.m_group4 = self:getChild("group4")
	self.m_group5 = self:getChild("group5")
	self.m_group6 = self:getChild("group6")
	self.m_jifenBg = self:getChild("jifenBg")
	self.m_cumulativeComp = self:getChild("cumulativeComp")
	self.m_drawCardBtn = self:getChild("drawCardBtn")
	self.m_keepDrawCardBtn = self:getChild("keepDrawCardBtn")
	self.m_effFly = self:getChild("effFly")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_clickIgnoreMask = self:getChild("clickIgnoreMask")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
