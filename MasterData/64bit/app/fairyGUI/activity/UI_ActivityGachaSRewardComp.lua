local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wm6mjgh"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_isGetController = self:getController("isGet")
	self.m_luckyBg = self:getChild("luckyBg")
	self.m_luckyValueTxt = self:getChild("luckyValueTxt")
	self.m_selectBtn = self:getChild("selectBtn")
	self.m_itemLoader = self:getChild("itemLoader")
	self.m_itemLoaderMask = self:getChild("itemLoaderMask")
	self.m_sTitleTxt = self:getChild("sTitleTxt")
	self.m_lastTxt = self:getChild("lastTxt")
	self.m_changeBtn = self:getChild("changeBtn")
	self.m_detailBtn = self:getChild("detailBtn")
	self.m_eff = self:getChild("eff")
end

var_0_0.StateCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.IsGetCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
