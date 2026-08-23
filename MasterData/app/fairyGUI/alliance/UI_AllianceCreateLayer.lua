local var_0_0 = {}

var_0_0.URL = "ui://lom3h0lcjye2l"

function var_0_0:__ctor()
	self.m_showStateController = self:getController("showState")
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_showCanJoin = self:getChild("showCanJoin")
	self.m_seekGuildBtn = self:getChild("seekGuildBtn")
	self.m_inputComp = self:getChild("inputComp")
	self.m_joinList = self:getChild("joinList")
	self.m_joinCD = self:getChild("joinCD")
	self.m_createBtn = self:getChild("createBtn")
	self.m_refreshBtn = self:getChild("refreshBtn")
	self.m_invitationListBtn = self:getChild("invitationListBtn")
	self.m_applyListBtn = self:getChild("applyListBtn")
	self.m_topBar = self:getChild("topBar")
end

var_0_0.ShowStateCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsEmptyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
