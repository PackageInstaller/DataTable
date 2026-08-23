local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9edjy68t2"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_cityComp = self:getChild("cityComp")
	self.m_stateComp = self:getChild("stateComp")
	self.m_nameComp = self:getChild("nameComp")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
