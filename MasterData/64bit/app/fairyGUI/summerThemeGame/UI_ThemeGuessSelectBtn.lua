local var_0_0 = {}

var_0_0.URL = "ui://qrucqci6cfmu1kk40p"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_selectTransition = self:getTransition("select")
	self.m_correctTransition = self:getTransition("correct")
end

var_0_0.StateCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0
}

return var_0_0
