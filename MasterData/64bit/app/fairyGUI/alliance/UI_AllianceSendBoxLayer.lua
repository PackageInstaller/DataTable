local var_0_0 = {}

var_0_0.URL = "ui://lom3h0lc9udx2q"

function var_0_0:__ctor()
	self.m_hasBoxController = self:getController("hasBox")
	self.m_boxSendDesc = self:getChild("boxSendDesc")
	self.m_sendList = self:getChild("sendList")
	self.m_sendNumSlider = self:getChild("sendNumSlider")
	self.m_maxNumBtm = self:getChild("maxNumBtm")
	self.m_sendBtn = self:getChild("sendBtn")
	self.m_topBar = self:getChild("topBar")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.HasBoxCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
