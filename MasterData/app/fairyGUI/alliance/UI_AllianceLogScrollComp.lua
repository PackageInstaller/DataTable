local var_0_0 = {}

var_0_0.URL = "ui://lom3h0lcggvw6w"

function var_0_0:__ctor()
	self.m_hasLogController = self:getController("hasLog")
	self.m_log1 = self:getChild("log1")
	self.m_log2 = self:getChild("log2")
end

var_0_0.HasLogCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
