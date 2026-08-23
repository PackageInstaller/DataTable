local var_0_0 = {}

var_0_0.URL = "ui://v9hfyn8781thby2wu"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_faceIcon = self:getChild("faceIcon")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.IsEmptyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
