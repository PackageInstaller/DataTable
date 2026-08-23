local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88od4e5rrm9"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_bgImage = self:getChild("bgImage")
	self.m_groupList = self:getChild("groupList")
	self.m_runnerBanner = self:getChild("runnerBanner")
	self.m_cardList = self:getChild("cardList")
	self.m_content = self:getChild("content")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.IsEmptyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
