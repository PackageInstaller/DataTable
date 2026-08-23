local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88okw9d9rrpv"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_iconUp = self:getChild("iconUp")
	self.m_iconDown = self:getChild("iconDown")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.TypeCtrl = {
	page0 = 3,
	page1 = 6
}

return var_0_0
