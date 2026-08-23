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
	canuse = 0,
	down = 2
}
var_0_0.StateCtrl = {
	goon = 4,
	stop = 3,
	use = 2,
	unuse = 1,
	none = 0
}

return var_0_0
