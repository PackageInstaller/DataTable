local var_0_0 = {}

var_0_0.URL = "ui://n47h6oagqtk93a"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_isRivalController = self:getController("isRival")
	self.m_knightPic = self:getChild("knightPic")
	self.m_addBtn = self:getChild("addBtn")
	self.m_imgPosTouch = self:getChild("imgPosTouch")
	self.m_buffDown = self:getChild("buffDown")
	self.m_buffUp = self:getChild("buffUp")
end

var_0_0.IsEmptyCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsRivalCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
