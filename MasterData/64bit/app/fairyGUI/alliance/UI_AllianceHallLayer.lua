local var_0_0 = {}

var_0_0.URL = "ui://lom3h0lcrv0q1"

function var_0_0:__ctor()
	self.m_gradeController = self:getController("grade")
	self.m_isShowTipController = self:getController("isShowTip")
	self.m_copyBtn = self:getChild("copyBtn")
	self.m_allianceId = self:getChild("allianceId")
	self.m_alliancePic = self:getChild("alliancePic")
	self.m_editInfoTouchBg = self:getChild("editInfoTouchBg")
	self.m_allianceName = self:getChild("allianceName")
	self.m_editNameBtn = self:getChild("editNameBtn")
	self.m_allianceLevel = self:getChild("allianceLevel")
	self.m_expProg = self:getChild("expProg")
	self.m_tipBtn = self:getChild("tipBtn")
	self.m_leaderName = self:getChild("leaderName")
	self.m_alliancePower = self:getChild("alliancePower")
	self.m_announceLabel = self:getChild("announceLabel")
	self.m_declareLabel = self:getChild("declareLabel")
	self.m_inviteBtn = self:getChild("inviteBtn")
	self.m_inviteGroup = self:getChild("inviteGroup")
	self.m_applyListBtn = self:getChild("applyListBtn")
	self.m_applyGroup = self:getChild("applyGroup")
	self.m_recordBtn = self:getChild("recordBtn")
	self.m_logGroup = self:getChild("logGroup")
	self.m_guildList = self:getChild("guildList")
	self.m_guildNum = self:getChild("guildNum")
	self.m_levelTip = self:getChild("levelTip")
	self.m_pullDownComp = self:getChild("pullDownComp")
	self.m_todayLimit = self:getChild("todayLimit")
	self.m_todayProg = self:getChild("todayProg")
	self.m_myGuild = self:getChild("myGuild")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.GradeCtrl = {
	page1 = 1,
	page0 = 0,
	page9 = 9,
	page8 = 8,
	page7 = 7,
	page6 = 6,
	page5 = 5,
	page4 = 4,
	page3 = 3,
	page2 = 2
}
var_0_0.IsShowTipCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
