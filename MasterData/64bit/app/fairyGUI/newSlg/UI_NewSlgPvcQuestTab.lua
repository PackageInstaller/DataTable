local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9unlz68qv"

function var_0_0:__ctor()
	self.m_passedController = self:getController("passed")
	self.m_loader = self:getChild("loader")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.PassedCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
