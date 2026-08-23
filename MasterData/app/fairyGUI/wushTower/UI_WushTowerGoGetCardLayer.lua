local var_0_0 = {}

var_0_0.URL = "ui://r7y8vwhak5r51a"

function var_0_0:__ctor()
	self.m_cardNameTxt = self:getChild("cardNameTxt")
	self.m_cardIconLoader = self:getChild("cardIconLoader")
	self.m_cardNumTxt = self:getChild("cardNumTxt")
	self.m_costItemLoader = self:getChild("costItemLoader")
	self.m_costNumTxt = self:getChild("costNumTxt")
	self.m_goGetBtn = self:getChild("goGetBtn")
	self.m_cardDescTxt = self:getChild("cardDescTxt")
	self.m_cardBagBtn = self:getChild("cardBagBtn")
	self.m_playTimeComp = self:getChild("playTimeComp")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
