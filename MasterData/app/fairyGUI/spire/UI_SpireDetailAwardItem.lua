local var_0_0 = {}

var_0_0.URL = "ui://q8j59504rkt94q"

function var_0_0:__ctor()
	self.m_isUpController = self:getController("isUp")
	self.m_itemComp = self:getChild("itemComp")
end

var_0_0.IsUpCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
