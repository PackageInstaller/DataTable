local var_0_0 = {}

var_0_0.URL = "ui://1rxs0yivn8wvkl"

function var_0_0:__ctor()
	self.m_isMaxController = self:getController("isMax")
	self.m_isMainController = self:getController("isMain")
	self.m_isEnoughController = self:getController("isEnough")
	self.m_isUnlockSellController = self:getController("isUnlockSell")
	self.m_knightIcon = self:getChild("knightIcon")
	self.m_name = self:getChild("name")
	self.m_numText = self:getChild("numText")
	self.m_fragProgBar = self:getChild("fragProgBar")
	self.m_fragBtn = self:getChild("fragBtn")
	self.m_starUpBtn = self:getChild("starUpBtn")
	self.m_chapterProgBar = self:getChild("chapterProgBar")
	self.m_descText = self:getChild("descText")
	self.m_chapterNumText = self:getChild("chapterNumText")
	self.m_gotoBtn = self:getChild("gotoBtn")
	self.m_fragIcon = self:getChild("fragIcon")
	self.m_sellBtn = self:getChild("sellBtn")
	self.m_shopBtn = self:getChild("shopBtn")
end

var_0_0.IsMaxCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0
}
var_0_0.IsMainCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsEnoughCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsUnlockSellCtrl = {
	lock = 0,
	unlock = 1
}

return var_0_0
