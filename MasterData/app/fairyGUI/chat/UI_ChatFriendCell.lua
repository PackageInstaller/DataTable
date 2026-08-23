local var_0_0 = {}

var_0_0.URL = "ui://v9hfyn87xip4by2x9"

function var_0_0:__ctor()
	self.m_isTopController = self:getController("isTop")
	self.m_showMoreController = self:getController("showMore")
	self.m_isCrossServerController = self:getController("isCrossServer")
	self.m_friendIcon = self:getChild("friendIcon")
	self.m_nameText = self:getChild("nameText")
	self.m_chatText = self:getChild("chatText")
	self.m_timeText = self:getChild("timeText")
	self.m_showMoreBtn = self:getChild("showMoreBtn")
	self.m_serverName = self:getChild("serverName")
	self.m_cancelBtn = self:getChild("cancelBtn")
	self.m_topBtn = self:getChild("topBtn")
	self.m_deleteBtn = self:getChild("deleteBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.IsTopCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ShowMoreCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsCrossServerCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
