local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9o9j768p6"

function var_0_0:__ctor()
	self.m_isMaxController = self:getController("isMax")
	self.m_showTipController = self:getController("showTip")
	self.m_tipBtn = self:getChild("tipBtn")
	self.m_bg = self:getChild("bg")
	self.m_maskComp = self:getChild("maskComp")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_efficiency = self:getChild("efficiency")
	self.m_tip = self:getChild("tip")
end

var_0_0.IsMaxCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ShowTipCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
