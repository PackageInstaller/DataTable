local var_0_0 = {}

var_0_0.URL = "ui://1b29hdofhh9b2o"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.TypeCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
