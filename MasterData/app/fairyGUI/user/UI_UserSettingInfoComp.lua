local var_0_0 = {}

var_0_0.URL = "ui://2r646maydco1v"

function var_0_0:__ctor()
	self.m_inGuildController = self:getController("inGuild")
	self.m_isMaxController = self:getController("isMax")
	self.m_titleIsLockController = self:getController("titleIsLock")
	self.m_birthSetTimeController = self:getController("birthSetTime")
	self.m_knightPicComp = self:getChild("knightPicComp")
	self.m_playerIcon = self:getChild("playerIcon")
	self.m_userFrameRedPointComp = self:getChild("userFrameRedPointComp")
	self.m_expProgBar = self:getChild("expProgBar")
	self.m_levelText = self:getChild("levelText")
	self.m_expText = self:getChild("expText")
	self.m_maxText = self:getChild("maxText")
	self.m_fightValueText = self:getChild("fightValueText")
	self.m_guildText = self:getChild("guildText")
	self.m_nameText = self:getChild("nameText")
	self.m_btnEdit = self:getChild("btnEdit")
	self.m_userIdTitleText = self:getChild("userIdTitleText")
	self.m_userIdText = self:getChild("userIdText")
	self.m_copyBtn = self:getChild("copyBtn")
	self.m_switchAvatarBtn = self:getChild("switchAvatarBtn")
	self.m_birthEditBtn = self:getChild("birthEditBtn")
	self.m_birthTxt = self:getChild("birthTxt")
	self.m_userBirthEditRedPointComp = self:getChild("userBirthEditRedPointComp")
	self.m_infoGroup = self:getChild("infoGroup")
	self.m_setTitleBtn = self:getChild("setTitleBtn")
	self.m_setRedPointComp = self:getChild("setRedPointComp")
	self.m_titleShowComp = self:getChild("titleShowComp")
	self.m_title = self:getChild("title")
	self.m_knightIcon1 = self:getChild("knightIcon1")
	self.m_knightIcon2 = self:getChild("knightIcon2")
	self.m_knightIcon3 = self:getChild("knightIcon3")
	self.m_knightIcon4 = self:getChild("knightIcon4")
	self.m_knightIcon5 = self:getChild("knightIcon5")
	self.m_knightIcon6 = self:getChild("knightIcon6")
	self.m_knightGroup = self:getChild("knightGroup")
	self.m_lineUpGroup = self:getChild("lineUpGroup")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.InGuildCtrl = {
	inGuild = 1,
	none = 0
}
var_0_0.IsMaxCtrl = {
	是 = 1,
	否 = 0
}
var_0_0.TitleIsLockCtrl = {
	未解锁 = 0,
	已解锁 = 1
}
var_0_0.BirthSetTimeCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
