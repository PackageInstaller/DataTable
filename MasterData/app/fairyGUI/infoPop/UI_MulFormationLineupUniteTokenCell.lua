local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bnbh0lgic3g"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_isBorrowController = self:getController("isBorrow")
	self.m_skillIcon = self:getChild("skillIcon")
	self.m_qualityBgLoader = self:getChild("qualityBgLoader")
	self.m_nameText = self:getChild("nameText")
	self.m_stateText = self:getChild("stateText")
	self.m_featureText = self:getChild("featureText")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsBorrowCtrl = {
	borrow = 1,
	normal = 0
}

return var_0_0
