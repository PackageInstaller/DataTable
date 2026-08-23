local var_0_0 = {}

var_0_0.URL = "ui://dj6vjom2sas762"

function var_0_0:__ctor()
	self.m_fightStatusController = self:getController("fightStatus")
	self.m_isFriendController = self:getController("isFriend")
	self.m_iconLoader = self:getChild("iconLoader")
	self.m_maskImg = self:getChild("maskImg")
	self.m_nameText = self:getChild("nameText")
	self.m_friendGroup = self:getChild("friendGroup")
end

var_0_0.FightStatusCtrl = {
	page3 = 3,
	page2 = 2,
	page1 = 1,
	page0 = 0,
	page5 = 5,
	page4 = 4
}
var_0_0.IsFriendCtrl = {
	否 = 0,
	是 = 1
}

return var_0_0
