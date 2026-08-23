local var_0_0 = {}

var_0_0.URL = "ui://1v7lxemfn1mfi"

function var_0_0:__ctor()
	self.m_knightPicComp = self:getChild("knightPicComp")
	self.m_formationComp = self:getChild("formationComp")
	self.m_starComp = self:getChild("starComp")
	self.m_nameText = self:getChild("nameText")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
