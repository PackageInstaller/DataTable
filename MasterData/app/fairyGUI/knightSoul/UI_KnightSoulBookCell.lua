local var_0_0 = {}

var_0_0.URL = "ui://kwpkf9ulamy98"

function var_0_0:__ctor()
	self.m_bookStatusController = self:getController("bookStatus")
	self.m_qualityBg = self:getChild("qualityBg")
	self.m_card1 = self:getChild("card1")
	self.m_card2 = self:getChild("card2")
	self.m_card3 = self:getChild("card3")
	self.m_card4 = self:getChild("card4")
	self.m_card5 = self:getChild("card5")
	self.m_starComp = self:getChild("starComp")
	self.m_eff = self:getChild("eff")
end

return var_0_0
