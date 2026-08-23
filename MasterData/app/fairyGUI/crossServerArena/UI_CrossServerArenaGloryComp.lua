local var_0_0 = {}

var_0_0.URL = "ui://n47h6oagknq94b"

function var_0_0:__ctor()
	self.m_rankController = self:getController("rank")
	self.m_hasMemberController = self:getController("hasMember")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_rankTxt = self:getChild("rankTxt")
	self.m_scoreTxt = self:getChild("scoreTxt")
	self.m_effRewardDown = self:getChild("effRewardDown")
	self.m_rewardBtn = self:getChild("rewardBtn")
	self.m_effRewardUp = self:getChild("effRewardUp")
	self.m_iconLoader = self:getChild("iconLoader")
	self.m_frameLoader = self:getChild("frameLoader")
	self.m_effHolder = self:getChild("effHolder")
end

var_0_0.RankCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1,
	page3 = 3
}
var_0_0.HasMemberCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
