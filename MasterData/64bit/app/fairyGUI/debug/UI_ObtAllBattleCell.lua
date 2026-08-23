local var_0_0 = {}

var_0_0.URL = "ui://7x1mja7yeslbl5ibl7"

function var_0_0:__ctor()
	self.m_hasDataController = self:getController("hasData")
	self.m_progressComp = self:getChild("progressComp")
	self.m_desc = self:getChild("desc")
end

var_0_0.HasDataCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
