local var_0_0 = {}

var_0_0.URL = "ui://16fa1nlapo2z5r"

function var_0_0:__ctor()
	self.m_isFreeController = self:getController("isFree")
	self.m_showRedPointController = self:getController("showRedPoint")
	self.m_freeDrawController = self:getController("freeDraw")
	self.m_freeTimeText = self:getChild("freeTimeText")
	self.m_costComp = self:getChild("costComp")
	self.m_redImg = self:getChild("redImg")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.IsFreeCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ShowRedPointCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.FreeDrawCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
