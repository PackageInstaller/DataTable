local var_0_0 = {}

var_0_0.URL = "ui://foyq921swhq58c"

function var_0_0:__ctor()
	self.m_isShowNextController = self:getController("isShowNext")
	self.m_isProcessFullController = self:getController("isProcessFull")
	self.m_effectNode = self:getChild("effectNode")
	self.m_teamIndexText = self:getChild("teamIndexText")
	self.m_teamIndexNumText = self:getChild("teamIndexNumText")
	self.m_effectArrow = self:getChild("effectArrow")
	self.m_effectTabPlay = self:getChild("effectTabPlay")
	self.m_percentTxt = self:getChild("percentTxt")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.IsShowNextCtrl = {
	normal = 0,
	show = 1
}
var_0_0.IsProcessFullCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
