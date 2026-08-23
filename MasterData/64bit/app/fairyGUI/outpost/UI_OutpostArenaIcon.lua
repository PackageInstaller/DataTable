local var_0_0 = {}

var_0_0.URL = "ui://ziwfw8v5lrhf771"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_knightIcon = self:getChild("knightIcon")
	self.m_iconElem = self:getChild("iconElem")
	self.m_levelTxt = self:getChild("levelTxt")
	self.m_fightValueTxt = self:getChild("fightValueTxt")
	self.m_placeLoader = self:getChild("placeLoader")
end

return var_0_0
