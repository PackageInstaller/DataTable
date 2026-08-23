local var_0_0 = {}

var_0_0.URL = "ui://pbd24silf49a5q"

function var_0_0:__ctor()
	self.m_hasStartInvincibleController = self:getController("hasStartInvincible")
	self.m_hasAirDropController = self:getController("hasAirDrop")
	self.m_cutComp = self:getChild("cutComp")
	self.m_refreshTxt = self:getChild("refreshTxt")
	self.m_killValueTxt = self:getChild("killValueTxt")
	self.m_deadValueTxt = self:getChild("deadValueTxt")
	self.m_startInvincibleTime = self:getChild("startInvincibleTime")
	self.m_airDropTip = self:getChild("airDropTip")
	self.m_effLight = self:getChild("effLight")
	self.m_txtShowTransition = self:getTransition("txtShow")
	self.m_txtHideTransition = self:getTransition("txtHide")
end

return var_0_0
