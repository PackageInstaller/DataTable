local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wia1uha"

function var_0_0:__ctor()
	self.m_isRecvController = self:getController("isRecv")
	self.m_knightIcon = self:getChild("knightIcon")
end

var_0_0.IsRecvCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
