local var_0_0 = {}

var_0_0.URL = "ui://lom3h0lcrv0qe"

function var_0_0:__ctor()
	self.m_needConfirmController = self:getController("needConfirm")
	self.m_popPanel = self:getChild("popPanel")
	self.m_changeLvComp = self:getChild("changeLvComp")
	self.m_confirmBtn = self:getChild("confirmBtn")
	self.m_content = self:getChild("content")
end

var_0_0.NeedConfirmCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
