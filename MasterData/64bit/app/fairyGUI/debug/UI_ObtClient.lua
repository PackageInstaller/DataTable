local var_0_0 = {}

var_0_0.URL = "ui://7x1mja7yzt5ml5ibl3"

function var_0_0:__ctor()
	self.m_hasVersionController = self:getController("hasVersion")
	self.m_showViewController = self:getController("showView")
	self.m_serverIpInput = self:getChild("serverIpInput")
	self.m_serverPortInput = self:getChild("serverPortInput")
	self.m_connectBtn = self:getChild("connectBtn")
	self.m_versionSelectComp = self:getChild("versionSelectComp")
	self.m_showProgressComp = self:getChild("showProgressComp")
	self.m_allBattleList = self:getChild("allBattleList")
	self.m_resultComp = self:getChild("resultComp")
	self.m_lookBtn = self:getChild("lookBtn")
	self.m_attackTeam = self:getChild("attackTeam")
	self.m_victimTeam = self:getChild("victimTeam")
	self.m_exportFileInput = self:getChild("exportFileInput")
	self.m_exportBtn = self:getChild("exportBtn")
	self.m_exportCsvList = self:getChild("exportCsvList")
	self.m_exportDir = self:getChild("exportDir")
end

var_0_0.HasVersionCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.ShowViewCtrl = {
	page1 = 1,
	page0 = 0,
	page2 = 5
}

return var_0_0
