local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2anu8st163u"

function var_0_0:__ctor()
	self.m_rankController = self:getController("rank")
	self.m_picBg = self:getChild("picBg")
	self.m_showPic = self:getChild("showPic")
	self.m_userName = self:getChild("userName")
	self.m_effFirst = self:getChild("effFirst")
end

var_0_0.RankCtrl = {
	page1 = 1,
	page0 = 0,
	page2 = 2
}

return var_0_0
