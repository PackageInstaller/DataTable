local var_0_0 = {}

var_0_0.URL = "ui://qrucqci6vmv39bnok0"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_selectTransition = self:getTransition("select")
	self.m_correctTransition = self:getTransition("correct")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
