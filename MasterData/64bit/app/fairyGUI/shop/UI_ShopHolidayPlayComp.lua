local var_0_0 = {}

var_0_0.URL = "ui://454a48jpvioh14bnni2"

function var_0_0:__ctor()
	self.m_isShowSubController = self:getController("isShowSub")
	self.m_showTipController = self:getController("showTip")
	self.m_showTypeController = self:getController("showType")
	self.m_tabList = self:getChild("tabList")
	self.m_subheadTxt = self:getChild("subheadTxt")
	self.m_descTxt = self:getChild("descTxt")
	self.m_lastTimeTxt = self:getChild("lastTimeTxt")
	self.m_itemList = self:getChild("itemList")
	self.m_tipTxt = self:getChild("tipTxt")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.IsShowSubCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.ShowTipCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.ShowTypeCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
