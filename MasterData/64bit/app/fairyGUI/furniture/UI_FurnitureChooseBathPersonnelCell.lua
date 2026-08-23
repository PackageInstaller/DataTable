local var_0_0 = {}

var_0_0.URL = "ui://irs65rtsiqzzm78"

function var_0_0:__ctor()
	self.m_checkInController = self:getController("checkIn")
	self.m_actionNullController = self:getController("actionNull")
	self.m_knightIconLoader = self:getChild("knightIconLoader")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_mobilityCircleBarComp = self:getChild("mobilityCircleBarComp")
end

return var_0_0
