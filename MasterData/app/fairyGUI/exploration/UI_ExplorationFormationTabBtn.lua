local var_0_0 = {}

var_0_0.URL = "ui://vhnpxv25nbgf89"

function var_0_0:__ctor()
	self.m_isProcessFullController = self:getController("isProcessFull")
	self.m_effectNode = self:getChild("effectNode")
	self.m_teamIndexText = self:getChild("teamIndexText")
	self.m_teamIndexNumText = self:getChild("teamIndexNumText")
	self.m_effectArrow = self:getChild("effectArrow")
	self.m_effectTabPlay = self:getChild("effectTabPlay")
	self.m_percentTxt = self:getChild("percentTxt")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.IsProcessFullCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
