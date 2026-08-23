local var_0_0 = {}

var_0_0.URL = "ui://xigti88crvig2y"

function var_0_0:__ctor()
	self.m_infoController = self:getController("info")
	self.m_stateController = self:getController("state")
	self.m_probar = self:getChild("probar")
	self.m_stateTipText = self:getChild("stateTipText")
	self.m_btnContinue = self:getChild("btnContinue")
	self.m_btnPause = self:getChild("btnPause")
	self.m_btnClose = self:getChild("btnClose")
	self.m_btnUpdate = self:getChild("btnUpdate")
	self.m_btnDownload = self:getChild("btnDownload")
	self.m_iconSelect = self:getChild("iconSelect")
end

var_0_0.InfoCtrl = {
	need = 1,
	down = 2,
	canuse = 0
}
var_0_0.StateCtrl = {
	stop = 3,
	unuse = 1,
	goon = 4,
	use = 2,
	none = 0
}

return var_0_0
