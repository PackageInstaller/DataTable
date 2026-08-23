local var_0_0 = {}

var_0_0.URL = "ui://1rxs0yivhob8bov"

function var_0_0:__ctor()
	self.m_isFullController = self:getController("isFull")
	self.m_barPic = self:getChild("barPic")
	self.m_maskPlace = self:getChild("maskPlace")
	self.m_rankText = self:getChild("rankText")
	self.m_effectNode = self:getChild("effectNode")
	self.m_enterTransition = self:getTransition("enter")
	self.m_advanceTransition = self:getTransition("advance")
end

var_0_0.IsFullCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
