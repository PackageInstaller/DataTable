local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8lkxd09s"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_isFristController = self:getController("isFrist")
	self.m_knightPicComp = self:getChild("knightPicComp")
	self.m_firstImg = self:getChild("firstImg")
	self.m_maskLoader = self:getChild("maskLoader")
end

var_0_0.IsEmptyCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsFristCtrl = {
	frist = 1,
	normal = 0
}

return var_0_0
