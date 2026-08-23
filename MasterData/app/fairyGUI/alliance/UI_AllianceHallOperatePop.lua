local var_0_0 = {}

var_0_0.URL = "ui://lom3h0lcqylg2x"

function var_0_0:__ctor()
	self.m_operationController = self:getController("operation")
	self.m_popPanel = self:getChild("popPanel")
	self.m_operationTxt = self:getChild("operationTxt")
	self.m_layoffTip1 = self:getChild("layoffTip1")
	self.m_layoffTip2 = self:getChild("layoffTip2")
	self.m_tips = self:getChild("tips")
	self.m_quitTips = self:getChild("quitTips")
	self.m_transferTip = self:getChild("transferTip")
	self.m_cancelBtn = self:getChild("cancelBtn")
	self.m_confirmBtn = self:getChild("confirmBtn")
	self.m_content = self:getChild("content")
end

var_0_0.OperationCtrl = {
	page2 = 2,
	page8 = 8,
	page1 = 1,
	page0 = 0,
	page7 = 7,
	page6 = 6,
	page5 = 5,
	page4 = 4,
	page3 = 3
}

return var_0_0
