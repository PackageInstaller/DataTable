local var_0_0 = {}

var_0_0.URL = "ui://xigti88cfvx32h"

function var_0_0:__ctor()
	self.m_speedController = self:getController("speed")
	self.m_entryTypeController = self:getController("entryType")
	self.m_isShowLevelController = self:getController("isShowLevel")
	self.m_effComp = self:getChild("effComp")
	self.m_bgComp = self:getChild("bgComp")
	self.m_descInitTxt = self:getChild("descInitTxt")
	self.m_unzipTxt = self:getChild("unzipTxt")
	self.m_logonImg = self:getChild("logonImg")
	self.m_globalLoginComp = self:getChild("globalLoginComp")
	self.m_serverTouch = self:getChild("serverTouch")
	self.m_serverBtn = self:getChild("serverBtn")
	self.m_group0 = self:getChild("group0")
	self.m_checkBtn = self:getChild("checkBtn")
	self.m_agreementText1 = self:getChild("agreementText1")
	self.m_agreementText2 = self:getChild("agreementText2")
	self.m_agreementText3 = self:getChild("agreementText3")
	self.m_agreementText4 = self:getChild("agreementText4")
	self.m_agreementText5 = self:getChild("agreementText5")
	self.m_agreementText6 = self:getChild("agreementText6")
	self.m_textStartNode = self:getChild("textStartNode")
	self.m_compTouch1 = self:getChild("compTouch1")
	self.m_compTouch2 = self:getChild("compTouch2")
	self.m_compTouch3 = self:getChild("compTouch3")
	self.m_compTouch4 = self:getChild("compTouch4")
	self.m_compTouch5 = self:getChild("compTouch5")
	self.m_selectTouch = self:getChild("selectTouch")
	self.m_agreementGroup = self:getChild("agreementGroup")
	self.m_copyrightTxt = self:getChild("copyrightTxt")
	self.m_noticeTxt = self:getChild("noticeTxt")
	self.m_versionTxt = self:getChild("versionTxt")
	self.m_specialTxt = self:getChild("specialTxt")
	self.m_group1 = self:getChild("group1")
	self.m_clearCacheBtn = self:getChild("clearCacheBtn")
	self.m_languageBtn = self:getChild("languageBtn")
	self.m_accountBtn = self:getChild("accountBtn")
	self.m_noticeBtn = self:getChild("noticeBtn")
	self.m_movieBtn = self:getChild("movieBtn")
	self.m_voiceBtn = self:getChild("voiceBtn")
	self.m_switchBtn = self:getChild("switchBtn")
	self.m_levelBtn = self:getChild("levelBtn")
	self.m_Criware = self:getChild("Criware")
	self.m_beianTxt = self:getChild("beianTxt")
	self.m_beianClickLoader = self:getChild("beianClickLoader")
	self.m_oneStoreComp = self:getChild("oneStoreComp")
	self.m_loopTransition = self:getTransition("loop")
	self.m_enterTransition = self:getTransition("enter")
	self.m_oneStoreLoginShowTransition = self:getTransition("oneStoreLoginShow")
end

var_0_0.SpeedCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.EntryTypeCtrl = {
	yoozoo = 0,
	chiyou = 1
}
var_0_0.IsShowLevelCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1,
	page3 = 3
}

return var_0_0
