local var_0_0 = {}

var_0_0.URL = "ui://3g2xiq47c6983x"

function var_0_0:__ctor()
	self.m_isMainTeamController = self:getController("isMainTeam")
	self.m_popPanel = self:getChild("popPanel")
	self.m_cancelBtn = self:getChild("cancelBtn")
	self.m_confirmBtn = self:getChild("confirmBtn")
	self.m_notOwnList = self:getChild("notOwnList")
end

var_0_0.IsMainTeamCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
