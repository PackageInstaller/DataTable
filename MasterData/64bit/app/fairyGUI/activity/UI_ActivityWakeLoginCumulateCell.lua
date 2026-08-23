local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wavfsly"

function var_0_0:__ctor()
	self.m_isSatisfyController = self:getController("isSatisfy")
	self.m_isRecvController = self:getController("isRecv")
	self.m_progBar = self:getChild("progBar")
	self.m_progDot = self:getChild("progDot")
	self.m_dayTxt = self:getChild("dayTxt")
	self.m_icon = self:getChild("icon")
	self.m_effCard = self:getChild("effCard")
	self.m_effDot = self:getChild("effDot")
	self.m_recvBtn = self:getChild("recvBtn")
end

var_0_0.IsSatisfyCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.IsRecvCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
