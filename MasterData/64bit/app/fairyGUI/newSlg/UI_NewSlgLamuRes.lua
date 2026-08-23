local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9l57h68g4"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_Comp_place = self:getChild("Comp_place")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
