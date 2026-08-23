local var_0_0 = {}

var_0_0.URL = "ui://tbm73rkgb11f5iblj"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_time_styleController = self:getController("time_style")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_time1Txt = self:getChild("time1Txt")
	self.m_time2Txt = self:getChild("time2Txt")
	self.m_descTxt = self:getChild("descTxt")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.StateCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.Time_styleCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0
}

return var_0_0
