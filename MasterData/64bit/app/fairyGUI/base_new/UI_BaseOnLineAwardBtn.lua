local var_0_0 = {}

var_0_0.URL = "ui://kvb3zneptaaxkk2xr"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_boxIconController = self:getController("boxIcon")
	self.m_getTxt = self:getChild("getTxt")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_effectComp = self:getChild("effectComp")
end

var_0_0.StateCtrl = {
	已破解（可领取） = 1,
	破解中 = 0
}
var_0_0.BoxIconCtrl = {
	大宝箱 = 2,
	中宝箱 = 1,
	小宝箱 = 0,
	空 = 3
}

return var_0_0
