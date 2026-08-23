local var_0_0 = {}

var_0_0.URL = "ui://n47h6oagknq93s"

function var_0_0:__ctor()
	self.m_myHaveController = self:getController("myHave")
	self.m_rivalHaveController = self:getController("rivalHave")
	self.m_bgPanel = self:getChild("bgPanel")
	self.m_myAdditionList = self:getChild("myAdditionList")
	self.m_rivalAdditionList = self:getChild("rivalAdditionList")
	self.m_rivalNo = self:getChild("rivalNo")
	self.m_myNo = self:getChild("myNo")
end

var_0_0.MyHaveCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.RivalHaveCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
