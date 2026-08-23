local var_0_0 = {}

var_0_0.URL = "ui://ziwfw8v5lrhf7a3"

function var_0_0:__ctor()
	self.m_showStarController = self:getController("showStar")
	self.m_quality = self:getChild("quality")
	self.m_equipIcon = self:getChild("equipIcon")
	self.m_starComp = self:getChild("starComp")
	self.m_levelTxt = self:getChild("levelTxt")
	self.m_placeLoader = self:getChild("placeLoader")
	self.m_equip = self:getChild("equip")
end

return var_0_0
