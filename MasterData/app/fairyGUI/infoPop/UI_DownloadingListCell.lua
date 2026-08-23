local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bn7t9d1v5dss9"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_isReceivedController = self:getController("isReceived")
	self.m_pro = self:getChild("pro")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_award = self:getChild("award")
	self.m_statueIcon = self:getChild("statueIcon")
	self.m_effLoading = self:getChild("effLoading")
end

var_0_0.StateCtrl = {
	finish = 2,
	downloading = 1,
	wait = 0
}
var_0_0.IsReceivedCtrl = {
	received = 1,
	normal = 0
}

return var_0_0
