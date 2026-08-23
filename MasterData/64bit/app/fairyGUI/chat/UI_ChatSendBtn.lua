local var_0_0 = {}

var_0_0.URL = "ui://v9hfyn87dhwcby2wy"

function var_0_0:__ctor()
	self.m_canSendController = self:getController("canSend")
	self.m_CDPic = self:getChild("CDPic")
	self.m_CDText = self:getChild("CDText")
end

var_0_0.CanSendCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
