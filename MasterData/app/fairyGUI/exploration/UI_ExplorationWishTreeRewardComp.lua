local var_0_0 = {}

var_0_0.URL = "ui://vhnpxv25chky5b"

function var_0_0:__ctor()
	self.m_lightController = self:getController("light")
	self.m_rewardIcon = self:getChild("rewardIcon")
	self.m_rewardNumTxt = self:getChild("rewardNumTxt")
	self.m_eff = self:getChild("eff")
end

var_0_0.LightCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
