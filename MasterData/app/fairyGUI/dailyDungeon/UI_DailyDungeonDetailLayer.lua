local var_0_0 = {}

var_0_0.URL = "ui://7nx6gocgkc651v"

function var_0_0:__ctor()
	self.m_isShowSwapController = self:getController("isShowSwap")
	self.m_isLockController = self:getController("isLock")
	self.m_recordController = self:getController("record")
	self.m_passStateController = self:getController("passState")
	self.m_isMatchLvController = self:getController("isMatchLv")
	self.m_knightPicComp = self:getChild("knightPicComp")
	self.m_monsterHolder = self:getChild("monsterHolder")
	self.m_monsterHolder1 = self:getChild("monsterHolder1")
	self.m_monsterHolder3 = self:getChild("monsterHolder3")
	self.m_monsterHolder2 = self:getChild("monsterHolder2")
	self.m_talkTxtComp = self:getChild("talkTxtComp")
	self.m_infoTitleTxt = self:getChild("infoTitleTxt")
	self.m_tipPowerTxt = self:getChild("tipPowerTxt")
	self.m_chapterIconLoader = self:getChild("chapterIconLoader")
	self.m_tipScoreTxt = self:getChild("tipScoreTxt")
	self.m_descTxt = self:getChild("descTxt")
	self.m_txt1 = self:getChild("txt1")
	self.m_rewardList = self:getChild("rewardList")
	self.m_rewardLeftIcon = self:getChild("rewardLeftIcon")
	self.m_rewardRightIcon = self:getChild("rewardRightIcon")
	self.m_fightBtn = self:getChild("fightBtn")
	self.m_swapBtn = self:getChild("swapBtn")
	self.m_fightLongBtn = self:getChild("fightLongBtn")
	self.m_swapLongBtn = self:getChild("swapLongBtn")
	self.m_lockTxt = self:getChild("lockTxt")
	self.m_attackNumTitleText = self:getChild("attackNumTitleText")
	self.m_atackNumText = self:getChild("atackNumText")
	self.m_lineupBtn = self:getChild("lineupBtn")
	self.m_groundBuffTxt = self:getChild("groundBuffTxt")
	self.m_infoGroup = self:getChild("infoGroup")
	self.m_list = self:getChild("list")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_currPowerTxt = self:getChild("currPowerTxt")
	self.m_mapNode = self:getChild("mapNode")
	self.m_subTipsComp = self:getChild("subTipsComp")
	self.m_monthCardTipsComp = self:getChild("monthCardTipsComp")
	self.m_mask = self:getChild("mask")
	self.m_enterTransition = self:getTransition("enter")
	self.m_switchTransition = self:getTransition("switch")
end

var_0_0.IsShowSwapCtrl = {
	hide = 0,
	show = 1
}
var_0_0.IsLockCtrl = {
	open = 0,
	lock = 1
}
var_0_0.RecordCtrl = {
	record = 1,
	none = 0
}
var_0_0.PassStateCtrl = {
	pass = 1,
	unPass = 0,
	perfect = 2
}
var_0_0.IsMatchLvCtrl = {
	unmatch = 0,
	match = 1
}

return var_0_0
