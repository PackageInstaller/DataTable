local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wjy7c7y"

function var_0_0:__ctor()
	self.m_qualityController = self:getController("quality")
	self.m_itemComp = self:getChild("itemComp")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.QualityCtrl = {
	page1 = 1,
	page0 = 0,
	page2 = 2
}

return var_0_0
