local var_0_0 = {}

var_0_0.URL = "ui://2egchbz1abvq35"

function var_0_0:__ctor()
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_buildTabList = self:getChild("buildTabList")
	self.m_typeTabList = self:getChild("typeTabList")
	self.m_levelCardComp = self:getChild("levelCardComp")
	self.m_cardList = self:getChild("cardList")
	self.m_attrBtn = self:getChild("attrBtn")
	self.m_oneKeyUpgrage = self:getChild("oneKeyUpgrage")
	self.m_effectNode = self:getChild("effectNode")
	self.m_mask = self:getChild("mask")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
