local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9lh7n8c9"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_isWinController = self:getController("isWin")
	self.m_bgIdxController = self:getController("bgIdx")
	self.m_hasAwardController = self:getController("hasAward")
	self.m_showAtkTipController = self:getController("showAtkTip")
	self.m_atkComp = self:getChild("atkComp")
	self.m_defComp = self:getChild("defComp")
	self.m_tipTxt = self:getChild("tipTxt")
	self.m_title = self:getChild("title")
	self.m_timeTxt = self:getChild("timeTxt")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.IsWinCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.BgIdxCtrl = {
	["2"] = 0,
	["1"] = 1
}
var_0_0.HasAwardCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ShowAtkTipCtrl = {
	hide = 0,
	show = 1
}

return var_0_0
