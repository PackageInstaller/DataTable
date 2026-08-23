local var_0_0 = {}

var_0_0.URL = "ui://m1cmgw9mlydfm5q"

function var_0_0:__ctor()
	self.m_chooseController = self:getController("choose")
	self.m_stateController = self:getController("state")
	self.m_userIcon = self:getChild("userIcon")
	self.m_fightValueTxt = self:getChild("fightValueTxt")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_stationNameTxt = self:getChild("stationNameTxt")
end

var_0_0.ChooseCtrl = {
	down = 1,
	up = 0
}
var_0_0.StateCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
