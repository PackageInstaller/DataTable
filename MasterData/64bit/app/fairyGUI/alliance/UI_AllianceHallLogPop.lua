local var_0_0 = {}

var_0_0.URL = "ui://lom3h0lckumgm"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_popPanel = self:getChild("popPanel")
	self.m_logList = self:getChild("logList")
	self.m_content = self:getChild("content")
end

var_0_0.IsEmptyCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
