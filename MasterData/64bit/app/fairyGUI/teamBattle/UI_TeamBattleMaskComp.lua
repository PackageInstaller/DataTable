local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8ltoz97s"

function var_0_0:__ctor()
	self.m_isBigMaskController = self:getController("isBigMask")
	self.m_mask = self:getChild("mask")
	self.m_knightPicComp = self:getChild("knightPicComp")
end

var_0_0.IsBigMaskCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
