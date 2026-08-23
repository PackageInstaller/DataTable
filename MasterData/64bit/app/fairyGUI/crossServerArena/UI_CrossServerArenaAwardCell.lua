local var_0_0 = {}

var_0_0.URL = "ui://n47h6oaghuis5"

function var_0_0:__ctor()
	self.m_isTopThreeController = self:getController("isTopThree")
	self.m_isShowBgController = self:getController("isShowBg")
	self.m_rankIndexComp = self:getChild("rankIndexComp")
	self.m_rankText = self:getChild("rankText")
	self.m_awardList = self:getChild("awardList")
end

var_0_0.IsTopThreeCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.IsShowBgCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
