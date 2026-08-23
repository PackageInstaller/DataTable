local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8lkxd0dr"

function var_0_0:__ctor()
	self.m_hasPlayerController = self:getController("hasPlayer")
	self.m_hasBgController = self:getController("hasBg")
	self.m_rankIndexComp = self:getChild("rankIndexComp")
	self.m_rewardList = self:getChild("rewardList")
	self.m_rankTxt = self:getChild("rankTxt")
end

var_0_0.HasPlayerCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.HasBgCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
