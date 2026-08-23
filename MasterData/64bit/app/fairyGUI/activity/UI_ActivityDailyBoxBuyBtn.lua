local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9waayj56"

function var_0_0:__ctor()
	self.m_isCanOneKeyController = self:getController("isCanOneKey")
	self.m_priceDesc = self:getChild("priceDesc")
end

var_0_0.IsCanOneKeyCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
