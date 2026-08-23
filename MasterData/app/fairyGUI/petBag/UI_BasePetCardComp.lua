local var_0_0 = {}

var_0_0.URL = "ui://3qhq8zotc8pws"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_isOwnController = self:getController("isOwn")
	self.m_hasAdvanceController = self:getController("hasAdvance")
	self.m_picComp = self:getChild("picComp")
	self.m_nameText = self:getChild("nameText")
	self.m_advLevelText = self:getChild("advLevelText")
	self.m_starComp = self:getChild("starComp")
	self.m_levelText = self:getChild("levelText")
	self.m_fragNumText = self:getChild("fragNumText")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1,
	page3 = 3
}
var_0_0.IsOwnCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.HasAdvanceCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
