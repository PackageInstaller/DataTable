local var_0_0 = {}

var_0_0.URL = "ui://qrucqci6jm5ekk3oi"

function var_0_0:__ctor()
	self.m_time_colorController = self:getController("time_color")
	self.m_titleNameTxt = self:getChild("titleNameTxt")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_progressBar = self:getChild("progressBar")
end

var_0_0.Time_colorCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
