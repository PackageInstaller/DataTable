local var_0_0 = {}

var_0_0.URL = "ui://ij78oondlaiw6m"

function var_0_0:__ctor()
	self.m_emptyController = self:getController("empty")
	self.m_touchBg = self:getChild("touchBg")
	self.m_bgPanel = self:getChild("bgPanel")
	self.m_groupList = self:getChild("groupList")
	self.m_screenBtn = self:getChild("screenBtn")
	self.m_runnerBanner = self:getChild("runnerBanner")
	self.m_checkBtn = self:getChild("checkBtn")
	self.m_cardList = self:getChild("cardList")
	self.m_recruitBtn = self:getChild("recruitBtn")
	self.m_cancelScreenBg = self:getChild("cancelScreenBg")
	self.m_screenComp = self:getChild("screenComp")
	self.m_content = self:getChild("content")
end

var_0_0.EmptyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
