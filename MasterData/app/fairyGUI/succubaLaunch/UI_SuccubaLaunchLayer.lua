local var_0_0 = {}

var_0_0.URL = "ui://bspi99sbira5s"

function var_0_0:__ctor()
	self.m_floorController = self:getController("floor")
	self.m_knightHolder = self:getChild("knightHolder")
	self.m_giftBtn = self:getChild("giftBtn")
	self.m_taskBtn = self:getChild("taskBtn")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_shopTabList = self:getChild("shopTabList")
	self.m_itemList = self:getChild("itemList")
	self.m_costItemIcon = self:getChild("costItemIcon")
	self.m_numTxt = self:getChild("numTxt")
	self.m_topBarComp = self:getChild("topBarComp")
end

return var_0_0
