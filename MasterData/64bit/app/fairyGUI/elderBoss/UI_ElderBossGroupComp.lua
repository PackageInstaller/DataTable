local var_0_0 = {}

var_0_0.URL = "ui://8cx1i074z7w4d"

function var_0_0:__ctor()
	self.m_hasHonnorController = self:getController("hasHonnor")
	self.m_effLoop = self:getChild("effLoop")
	self.m_nameShadowTxt = self:getChild("nameShadowTxt")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_descTxt = self:getChild("descTxt")
	self.m_effShow = self:getChild("effShow")
	self.m_honorTxt = self:getChild("honorTxt")
	self.m_showTransition = self:getTransition("show")
end

var_0_0.HasHonnorCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
