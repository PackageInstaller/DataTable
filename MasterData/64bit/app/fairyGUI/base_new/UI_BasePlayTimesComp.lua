local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepqa8zkk2vo"

function var_0_0:__ctor()
	self.m_showDetailController = self:getController("showDetail")
	self.m_HideIconController = self:getController("HideIcon")
	self.m_valueTxt = self:getChild("valueTxt")
	self.m_touchComp = self:getChild("touchComp")
	self.m_getTimesBtn = self:getChild("getTimesBtn")
	self.m_bubbleComp = self:getChild("bubbleComp")
end

var_0_0.ShowDetailCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.HideIconCtrl = {
	hide = 1,
	show = 0
}

return var_0_0
