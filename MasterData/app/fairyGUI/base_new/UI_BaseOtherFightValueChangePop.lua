local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepk2kw1emigg0"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_placeHolderComp = self:getChild("placeHolderComp")
	self.m_fightTxt = self:getChild("fightTxt")
	self.m_fightValueTxt = self:getChild("fightValueTxt")
	self.m_valueTxt = self:getChild("valueTxt")
	self.m_inTransition = self:getTransition("in")
	self.m_outTransition = self:getTransition("out")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
