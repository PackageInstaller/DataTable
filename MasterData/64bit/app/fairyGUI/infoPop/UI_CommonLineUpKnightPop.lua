local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bnu7kxgic36"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_isShowGotoController = self:getController("isShowGoto")
	self.m_bgImage = self:getChild("bgImage")
	self.m_groupList = self:getChild("groupList")
	self.m_topTabList = self:getChild("topTabList")
	self.m_runnerBanner = self:getChild("runnerBanner")
	self.m_cardList = self:getChild("cardList")
	self.m_filterBtn = self:getChild("filterBtn")
	self.m_emptyComp = self:getChild("emptyComp")
	self.m_gotoBtn = self:getChild("gotoBtn")
	self.m_content = self:getChild("content")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.IsEmptyCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.IsShowGotoCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
