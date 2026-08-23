local var_0_0 = {}

var_0_0.URL = "ui://tbm73rkgq8o25ibiu"

function var_0_0:__ctor()
	self.m_lowBatteryController = self:getController("lowBattery")
	self.m_netStateController = self:getController("netState")
	self.m_batteryLoader = self:getChild("batteryLoader")
	self.m_timeText = self:getChild("timeText")
end

var_0_0.LowBatteryCtrl = {
	high = 0,
	low = 1
}
var_0_0.NetStateCtrl = {
	WLAN = 2,
	WIFI = 1,
	none = 0
}

return var_0_0
