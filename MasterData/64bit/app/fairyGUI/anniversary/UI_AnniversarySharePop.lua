local var_0_0 = {}

var_0_0.URL = "ui://pb5qrmiqkj0u2p"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_isShowShareTypeController = self:getController("isShowShareType")
	self.m_bg = self:getChild("bg")
	self.m_title = self:getChild("title")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_shareBtn = self:getChild("shareBtn")
	self.m_shareList = self:getChild("shareList")
	self.m_shareCrossBtn = self:getChild("shareCrossBtn")
	self.m_shareGuildBtn = self:getChild("shareGuildBtn")
	self.m_shareFriendBtn = self:getChild("shareFriendBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
