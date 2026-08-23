local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wqlxuk3"

function var_0_0:__ctor()
	self.m_isAllGetController = self:getController("isAllGet")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.IsAllGetCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
